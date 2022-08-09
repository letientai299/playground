# Cargo book

## Introduction

## 1. Getting Started

- [x] 1.1. Installation
- [x] 1.2. First Steps with Cargo

## 2. Cargo Guide

- [x] 2.1. Why Cargo Exists
- [x] 2.2. Creating a New Package
- [x] 2.3. Working on an Existing Package
- [x] 2.4. Dependencies
- [x] 2.5. Package Layout
  - `src/bin` contains code to compile other binaries.
  - `benches`, `tests`, `examples` live on top level dir
- [x] 2.6. `Cargo.toml` vs `Cargo.lock`
  - Ignore `Cargo.lock` for lib, track it for bin.
- [x] 2.7. Tests
- [x] 2.8. Continuous Integration
- [x] 2.9. Cargo Home
  - On CI, only cache these folders of `$CARGO_HOME` across build
    - `bin`
    - `registry/index`
    - `registry/cache`
    - `git/db`
- [x] 2.10. Build Cache

## 3. Cargo Reference

- [ ] 3.1. Specifying Dependencies
  - Can specify multiple package versions and locations to use in different
    situation.
  - `build-dependencies` for `build.rs`, doens't have access to `dependencies`
    and `dev-dependencies`
  - Can rename dependencies via `package` key.
  - [x] 3.1.1. Overriding Dependencies
- [x] 3.2. The Manifest Format
  - [x] 3.2.1. Cargo Targets

**mostly skimming starting from this**

- [ ] 3.3. Workspaces
- [ ] 3.4. Features
  - [ ] 3.4.1. Features Examples
- [ ] 3.5. Profiles
- [ ] 3.6. Configuration
- [ ] 3.7. Environment Variables
- [ ] 3.8. Build Scripts
  - [ ] 3.8.1. Build Script Examples
- [ ] 3.9. Publishing on crates.io
- [ ] 3.10. Package ID Specifications
- [ ] 3.11. Source Replacement
- [ ] 3.12. External Tools
- [ ] 3.13. Registries
- [ ] 3.14. Dependency Resolution
- [ ] 3.15. SemVer Compatibility
- [ ] 3.16. Future incompat report
- [ ] 3.17. Reporting build timings
- [ ] 3.18. Unstable Features

## 4. Cargo Commands

- [ ] 4.1. General Commands
  - [ ] 4.1.1. cargo
  - [ ] 4.1.2. cargo help
  - [ ] 4.1.3. cargo version
- [ ] 4.2. Build Commands
  - [ ] 4.2.1. cargo bench
  - [ ] 4.2.2. cargo build
  - [ ] 4.2.3. cargo check
  - [ ] 4.2.4. cargo clean
  - [ ] 4.2.5. cargo doc
  - [ ] 4.2.6. cargo fetch
  - [ ] 4.2.7. cargo fix
  - [ ] 4.2.8. cargo run
  - [ ] 4.2.9. cargo rustc
  - [ ] 4.2.10. cargo rustdoc
  - [ ] 4.2.11. cargo test
  - [ ] 4.2.12. cargo report
- [ ] 4.3. Manifest Commands
  - [ ] 4.3.1. cargo add
  - [ ] 4.3.2. cargo generate-lockfile
  - [ ] 4.3.3. cargo locate-project
  - [ ] 4.3.4. cargo metadata
  - [ ] 4.3.5. cargo pkgid
  - [ ] 4.3.6. cargo tree
  - [ ] 4.3.7. cargo update
  - [ ] 4.3.8. cargo vendor
  - [ ] 4.3.9. cargo verify-project
- [ ] 4.4. Package Commands
  - [ ] 4.4.1. cargo init
  - [ ] 4.4.2. cargo install
  - [ ] 4.4.3. cargo new
  - [ ] 4.4.4. cargo search
  - [ ] 4.4.5. cargo uninstall
- [ ] 4.5. Publishing Commands
  - [ ] 4.5.1. cargo login
  - [ ] 4.5.2. cargo owner
  - [ ] 4.5.3. cargo package
  - [ ] 4.5.4. cargo publish
  - [ ] 4.5.5. cargo yank

## 5. FAQ

Done

## 6. Appendix: Glossary

## 7. Appendix: Git Authentication
