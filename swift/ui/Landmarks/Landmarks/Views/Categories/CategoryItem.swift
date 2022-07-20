import SwiftUI

struct CategoryItem: View {
  var lm: Landmark

  var body: some View {
    VStack(alignment: .leading) {
      lm.image
        .renderingMode(.original)
        .resizable()
        .frame(width: 155, height: 155)
        .cornerRadius(5)

      Text(lm.name)
        .foregroundColor(.primary)
        .font(.caption)
    }
    .padding(.leading, 15)
  }
}

struct CategoryItem_Previews: PreviewProvider {
  static let lm = ModelData().landmarks[0]

  static var previews: some View {
    CategoryItem(lm: lm)
  }
}
