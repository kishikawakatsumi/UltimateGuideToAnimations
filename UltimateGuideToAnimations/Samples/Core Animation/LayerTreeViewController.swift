import UIKit

enum CoreAnimation {}

extension CoreAnimation {
  class LayerTreeExampleViewController: UIViewController {
    private let viewController = LayerTreeViewController()

    private let slider = UISlider()
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

      let slider = self.slider
      slider.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(slider)

      NSLayoutConstraint.activate([
        slider.topAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: 20),
        slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        slider.widthAnchor.constraint(equalTo: viewController.view.widthAnchor),
      ])

      slider.addAction(
        UIAction(
          handler: { _ in
            viewController.viewHierarchyView.layer.timeOffset = CFTimeInterval(slider.value)
            viewController.wireframeView.layer.timeOffset = CFTimeInterval(slider.value)
          }
        ),
        for: .valueChanged
      )

      let toggle = self.toggle
      toggle.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(toggle)

      NSLayoutConstraint.activate([
        toggle.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
        toggle.trailingAnchor.constraint(equalTo: slider.trailingAnchor),
      ])

      toggle.addAction(
        UIAction(
          handler: { _ in
            viewController.toggleShowWireframes(toggle.isOn)
          }
        ),
        for: .valueChanged
      )

      label.text = "Show Layers:"
      label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
      label.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(label)

      NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
        label.leadingAnchor.constraint(equalTo: slider.leadingAnchor),
      ])
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)

      slider.removeFromSuperview()
      view.superview?.addSubview(slider)

      NSLayoutConstraint.activate([
        slider.topAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: 20),
        slider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        slider.widthAnchor.constraint(equalTo: viewController.view.widthAnchor),
      ])

      toggle.removeFromSuperview()
      view.superview?.addSubview(toggle)

      NSLayoutConstraint.activate([
        toggle.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
        toggle.trailingAnchor.constraint(equalTo: slider.trailingAnchor),
      ])

      label.removeFromSuperview()
      view.superview?.addSubview(label)

      NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
        label.leadingAnchor.constraint(equalTo: slider.leadingAnchor),
      ])
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)

      slider.value = 0
      toggle.isOn = false
    }
  }
}

class LayerTreeViewController: UIViewController {
  fileprivate let viewHierarchyView = TransformLayerView()
  fileprivate let wireframeView = TransformLayerView()

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

    let viewController = UIStoryboard(name: "LayerTreeTemplateViewController", bundle: nil).instantiateInitialViewController()!
    viewController.view.frame = view.bounds
    viewController.view.layoutIfNeeded()

    viewHierarchyView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(viewHierarchyView)
    NSLayoutConstraint.activate([
      viewHierarchyView.topAnchor.constraint(equalTo: view.topAnchor),
      viewHierarchyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      viewHierarchyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      viewHierarchyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    wireframeView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(wireframeView)
    NSLayoutConstraint.activate([
      wireframeView.topAnchor.constraint(equalTo: view.topAnchor),
      wireframeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      wireframeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      wireframeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    renderViewHierarchy(rootView: viewController.view, from: viewController.view, to: viewHierarchyView)
    renderLayerWireframes(rootLayer: viewController.view.layer, from: viewController.view.layer, to: wireframeView.layer)

    toggleShowWireframes(false)

    var perspective = CATransform3DIdentity
    perspective.m34 = -1 / 300

    let animation = CABasicAnimation(keyPath: "transform")
    animation.fromValue = CATransform3DIdentity
    animation.toValue = CATransform3DRotate(perspective, 90.0 * .pi / 180.0, 0, 1, 0)
    animation.duration = 1

    viewHierarchyView.layer.add(animation, forKey: nil)
    wireframeView.layer.add(animation, forKey: nil)

    viewHierarchyView.layer.speed = 0
    wireframeView.layer.speed = 0
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)

    viewHierarchyView.layer.timeOffset = 0
    viewHierarchyView.layer.removeAllAnimations()
    viewHierarchyView.removeFromSuperview()

    wireframeView.layer.timeOffset = 0
    wireframeView.layer.removeAllAnimations()
    wireframeView.removeFromSuperview()
  }

  func toggleShowWireframes(_ show: Bool) {
    viewHierarchyView.isHidden = show
    wireframeView.isHidden = !show
  }

  private func renderViewHierarchy(rootView: UIView, from fromView: UIView, to toView: UIView, depth: CGFloat = 1) {
    for subview in fromView.subviews {
      let layer = CALayer()
      layer.frame = subview.layer.convert(subview.layer.bounds, to: rootView.layer)
      layer.backgroundColor = subview.layer.backgroundColor
      layer.borderWidth = 1
      layer.zPosition = 26 * depth

      toView.layer.addSublayer(layer)

      renderViewHierarchy(rootView: rootView, from: subview, to: toView, depth: depth + 1)
    }
  }

  private func renderLayerWireframes(rootLayer: CALayer, from fromLayer: CALayer, to toLayer: CALayer, depth: CGFloat = 1) {
    if let sublayers = fromLayer.sublayers {
      for sublayer in sublayers {
        let layer = CALayer()
        layer.frame = sublayer.convert(sublayer.bounds, to: rootLayer)
        layer.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.3).cgColor
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemIndigo.cgColor
        layer.zPosition = 26 * depth

        toLayer.addSublayer(layer)

        renderLayerWireframes(rootLayer: rootLayer, from: sublayer, to: toLayer, depth: depth + 1)
      }
    }
  }

  fileprivate class TransformLayerView: UIView {
    override class var layerClass: AnyClass {
      CATransformLayer.self
    }
  }
}
