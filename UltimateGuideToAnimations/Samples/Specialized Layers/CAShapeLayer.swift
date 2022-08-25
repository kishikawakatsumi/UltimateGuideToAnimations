import UIKit

class MarchingAntsViewController: UIViewController {
  let layer = CAShapeLayer()

  override func viewDidLoad() {
    super.viewDidLoad()

    let imageView = UIImageView(image: UIImage(named: "iewek-gnos-hhUx08PuYpc-unsplash"))
    imageView.clipsToBounds = true
    imageView.contentMode = .scaleAspectFill

    imageView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(imageView)

    NSLayoutConstraint.activate([
      imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 1200),
      imageView.heightAnchor.constraint(equalToConstant: 680),
    ])

    let bounds = CGRect(x: 100, y: 200, width: 600, height: 300)
    layer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 2, height: 2)).cgPath
    layer.lineWidth = 4
    layer.strokeColor = UIColor.white.cgColor
    layer.fillColor = nil
    layer.lineDashPattern = [14, 10]
    view.layer.addSublayer(layer)
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let animation = CABasicAnimation(keyPath: "lineDashPhase")
    animation.fromValue = 0
    animation.toValue = layer.lineDashPattern?.reduce(0) { $0 - $1.intValue } ?? 0
    animation.duration = 1
    animation.repeatCount = .infinity
    layer.add(animation, forKey: "line")
  }
}
