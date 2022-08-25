import UIKit

enum SpringAnimation {}

extension SpringAnimation {
  class SpringAnimationExampleViewController: UIViewController {
    private let viewController = SpringAnimationViewController()

    private let toggle = UISwitch()
    private let label = UILabel()

    override func viewDidLoad() {
      super.viewDidLoad()

      let viewController = self.viewController
      viewController.view.clipsToBounds = true

      addChild(viewController)
      viewController.view.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(viewController.view)
      viewController.didMove(toParent: self)

      NSLayoutConstraint.activate([
        viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
        viewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        viewController.view.widthAnchor.constraint(equalToConstant: 320),
        viewController.view.heightAnchor.constraint(equalToConstant: 568),
      ])
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
    }
  }
}

class SpringAnimationViewController: UIViewController {
  private let cyanView = UIView()
  private var timer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    view.layer.cornerRadius = 40
    view.layer.cornerCurve = .continuous
    view.layer.borderWidth = 2
    view.layer.borderColor = UIColor.systemGray.cgColor

    if #available(iOS 15.0, *) {
      cyanView.backgroundColor = .systemCyan
    } else {
      cyanView.backgroundColor = .cyan
    }
    cyanView.layer.cornerRadius = 10

    cyanView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(cyanView)

    NSLayoutConstraint.activate([
      cyanView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      cyanView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      cyanView.widthAnchor.constraint(equalToConstant: 240),
      cyanView.heightAnchor.constraint(equalToConstant: 180),
    ])
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let cyanView = self.cyanView

    let timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
      cyanView.alpha = 0

      UIView.animate(withDuration: 1, delay: 1) {
        cyanView.alpha = 0
        cyanView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
      } completion: { _ in
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10) {
          cyanView.alpha = 1
          cyanView.transform = .identity
        }
      }
    }
    timer.fire()
    self.timer = timer
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    timer?.invalidate()
  }
}

extension SpringAnimation {
  class SpringCAAnimationExampleViewController: UIViewController {
    private let viewController = SpringCAAnimationViewController()

    private let toggle = UISwitch()
    private let label = UILabel()

    override func viewDidLoad() {
      super.viewDidLoad()

      let viewController = self.viewController
      viewController.view.clipsToBounds = true

      addChild(viewController)
      viewController.view.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(viewController.view)
      viewController.didMove(toParent: self)

      NSLayoutConstraint.activate([
        viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
        viewController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        viewController.view.widthAnchor.constraint(equalToConstant: 320),
        viewController.view.heightAnchor.constraint(equalToConstant: 568),
      ])
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
    }
  }
}

class SpringCAAnimationViewController: UIViewController {
  private let cyanView = UIView()
  private var timer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    view.layer.cornerRadius = 40
    view.layer.cornerCurve = .continuous
    view.layer.borderWidth = 2
    view.layer.borderColor = UIColor.systemGray.cgColor

    if #available(iOS 15.0, *) {
      cyanView.backgroundColor = .systemCyan
    } else {
      cyanView.backgroundColor = .cyan
    }
    cyanView.layer.cornerRadius = 10

    cyanView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(cyanView)

    NSLayoutConstraint.activate([
      cyanView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      cyanView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      cyanView.widthAnchor.constraint(equalToConstant: 240),
      cyanView.heightAnchor.constraint(equalToConstant: 180),
    ])
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let cyanView = self.cyanView

    let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
      cyanView.alpha = 0

      UIView.animate(withDuration: 0.5, delay: 1) {
        cyanView.alpha = 0
      } completion: { _ in
        cyanView.alpha = 1

        do {
          let animation = CASpringAnimation(keyPath: #keyPath(CALayer.opacity))
          animation.duration = 0.6
          animation.fromValue = 0
          animation.toValue = 1

          cyanView.layer.add(animation, forKey: nil)
        }
        do {
          let animation = CASpringAnimation(keyPath: "transform.scale")
          animation.duration = 1
          animation.fromValue = 0.8
          animation.toValue = 1

          animation.damping = 5
          animation.initialVelocity = 2
          animation.mass = 0.5
          animation.stiffness = 392

          cyanView.layer.add(animation, forKey: nil)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
          cyanView.alpha = 0
        }
      }
    }
    timer.fire()
    self.timer = timer
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    timer?.invalidate()
  }
}
