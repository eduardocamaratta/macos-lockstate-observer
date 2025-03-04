import Vapor

struct LogsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let logs = routes.grouped("logs")

        // Routes
        logs.get { req -> Response in
            var headers = HTTPHeaders()
            headers.add(name: .contentType, value: "plain/text")
            headers.add(name: .accessControlAllowOrigin, value: "*")
            let body = readFile() ?? ""
            return Response(status: .ok, headers: headers, body: .init(string: body))
        }
    }

    // MARK: - Private

    private func readFile() -> String? {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let logFileUrl = documentsUrl.appendingPathComponent(".lockStateObserver").appendingPathComponent("log.txt")

        do {
            let result = try String(contentsOf: logFileUrl, encoding: .utf8)
            return result
        } catch {
            NSLog("Error \(error.localizedDescription) reading file \(logFileUrl.absoluteString)")
            return nil
        }
    }
}
