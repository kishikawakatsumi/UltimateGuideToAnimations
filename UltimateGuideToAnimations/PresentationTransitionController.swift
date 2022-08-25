import UIKit

class PresentationTransitionController: UIViewController {
  var delegate: PresentationTransitionControllerDelegate?
  var progress: Float { Float(currentIndex) / Float(slides.count - 1) }
  var currentPage: Int { currentIndex + 1 }
  var pageCount: Int { slides.count }

  private let slides: [any PresentationSlideViewController]
  private var currentIndex: Int = 0

  private let previousButton = UIButton(type: .custom)
  private let nextButton = UIButton(type: .custom)

  init(slides: [any PresentationSlideViewController]) {
    self.slides = slides
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    guard !slides.isEmpty else { return }

    add(slides[0])

    previousButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(previousButton)
    NSLayoutConstraint.activate([
      previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      previousButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      previousButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
      previousButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
    ])

    nextButton.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(nextButton)
    NSLayoutConstraint.activate([
      nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
      nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),

    ])

    previousButton.addAction(UIAction { [weak self] in self?.previous($0) }, for: .touchUpInside)
    nextButton.addAction(UIAction { [weak self] in self?.next($0) }, for: .touchUpInside)
  }

  private func previous(_ action: UIAction) {
    let previousIndex = currentIndex - 1
    if previousIndex >= 0 {
      let transition = CATransition()
      transition.type = .fade
      transition.duration = 0.12
      transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
      view.layer.add(transition, forKey: nil)

      let current = slides[currentIndex]
      let previous = slides[previousIndex]
      remove(current)
      insert(previous, at: 0)

      currentIndex = previousIndex
      delegate?.didMovePrevious(self, current: current, previous: previous)
    }
  }

  private func next(_ action: UIAction) {
    let nextIndex = currentIndex + 1
    if slides.count > nextIndex {
      let transition = CATransition()
      transition.type = .fade
      transition.duration = 0.12
      transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
      view.layer.add(transition, forKey: nil)

      let current = slides[currentIndex]
      let next = slides[nextIndex]
      remove(current)
      insert(next, at: 0)

      currentIndex = nextIndex
      delegate?.didMoveNext(self, current: current, next: next)
    }
  }

  private func add(_ viewController: UIViewController) {
    insert(viewController, at: view.subviews.count)
  }

  private func insert(_ viewController: UIViewController, at index: Int) {
    addChild(viewController)
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    view.insertSubview(viewController.view, at: index)
    viewController.didMove(toParent: self)

    NSLayoutConstraint.activate([
      viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }

  private func remove(_ viewController: UIViewController) {
    viewController.willMove(toParent: nil)
    viewController.view.removeFromSuperview()
    viewController.removeFromParent()
  }
}

protocol PresentationTransitionControllerDelegate {
  func didMovePrevious(_ presentationTransitionController: PresentationTransitionController, current currentViewController: any PresentationSlideViewController, previous previousViewController: any PresentationSlideViewController)
  func didMoveNext(_ presentationTransitionController: PresentationTransitionController, current currentViewController: any PresentationSlideViewController, next nextViewController: any PresentationSlideViewController)
}
