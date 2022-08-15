use std::net::SocketAddr;

use tokio::{
    io::{self, AsyncReadExt, AsyncWriteExt},
    net::{TcpListener, TcpStream},
};

#[tokio::main]
async fn main() {
    let listener = TcpListener::bind("127.0.0.1:8989").await.unwrap();
    loop {
        let (socket, addr) = listener.accept().await.unwrap();
        tokio::spawn(async move {
            echo_copy(socket, addr).await;
        });
    }
}

async fn echo_copy(mut socket: TcpStream, addr: SocketAddr) {
    println!("{} connected", addr);
    let (mut tx, mut rx) = socket.split();
    io::copy(&mut tx, &mut rx).await.unwrap();
    println!("{} disconnected", addr);
}

async fn echo(mut socket: TcpStream, addr: SocketAddr) {
    println!("{} connected", addr);
    let (mut tx, mut rx) = socket.split();
    let mut buffer = Vec::with_capacity(1024);
    while let Ok(n) = tx.read_buf(&mut buffer).await {
        if n == 0 {
            // socket is closed
            break;
        }
        if let Err(e) = rx.write(&buffer).await {
            println!("failed to echo back, {}", e);
        } else {
            buffer.clear();
        };
    }
    println!("{} disconnected", addr);
}
