import Foundation

extension String {
    func formatWithDate(date: Date?) -> String {
        guard let date else { return self }
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .long
        return "\(dateFormatter.string(from: date)): \(self)\n"
    }
}
