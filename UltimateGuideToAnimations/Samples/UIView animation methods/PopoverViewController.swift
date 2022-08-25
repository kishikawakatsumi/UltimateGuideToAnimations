import UIKit

extension UIViewAnimations {
  class PopoverExampleViewController: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()

      let viewController = UIStoryboard(name: "PopoverViewController", bundle: nil).instantiateInitialViewController()!

      addChild(viewController)

      viewController.view.clipsToBounds = true
      viewController.view.layer.cornerRadius = 40
      viewController.view.layer.cornerCurve = .continuous
      viewController.view.layer.borderWidth = 2
      viewController.view.layer.borderColor = UIColor.systemGray.cgColor
      
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
  }
}

class PopoverViewController: UIViewController {
  @IBOutlet var popoverView: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground

    popoverView.layer.cornerRadius = 12
    popoverView.layer.shadowColor = UIColor.black.cgColor
    popoverView.layer.shadowOffset = CGSize(width: 0, height: 4)
    popoverView.layer.shadowOpacity = 0.2
    popoverView.layer.shadowRadius = 10
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    popoverView.alpha = 0
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    popoverView.alpha = 0
  }

  @IBAction
  private func showPopover(_ sender: UIBarButtonItem) {
    let popoverView = self.popoverView!

    popoverView.alpha = 0
    popoverView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)

    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
      popoverView.alpha = 1
      popoverView.transform = .identity
    }
  }

  @IBAction
  private func hidePopover(_ sender: UIBarButtonItem) {
    let popoverView = self.popoverView!

    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut]) {
      popoverView.alpha = 0
    }
  }
}
