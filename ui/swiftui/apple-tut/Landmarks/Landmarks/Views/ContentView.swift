import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

class ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
                .environmentObject(ModelData())
    }
}
