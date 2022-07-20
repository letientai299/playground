import SwiftUI

struct CategoryRow: View {
  var cat: String
  var items: [Landmark]

  var body: some View {
    VStack(alignment: .leading) {
      Text(cat)
        .font(.headline)
        .padding(.leading, 15)
        .padding(.top, 5)

      ScrollView(.horizontal, showsIndicators: false) {
        HStack(alignment: .top, spacing: 0){
          ForEach(items) { lm in
            NavigationLink {
              LandmarkDetail(lm)
            } label: {
              CategoryItem(lm: lm)
            }
          }
        }
      }.frame(height: 185)
    }
  }
}

struct CategoryRow_Previews: PreviewProvider {
  static var lms = ModelData().landmarks
  static var previews: some View {
    CategoryRow(
      cat: lms[0].category.rawValue,
      items: Array(lms.prefix(4))
    )
  }
}
