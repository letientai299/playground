import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable {
    // for Identifiable, this must be var, not let
    var id: Int
    let name: String
    let park: String
    let state: String
    let description: String

    private var imageName: String
    var image: Image {
        Image(imageName)
    }

    private let coordinates: Coordinates
    var locationCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }

    struct Coordinates: Hashable, Codable {
        let latitude: Double
        let longitude: Double
    }
}
