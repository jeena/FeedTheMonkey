mod app;
mod settings;

fn main() {
    let app = app::App::new();
    app.run(&std::env::args().collect::<Vec<_>>());
}