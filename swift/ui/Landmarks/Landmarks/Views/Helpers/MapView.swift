import MapKit
import SwiftUI

struct MapView: View {
  var coordinate: CLLocationCoordinate2D

  private var region: MKCoordinateRegion {
    MKCoordinateRegion (
      center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
      span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
    )
  }

  @AppStorage("MapView.zoom")
  private var zoom = Zoom.medium

  var delta: CLLocationDegrees {
    switch zoom {
    case .near:
      return 0.02
    case .medium:
      return 0.2
    case .far:
      return 2
    }
  }

  var body: some View {
    Map(coordinateRegion:.constant(region))
  }

  enum Zoom: String, CaseIterable, Identifiable {
    case near = "Near"
    case medium = "Medium"
    case far = "Far"

    var id: Zoom { self }
  }
}

struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
  }
}
