import SwiftUI

struct PageView<Page: View>: View {
  @State private var currentPage = 0
  var pages: [Page]

  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      PageViewController(currentPage: $currentPage, pages: pages)
      PageControl(numPages: pages.count, currentPage: $currentPage)
        .frame(width: CGFloat(pages.count * 18))
        .padding(.trailing)
    }
  }
}

struct PageView_Previews: PreviewProvider {
  static let m = ModelData()
  static var previews: some View {
    PageView(
      pages: m.features.map {
        FeatureCard(lm: $0)
      }
    )
    .aspectRatio(3 / 2, contentMode: .fit)
  }
}
