import SwiftUI

struct LandmarkSettings: View {
  @AppStorage("MapView.zoom")
  private var zoom = MapView.Zoom.medium

  var body: some View {
    Form {
      Picker("Map zoom:", selection: $zoom) {
        ForEach(MapView.Zoom.allCases) { z in
          Text(z.rawValue)
        }
      }
      .pickerStyle(.inline)
    }
    .frame(width: 300)
    .navigationTitle("Landmark Settings")
    .padding(80)
  }
}

struct LandmarkSettings_Previews: PreviewProvider {
  static var previews: some View {
    LandmarkSettings()
  }
}
