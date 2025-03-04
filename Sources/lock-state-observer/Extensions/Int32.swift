import Foundation

extension Int32 {
    var signalDescription: String {
        switch self {
        case SIGKILL: "SIGKILL"
        case SIGTERM: "SIGTERM"
        case SIGINT: "SIGINT"
        default: "\(self)"
        }
    }
}
