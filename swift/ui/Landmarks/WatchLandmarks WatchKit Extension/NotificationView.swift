import SwiftUI

struct NotificationView: View {
  var title: String?
  var msg: String?
  var lm: Landmark?

  var body: some View {
    VStack {
      if let lm = lm {
        CircleImage(lm.image)
          .scaledToFit()
      }

      Text(title ?? "Unknown Landmark")
        .font(.headline)

      Divider()

      Text(msg ?? "You are within 5 miles of one of your landmarks")
        .font(.caption)
        .multilineTextAlignment(.center)
    }
    .lineLimit(2)
  }
}

struct NotificationView_Previews: PreviewProvider {
  static let m = ModelData()
  static let lm = m.landmarks[0]

  static var previews: some View {
    Group {
      NotificationView()
      NotificationView(
        title: "Turtle Rock", msg: "You are within 5 miles of \(lm.name)",
        lm: lm
      )
    }
  }
}
