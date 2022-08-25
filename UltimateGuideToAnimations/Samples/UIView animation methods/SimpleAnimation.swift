import UIKit

extension UIViewAnimations {
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

      let viewWidth = view.bounds.width
      UIView.animate(
        withDuration: 4,
        delay: 1.5,
        options: [.curveEaseInOut, .repeat, .autoreverse],
        animations: {
          cyanView.frame = CGRect(x: viewWidth - 100, y: cyanView.frame.origin.y, width: 100, height: 100)
          cyanView.backgroundColor = .systemRed
        }
      )
    }
  }
}
