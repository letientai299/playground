import SwiftUI

struct FeatureCard: View {
  var lm: Landmark

  var body: some View {
    lm.featureImage?
      .resizable()
      .aspectRatio(3/2, contentMode: .fit)
      .overlay {
        TextOverlay(lm: lm)
      }
  }
}

struct TextOverlay: View {
  var lm: Landmark

  var gradient: LinearGradient {
    .linearGradient(
      Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
      startPoint: .bottom,
      endPoint: .center)
  }

  var body: some View {
    ZStack(alignment: .bottomLeading) {
      gradient
      VStack(alignment: .leading) {
        Text(lm.name)
          .font(.title)
          .bold()

        Text(lm.park)
      }
      .padding()
    }
    .foregroundColor(.white)
  }
}

struct FeatureCard_Previews: PreviewProvider {
  static var previews: some View {
    FeatureCard(lm: ModelData().features[0])
  }
}
