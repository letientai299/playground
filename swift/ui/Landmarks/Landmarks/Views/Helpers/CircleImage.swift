import SwiftUI

struct CircleImage: View {
  var img: Image

  init(_ img: Image) {
    self.img = img
  }

  var body: some View {
    img
      .resizable()
      .clipShape(Circle())
      .overlay {
        Circle().stroke(.gray, lineWidth: 4)
      }
      .shadow(radius: 7)
  }
}

struct SwiftUIView_Previews: PreviewProvider {
  static var previews: some View {
    CircleImage(Image("turtlerock"))
  }
}
