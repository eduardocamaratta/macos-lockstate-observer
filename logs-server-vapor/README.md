# Local Vapor Server

## Motivation

Had trouble trying to make the server with node & express properly launch as a daemon. When succeeded it, the resulting binary size was simply massive. Pivoting to swift in order to achieve a more manageable binary size while the resulting binary is relatively easy to use as a daemon. Also taking the opportunity to learn a bit about Vapor.

## Installation

Vapor [documentation](https://docs.vapor.codes/install/macos/) recommends installing it via brew, even though it's not really necessary. After installing with brew (`brew install vapor`) the Vapor CLI becomes available and it's easy to create a new project.

## New Project

Creating a new "[hello world](https://docs.vapor.codes/getting-started/hello-world/)" project with Vapor: `vapor new local-logs-server-vapor -n`.

- The command created a new repository inside the folder. Deleted it (.git and .gitignore).
- Also deleted docker related files (Dockerfile, docker-compose.yml, .dockerignore).
- Renamed App on Package.swift to logs-server.

## Building

Show resulting binary path:
```bash
swift build -c release --show-bin-path
```

Compiling a release version. First build took 130.05s (M1, 16GB, Sequoia 15.3.1). Subsequent build: 2.08s.
```bash
swift build -c release
```