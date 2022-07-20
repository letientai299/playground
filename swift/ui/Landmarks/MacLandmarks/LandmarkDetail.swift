import MapKit
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
    ScrollView {
      ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
        MapView(coordinate: lm.locationCoordinate)
          .ignoresSafeArea()
          .frame(height: 300)
        Button("Open in Maps") {
          let dst = MKMapItem(
            placemark: MKPlacemark(coordinate: lm.locationCoordinate))
          dst.name = lm.name
          dst.openInMaps()
        }.padding()
      }

      VStack(alignment: .leading, spacing: 20) {
        HStack(spacing: 24) {
          CircleImage(lm.image)
            .offset(y: -30)
            .frame(width: 160, height: 160)
            .padding(.bottom, -40)

          VStack(alignment: .leading) {
            HStack {
              Text(lm.name)
                .font(.title)
              FavoriteButton(isSet: $m.landmarks[lmIdx].isFavorite)
            }

            VStack(alignment: .leading) {
              Text(lm.park)
              Text(lm.state)
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
          }
        }

        Divider()

        Text("About \(lm.name)")
          .font(.title2)

        Text(lm.description)
      }

      .padding()
      .frame(maxWidth: 700)
      .offset(y: -50)
    }
    .navigationTitle(lm.name)
  }
}

struct LandmarkDetail_Previews: PreviewProvider {
  static let m = ModelData()
  static var previews: some View {
    LandmarkDetail(m.landmarks[0])
      .environmentObject(m)
      .frame(minWidth: 800, minHeight: 700)
  }
}
