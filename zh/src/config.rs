use std::fs;
use serde::Deserialize;
use crate::vars::ZH_CONFIG_PATH;

#[derive(Deserialize)]
struct Config {
   mode: String,
   vbmeta: bool,
   rom: bool
}

pub fn get_config_txt() -> String {
    let contents = fs::read_to_string(ZH_CONFIG_PATH).expect("open config");
    return contents;
}
pub fn get_config(option: &str) -> String {
    let contents = fs::read_to_string(ZH_CONFIG_PATH).expect("open config");
    let config: Config = toml::from_str(&contents).unwrap();
    if option == "mode" {
        return config.mode;
    } else if option == "vbmeta" {
        return config.vbmeta.to_string();
    } else if  option == "rom" {
        return config.rom.to_string();
    } else {
        return "".to_string();
    }
}
pub fn get_config_cli(option: &str) {
    let result = get_config(option);
    if result == "" {
        println!("Unknown option.");
    } else {
        println!("{}",result);
    }
}