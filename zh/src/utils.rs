use std::fs;
use std::process::Command;
pub fn update_status(status: &str) {
    let path = "module.prop";
    let content = r#"id=zygisk_hide
name=Zygisk Hide [TEST]
version=v0.02
versionCode=002
author=Sliva4
description=[STATUS] Zygisk module to hide traces."#;
    let _ = fs::write(path, content.replace("STATUS",status));
}
pub fn get_kernel_version() -> String {
    let output = Command::new("uname")
                     .arg("-r")
                     .output()
                     .expect("Should be able to execute `uname`");
    return String::from_utf8_lossy(&output.stdout).to_string();
}