import SwiftUI

struct LandmarkDetail: View {
  @EnvironmentObject var m: ModelData
  var lm: Landmark

  init(_ lm: Landmark) {
    self.lm = lm
  }

  var lmIdx: Int {
    m.landmarks.firstIndex(where: {$0.id == lm.id})!
  }

  var body: some View {
    ScrollView {
      VStack {
        CircleImage(lm.image)
          .scaledToFit()

        Text(lm.name)
          .font(.headline)
          .lineLimit(0)

        Toggle(isOn: $m.landmarks[lmIdx].isFavorite) {
          Text("Favorite")
        }

        Divider()

        Text(lm.park)
          .font(.caption)
          .bold()
          .lineLimit(0)

        Text(lm.state)
          .font(.caption)

        Divider()

        MapView(coordinate: lm.locationCoordinate)
          .scaledToFit()
      }
      .padding(16)
    }
    .navigationTitle("Landmarks")
  }
}

struct LandmarkDetail_Previews: PreviewProvider {
  static let m = ModelData()
  static var previews: some View {
    let lm = m.landmarks[0]
    return Group {
      LandmarkDetail(lm)
        .previewDevice("Apple Watch Series 5 - 44mm")

      LandmarkDetail(lm)
        .previewDevice("Apple Watch Series 5 - 40mm")

    }.environmentObject(m)
  }
}
