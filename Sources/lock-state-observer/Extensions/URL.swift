import Foundation

extension URL {
    func writeToFile(data: Data) {
        guard FileManager.default.fileExists(atPath: path) else {
            try! data.write(to: self, options: .atomic)
            return
        }

        FileHandle(forWritingAtPath: path)?.append(data: data)
    }
}
