import UIKit

protocol PresentationSlideViewController: UIViewController {
  static var identifier: String { get }
  static func makeViewController(setup: (Self) -> Void) -> Self
}

extension PresentationSlideViewController {
  static func makeViewController(setup: (Self) -> Void = { _ in }) -> Self {
    let viewController = UIStoryboard(name: "Templates", bundle: nil)
      .instantiateViewController(identifier: identifier) { Self(coder: $0) }
    setup(viewController)
    return viewController
  }

  func itself<T>(_ value: T) -> T { value }
}
