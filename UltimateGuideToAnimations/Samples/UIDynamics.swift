import UIKit

enum UIDynamics {}

extension UIDynamics {
  class ExampleViewController: UIViewController {
    let cyanView = UIView()
    let redView = UIView()
    
    override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = .systemBackground
      view.clipsToBounds = true
      view.layer.cornerRadius = 40
      view.layer.cornerCurve = .continuous
      view.layer.borderWidth = 2
      view.layer.borderColor = UIColor.systemGray.cgColor

      if #available(iOS 15.0, *) {
        cyanView.backgroundColor = .systemCyan
      } else {
        cyanView.backgroundColor = .cyan
      }
      view.addSubview(cyanView)

      redView.backgroundColor = .systemRed

      redView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(redView)
      NSLayoutConstraint.activate([
        redView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
        redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        redView.widthAnchor.constraint(equalToConstant: 50),
        redView.heightAnchor.constraint(equalToConstant: 50),
      ])
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      guard let view = self.view else { return }

      let cyanView = self.cyanView
      let redView = self.redView

      let animator = UIDynamicAnimator(referenceView: view)

      let timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
        animator.removeAllBehaviors()

        let size = CGSize(width: 200, height: 200)
        cyanView.frame = CGRect(
          x: (view.bounds.width - size.width) / 2,
          y: 40,
          width: size.width,
          height: size.height)

        let gravity = UIGravityBehavior(items: [cyanView, redView])
        animator.addBehavior(gravity)

