use std::{
    collections::{hash_map::DefaultHasher, HashMap},
    hash::{Hash, Hasher},
    net::SocketAddr,
    sync::{Arc, Mutex},
};

use mini_redis::Command::{Get, Set};
use mini_redis::{Command, Connection, Frame};
use tokio::net::{TcpListener, TcpStream};

const ADDRESS: &str = "127.0.0.1:6379";

type Db = Mutex<HashMap<String, Vec<u8>>>;
type _ShardedDb = Arc<Vec<Mutex<HashMap<String, Vec<u8>>>>>;
struct ShardedDb(_ShardedDb);

fn new_sharded_db(n: usize) -> ShardedDb {
    let mut db = Vec::with_capacity(n);
    for _ in 0..n {
        db.push(Mutex::new(HashMap::new()));
    }
    ShardedDb(Arc::new(db))
}

impl ShardedDb {
    fn get_shard(&self, key: &str) -> &Db {
        let mut h = DefaultHasher::new();
        key.hash(&mut h);
        &self.0[(h.finish() as usize) % self.0.len()]
    }
}

impl Clone for ShardedDb {
    fn clone(&self) -> Self {
        ShardedDb(self.0.clone())
    }
}

#[tokio::main]
async fn main() {
    let listener = TcpListener::bind(ADDRESS).await.unwrap();
    let db = new_sharded_db(10);

    loop {
        let (socket, addr) = listener.accept().await.unwrap();
        let db = db.clone();

        tokio::spawn(async move {
            process(db, addr, socket).await;
        });
    }
}

async fn process(db: ShardedDb, addr: SocketAddr, socket: TcpStream) {
    let mut connection = Connection::new(socket);
    while let Some(frame) = connection.read_frame().await.unwrap() {
        println!("From {}: {:?}", addr, frame);

        let response = match Command::from_frame(frame).unwrap() {
            Set(cmd) => {
                let key = cmd.key();
                let value = cmd.value();
                let db = db.get_shard(key);
                let mut db = db.lock().unwrap();
                db.insert(key.into(), value.to_vec());
                Frame::Simple("OK".into())
            }

            Get(cmd) => {
                let key = cmd.key();
                let db = db.get_shard(key);
                let db = db.lock().unwrap();
                if let Some(value) = db.get(key) {
                    Frame::Bulk(value.to_vec().into())
                } else {
                    Frame::Null
                }
            }
            _ => unimplemented!(),
        };

        connection.write_frame(&response).await.unwrap();
    }
}
