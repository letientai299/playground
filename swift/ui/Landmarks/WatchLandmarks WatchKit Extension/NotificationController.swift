import SwiftUI
import UserNotifications
import WatchKit

class NotificationController: WKUserNotificationHostingController<
  NotificationView
>
{
  var title: String?
  var msg: String?
  var lm: Landmark?

  let lmIdxKey = "landmarkIndex"

  override var body: NotificationView {
    return NotificationView(
      title: title, msg: msg, lm: lm
    )
  }

  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }

  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }

  override func didReceive(_ notification: UNNotification) {
    let m = ModelData()

    let notiData = notification.request.content.userInfo as? [String: Any]
    let aps = notiData?["aps"] as? [String: Any]
    let alert = aps?["alert"] as? [String: Any]

    title = alert?["title"] as? String
    msg = alert?["body"] as? String

    if let idx = notiData?[lmIdxKey] as? Int {
      lm = m.landmarks[idx]
    }
  }
}
