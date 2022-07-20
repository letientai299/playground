import SwiftUI

struct ContentView: View {
  var body: some View {
    Text("Hello, world!")
      .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ContentView().preferredColorScheme(.light)
      ContentView().preferredColorScheme(.dark)
    }
  }
}
