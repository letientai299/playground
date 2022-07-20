import SwiftUI

struct ProfileHost: View {
  @Environment(\.editMode) var editMode
  @EnvironmentObject var m: ModelData

  @State private var draftProfile = Profile.default

  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      HStack {
        if editMode?.wrappedValue == .active {
          Button("Cancel", role: .cancel) {
            draftProfile = m.profile
            editMode?.animation().wrappedValue = .inactive
          }
        }

        Spacer()
        EditButton()
      }

      if editMode?.wrappedValue == .inactive {
        ProfileSummary(profile: m.profile)
      } else {
        ProfileEditor(p: $draftProfile)
          .onAppear {
            draftProfile = m.profile
          }
          .onDisappear {
            m.profile = draftProfile
          }
      }
    }
    .padding()
  }
}

struct ProfileHost_Previews: PreviewProvider {
  static var previews: some View {
    ProfileHost()
      .environmentObject(ModelData())
  }
}
