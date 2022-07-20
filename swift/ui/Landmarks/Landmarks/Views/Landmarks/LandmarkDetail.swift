import SwiftUI

struct LandmarkDetail: View {
  @EnvironmentObject var m: ModelData
  var lm: Landmark

  var lmIdx: Int {
    m.landmarks.firstIndex(where: { $0.id == lm.id })!
  }

  init(_ lm: Landmark) {
    self.lm = lm
  }

  var body: some View {
    VStack {
      MapView(coordinate: lm.locationCoordinate)
        .ignoresSafeArea()
        .frame(height: 300)

      CircleImage(lm.image)
        .offset(y: -130)
        .padding(.bottom, -130)

      VStack(alignment: .leading) {
        HStack {
          Text(lm.name)
            .font(.title)
          FavoriteButton(isSet: $m.landmarks[lmIdx].isFavorite)
        }

        HStack {
          Text(lm.park)
          Spacer()
          Text(lm.state)
        }
        .font(.subheadline)
        .foregroundColor(.secondary)

        Divider()

        Text("About \(lm.name)")
          .font(.title2)

        Text(lm.description)
      }
      .padding()

      Spacer()
    }
    .navigationTitle(lm.name)
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct LandmarkDetail_Previews: PreviewProvider {
  static let m = ModelData()
  static var previews: some View {
    LandmarkDetail(m.landmarks[0])
      .environmentObject(m)
  }
}
