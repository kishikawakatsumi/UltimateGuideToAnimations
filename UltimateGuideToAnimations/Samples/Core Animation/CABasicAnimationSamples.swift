import UIKit

enum BasicAnimation {}

extension BasicAnimation {
  class RotateAnimationViewController: UIViewController {
    private let cyanView = UIView()

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

      cyanView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(cyanView)

      NSLayoutConstraint.activate([
        cyanView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        cyanView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        cyanView.widthAnchor.constraint(equalToConstant: 200),
        cyanView.heightAnchor.constraint(equalToConstant: 200),
      ])
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let animation = CABasicAnimation(keyPath: "transform.rotation.z")
      animation.duration = 4
      animation.repeatCount = .infinity
      animation.fromValue = 0
      animation.toValue = CGFloat.pi

      cyanView.layer.add(animation, forKey: nil)
    }
  }

  class BackgroundColorAnimationViewController: UIViewController {
    private let cyanView = UIView()
    private var timer: Timer?

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

      cyanView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(cyanView)

      NSLayoutConstraint.activate([
        cyanView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        cyanView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        cyanView.widthAnchor.constraint(equalToConstant: 200),
        cyanView.heightAnchor.constraint(equalToConstant: 200),
      ])
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let cyanView = self.cyanView

      let timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.backgroundColor))
        animation.duration = 2
        animation.toValue = UIColor.systemRed.cgColor

        cyanView.layer.add(animation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      self.timer?.invalidate()
    }
  }

  class BackgroundColorFillModeAnimationViewController: UIViewController {
    private let cyanView = UIView()

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

      cyanView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(cyanView)

      NSLayoutConstraint.activate([
        cyanView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        cyanView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        cyanView.widthAnchor.constraint(equalToConstant: 200),
        cyanView.heightAnchor.constraint(equalToConstant: 200),
      ])
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let animation = CABasicAnimation(keyPath: #keyPath(CALayer.backgroundColor))
      animation.duration = 2

      animation.fillMode = .forwards
      animation.isRemovedOnCompletion = false

      animation.toValue = UIColor.systemRed.cgColor

      cyanView.layer.add(animation, forKey: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)

      cyanView.layer.removeAllAnimations()
      if #available(iOS 15.0, *) {
        cyanView.layer.backgroundColor = UIColor.systemCyan.cgColor
      } else {
        cyanView.layer.backgroundColor = UIColor.cyan.cgColor
      }
    }
  }

  class BackgroundColorSetPropertyAnimationViewController: UIViewController {
    private let cyanView = UIView()

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

      cyanView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(cyanView)

      NSLayoutConstraint.activate([
        cyanView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        cyanView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        cyanView.widthAnchor.constraint(equalToConstant: 200),
        cyanView.heightAnchor.constraint(equalToConstant: 200),
      ])
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let animation = CABasicAnimation(keyPath: #keyPath(CALayer.backgroundColor))
      animation.duration = 2

      let fromValue = cyanView.layer.backgroundColor
      animation.fromValue = fromValue

      let toValue = UIColor.systemRed.cgColor
      animation.toValue = toValue

      cyanView.layer.backgroundColor = toValue

      cyanView.layer.add(animation, forKey: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      if #available(iOS 15.0, *) {
        cyanView.layer.backgroundColor = UIColor.systemCyan.cgColor
      } else {
        cyanView.layer.backgroundColor = UIColor.cyan.cgColor
      }
    }
  }
}
