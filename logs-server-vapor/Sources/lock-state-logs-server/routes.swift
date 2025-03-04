import Vapor

func routes(_ app: Application) throws {
    app.get { req async -> String in
        "Available routes:\n" + app.routes.all.map(\.description).joined(separator: "\n")
    }

    try app.register(collection: LogsController())
}
