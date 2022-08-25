import UIKit

enum UIViewAnimations {}

extension UIViewAnimations {
  class BaseViewController: UIViewController {
    fileprivate let animationView = UIView()
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

  class AnimateFrameViewController: BaseViewController {
    override var headerText: String {
      get { "frame" }
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

            let textView = UINib(nibName: "ViewAnimatableProperties", bundle: nil).instantiate(withOwner: nil)[0] as! UIView

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
      
      let animationView = self.animationView
      animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

      let viewWidth = animationViewContainer.bounds.width
      let viewHeight = animationViewContainer.bounds.height
      UIView.animate(withDuration: 4, delay: 1.5, options: [.autoreverse, .repeat]) {
        animationView.frame = CGRect(x: viewWidth - 200, y: viewHeight - 200, width: 200, height: 200)
      }
    }
  }

  class AnimateBoundsViewController: BaseViewController {
    override var headerText: String {
      get { "bounds" }
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

            let textView = UINib(nibName: "ViewAnimatableProperties", bundle: nil).instantiate(withOwner: nil)[1] as! UIView

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

      let animationView = self.animationView
      animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
      animationView.center = animationViewContainer.center

      UIView.animate(withDuration: 4, delay: 1.5, options: [.autoreverse, .repeat]) {
        animationView.bounds.size = CGSize(width: 200, height: 200)
      }
    }
  }

  class AnimateCenterViewController: BaseViewController {
    override var headerText: String {
      get { "center" }
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

            let textView = UINib(nibName: "ViewAnimatableProperties", bundle: nil).instantiate(withOwner: nil)[2] as! UIView

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

      let animationView = self.animationView
      animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
      animationView.center.y = animationViewContainer.center.y

      let viewWidth = animationViewContainer.bounds.width
      UIView.animate(withDuration: 4, delay: 1.5, options: [.autoreverse, .repeat]) {
        animationView.center = CGPoint(x: viewWidth - animationView.bounds.width / 2, y: animationView.center.y)
      }
    }
  }

  class AnimateTransformViewController: BaseViewController {
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

            let textView = UINib(nibName: "ViewAnimatableProperties", bundle: nil).instantiate(withOwner: nil)[3] as! UIView

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

      let animationView = self.animationView
      animationView.transform = .identity
      animationView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
      animationView.center = animationViewContainer.center
      UIView.animate(withDuration: 4, delay: 1.5, options: [.autoreverse, .repeat]) {
        let scaleTransform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        let rotateTransform = CGAffineTransform(rotationAngle: .pi)
        animationView.transform = scaleTransform.concatenating(rotateTransform)
      }
    }
  }

  class AnimateAlphaViewController: BaseViewController {
    override var headerText: String {
      get { "alpha" }
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

            let textView = UINib(nibName: "ViewAnimatableProperties", bundle: nil).instantiate(withOwner: nil)[4] as! UIView

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

      let animationView = self.animationView
      animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
      animationView.center = animationViewContainer.center
      animationView.alpha = 1
      UIView.animate(withDuration: 4, delay: 1.5, options: [.autoreverse, .repeat]) {
        animationView.alpha = 0
      }
    }
  }

  class AnimateBackgroundColorViewController: BaseViewController {
    override var headerText: String {
      get { "backgroundColor" }
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

            let textView = UINib(nibName: "ViewAnimatableProperties", bundle: nil).instantiate(withOwner: nil)[5] as! UIView

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

      let animationView = self.animationView
      animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
      animationView.center = animationViewContainer.center
      if #available(iOS 15.0, *) {
        animationView.backgroundColor = .systemCyan
      } else {
        animationView.backgroundColor = .cyan
      }
      UIView.animate(withDuration: 4, delay: 1.5, options: [.autoreverse, .repeat]) {
        animationView.backgroundColor = .systemRed
      }
    }
  }
}

class CodeSnippetViewController: UIViewController {
  override var preferredContentSize: CGSize {
    get { CGSize(width: 1200, height: 600) }
    set { super.preferredContentSize = newValue }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
