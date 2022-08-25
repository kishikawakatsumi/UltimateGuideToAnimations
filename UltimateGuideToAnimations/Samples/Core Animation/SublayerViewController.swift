import UIKit

extension CoreAnimation {
  class SublayerExampleViewController: UIViewController {
    private let viewController = SublayerViewController()

    private let slider = UISlider()
    private let layerToggle = UISwitch()
    private let layerLabel = UILabel()
    private let wireframeToggle = UISwitch()
    private let wireframeLabel = UILabel()

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
            viewController.layerView.layer.timeOffset = CFTimeInterval(slider.value)
            viewController.wireframeView.layer.timeOffset = CFTimeInterval(slider.value)
          }
        ),
        for: .valueChanged
      )

      let layerToggle = self.layerToggle
      layerToggle.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(layerToggle)

      NSLayoutConstraint.activate([
        layerToggle.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
        layerToggle.trailingAnchor.constraint(equalTo: slider.trailingAnchor),
      ])

      layerToggle.addAction(
        UIAction(
          handler: { _ in
            viewController.toggleShowLayers(!layerToggle.isOn)
          }
        ),
        for: .valueChanged
      )

      layerLabel.text = "Hide Layers:"
      layerLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
      layerLabel.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(layerLabel)

      NSLayoutConstraint.activate([
        layerLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
        layerLabel.leadingAnchor.constraint(equalTo: slider.leadingAnchor),
      ])

      let wireframeToggle = self.wireframeToggle
      wireframeToggle.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(wireframeToggle)

      NSLayoutConstraint.activate([
        wireframeToggle.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
        wireframeToggle.trailingAnchor.constraint(equalTo: slider.trailingAnchor),
      ])

      wireframeToggle.addAction(
        UIAction(
          handler: { _ in
            viewController.toggleShowWireframes(wireframeToggle.isOn)
          }
        ),
        for: .valueChanged
      )

      wireframeLabel.text = "Show Layer Wireframes:"
      wireframeLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
      wireframeLabel.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(wireframeLabel)

      NSLayoutConstraint.activate([
        wireframeLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
        wireframeLabel.leadingAnchor.constraint(equalTo: slider.leadingAnchor),
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

      layerToggle.removeFromSuperview()
      view.superview?.addSubview(layerToggle)

      NSLayoutConstraint.activate([
        layerToggle.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
        layerToggle.trailingAnchor.constraint(equalTo: slider.trailingAnchor),
      ])

      layerLabel.removeFromSuperview()
      view.superview?.addSubview(layerLabel)

      NSLayoutConstraint.activate([
        layerLabel.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 20),
        layerLabel.leadingAnchor.constraint(equalTo: slider.leadingAnchor),
      ])

      wireframeToggle.removeFromSuperview()
      view.superview?.addSubview(wireframeToggle)

      NSLayoutConstraint.activate([
        wireframeToggle.topAnchor.constraint(equalTo: layerToggle.bottomAnchor, constant: 20),
        wireframeToggle.trailingAnchor.constraint(equalTo: slider.trailingAnchor),
      ])

      wireframeLabel.removeFromSuperview()
      view.superview?.addSubview(wireframeLabel)

      NSLayoutConstraint.activate([
        wireframeLabel.topAnchor.constraint(equalTo: layerLabel.bottomAnchor, constant: 20),
        wireframeLabel.leadingAnchor.constraint(equalTo: slider.leadingAnchor),
      ])
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)

      slider.value = 0
      wireframeToggle.isOn = false
    }
  }

  class SublayerViewController: UIViewController {
    fileprivate let viewHierarchyView = TransformLayerView()
    fileprivate let layerView = TransformLayerView()
    fileprivate let wireframeView = TransformLayerView()

    override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = .systemBackground
      view.layer.cornerRadius = 40
      view.layer.cornerCurve = .continuous
      view.layer.borderWidth = 1
      view.layer.borderColor = UIColor.systemGray.cgColor
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let viewController = ViewController()
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

      layerView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(layerView)
      NSLayoutConstraint.activate([
        layerView.topAnchor.constraint(equalTo: view.topAnchor),
        layerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        layerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        layerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
      renderLayer(rootLayer: viewController.view.layer, from: viewController.view.layer, to: layerView.layer)
      renderLayerWireframes(rootLayer: viewController.view.layer, from: viewController.view.layer, to: wireframeView.layer)

      toggleShowLayers(true)
      toggleShowWireframes(false)

      var perspective = CATransform3DIdentity
      perspective.m34 = -1 / 300

      let animation = CABasicAnimation(keyPath: "transform")
      animation.fromValue = CATransform3DIdentity
      animation.toValue = CATransform3DRotate(perspective, 90.0 * .pi / 180.0, 0, 1, 0)
      animation.duration = 1

      viewHierarchyView.layer.add(animation, forKey: nil)
      layerView.layer.add(animation, forKey: nil)
      wireframeView.layer.add(animation, forKey: nil)

      viewHierarchyView.layer.speed = 0
      layerView.layer.speed = 0
      wireframeView.layer.speed = 0
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)

      viewHierarchyView.layer.timeOffset = 0
      viewHierarchyView.layer.removeAllAnimations()
      viewHierarchyView.removeFromSuperview()

      layerView.layer.timeOffset = 0
      layerView.layer.removeAllAnimations()
      layerView.removeFromSuperview()

      wireframeView.layer.timeOffset = 0
      wireframeView.layer.removeAllAnimations()
      wireframeView.removeFromSuperview()
    }

    func toggleShowLayers(_ show: Bool) {
      viewHierarchyView.isHidden = show
      layerView.isHidden = !show
      wireframeView.isHidden = !show
    }

    func toggleShowWireframes(_ show: Bool) {
      viewHierarchyView.isHidden = show
      layerView.isHidden = show
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

    private func renderLayer(rootLayer: CALayer, from fromLayer: CALayer, to toLayer: CALayer, depth: CGFloat = 1) {
      if let sublayers = fromLayer.sublayers {
        for sublayer in sublayers {
          let layer = CALayer()
          layer.frame = sublayer.convert(sublayer.bounds, to: rootLayer)
          layer.backgroundColor = sublayer.backgroundColor
          layer.zPosition = 26 * depth

          toLayer.addSublayer(layer)

          renderLayer(rootLayer: rootLayer, from: sublayer, to: toLayer, depth: depth + 1)
        }
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

  class ViewController: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()

      let indigoView = UIView()
      indigoView.backgroundColor = .systemIndigo

      indigoView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(indigoView)

      NSLayoutConstraint.activate([
        indigoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        indigoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        indigoView.widthAnchor.constraint(equalToConstant: 200),
        indigoView.heightAnchor.constraint(equalToConstant: 200),
      ])

      let greenLayer = CALayer()
      greenLayer.backgroundColor = UIColor.systemGreen.cgColor
      greenLayer.frame = CGRect(x: 20, y: 20, width: 160, height: 160)
      indigoView.layer.addSublayer(greenLayer)

      let redLayer = CALayer()
      redLayer.backgroundColor = UIColor.systemRed.cgColor
      redLayer.frame = CGRect(x: 20, y: 20, width: 120, height: 120)
      greenLayer.addSublayer(redLayer)
    }
  }
}
