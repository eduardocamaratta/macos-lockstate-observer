import Foundation

extension FileManager {
    func createDirectoryIfNeeded(dirPathURL: URL) throws {
        guard !fileExists(atPath: dirPathURL.relativePath) else { return }
        try createDirectory(at: dirPathURL, withIntermediateDirectories: false)
    }
}
