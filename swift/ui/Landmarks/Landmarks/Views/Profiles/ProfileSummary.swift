import SwiftUI

struct ProfileSummary: View {
  @EnvironmentObject var m: ModelData
  var profile: Profile

  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 10) {
        Text(profile.username)
          .bold()
          .font(.title)

        let p = profile
        let noti = p.prefersNotifications ? "On" : "Off"
        Text("Notifictions: \(noti)")
        Text("Seasonal Photos: \(p.seasonalPhoto.rawValue)")
        Text("Goal Date: ") + Text(p.goalDate, style: .date)

        Divider()

        VStack(alignment: .leading) {
          Text("Completed Badges")
            .font(.headline)

          ScrollView(.horizontal) {
            HStack {
              HikeBadge(name: "First Hike")
              HikeBadge(name: "Earth Day")
                .hueRotation(Angle(degrees: 90))
              HikeBadge(name: "Tenth Hike")
                .grayscale(0.5)
                .hueRotation(Angle(degrees: 45))
            }
            .padding(.bottom)
          }
        }

        Divider()

        VStack {
          Text("Recent Hikes")
            .font(.headline)

          HikeView(hike: m.hikes[0])
        }
      }
    }
  }
}

struct ProfileSummary_Previews: PreviewProvider {
  static var previews: some View {
    ProfileSummary(profile: Profile.default)
      .environmentObject(ModelData())
  }
}
