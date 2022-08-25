import UIKit

class CircularLoader: UIView {
  override init(frame: CGRect) {
    super.init(frame: frame)
    let replicatorLayer = CAReplicatorLayer()
    layer.addSublayer(replicatorLayer)

    let size: CGFloat = 400
    let viewFrame = frame

    replicatorLayer.frame = CGRect(
      x: viewFrame.midX - size / 2,
      y: viewFrame.midY - size / 2,
      width: size, height: size
    )

    let circle = CALayer()
    circle.backgroundColor = UIColor.blue.cgColor
    circle.cornerRadius = 20
    circle.frame.size = CGSize(width: 40, height: 40)

    //It DOES need to be added as a sublayer to the replicator
    replicatorLayer.addSublayer(circle)

    let instanceCount = 20
    replicatorLayer.instanceCount = instanceCount
    replicatorLayer.instanceDelay = 1/CFTimeInterval(instanceCount)

    let angle = -CGFloat.pi * 2 / CGFloat(instanceCount)
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)

    let fadingAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
    fadingAnimation.fromValue = 1
    fadingAnimation.toValue = 0
    fadingAnimation.duration = 1
    fadingAnimation.repeatCount = .infinity
    fadingAnimation.isRemovedOnCompletion = false

    //Then we simply add the animation to the layer.
    //the 'key' parameter is a unique string key we can assign to reference the animation later.
    circle.add(fadingAnimation, forKey: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
