import SwiftUI

struct LandmarkRow: View {
  var landmark: Landmark

  var body: some View {
    HStack {
      landmark.image
        .resizable()
        .frame(width: 50, height: 50)
        .cornerRadius(5)

      VStack(alignment: .leading) {
        Text(landmark.name)
          .bold()
#if !os(watchOS)
        Text(landmark.park)
          .font(.caption)
          .foregroundColor(.secondary)
#endif
      }

      Spacer()

      if landmark.isFavorite {
        Image(systemName: "star.fill")
          .foregroundColor(.yellow)
      }
    }
    .padding(.vertical, 4)
  }
}

struct LandmarkRow_Previews: PreviewProvider {
  static var previews: some View {
    LandmarkRow(landmark: ModelData().landmarks[0])
  }
}
