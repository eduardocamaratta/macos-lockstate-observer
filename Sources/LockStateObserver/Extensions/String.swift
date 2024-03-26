import Foundation

extension String {
    func formatWithDate(date: Date?) -> String {
        guard let date else { return self }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return "\(dateFormatter.string(from: date)): \(self)\n"
    }

    var prefixSpaceIfNotEmpty: String {
        isEmpty ? "" : " \(self)"
    }
}
