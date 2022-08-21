use warp::Filter;
/// let's try building a web server that use many different crates in Rusts, to
/// get a feel for each of them.

#[tokio::main]
async fn main() {
    let help = warp::any().map(show_help);
    let hello =
        warp::path!("hello" / String).map(|name| format!("Hello, {}", name));
    let api = hello.or(help);
    warp::serve(api).run(([127, 0, 0, 1], 8080)).await;
}

fn show_help() -> String {
    "Try GET /hello/<name>".into()
}
