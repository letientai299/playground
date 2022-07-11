//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Le Tien Tai on 11/7/22.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ModelData())
        }
    }
}
