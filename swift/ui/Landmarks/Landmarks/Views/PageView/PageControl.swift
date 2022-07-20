import SwiftUI
import UIKit

struct PageControl: UIViewRepresentable {
  var numPages: Int
  @Binding var currentPage: Int

  func makeCoordinator() -> Coor {
    Coor(self)
  }

  func makeUIView(context: Context) -> UIPageControl {
    let ctrl = UIPageControl()
    ctrl.numberOfPages = numPages
    ctrl.addTarget(
      context.coordinator,
      action: #selector(Coor.updateCurrentPage(sender:)),
      for: .valueChanged
    )
    return ctrl
  }

  func updateUIView(_ uiView: UIPageControl, context: Context) {
    uiView.currentPage = currentPage
  }

  class Coor: NSObject {
    var ctrl: PageControl

    init(_ ctrl: PageControl) {
      self.ctrl = ctrl
    }

    @objc
    func updateCurrentPage(sender: UIPageControl) {
      ctrl.currentPage = sender.currentPage
    }
  }
}
