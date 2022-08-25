import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    guard let window = window else { return }

#if !targetEnvironment(macCatalyst)
    let bounds = window.bounds

    let width: CGFloat = 1920
    let height: CGFloat = 1080

    window.frame = CGRect(x: 0, y: 0, width: width, height: height)

    if bounds.width < bounds.height {
      let scale = bounds.height / height
      window.transform = CGAffineTransform(scaleX: scale, y: scale)
    } else {
      let scale = bounds.width / width
      window.transform = CGAffineTransform(scaleX: scale, y: scale)
    }

    if window.frame.width > bounds.width {
      let scale = bounds.width / window.frame.width
      window.transform = window.transform.scaledBy(x: scale, y: scale)
    }
    if window.frame.height > bounds.height {
      let scale = bounds.height / window.frame.height
      window.transform = window.transform.scaledBy(x: scale, y: scale)
    }

    window.frame.origin.x = (bounds.width - window.frame.width) / 2
    window.frame.origin.y = (bounds.height - window.frame.height) / 2
#endif

#if targetEnvironment(macCatalyst)
    if let titlebar = windowScene.titlebar {
      titlebar.titleVisibility = .hidden
      titlebar.toolbar = nil
    }
#endif
  }
}
