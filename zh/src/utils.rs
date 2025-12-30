use std::fs;
use std::process::Command;
use std::path::Path;
use crate::config::get_config;
use crate::vars::ZH_SHA256_PATH;
use crate::vars::ZH_VBMETA_PATH;
pub fn update_status(status: &str) {
    let path = "module.prop";
    let content = format!(r#"id=zygisk_hide
name=Zygisk Hide [TEST]
version=v0.03
versionCode=003
author=Sliva4
description=[STATUS | Mode: {}] Zygisk module to hide traces."#,get_config("mode"));
    let _ = fs::write(path, content.replace("STATUS",status));
}
pub fn get_kernel_version() -> String {
    let output = Command::new("uname")
                     .arg("-r")
                     .output()
                     .expect("Should be able to execute `uname`");
    return String::from_utf8_lossy(&output.stdout).to_string();
}

pub fn sha256ok_exists() -> bool {
    return Path::new(ZH_SHA256_PATH).exists();
}

pub fn vbmeta_exists() -> bool {
    return Path::new(ZH_VBMETA_PATH).exists();
}