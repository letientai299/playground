use bytes::Bytes;
use mini_redis::client;
use tokio::sync::{mpsc, oneshot};

#[tokio::main]
async fn main() {
    let (tx, mut rx) = mpsc::channel(32);
    let tx2 = tx.clone();

    let t1 = tokio::spawn(async move {
        let (resp_tx, resp_rx) = oneshot::channel();
        let cmd = Command::Get {
            key: "hello".into(),
            resp: resp_tx,
        };
        tx.send(cmd).await.unwrap();
        let res = resp_rx.await;
        println!("GOT = {:?}", res);
    });

    let t2 = tokio::spawn(async move {
        let (resp_tx, resp_rx) = oneshot::channel();
        let cmd = Command::Set {
            key: "hello".into(),
            val: Bytes::from("world"),
            resp: resp_tx,
        };
        tx2.send(cmd).await.unwrap();
        let res = resp_rx.await;
        println!("GOT = {:?}", res);
    });

    let manager = tokio::spawn(async move {
        let mut client = client::connect("127.0.0.1:6379").await.unwrap();

        while let Some(cmd) = rx.recv().await {
            use Command::*;
            println!("CMD = {:?}", &cmd);
            match cmd {
                Get { key, resp } => {
                    let v = client.get(&key).await;
                    let _ = resp.send(v);
                }
                Set { key, val, resp } => {
                    let v = client.set(&key, val).await;
                    let _ = resp.send(v);
                }
            }
        }
    });

    t1.await.unwrap();
    t2.await.unwrap();
    manager.await.unwrap();
}

#[derive(Debug)]
enum Command {
    Get {
        key: String,
        resp: Responder<Option<Bytes>>,
    },
    Set {
        key: String,
        val: Bytes,
        resp: Responder<()>,
    },
}

type Responder<T> = oneshot::Sender<mini_redis::Result<T>>;
