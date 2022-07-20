import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
  @Binding var currentPage: Int

  var pages: [Page]

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIViewController(context: Context) -> UIPageViewController {
    let pageViewController = UIPageViewController(
      transitionStyle: .scroll,
      navigationOrientation: .horizontal
    )

    pageViewController.dataSource = context.coordinator
    pageViewController.delegate = context.coordinator

    return pageViewController
  }

  func updateUIViewController(
    _ uiViewController: UIPageViewController, context: Context
  ) {
    uiViewController.setViewControllers(
      [context.coordinator.ctrls[currentPage]],
      direction: .forward,
      animated: true
    )
  }

  class Coordinator:
    NSObject,
    UIPageViewControllerDataSource,
    UIPageViewControllerDelegate
  {
    func pageViewController(
      _ pvc: UIPageViewController, viewControllerBefore vc: UIViewController
    ) -> UIViewController? {
      guard let index = ctrls.firstIndex(of: vc) else {
        return nil
      }

      if index == 0 {
        return ctrls.last
      }

      return ctrls[index - 1]
    }

    func pageViewController(
      _ pvc: UIPageViewController, viewControllerAfter vc: UIViewController
    ) -> UIViewController? {
      guard let index = ctrls.firstIndex(of: vc) else {
        return nil
      }

      if index == ctrls.count - 1 {
        return ctrls.first
      }

      return ctrls[index + 1]
    }

    func pageViewController(
      _ pvc: UIPageViewController,
      didFinishAnimating finished: Bool,
      previousViewControllers: [UIViewController],
      transitionCompleted completed: Bool
    ) {
      if completed,
        let visibleVC = pvc.viewControllers?.first,
        let index = ctrls.firstIndex(of: visibleVC)
      {
        parent.currentPage = index
      }
    }

    var parent: PageViewController
    var ctrls: [UIViewController] = []

    init(_ parent: PageViewController<Page>) {
      self.parent = parent
      ctrls = parent.pages.map { UIHostingController(rootView: $0) }
    }
  }
}
