import Vapor

// configures the application
public func configure(_ app: Application) async throws {
    // https://docs.vapor.codes/advanced/server/
    // Configure custom port
    app.http.server.configuration.port = 7654
    // # Override configured port
    // swift run App serve --port 1337

    // register routes
    try routes(app)
}
