//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by Le Tien Tai on 11/7/22.
//

import SwiftUI
import Inject

@main
struct LandmarksApp: App {
    @ObservedObject private var iO = Inject.observer
    @StateObject private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                    .environmentObject(ModelData())
                    .enableInjection()
        }
    }
}
