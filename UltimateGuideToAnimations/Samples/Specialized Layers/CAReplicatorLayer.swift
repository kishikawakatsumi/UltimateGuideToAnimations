import UIKit

class CircularLoaderViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    let loader = CircularLoader()
    loader.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(loader)

    NSLayoutConstraint.activate([
      loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
    ])
  }
}

class SoundWaveViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    let width = 1200
    let height = 400

    let replicatorLayer = CAReplicatorLayer()
    view.layer.addSublayer(replicatorLayer)

    replicatorLayer.frame = CGRect(x: 0, y: 0, width: width, height: height)
    //    replicatorLayer.position = view.center
    replicatorLayer.borderWidth = 1
    replicatorLayer.instanceCount = width / 3
    replicatorLayer.masksToBounds = true
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(-30, 0, 0)
    replicatorLayer.instanceDelay = 0.025

    let layer = CALayer()
    layer.frame = CGRect(x: width - 1, y: height, width: 20, height: 400)
    layer.backgroundColor = UIColor.systemIndigo.cgColor
    replicatorLayer.addSublayer(layer)

    let timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
      let animation = CABasicAnimation(keyPath: "position.y")
      animation.toValue = layer.position.y - CGFloat(arc4random() % 400)
      animation.duration = 0.5
      animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
      animation.autoreverses = true
      animation.repeatCount = .infinity
      layer.add(animation, forKey: nil)
    }
    timer.fire()
  }
}

class ReflectionViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemGray2
    view.clipsToBounds = true
    view.layer.cornerRadius = 12

    let reflectionView = ReflectionView(frame: CGRect(x: 0, y: 0, width: 420, height: 500))
    reflectionView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(reflectionView)

    NSLayoutConstraint.activate([
      reflectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      reflectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
      reflectionView.widthAnchor.constraint(equalToConstant: 420),
      reflectionView.heightAnchor.constraint(equalToConstant: 500),
    ])

    let imageView = UIImageView(image: UIImage(named: "abhinav-bhardwaj-fOcPg7lM1Fs-unsplash"))
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill

    imageView.translatesAutoresizingMaskIntoConstraints = false
    reflectionView.addSubview(imageView)

    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: reflectionView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: reflectionView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: reflectionView.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: reflectionView.bottomAnchor),
    ])
  }
}

class ReflectionView: UIView {
  override class var layerClass: AnyClass {
    CAReplicatorLayer.self
  }

  func setUp() {
    let layer = self.layer as! CAReplicatorLayer
    layer.instanceCount = 2

    var transform = CATransform3DIdentity
    let verticalOffset = bounds.size.height + 2
    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0)
    transform = CATransform3DScale(transform, 1, -1, 0)

    layer.instanceTransform = transform

    layer.instanceAlphaOffset = -0.6
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setUp()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func awakeFromNib() {
    setUp()
  }
}