        let collision = UICollisionBehavior(items: [cyanView, redView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)

        let behaviour = UIDynamicItemBehavior(items: [cyanView, redView])
        behaviour.allowsRotation = true
        behaviour.elasticity = 0.5
        animator.addBehavior(behaviour)
      }
      timer.fire()
    }
  }

  class CardViewController: UIViewController {
    let cyanView = UIView()

    var animator: UIDynamicAnimator!
    var snapping: UISnapBehavior!

    override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = .systemBackground
      view.clipsToBounds = true
      view.layer.cornerRadius = 40
      view.layer.cornerCurve = .continuous
      view.layer.borderWidth = 2
      view.layer.borderColor = UIColor.systemGray.cgColor

      if #available(iOS 15.0, *) {
        cyanView.backgroundColor = .systemCyan
      } else {
        cyanView.backgroundColor = .cyan
      }
      view.addSubview(cyanView)

      let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
      cyanView.addGestureRecognizer(gestureRecognizer)
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let cyanView = self.cyanView

      let size = CGSize(width: 200, height: 200)
      cyanView.frame = CGRect(
        x: (view.bounds.width - size.width) / 2,
        y: (view.bounds.height - size.height) / 2,
        width: size.width,
        height: size.height)

      animator = UIDynamicAnimator(referenceView: view)
      snapping = UISnapBehavior(item: cyanView, snapTo: cyanView.center)
      animator.addBehavior(snapping)
    }

    @objc
    private func pan(_ sender: UIPanGestureRecognizer) {
      switch sender.state {
      case .began:
        animator.removeBehavior(snapping)
      case .changed:
        let translation = sender.translation(in: view)
        cyanView.center = CGPoint(
          x: cyanView.center.x + translation.x,
          y: cyanView.center.y + translation.y
        )
        sender.setTranslation(.zero, in: view)
      case .ended, .cancelled, .failed:
        animator.addBehavior(snapping)
      default:
        break
      }
    }
  }

  class SampleCollectionViewController: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()

      let viewController = UINavigationController(
        rootViewController: SpringyCollectionViewController(collectionViewLayout: SpringyCollectionViewFlowLayout())
      )
      viewController.navigationBar.standardAppearance = UINavigationBarAppearance()
      viewController.navigationBar.scrollEdgeAppearance = UINavigationBarAppearance()

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

  class SpringyCollectionViewController: UICollectionViewController {
    override func viewDidLoad() {
      super.viewDidLoad()

      collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
      collectionView.backgroundColor = .systemBackground
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      100
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
      cell.backgroundColor = .systemIndigo
      cell.layer.cornerRadius = 8
      return cell
    }
  }

  class SpringyCollectionViewFlowLayout: UICollectionViewFlowLayout {
    private var dynamicAnimator: UIDynamicAnimator!
    private var visibleIndexPathsSet = Set<IndexPath>()
    private var latestDelta: CGFloat = 0

    override init() {
      super.init()
      self.dynamicAnimator = UIDynamicAnimator(collectionViewLayout: self)
      minimumInteritemSpacing = 10
      minimumLineSpacing = 14
      itemSize = CGSize(width: 290, height: 44)
      sectionInset = UIEdgeInsets(top: 10, left: 14, bottom: 10, right: 14)
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
      super.prepare()

      guard let collectionView = collectionView else { return }

      let visibleRect = CGRect(origin: collectionView.bounds.origin, size: collectionView.frame.size)
        .insetBy(
          dx: -100,
          dy: -100
        )

      guard let itemsInVisibleRectArray = super.layoutAttributesForElements(in: visibleRect) else { return }
      let itemsInVisibleRectSet = Set(itemsInVisibleRectArray.map { $0.indexPath })

      let noLongerVisibleBehaviours = dynamicAnimator.behaviors.filter {
        if let behavior = $0 as? UIAttachmentBehavior, let first = behavior.items.first as? UICollectionViewLayoutAttributes {
          let currentlyVisible = itemsInVisibleRectSet.contains(first.indexPath)
          return !currentlyVisible
        }
        return false
      }

      noLongerVisibleBehaviours.forEach {
        dynamicAnimator.removeBehavior($0)
        if let behavior = $0 as? UIAttachmentBehavior, let first = behavior.items.first as? UICollectionViewLayoutAttributes {
          visibleIndexPathsSet.remove(first.indexPath)
        }
      }

      let newlyVisibleItems = itemsInVisibleRectArray.filter {
        let currentlyVisible = visibleIndexPathsSet.contains($0.indexPath)
        return !currentlyVisible
      }

      newlyVisibleItems.forEach {
        let center = $0.center

        let springBehaviour = UIAttachmentBehavior(item: $0, attachedToAnchor: center)
        springBehaviour.length = 0
        springBehaviour.damping = 0.8
        springBehaviour.frequency = 1

        dynamicAnimator.addBehavior(springBehaviour)
        visibleIndexPathsSet.insert($0.indexPath)
      }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      let items: [UICollectionViewLayoutAttributes]? = dynamicAnimator.items(in: rect).compactMap {
        if let attributes = $0 as? UICollectionViewLayoutAttributes {
          return attributes
        }
        return nil
      }
      return items
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
      dynamicAnimator.layoutAttributesForCell(at: indexPath)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
      guard let scrollView = collectionView else { return false }

      let delta = newBounds.origin.y - scrollView.bounds.origin.y
      latestDelta = delta

      let touchLocation = scrollView.panGestureRecognizer.location(in: scrollView)

      dynamicAnimator.behaviors.forEach {
        if let behaviour = $0 as? UIAttachmentBehavior {
          let yDistanceFromTouch = abs(touchLocation.y - behaviour.anchorPoint.y)
          let xDistanceFromTouch = abs(touchLocation.x - behaviour.anchorPoint.x)
          let scrollResistance = (yDistanceFromTouch + xDistanceFromTouch) / 1500.0

          guard let item = behaviour.items.first else { return }

          var center = item.center
          if (delta < 0) {
            center.y += max(delta, delta * scrollResistance);
          }
          else {
            center.y += min(delta, delta * scrollResistance);
          }
          item.center = center;

          dynamicAnimator.updateItem(usingCurrentState: item)
        }
      }

      return false
    }
  }
}
