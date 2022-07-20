import SwiftUI

struct ProfileEditor: View {
  @Binding var p: Profile

  var dateRange: ClosedRange<Date> {
    let min = Calendar.current.date(
      byAdding: .year,
      value: -1,
      to: p.goalDate
    )!

    let max = Calendar.current.date(
      byAdding: .year,
      value: 1,
      to: p.goalDate
    )!

    return min...max
  }

  var body: some View {
    List {

      HStack {
        Text("Username").bold()
        Divider()
        TextField("Username", text: $p.username)
      }

      Toggle(isOn: $p.prefersNotifications, label: {
        Text("Enable Notifications").bold()
      })

      VStack(alignment: .leading, spacing: 20) {
        Text("Seasonal Photo").bold()

        Picker("Seasonal Photo", selection: $p.seasonalPhoto) {
          ForEach(Profile.Season.allCases) {season in
            Text(season.rawValue).tag(season)
          }
        }
        .pickerStyle(.segmented)
      }

      DatePicker(selection: $p.goalDate, in: dateRange, displayedComponents: .date) {
        Text("Goal Date").bold()
      }
    }
  }
}

struct ProfileEditor_Previews: PreviewProvider {
  static var previews: some View {
    ProfileEditor(p: .constant(.default))
  }
}
