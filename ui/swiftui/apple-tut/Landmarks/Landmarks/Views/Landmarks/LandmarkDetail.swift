import SwiftUI

struct LandmarkDetail: View {
    @EnvironmentObject var modelData: ModelData

    var landmark: Landmark

    var landmarkIndex: Int {
        // WTF is this code?
        // Why need "!"? Why can't I just use the "landmark.isFavorite"
        modelData.landmarks.firstIndex(where: {$0.id == landmark.id})!
    }

    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinates)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)

            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                HStack {
                    Text(landmark.name)
                        .font(.title)
                    let lm = $modelData.landmarks[landmarkIndex]
                    FavoriteButton(isSet: lm.isFavorite)
                }

                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)


                Divider()

                Text("About \(landmark.name)")
                    .font(.title2)

                Text(landmark.description)

            }
            .padding()
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static let modelData = ModelData()
    static var previews: some View {
        LandmarkDetail(landmark: modelData.landmarks[1])
            .environmentObject(modelData)
    }
}
