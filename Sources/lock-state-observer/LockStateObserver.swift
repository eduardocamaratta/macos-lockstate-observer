import Cocoa
import Foundation

@main
public struct LockStateObserver {
    public static func main() {
        Logger.write("process started")
        configureNotificationObserver()
        configureSignalHandlers()
        RunLoop.main.run()
    }

    // MARK: - Private

    private static func configureSignalHandlers() {
        [SIGINT, SIGTERM, SIGKILL].forEach {
            signal($0) {
                Logger.logSignal($0)
                if [SIGTERM, SIGINT].contains($0) {
                    exit(0)
                }
            }
        }
    }

    private static func configureNotificationObserver() {
        let dnc = DistributedNotificationCenter.default()

        let notifications = ["screenIsLocked", "screenIsUnlocked"]
        notifications.forEach {
            dnc.addObserver(
                forName: .init("com.apple.\($0)"),
                object: nil,
                queue: .main,
                using: Logger.logNotification(_:)
            )
        }

        let workspaceNotifications: [NSNotification.Name] = [
            NSWorkspace.willPowerOffNotification,
            NSWorkspace.willSleepNotification,
            NSWorkspace.screensDidWakeNotification,
            NSWorkspace.screensDidSleepNotification
        ]
        workspaceNotifications.forEach {
            NSWorkspace.shared.notificationCenter.addObserver(
                forName: $0,
                object: nil,
                queue: .main,
                using: Logger.logNotification(_:)
            )
        }
    }
}
