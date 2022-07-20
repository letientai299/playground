import SwiftUI

@main
struct LandmarksApp: App {
  @StateObject private var m = ModelData()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(m)
    }#if !os(watchOS)
      .commands {
        LandmarkCommands()
      }
    #endif

    #if os(watchOS)
      WKNotificationScene(
        controller: NotificationController.self, category: "LandmarkNear")
    #endif

    #if os(macOS)
      Settings {
        LandmarkSettings()
      }
    #endif
  }
}
