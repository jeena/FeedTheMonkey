extern crate confy;

use std::string::String;
use url::Url;
use serde::{Serialize, Deserialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct Settings {
    pub session_id: String,
    pub server_url: Url,
}

impl ::std::default::Default for Settings {
    fn default() -> Self {
        Self {
            session_id: String::from("abcdefg"),
            server_url: Url::parse("https://example.com").expect("Not a URL"),
        }
    }
}