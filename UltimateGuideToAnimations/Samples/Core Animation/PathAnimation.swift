import UIKit

enum PathAnimation {}

extension PathAnimation {
  class PathAnimationExampleViewController: UIViewController {
    private let viewController = PathAnimationViewController()

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

      let toggle = self.toggle
      toggle.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(toggle)

      NSLayoutConstraint.activate([
        toggle.topAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: 20),
        toggle.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
      ])

      toggle.addAction(
        UIAction(
          handler: { _ in
            viewController.resetAnimation(toggle.isOn)
          }
        ),
        for: .valueChanged
      )

      label.text = "Rotateion Mode:"
      label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
      label.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(label)

      NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: 20),
        label.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
      ])
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)

      toggle.removeFromSuperview()
      view.superview?.addSubview(toggle)

      NSLayoutConstraint.activate([
        toggle.topAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: 20),
        toggle.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
      ])

      label.removeFromSuperview()
      view.superview?.addSubview(label)

      NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: 20),
        label.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
      ])
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      toggle.isOn = false
    }
  }
}

class PathAnimationViewController: UIViewController {
  private let shapeLayer = CAShapeLayer()
  private let textLayer = CATextLayer()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    view.layer.cornerRadius = 40
    view.layer.cornerCurve = .continuous
    view.layer.borderWidth = 2
    view.layer.borderColor = UIColor.systemGray.cgColor

  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    shapeLayer.frame = view.bounds

    let size = CGSize(width: 200, height: 200)
    let path = UIBezierPath(
      ovalIn: CGRect(
        x: (view.bounds.width - size.width) / 2, y: (view.bounds.height - size.height) / 2,
        width: size.width, height: size.height
      )
    )
    shapeLayer.path = path.cgPath
    shapeLayer.lineWidth = 2
    shapeLayer.strokeColor = UIColor.systemGray2.cgColor
    shapeLayer.fillColor = UIColor.clear.cgColor

    view.layer.addSublayer(shapeLayer)

    textLayer.backgroundColor = UIColor.clear.cgColor
    textLayer.frame = CGRect(x: 100, y: 100, width: 40, height: 40)
    textLayer.string = "➡️"

    view.layer.addSublayer(textLayer)

    resetAnimation()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
  }

  func resetAnimation(_ rotateAuto: Bool = false) {
    textLayer.removeAllAnimations()

    DispatchQueue.main.async { [self] in
      let animation = CAKeyframeAnimation(keyPath: "position")
      animation.duration = 8
      animation.repeatDuration = .infinity
      animation.calculationMode = .paced
      animation.path = shapeLayer.path

      if rotateAuto {
        animation.rotationMode = .rotateAuto
      }

      textLayer.add(animation, forKey: nil)
    }
  }
}
