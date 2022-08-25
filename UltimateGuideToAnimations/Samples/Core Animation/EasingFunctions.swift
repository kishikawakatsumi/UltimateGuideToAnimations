import UIKit

enum EasingFunctions {}

extension EasingFunctions {
  class BaseViewController: UIViewController {
    fileprivate let animationView = UIView()
    fileprivate let animationLayer = CALayer()
    fileprivate let animationViewContainer = UIView()
    fileprivate let easingBackgroundView = EasingView()
    fileprivate let easingView = EasingView()
    fileprivate var timer: Timer?
    fileprivate var headerText: String = ""
    let codeButton = UIButton(type: .custom)

    override func viewDidLoad() {
      super.viewDidLoad()

      let backgroundView = UIView()
      backgroundView.backgroundColor = .systemGroupedBackground
      backgroundView.layer.cornerRadius = 6

      backgroundView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(backgroundView)
      NSLayoutConstraint.activate([
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      ])

      let rootView = UIStackView()
      rootView.axis = .vertical
      rootView.distribution = .fill
      rootView.spacing = 4

      rootView.translatesAutoresizingMaskIntoConstraints = false
      backgroundView.addSubview(rootView)
      NSLayoutConstraint.activate([
        rootView.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
        rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        rootView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
      ])

      let headerView = UIStackView()
      headerView.axis = .horizontal
      headerView.distribution = .equalSpacing

      let titleLabel = UILabel()
      titleLabel.text = headerText
      titleLabel.font = UIFont.monospacedSystemFont(ofSize: 36, weight: .regular)

      titleLabel.translatesAutoresizingMaskIntoConstraints = false
      headerView.addArrangedSubview(titleLabel)

      codeButton.setImage(UIImage(systemName: "doc.text", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .regular, scale: .default)), for: .normal)

      codeButton.translatesAutoresizingMaskIntoConstraints = false
      headerView.addArrangedSubview(codeButton)

      headerView.translatesAutoresizingMaskIntoConstraints = false
      rootView.addArrangedSubview(headerView)

      let contentView = UIView()
      contentView.backgroundColor = .systemIndigo
      contentView.layer.cornerRadius = 4

      contentView.translatesAutoresizingMaskIntoConstraints = false
      rootView.addArrangedSubview(contentView)

      animationViewContainer.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(animationViewContainer)
      NSLayoutConstraint.activate([
        animationViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
        animationViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
        animationViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        animationViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      ])

      if #available(iOS 15.0, *) {
        animationView.backgroundColor = .systemCyan
      } else {
        animationView.backgroundColor = .cyan
      }
      animationView.layer.cornerRadius = 12

      animationView.translatesAutoresizingMaskIntoConstraints = false
      animationViewContainer.addSubview(animationView)
      NSLayoutConstraint.activate([
        animationView.leadingAnchor.constraint(equalTo: animationViewContainer.leadingAnchor, constant: 4),
        animationView.bottomAnchor.constraint(equalTo: animationViewContainer.bottomAnchor),
        animationView.widthAnchor.constraint(equalToConstant: 24),
        animationView.heightAnchor.constraint(equalToConstant: 24),
      ])

