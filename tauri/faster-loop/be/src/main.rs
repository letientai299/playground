use std::{fs, net::SocketAddr, path};

use axum::{extract, http::StatusCode, response::IntoResponse, routing::get, Json, Router};
use serde::Serialize;
use tracing::*;

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt()
        .compact()
        .with_line_number(true)
        .with_file(true)
        .init();

    let app = Router::new().route("/list/*path", get(list));
    let addr = SocketAddr::from(([127, 0, 0, 1], 8080));

    tracing::info!("listening on {}", addr);

    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .unwrap();
}

#[derive(Debug, Serialize)]
enum Kind {
    Dir,
    File,
    Link,
}

#[derive(Debug, Serialize)]
struct Item {
    kind: Kind,
    name: String,
}

#[derive(Debug, Serialize)]
struct Resp {
    items: Vec<Item>,
    error: String,
}

impl Resp {
    fn err(msg: &str) -> Resp {
        Resp {
            items: vec![],
            error: msg.into(),
        }
    }

    fn data(items: Vec<Item>) -> Resp {
        Resp {
            items,
            error: "".into(),
        }
    }
}

// https://docs.rs/tracing-attributes/0.1.22/tracing_attributes/attr.instrument.html
#[instrument(ret)]
async fn list(extract::Path(raw_path): extract::Path<String>) -> impl IntoResponse {
    let p = path::Path::new(&raw_path);

    // TODO (tai.le): should read file content
    if !p.is_dir() {
        let msg = format!("not a dir: {}", raw_path);
        // return Response::builder().status(StatusCode::NOT_IMPLEMENTED).body(body);
        return (StatusCode::NOT_IMPLEMENTED, Json(Resp::err(&msg)));
    }

    let r = p.read_dir();
    if let Err(e) = r {
        // TODO (tai.le): how to properly return errors?
        // still don't understand this https://docs.rs/axum/latest/axum/error_handling/
        let msg = format!("failed to read dir {}, err={}", raw_path, e);
        return (StatusCode::INTERNAL_SERVER_ERROR, Json(Resp::err(&msg)));
    }

    let mut items = vec![];
    let r = r.unwrap();

    for entry in r {
        if let Err(e) = entry {
            let msg = format!("failed to read dir entry, err={}", e);
            return (StatusCode::INTERNAL_SERVER_ERROR, Json(Resp::err(&msg)));
        }

        let entry = entry.unwrap();
        items.push(Item {
            name: entry.file_name().to_string_lossy().to_string(),
            kind: kind_of(&entry.path()),
        });
    }

    (StatusCode::OK, Json(Resp::data(items)))
}

fn kind_of(p: &path::Path) -> Kind {
    if fs::symlink_metadata(p).unwrap().is_symlink() {
        return Kind::Link;
    }

    if p.is_dir() {
        return Kind::Dir;
    }

    if p.is_file() {
        return Kind::File;
    }

    panic!("impossible")
}
