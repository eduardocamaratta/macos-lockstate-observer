import Cocoa

public struct Logger {
    private static let fileManager = FileManager.default
    private static let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    private static let logFileName = "log.txt"
    private static let logFolderName = ".lockStateObserver"

    static func write(_ logMessage: String, date: Date? = Date()) {
        guard let data = formatData(logMessage: logMessage, date: date) else {
            NSLog("Error encoding data")
            return
        }

        let logFolderURL = documentsUrl.appendingPathComponent(logFolderName)
        do {
            try fileManager.createDirectoryIfNeeded(dirPathURL: logFolderURL)
        } catch {
            NSLog("Error creating directory \(logFolderURL.absoluteString)")
            return
        }
        logFolderURL.appendingPathComponent(logFileName).writeToFile(data: data)
    }

    static func logNotification(_ notification: Notification) {
        write(notification.name.rawValue)
    }

    // MARK: - Private

    private static func formatData(logMessage: String, date: Date?) -> Data? {
        logMessage
            .formatWithDate(date: date)
            .data(using: .utf8)
    }
}
