import Foundation
import SwiftUI

struct LandmarkCommands: Commands {
  @FocusedBinding(\.selectedLandmark) var selectedLandmark

  var body: some Commands {
    SidebarCommands()
    CommandMenu("Landmark") {
      Button("\(selectedLandmark?.isFavorite == true ? "Remove" : "Mark") as Favorite") {
        selectedLandmark?.isFavorite.toggle()
      }
      .disabled(selectedLandmark == nil)
      .keyboardShortcut("f", modifiers: [.shift, .option])
    }
  }
}

private struct SelectLandmarkKey: FocusedValueKey {
  typealias Value = Binding<Landmark>
}

extension FocusedValues {
  var selectedLandmark: Binding<Landmark>? {
    get { self[SelectLandmarkKey.self] }
    set { self[SelectLandmarkKey.self] = newValue }
  }
}
