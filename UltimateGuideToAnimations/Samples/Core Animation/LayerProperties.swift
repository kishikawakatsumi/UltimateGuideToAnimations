import UIKit

enum LayerProperties {}

extension LayerProperties {
  class BaseViewController: UIViewController {
    fileprivate let animationView = UIView()
    fileprivate let animationLayer = CALayer()
    fileprivate let animationViewContainer = UIView()
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
      animationViewContainer.addSubview(animationView)
    }
  }

  class CornerRadiusViewController: BaseViewController {
    override var headerText: String {
      get { "cornerRadius" }
      set { super.headerText = newValue }
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let animationView = self.animationView
      animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
      animationView.center = animationViewContainer.center

      animationView.layer.cornerRadius = 40
    }
  }

  class BorderViewController: BaseViewController {
    override var headerText: String {
      get { "borderColor, borderWidth" }
      set { super.headerText = newValue }
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let animationView = self.animationView
      animationView.frame = CGRect(x: 0, y: 0, width: 200, height:200)
      animationView.center = animationViewContainer.center

      animationView.layer.borderColor = UIColor.systemRed.cgColor
      animationView.layer.borderWidth = 20
    }
  }

  class ShadowViewController: BaseViewController {
    override var headerText: String {
      get { "shadowColor, shadowOpacity" }
      set { super.headerText = newValue }
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let animationView = self.animationView
      animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
      animationView.center = animationViewContainer.center

      if #available(iOS 15.0, *) {
        animationView.layer.shadowColor = UIColor.systemMint.cgColor
      } else {
        animationView.layer.shadowColor = UIColor.green.cgColor
      }
      animationView.layer.shadowOpacity = 1
      animationView.layer.shadowOffset = CGSize(width: 0, height: 0)
      animationView.layer.shadowRadius = 30
    }
  }

  class TransformViewController: BaseViewController {
    override var headerText: String {
      get { "transform" }
      set { super.headerText = newValue }
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let animationView = self.animationView
      animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
      animationView.center = animationViewContainer.center

      animationView.layer.transform = CATransform3DMakeRotation(45 * .pi / 180, 0.2, 1, 0)
    }
  }

  enum Animating {
    class CornerRadiusViewController: BaseViewController {
      override var headerText: String {
        get { "cornerRadius" }
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

              let textView = UINib(nibName: "LayerProperties", bundle: nil).instantiate(withOwner: nil)[0] as! UIView

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

        if animationLayer.superlayer == nil {
          let animationView = self.animationView
          animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
          animationView.center = animationViewContainer.center

          animationLayer.frame = animationView.layer.bounds
          animationLayer.backgroundColor = animationView.layer.backgroundColor
          animationView.layer.backgroundColor = UIColor.clear.cgColor

          animationView.layer.addSublayer(animationLayer)

          animate(layer: animationLayer)
        }
      }

      func animate(layer: CALayer) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          layer.cornerRadius = 40

          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.reset(layer: layer)
          }
        }
      }

      func reset(layer: CALayer) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          layer.cornerRadius = 0

          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animate(layer: layer)
          }
        }
      }
    }

    class BorderViewController: BaseViewController {
      override var headerText: String {
        get { "borderColor, borderWidth" }
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

              let textView = UINib(nibName: "LayerProperties", bundle: nil).instantiate(withOwner: nil)[1] as! UIView

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

        if animationLayer.superlayer == nil {
          let animationView = self.animationView
          animationView.frame = CGRect(x: 0, y: 0, width: 200, height:200)
          animationView.center = animationViewContainer.center

          animationLayer.frame = animationView.layer.bounds
          animationLayer.backgroundColor = animationView.layer.backgroundColor
          animationView.layer.backgroundColor = UIColor.clear.cgColor

          animationView.layer.addSublayer(animationLayer)

          animate(layer: animationLayer)
        }
      }

      func animate(layer: CALayer) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          layer.borderColor = UIColor.systemRed.cgColor
          layer.borderWidth = 12

          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.reset(layer: layer)
          }
        }
      }

      func reset(layer: CALayer) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          layer.borderColor = UIColor.clear.cgColor
          layer.borderWidth = 0

          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animate(layer: layer)
          }
        }
      }
    }

    class ShadowViewController: BaseViewController {
      override var headerText: String {
        get { "shadowColor, shadowOpacity" }
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

              let textView = UINib(nibName: "LayerProperties", bundle: nil).instantiate(withOwner: nil)[2] as! UIView

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

        if animationLayer.superlayer == nil {
          let animationView = self.animationView
          animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
          animationView.center = animationViewContainer.center

          animationLayer.frame = animationView.layer.bounds
          animationLayer.backgroundColor = animationView.layer.backgroundColor
          animationView.layer.backgroundColor = UIColor.clear.cgColor

          animationView.layer.addSublayer(animationLayer)

          animate(layer: animationLayer)
        }
      }

      func animate(layer: CALayer) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          if #available(iOS 15.0, *) {
            layer.shadowColor = UIColor.systemMint.cgColor
          } else {
            layer.shadowColor = UIColor.green.cgColor
          }
          layer.shadowOpacity = 1
          layer.shadowOffset = CGSize(width: 0, height: 0)
          layer.shadowRadius = 30

          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.reset(layer: layer)
          }
        }
      }

      func reset(layer: CALayer) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          layer.shadowColor = UIColor.clear.cgColor
          layer.shadowOpacity = 0
          layer.shadowOffset = CGSize(width: 0, height: -3)
          layer.shadowRadius = 3

          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animate(layer: layer)
          }
        }
      }
    }

    class TransformViewController: BaseViewController {
      override var headerText: String {
        get { "transform" }
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

              let textView = UINib(nibName: "LayerProperties", bundle: nil).instantiate(withOwner: nil)[3] as! UIView

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

        if animationLayer.superlayer == nil {
          let animationView = self.animationView
          animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
          animationView.center = animationViewContainer.center

          animationLayer.frame = animationView.layer.bounds
          animationLayer.backgroundColor = animationView.layer.backgroundColor
          animationView.layer.backgroundColor = UIColor.clear.cgColor

          animationView.layer.addSublayer(animationLayer)

          animate(layer: animationLayer)
        }
      }

      func animate(layer: CALayer) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          layer.transform = CATransform3DMakeRotation(180 * .pi / 180, 0, 1, 0)

          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.reset(layer: layer)
          }
        }
      }

      func reset(layer: CALayer) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          layer.transform = CATransform3DIdentity

          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animate(layer: layer)
          }
        }
      }
    }
  }
}
