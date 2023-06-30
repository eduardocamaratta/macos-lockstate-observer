import Foundation

extension FileHandle {
    func append(data: Data) {
        seekToEndOfFile()
        write(data)
        closeFile()
    }
}
