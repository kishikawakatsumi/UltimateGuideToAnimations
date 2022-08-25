import UIKit

enum CA3DAnimations {}

extension CA3DAnimations {
  class ExampleViewController: UIViewController {
    private let cyanView = UIView()
    private var timer: Timer?

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
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let cyanView = self.cyanView

      var perspective = CATransform3DIdentity
      perspective.m34 = -1 / 300
      cyanView.layer.transform = perspective

      let size = CGSize(width: 200, height: 200)
      cyanView.frame = CGRect(
        x: (view.bounds.width - size.width) / 2,
        y: (view.bounds.height - size.height) / 2,
        width: size.width,
        height: size.height)


      let timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
        let animation = CABasicAnimation(keyPath: "transform.rotation.y")
        animation.duration = 1
        animation.toValue = CGFloat.pi

        cyanView.layer.add(animation, forKey: nil)
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      timer?.invalidate()
    }
  }

  class CubeTransitionViewController: UIViewController {
    let cubeView = CubeView()

    override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = .systemBackground
      view.clipsToBounds = true
      view.layer.cornerRadius = 40
      view.layer.cornerCurve = .continuous
      view.layer.borderWidth = 2
      view.layer.borderColor = UIColor.systemGray.cgColor

      let iv1 = UIImageView(image: UIImage(named: "abhinav-bhardwaj-fOcPg7lM1Fs-unsplash"))
      iv1.contentMode = .scaleAspectFill
      let iv2 = UIImageView(image: UIImage(named: "eray-uman-no2O8fieivY-unsplash"))
      iv2.contentMode = .scaleAspectFill
      let iv3 = UIImageView(image: UIImage(named: "iewek-gnos-hhUx08PuYpc-unsplash"))
      iv3.contentMode = .scaleAspectFill
      let iv4 = UIImageView(image: UIImage(named: "tom-podmore-Pm7Ugc2-WSg-unsplash"))
      iv4.contentMode = .scaleAspectFill

      cubeView.addChildViews([iv1, iv2, iv3, iv4])

      cubeView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(cubeView)

      NSLayoutConstraint.activate([
        cubeView.topAnchor.constraint(equalTo: view.topAnchor),
        cubeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        cubeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        cubeView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      ])
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
    }
  }
}
