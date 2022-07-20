import SwiftUI

struct LandmarkList: View {
  @State private var favoriteOnly = false
  @EnvironmentObject var m: ModelData

  var fitlered: [Landmark] {
    m.landmarks.filter { $0.isFavorite || !favoriteOnly }
  }

  var body: some View {
    NavigationView {
      List {
        Toggle(isOn: $favoriteOnly) {
          Text("Favorite only")
        }

        ForEach(fitlered) { lm in
          NavigationLink {
            LandmarkDetail(lm)
          } label: {
            LandmarkRow(landmark: lm)
          }
        }
      }
      .navigationTitle("Landmarks")
    }
  }
}

struct LandmarkList_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      LandmarkList()
      LandmarkList()
        .preferredColorScheme(.dark)
    }
    .environmentObject(ModelData())
  }
}
