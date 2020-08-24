extern crate gio;
extern crate gtk;
extern crate confy;

use gio::prelude::*;
use gtk::prelude::*;
use std::string::String;
use crate::settings::Settings;

const APP_ID: &str = "net.jeena.feedthemonkey";

#[derive(Debug)]
pub struct App {
    uiapp: gtk::Application,
    settings: Option<Settings>,
}

impl App {
    pub fn new() -> Self {
        let app = gtk::Application::new(
            Some(&APP_ID),
            gio::ApplicationFlags::FLAGS_NONE,
        )
        .expect("Application::new failed");

        app.connect_activate(|app| {
            // We create the main window.
            let win = gtk::ApplicationWindow::new(app);
    
            // Then we set its size and a title.
            win.set_default_size(320, 200);
            win.set_title("FeedTheMonkey");
    
            // Don't forget to make all widgets visible.
            win.show_all();
        });

        let conf: Result<Settings, std::io::Error> = confy::load(&APP_ID);

        match conf {
            Ok(s) => Self { uiapp: app, settings: Some(s) },
            Err(_) => Self { uiapp: app, settings: None },
        }
    }

    pub fn run(&self, argv: &[String]) {
/*
        match self.settings {
            Some(_) => self.show_content(),
            None => match confy::store(&APP_ID, Settings::default()) { // TODO: Replace default data with login form data
                Ok(_) => println!("New settings stored"),
                Err(e) => eprint!("Error while storing settings: {}", e)
            }
        }
*/
        self.uiapp.run(&argv);
    }

    pub fn show_content(&self) {
        println!("Show content")
    }

}
