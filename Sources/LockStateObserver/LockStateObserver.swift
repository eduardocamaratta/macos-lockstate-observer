import Cocoa
import Foundation

@main
public struct LockStateObserver {
    public static func main() {
        configureNotificationObserver()
        Logger.write("started")
        RunLoop.main.run()
    }

    // MARK: - Private

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
