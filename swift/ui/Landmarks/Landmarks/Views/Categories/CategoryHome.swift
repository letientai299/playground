import SwiftUI

struct CategoryHome: View {
  @EnvironmentObject var m: ModelData
  @State private var showProfile = false

  var body: some View {
    NavigationView {
      List {
        PageView(
          pages: ModelData().features.map {
            FeatureCard(lm: $0)
          }
        )
        .aspectRatio(3 / 2, contentMode: .fit)
        .listRowInsets(EdgeInsets())

        ForEach(m.categories.keys.sorted(), id: \.self) { cat in
          CategoryRow(cat: cat, items: m.categories[cat]!)
        }
        .listRowInsets(EdgeInsets())
      }
      .listStyle(.inset)
      .navigationTitle("Featured")
      .toolbar {
        Button {
          showProfile.toggle()
        } label: {
          Label("User Profile", systemImage: "person.crop.circle")
        }
      }
      .sheet(isPresented: $showProfile) {
        ProfileHost()
          .environmentObject(m)
      }
    }
  }
}

struct CategoryHome_Previews: PreviewProvider {
  static var previews: some View {
    CategoryHome()
      .environmentObject(ModelData())
  }
}
