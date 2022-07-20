import SwiftUI

struct ContentView: View {
  var body: some View {
    LandmarkList()
      .frame(minWidth: 900, minHeight: 300)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(ModelData())
  }
}
