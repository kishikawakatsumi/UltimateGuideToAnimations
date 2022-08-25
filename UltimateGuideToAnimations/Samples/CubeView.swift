import UIKit

open class CubeView: UIScrollView, UIScrollViewDelegate {
  weak var cubeDelegate: CubeViewDelegate?

  fileprivate let maxAngle: CGFloat = 60.0

  fileprivate var childViews = [UIView]()

  fileprivate lazy var stackView: UIStackView = {

    let sv = UIStackView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.axis = NSLayoutConstraint.Axis.horizontal

    return sv
  }()

  open override func awakeFromNib() {
    super.awakeFromNib()
    configureScrollView()
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    configureScrollView()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  open override func layoutSubviews() {
    super.layoutSubviews()
  }

  open func addChildViews(_ views: [UIView]) {
    for view in views {
      view.layer.masksToBounds = true
      stackView.addArrangedSubview(view)

      addConstraint(NSLayoutConstraint(
        item: view,
        attribute: NSLayoutConstraint.Attribute.width,
        relatedBy: NSLayoutConstraint.Relation.equal,
        toItem: self,
        attribute: NSLayoutConstraint.Attribute.width,
        multiplier: 1,
        constant: 0)
      )

      childViews.append(view)
    }
  }

  open func addChildView(_ view: UIView) {
    addChildViews([view])
  }

  open func scrollToViewAtIndex(_ index: Int, animated: Bool) {
    if index > -1 && index < childViews.count {

      let width = self.frame.size.width
      let height = self.frame.size.height

      let frame = CGRect(x: CGFloat(index)*width, y: 0, width: width, height: height)
      scrollRectToVisible(frame, animated: animated)
    }
  }

  // MARK: Scroll view delegate

  open func scrollViewDidScroll(_ scrollView: UIScrollView) {
    transformViewsInScrollView(scrollView)
    cubeDelegate?.cubeViewDidScroll?(self)
  }

  // MARK: Private methods

  fileprivate func configureScrollView() {

    // Configure scroll view properties

    backgroundColor = UIColor.black
    showsHorizontalScrollIndicator = false
    showsVerticalScrollIndicator = false
    isPagingEnabled = true
    bounces = true
    delegate = self

    // Add layout constraints

    addSubview(stackView)

    addConstraint(NSLayoutConstraint(
      item: stackView,
      attribute: NSLayoutConstraint.Attribute.leading,
      relatedBy: NSLayoutConstraint.Relation.equal,
      toItem: self,
      attribute: NSLayoutConstraint.Attribute.leading,
      multiplier: 1,
      constant: 0)
    )

    addConstraint(NSLayoutConstraint(
      item: stackView,
      attribute: NSLayoutConstraint.Attribute.top,
      relatedBy: NSLayoutConstraint.Relation.equal,
      toItem: self,
      attribute: NSLayoutConstraint.Attribute.top,
      multiplier: 1,
      constant: 0)
    )

    addConstraint(NSLayoutConstraint(
      item: stackView,
      attribute: NSLayoutConstraint.Attribute.height,
      relatedBy: NSLayoutConstraint.Relation.equal,
      toItem: self,
      attribute: NSLayoutConstraint.Attribute.height,
      multiplier: 1,
      constant: 0)
    )

    addConstraint(NSLayoutConstraint(
      item: stackView,
      attribute: NSLayoutConstraint.Attribute.centerY,
      relatedBy: NSLayoutConstraint.Relation.equal,
      toItem: self,
      attribute: NSLayoutConstraint.Attribute.centerY,
      multiplier: 1,
      constant: 0)
    )

    addConstraint(NSLayoutConstraint(
      item: self,
      attribute: NSLayoutConstraint.Attribute.trailing,
      relatedBy: NSLayoutConstraint.Relation.equal,
      toItem: stackView,
      attribute: NSLayoutConstraint.Attribute.trailing,
      multiplier: 1,
      constant: 0)
    )

    addConstraint(NSLayoutConstraint(
      item: self,
      attribute: NSLayoutConstraint.Attribute.bottom,
      relatedBy: NSLayoutConstraint.Relation.equal,
      toItem: stackView,
      attribute: NSLayoutConstraint.Attribute.bottom,
      multiplier: 1,
      constant: 0)
    )
  }

  fileprivate func transformViewsInScrollView(_ scrollView: UIScrollView) {
    let xOffset = scrollView.contentOffset.x
    let svWidth = scrollView.frame.width
    var deg = maxAngle / bounds.size.width * xOffset

    for index in 0 ..< childViews.count {
      let view = childViews[index]

      deg = index == 0 ? deg : deg - maxAngle
      let rad = deg * CGFloat(Double.pi / 180)

      var transform = CATransform3DIdentity
      transform.m34 = 1 / 500
      transform = CATransform3DRotate(transform, rad, 0, 1, 0)

      view.layer.transform = transform

      let x = xOffset / svWidth > CGFloat(index) ? 1.0 : 0.0
      setAnchorPoint(CGPoint(x: x, y: 0.5), forView: view)

      applyShadowForView(view, index: index)
    }
  }

  fileprivate func applyShadowForView(_ view: UIView, index: Int) {
    let w = self.frame.size.width
    let h = self.frame.size.height

    let r1 = frameFor(origin: contentOffset, size: self.frame.size)
    let r2 = frameFor(origin: CGPoint(x: CGFloat(index)*w, y: 0),
                      size: CGSize(width: w, height: h))

    // Only show shadow on right-hand side
    if r1.origin.x <= r2.origin.x {

      let intersection = r1.intersection(r2)
      let intArea = intersection.size.width*intersection.size.height
      let union = r1.union(r2)
      let unionArea = union.size.width*union.size.height

      view.layer.opacity = Float(intArea / unionArea)
    }
  }

  fileprivate func setAnchorPoint(_ anchorPoint: CGPoint, forView view: UIView) {
    var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
    var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)

    newPoint = newPoint.applying(view.transform)
    oldPoint = oldPoint.applying(view.transform)

    var position = view.layer.position
    position.x -= oldPoint.x
    position.x += newPoint.x

    position.y -= oldPoint.y
    position.y += newPoint.y

    view.layer.position = position
    view.layer.anchorPoint = anchorPoint
  }

  fileprivate func frameFor(origin: CGPoint, size: CGSize) -> CGRect {
    return CGRect(x: origin.x, y: origin.y, width: size.width, height: size.height)
  }
}

@objc protocol CubeViewDelegate: AnyObject {
  @objc optional func cubeViewDidScroll(_ cubeView: CubeView)
}
