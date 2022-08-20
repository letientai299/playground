use std::{
    cell::RefCell,
    fs,
    io::Write,
    mem,
    net::{TcpListener, TcpStream},
    sync::mpsc,
    sync::mpsc::Sender,
    sync::Arc,
    thread, vec,
};

fn main() {
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();
    let pool = ThreadPool::new(16);
    let contents = fs::read_to_string("index.html").unwrap();
    let contents = Arc::new(contents);

    for stream in listener.incoming() {
        let stream = stream.unwrap();
        let c = contents.clone();
        pool.exec(|| handle(stream, c));
    }
}

struct ThreadPool {
    cap: RefCell<usize>,
    current: RefCell<usize>,
    txs: Vec<Sender<Job>>,
}

impl Drop for ThreadPool {
    fn drop(&mut self) {
        for tx in &self.txs {
            mem::drop(tx);
        }
    }
}

type Job = Box<dyn FnOnce() + Send + 'static>;

impl ThreadPool {
    fn new(n: usize) -> Self {
        assert!(n > 0);

        let mut txs = Vec::with_capacity(n);

        for _id in 0 .. n {
            let (tx, rx) = mpsc::channel::<Job>();
            thread::spawn(move || {
                for job in rx {
                    job();
                }
            });
            txs.push(tx);
        }

        Self {
            cap: RefCell::new(n),
            current: RefCell::new(0),
            txs,
        }
    }

    fn exec<F>(&self, f: F)
    where
        F: FnOnce() + Send + 'static,
    {
        let n = *self.current.borrow();
        let cap = *self.cap.borrow();

        let tx = &self.txs[n];
        let job = Box::new(f);
        tx.send(job).unwrap();

        let n = if n < cap - 1 { n + 1 } else { 0 };
        *self.current.borrow_mut() = n;
    }
}

fn handle(mut stream: TcpStream, contents: Arc<String>) {
    // let mut buffer = [0; 1024];
    // stream.read(&mut buffer).unwrap();
    let status = "HTTP/1.1 200 OK";
    let res = vec![
        status.into(),
        "Content-Type: text/html".into(),
        format!("Content-Length: {}", contents.len()),
        "".into(),
        contents.to_string(),
    ]
    .join("\r\n");

    stream.write(res.as_bytes()).unwrap();
    // println!( "Request: {}", String::from_utf8_lossy(&buffer[..])
    // .split("\n") .take(1) .collect::<String>());
}
