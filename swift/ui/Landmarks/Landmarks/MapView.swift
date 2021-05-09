//
//  MapView.swift
//  Landmarks
//
//  Created by Le Tien Tai on 9/5/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                    latitude: 34.011_286,
                    longitude: -116.166_868
            ),
            span: MKCoordinateSpan(
                    latitudeDelta: 0.2,
                    longitudeDelta: 0.2
            )
    )

    var body: some View {
        MapCompat(coordinateRegion: $region)
    }
}

struct MapCompat: NSViewRepresentable {
    @Binding var coordinateRegion: MKCoordinateRegion

    func makeNSView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateNSView(_ view: MKMapView, context: Context) {
        view.region = coordinateRegion
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapCompat

        init(_ parent: MapCompat) {
            self.parent = parent
        }

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            DispatchQueue.main.async {
                self.parent.coordinateRegion = mapView.region
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