      do {
        easingBackgroundView.backgroundColor = .systemGray6
        easingBackgroundView.layer.cornerRadius = 4

        let shapeLayer: CAShapeLayer = easingBackgroundView.layer as! CAShapeLayer
        shapeLayer.lineWidth = 4
        shapeLayer.strokeColor = UIColor.systemGray2.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.setAffineTransform(CGAffineTransform(scaleX: 1, y: -1))

        easingBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(easingBackgroundView)
        NSLayoutConstraint.activate([
          easingBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
          easingBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
          easingBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
          easingBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
      }

      easingView.backgroundColor = .clear

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      shapeLayer.lineWidth = 4
      shapeLayer.strokeColor = UIColor.systemRed.cgColor
      shapeLayer.fillColor = UIColor.clear.cgColor
      shapeLayer.setAffineTransform(CGAffineTransform(scaleX: 1, y: -1))

      easingView.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview(easingView)
      NSLayoutConstraint.activate([
        easingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
        easingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 48),
        easingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        easingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
      ])
    }
  }

  class LinearViewController: BaseViewController {
    override var headerText: String {
      get { "linear" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[2] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()
      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))
      path.addCurve(
        to: CGPoint(x: easingView.bounds.maxX, y: easingView.bounds.maxY),
        controlPoint1: CGPoint(x: easingView.bounds.maxX * 0, y: easingView.bounds.maxY * 0.0),
        controlPoint2: CGPoint(x: easingView.bounds.maxX * 1.0, y: easingView.bounds.maxY * 1.0)
      )
      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
      let animation = CABasicAnimation(keyPath: "transform.translation.y")
      animation.duration = 2
      animation.timingFunction = CAMediaTimingFunction(name: .linear)
      animation.toValue = -(easingView.bounds.height - animationView.bounds.height)

      animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 2
        pathAnimation.timingFunction = animation.timingFunction
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }
  }

  class EaseInViewController: BaseViewController {
    override var headerText: String {
      get { "easeIn" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[3] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()
      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))
      path.addCurve(
        to: CGPoint(x: easingView.bounds.maxX, y: easingView.bounds.maxY),
        controlPoint1: CGPoint(x: easingView.bounds.maxX * 0.42, y: easingView.bounds.maxY * 0.0),
        controlPoint2: CGPoint(x: easingView.bounds.maxX * 1.0, y: easingView.bounds.maxY * 1.0)
      )
      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        animation.toValue = -(easingView.bounds.height - animationView.bounds.height)

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 2
        pathAnimation.timingFunction = animation.timingFunction
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }
  }

  class EaseOutViewController: BaseViewController {
    override var headerText: String {
      get { "easeOut" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[4] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()
      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))
      path.addCurve(
        to: CGPoint(x: easingView.bounds.maxX, y: easingView.bounds.maxY),
        controlPoint1: CGPoint(x: easingView.bounds.maxX * 0.0, y: easingView.bounds.maxY * 0.0),
        controlPoint2: CGPoint(x: easingView.bounds.maxX * 0.58, y: easingView.bounds.maxY * 1.0)
      )
      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.toValue = -(easingView.bounds.height - animationView.bounds.height)

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 2
        pathAnimation.timingFunction = animation.timingFunction
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }
  }

  class EaseInEaseOutViewController: BaseViewController {
    override var headerText: String {
      get { "easeInEaseOut" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[5] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()
      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))
      path.addCurve(
        to: CGPoint(x: easingView.bounds.maxX, y: easingView.bounds.maxY),
        controlPoint1: CGPoint(x: easingView.bounds.maxX * 0.42, y: easingView.bounds.maxY * 0.0),
        controlPoint2: CGPoint(x: easingView.bounds.maxX * 0.58, y: easingView.bounds.maxY * 1.0)
      )
      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.toValue = -(easingView.bounds.height - animationView.bounds.height)

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 2
        pathAnimation.timingFunction = animation.timingFunction
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }
  }

  class DefaultViewController: BaseViewController {
    override var headerText: String {
      get { "default" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[6] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()
      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))
      path.addCurve(
        to: CGPoint(x: easingView.bounds.maxX, y: easingView.bounds.maxY),
        controlPoint1: CGPoint(x: easingView.bounds.maxX * 0.25, y: easingView.bounds.maxY * 0.1),
        controlPoint2: CGPoint(x: easingView.bounds.maxX * 0.25, y: easingView.bounds.maxY * 1.0)
      )
      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .default)
        animation.toValue = -(easingView.bounds.height - animationView.bounds.height)

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 2
        pathAnimation.timingFunction = animation.timingFunction
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }
  }

  class EaseInSineViewController: BaseViewController {
    override var headerText: String {
      get { "easeInSine" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[7] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let controlPoints = (CGPoint(x: 0.12, y: 0), CGPoint(x: 0.39, y: 0))

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()
      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))
      path.addCurve(
        to: CGPoint(x: easingView.bounds.maxX, y: easingView.bounds.maxY),
        controlPoint1: CGPoint(x: easingView.bounds.maxX * controlPoints.0.x, y: easingView.bounds.maxY * controlPoints.0.y),
        controlPoint2: CGPoint(x: easingView.bounds.maxX * controlPoints.1.x, y: easingView.bounds.maxY * controlPoints.1.y)
      )
      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(
          controlPoints: Float(controlPoints.0.x),
          Float(controlPoints.0.y),
          Float(controlPoints.1.x),
          Float(controlPoints.1.y)
        )
        animation.toValue = -(easingView.bounds.height - animationView.bounds.height)

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 2
        pathAnimation.timingFunction = animation.timingFunction
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }
  }

  class EaseOutSineViewController: BaseViewController {
    override var headerText: String {
      get { "easeOutSine" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[8] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let controlPoints = (CGPoint(x: 0.61, y: 1), CGPoint(x: 0.88, y: 1))

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()
      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))
      path.addCurve(
        to: CGPoint(x: easingView.bounds.maxX, y: easingView.bounds.maxY),
        controlPoint1: CGPoint(x: easingView.bounds.maxX * controlPoints.0.x, y: easingView.bounds.maxY * controlPoints.0.y),
        controlPoint2: CGPoint(x: easingView.bounds.maxX * controlPoints.1.x, y: easingView.bounds.maxY * controlPoints.1.y)
      )
      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(
          controlPoints: Float(controlPoints.0.x),
          Float(controlPoints.0.y),
          Float(controlPoints.1.x),
          Float(controlPoints.1.y)
        )
        animation.toValue = -(easingView.bounds.height - animationView.bounds.height)

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 2
        pathAnimation.timingFunction = animation.timingFunction
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }
  }

  class EaseInOutSineViewController: BaseViewController {
    override var headerText: String {
      get { "easeInOutSine" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[9] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let controlPoints = (CGPoint(x: 0.37, y: 0), CGPoint(x: 0.63, y: 1))

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()
      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))
      path.addCurve(
        to: CGPoint(x: easingView.bounds.maxX, y: easingView.bounds.maxY),
        controlPoint1: CGPoint(x: easingView.bounds.maxX * controlPoints.0.x, y: easingView.bounds.maxY * controlPoints.0.y),
        controlPoint2: CGPoint(x: easingView.bounds.maxX * controlPoints.1.x, y: easingView.bounds.maxY * controlPoints.1.y)
      )
      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(
          controlPoints: Float(controlPoints.0.x),
          Float(controlPoints.0.y),
          Float(controlPoints.1.x),
          Float(controlPoints.1.y)
        )
        animation.toValue = -(easingView.bounds.height - animationView.bounds.height)

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 2
        pathAnimation.timingFunction = animation.timingFunction
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }
  }

  class EaseInCubicViewController: BaseViewController {
    override var headerText: String {
      get { "easeInCubic" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[10] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let controlPoints = (CGPoint(x: 0.32, y: 0), CGPoint(x: 0.67, y: 0))

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()
      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))
      path.addCurve(
        to: CGPoint(x: easingView.bounds.maxX, y: easingView.bounds.maxY),
        controlPoint1: CGPoint(x: easingView.bounds.maxX * controlPoints.0.x, y: easingView.bounds.maxY * controlPoints.0.y),
        controlPoint2: CGPoint(x: easingView.bounds.maxX * controlPoints.1.x, y: easingView.bounds.maxY * controlPoints.1.y)
      )
      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(
          controlPoints: Float(controlPoints.0.x),
          Float(controlPoints.0.y),
          Float(controlPoints.1.x),
          Float(controlPoints.1.y)
        )
        animation.toValue = -(easingView.bounds.height - animationView.bounds.height)

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 2
        pathAnimation.timingFunction = animation.timingFunction
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }
  }

  class EaseOutCubicViewController: BaseViewController {
    override var headerText: String {
      get { "easeOutCubic" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[11] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let controlPoints = (CGPoint(x: 0.33, y: 1), CGPoint(x: 0.68, y: 1))

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()
      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))
      path.addCurve(
        to: CGPoint(x: easingView.bounds.maxX, y: easingView.bounds.maxY),
        controlPoint1: CGPoint(x: easingView.bounds.maxX * controlPoints.0.x, y: easingView.bounds.maxY * controlPoints.0.y),
        controlPoint2: CGPoint(x: easingView.bounds.maxX * controlPoints.1.x, y: easingView.bounds.maxY * controlPoints.1.y)
      )
      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(
          controlPoints: Float(controlPoints.0.x),
          Float(controlPoints.0.y),
          Float(controlPoints.1.x),
          Float(controlPoints.1.y)
        )
        animation.toValue = -(easingView.bounds.height - animationView.bounds.height)

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 2
        pathAnimation.timingFunction = animation.timingFunction
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }
  }

  class EaseInOutCubicViewController: BaseViewController {
    override var headerText: String {
      get { "easeInOutCubic" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[12] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let controlPoints = (CGPoint(x: 0.65, y: 0), CGPoint(x: 0.35, y: 1))

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()
      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))
      path.addCurve(
        to: CGPoint(x: easingView.bounds.maxX, y: easingView.bounds.maxY),
        controlPoint1: CGPoint(x: easingView.bounds.maxX * controlPoints.0.x, y: easingView.bounds.maxY * controlPoints.0.y),
        controlPoint2: CGPoint(x: easingView.bounds.maxX * controlPoints.1.x, y: easingView.bounds.maxY * controlPoints.1.y)
      )
      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
        let animation = CABasicAnimation(keyPath: "transform.translation.y")
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(
          controlPoints: Float(controlPoints.0.x),
          Float(controlPoints.0.y),
          Float(controlPoints.1.x),
          Float(controlPoints.1.y)
        )
        animation.toValue = -(easingView.bounds.height - animationView.bounds.height)

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 2
        pathAnimation.timingFunction = animation.timingFunction
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }
  }

  class EaseInElasticViewController: BaseViewController {
    override var headerText: String {
      get { "easeInElastic" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[13] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()

      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))

      let origin = CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX)
      path.move(to: origin)

      let interstitialSteps = 99.0
      let stepSize = 1.0 / (interstitialSteps + 1)
      for x in stride(from: 0.0, to: 1.0, by: stepSize) {
        path.addLine(
          to: CGPoint(
            x: origin.x + x * (easingView.bounds.maxX - origin.x),
            y: origin.y + easing(x: x) * (easingView.bounds.maxY - origin.y)
          )
        )
      }

      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.duration = 3

        let values = self.values(
          start: 0,
          end: -(easingView.bounds.height - animationView.bounds.height),
          steps: interstitialSteps
        )
        animation.values = values

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 3
        pathAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }

    private func easing(x: CGFloat) -> CGFloat {
      let c4 = (2 * CGFloat.pi) / 3

      return x == 0
      ? 0
      : x == 1
      ? 1
      : -pow(2, 10 * x - 10) * sin((x * 10 - 10.75) * c4)
    }

    private func values(start: CGFloat, end: CGFloat, steps: CGFloat) -> [CGFloat] {
      let count = steps + 2
      var values = [CGFloat]()

      var progress = 0.0
      let increment = 1.0 / (count - 1)
      for _ in 0..<Int(count) {
        let value = start + easing(x: progress) * (end - start)
        values.append(value)

        progress += increment
      }

      return values
    }
  }

  class EaseOutElasticViewController: BaseViewController {
    override var headerText: String {
      get { "easeOutElastic" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[14] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()

      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))

      let origin = CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX)
      path.move(to: origin)

      let interstitialSteps = 99.0
      let stepSize = 1.0 / (interstitialSteps + 1)
      for x in stride(from: 0.0, to: 1.0, by: stepSize) {
        path.addLine(
          to: CGPoint(
            x: origin.x + x * (easingView.bounds.maxX - origin.x),
            y: origin.y + easing(x: x) * (easingView.bounds.maxY - origin.y)
          )
        )
      }

      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.duration = 3

        let values = self.values(
          start: 0,
          end: -(easingView.bounds.height - animationView.bounds.height),
          steps: interstitialSteps
        )
        animation.values = values

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 3
        pathAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }

    private func easing(x: CGFloat) -> CGFloat {
      let c4 = (2 * CGFloat.pi) / 3

      return x == 0
      ? 0
      : x == 1
      ? 1
      : pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1
    }

    private func values(start: CGFloat, end: CGFloat, steps: CGFloat) -> [CGFloat] {
      let count = steps + 2
      var values = [CGFloat]()

      var progress = 0.0
      let increment = 1.0 / (count - 1)
      for _ in 0..<Int(count) {
        let value = start + easing(x: progress) * (end - start)
        values.append(value)

        progress += increment
      }

      return values
    }
  }

  class EaseInBounceViewController: BaseViewController {
    override var headerText: String {
      get { "easeInBounce" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[15] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()

      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))

      let origin = CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX)
      path.move(to: origin)

      let interstitialSteps = 99.0
      let stepSize = 1.0 / (interstitialSteps + 1)
      for x in stride(from: 0.0, to: 1.0, by: stepSize) {
        path.addLine(
          to: CGPoint(
            x: origin.x + x * (easingView.bounds.maxX - origin.x),
            y: origin.y + easing(x: x) * (easingView.bounds.maxY - origin.y)
          )
        )
      }

      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.duration = 3

        let values = self.values(
          start: 0,
          end: -(easingView.bounds.height - animationView.bounds.height),
          steps: interstitialSteps
        )
        animation.values = values

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 3
        pathAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }

    private func easing(x: CGFloat) -> CGFloat {
      pow(2.0, 6.0 * (x - 1)) * abs(sin(x * .pi * 3.5))
    }

    private func values(start: CGFloat, end: CGFloat, steps: CGFloat) -> [CGFloat] {
      let count = steps + 2
      var values = [CGFloat]()

      var progress = 0.0
      let increment = 1.0 / (count - 1)
      for _ in 0..<Int(count) {
        let value = start + easing(x: progress) * (end - start)
        values.append(value)

        progress += increment
      }

      return values
    }
  }

  class EaseOutBounceViewController: BaseViewController {
    override var headerText: String {
      get { "easeOutBounce" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()

      codeButton.addAction(
        UIAction(
          handler: { [self] _ in
            let viewController = UIStoryboard(name: "ViewAnimatableProperties", bundle: nil).instantiateInitialViewController()!
            viewController.modalPresentationStyle = .popover
            viewController.popoverPresentationController?.permittedArrowDirections = [.up, .down]
            viewController.popoverPresentationController?.sourceView = codeButton
            viewController.overrideUserInterfaceStyle = .light

            let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[16] as! UIView

            textView.translatesAutoresizingMaskIntoConstraints = false
            viewController.view.addSubview(textView)
            NSLayoutConstraint.activate([
              textView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
              textView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
              textView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
              textView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            ])

            present(viewController, animated: true)
          }
        ),
        for: .touchUpInside
      )
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let shapeLayer: CAShapeLayer = easingView.layer as! CAShapeLayer
      let path = UIBezierPath()

      path.move(to: CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX))

      let origin = CGPoint(x: easingView.bounds.minX, y: easingView.bounds.minX)
      path.move(to: origin)

      let interstitialSteps = 99.0
      let stepSize = 1.0 / (interstitialSteps + 1)
      for x in stride(from: 0.0, to: 1.0, by: stepSize) {
        path.addLine(
          to: CGPoint(
            x: origin.x + x * (easingView.bounds.maxX - origin.x),
            y: origin.y + easing(x: x) * (easingView.bounds.maxY - origin.y)
          )
        )
      }

      shapeLayer.path = path.cgPath
      (easingBackgroundView.layer as! CAShapeLayer).path = shapeLayer.path

      let animationView = self.animationView
      let easingView = self.easingView

      let timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.duration = 3

        let values = self.values(
          start: 0,
          end: -(easingView.bounds.height - animationView.bounds.height),
          steps: interstitialSteps
        )
        animation.values = values

        animationView.layer.add(animation, forKey: nil)

        let pathAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        pathAnimation.duration = 3
        pathAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1

        easingView.layer.add(pathAnimation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }

    private func easing(x: CGFloat) -> CGFloat {
      1.0 - pow(2.0, -6.0 * x) * abs(cos(x * .pi * 3.5))
    }

    private func values(start: CGFloat, end: CGFloat, steps: CGFloat) -> [CGFloat] {
      let count = steps + 2
      var values = [CGFloat]()

      var progress = 0.0
      let increment = 1.0 / (count - 1)
      for _ in 0..<Int(count) {
        let value = start + easing(x: progress) * (end - start)
        values.append(value)

        progress += increment
      }

      return values
    }
  }

  class BlankViewController: BaseViewController {
    override var headerText: String {
      get { "default" }
      set { super.headerText = newValue }
    }

    override func viewDidLoad() {
      super.viewDidLoad()
      for subview in view.subviews {
        subview.removeFromSuperview()
      }
    }
  }
}

class EasingView: UIView {
  override class var layerClass: AnyClass {
    CAShapeLayer.self
  }
}

