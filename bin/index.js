#!/usr/bin/env node

const { execSync } = require("child_process");
const { join } = require("path");

if (process.platform !== "darwin") {
  console.error("\n  This tool only works on macOS.\n");
  process.exit(1);
}

try {
  execSync(`bash "${join(__dirname, "..", "share-login.sh")}"`, {
    stdio: "inherit",
  });
} catch (e) {
  process.exit(e.status || 1);
}
