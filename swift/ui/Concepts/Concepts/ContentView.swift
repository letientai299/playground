import SwiftUI

struct ContentView: View {
  @State private var count = 0
  var body: some View {
    HStack {
      Button {
        count += 1
      } label: {
        Text("Count")
      }

      Text("\(count)")
    }
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
