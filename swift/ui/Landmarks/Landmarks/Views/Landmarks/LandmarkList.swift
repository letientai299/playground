import SwiftUI

struct LandmarkList: View {
  @State private var favoriteOnly = false
  @EnvironmentObject var m: ModelData
  @State private var filter = FilterCategory.all
  @State private var selected: Landmark?

  enum FilterCategory: String, CaseIterable, Identifiable {
    case all = "All"
    case lakes = "Lakes"
    case rivers = "Rivers"
    case mountains = "Mountains"

    var id: FilterCategory {self}
  }

  var fitlered: [Landmark] {
    m.landmarks.filter{
      ($0.isFavorite || !favoriteOnly) &&
      (filter == .all || filter.rawValue == $0.category.rawValue)
    }
  }

  var title: String {
    let t = filter == .all ? "Landmarks" : filter.rawValue
    return favoriteOnly ? "Favorite \(t)" : t
  }

  var index: Int? {
    m.landmarks.firstIndex( where: { $0.id == selected?.id })
  }

  var body: some View {
    NavigationView {
      List(selection: $selected) {
        ForEach(fitlered) { lm in
          NavigationLink {
            LandmarkDetail(lm)
          } label: {
            LandmarkRow(landmark: lm)
          }
          .tag(lm)
        }
      }
      .navigationTitle(title)
      .frame(minWidth: 300)
      .toolbar {
        ToolbarItem {
          Menu {
            Picker("Category", selection: $filter) {
              ForEach(FilterCategory.allCases) { cat in
                Text(cat.rawValue).tag(cat)
              }
            }
            .pickerStyle(.inline)

            Toggle(isOn: $favoriteOnly) {
              Text("Favorite only")
            }

          } label: {
            Label("Filter", systemImage: "slider.horizontal.3")
          }
        }
      }

      Text("Select a Landmark")
    }
    .focusedValue(\.selectedLandmark, $m.landmarks[index ?? 0])
  }
}


struct LandmarkList_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      LandmarkList()
        .preferredColorScheme(.light)
      LandmarkList()
        .preferredColorScheme(.dark)
    }
    .environmentObject(ModelData())
  }
}
