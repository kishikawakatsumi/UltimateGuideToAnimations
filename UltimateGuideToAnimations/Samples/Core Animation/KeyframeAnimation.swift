import UIKit

enum KeyframeAnimations {}

extension KeyframeAnimations {
  class SimpleAnimationViewController: UIViewController {
    let cyanView = UIView()

    override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = .systemBackground
      view.layer.cornerRadius = 40
      view.layer.cornerCurve = .continuous
      view.layer.borderWidth = 1
      view.layer.borderColor = UIColor.systemGray.cgColor

      if #available(iOS 15.0, *) {
        cyanView.backgroundColor = .systemCyan
      } else {
        cyanView.backgroundColor = .cyan
      }
      view.addSubview(cyanView)
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let cyanView = self.cyanView

      let size = CGSize(width: 200, height: 200)
      cyanView.frame = CGRect(x: 0, y: (view.bounds.height - size.height) / 2, width: size.width, height: size.height)
      if #available(iOS 15.0, *) {
        cyanView.backgroundColor = .systemCyan
      } else {
        cyanView.backgroundColor = .cyan
      }

      UIView.animateKeyframes(withDuration: 2, delay: 0, options: [.repeat, .autoreverse]) {
        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
          cyanView.center.y += 100.0
        }
        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1) {
          cyanView.transform = CGAffineTransform(rotationAngle: .pi / 2)
        }

        UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
          cyanView.center.x += 100.0
        }
        UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.1) {
          cyanView.transform = CGAffineTransform(rotationAngle: .pi)
        }

        UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
          cyanView.center.y -= 100.0
        }
        UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.1) {
          cyanView.transform = CGAffineTransform(rotationAngle: .pi + .pi / 2)
        }

        UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
          cyanView.center.x -= 100.0
        }
        UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.1) {
          cyanView.transform = CGAffineTransform(rotationAngle: .pi * 2)
        }
      }
    }
  }
}
