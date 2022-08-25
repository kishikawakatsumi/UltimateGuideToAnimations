import UIKit

enum InteractiveAnimation {}

extension InteractiveAnimation {
  class PathAnimationViewController: UIViewController {
    let shapeLayer = CAShapeLayer()
    let slider = UISlider()

    override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = .systemBackground
      view.layer.cornerRadius = 20

      let shapeLayer = self.shapeLayer

      shapeLayer.fillColor = UIColor.clear.cgColor
      shapeLayer.strokeColor = UIColor.systemIndigo.cgColor
      shapeLayer.lineWidth = 4
      shapeLayer.lineCap = .round

      view.layer.addSublayer(shapeLayer)

      let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
      animation.duration = 1
      animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
      animation.fromValue = 0
      animation.toValue = 1
      animation.isRemovedOnCompletion = false

      shapeLayer.speed = 0

      shapeLayer.add(animation, forKey: nil)

      let attributed = NSMutableAttributedString(string: "HelloWorld!")
      attributed.addAttributes([NSAttributedString.Key.font : UIFont(name: "SnellRoundhand-Black", size: 96)!], range: NSRange(location: 0, length: attributed.string.utf16.count))
      shapeLayer.path = textPath(text: attributed).cgPath

      let slider = self.slider

      slider.addAction(
        UIAction(
          handler: { _ in
            shapeLayer.timeOffset = CFTimeInterval(slider.value)
          }
        ),
        for: .valueChanged
      )

      slider.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(slider)

      NSLayoutConstraint.activate([
        slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        slider.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
      ])
    }

    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)

      shapeLayer.frame = view.bounds
      shapeLayer.position.x += 40
      shapeLayer.position.y += 40
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      slider.value = 1
      shapeLayer.timeOffset = CFTimeInterval(slider.value)
    }
  }

  class BlurHeaderViewController: UIViewController {
    override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = .systemBackground
      view.clipsToBounds = true

      view.layer.cornerRadius = 40
      view.layer.cornerCurve = .continuous
      view.layer.borderWidth = 1
      view.layer.borderColor = UIColor.systemGray.cgColor

      let imageView = UIImageView(image: UIImage(named: "iewek-gnos-hhUx08PuYpc-unsplash"))
      imageView.contentMode = .scaleAspectFill

      let blurView = UIVisualEffectView()
      blurView.effect = nil

      let animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
      animator.pausesOnCompletion = true
      animator.addAnimations {
        blurView.effect = UIBlurEffect(style: .light)
      }

      let scrollView = UIScrollView()
      scrollView.alwaysBounceVertical = true

      let threadLocal = Thread.current.threadDictionary
      threadLocal["scrollView.contentOffset"] = scrollView.observe(\.contentOffset) { (scrollView, change) in
        var changedValue = min(300, abs(scrollView.contentOffset.y)) // 0 to image height
        changedValue = min(300, changedValue / 300) // 0.0 to 1.0

        animator.fractionComplete = changedValue
      }

      scrollView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(scrollView)
      NSLayoutConstraint.activate([
        scrollView.topAnchor.constraint(equalTo: view.topAnchor),
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      ])

      imageView.translatesAutoresizingMaskIntoConstraints = false
      scrollView.addSubview(imageView)
      NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
        imageView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
        imageView.heightAnchor.constraint(equalToConstant: 300),
      ])

      blurView.translatesAutoresizingMaskIntoConstraints = false
      scrollView.addSubview(blurView)
      NSLayoutConstraint.activate([
        blurView.topAnchor.constraint(equalTo: imageView.topAnchor),
        blurView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
        blurView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        blurView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
      ])

      let contentView = UIView()
      contentView.translatesAutoresizingMaskIntoConstraints = false
      scrollView.addSubview(contentView)
      NSLayoutConstraint.activate([
        contentView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
        contentView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
        contentView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
        contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.1),
      ])
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
    }
  }

  class BlurAnimationViewController: UIViewController {
    private let blurView = UIVisualEffectView()
    private var timer: Timer?
    
    override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = .systemBackground
      view.clipsToBounds = true

      view.layer.cornerRadius = 40
      view.layer.cornerCurve = .continuous
      view.layer.borderWidth = 1
      view.layer.borderColor = UIColor.systemGray.cgColor

      let imageView = UIImageView(image: UIImage(named: "iewek-gnos-hhUx08PuYpc-unsplash"))
      imageView.clipsToBounds = true
      imageView.contentMode = .scaleAspectFill

      imageView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(imageView)
      NSLayoutConstraint.activate([
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        imageView.heightAnchor.constraint(equalToConstant: 300),
      ])

      blurView.translatesAutoresizingMaskIntoConstraints = false
      imageView.addSubview(blurView)
      NSLayoutConstraint.activate([
        blurView.topAnchor.constraint(equalTo: imageView.topAnchor),
        blurView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
        blurView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        blurView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
      ])
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      let blurView = self.blurView

      let timer = Timer.scheduledTimer(withTimeInterval: 7, repeats: true) { _ in
        blurView.effect = nil
        UIView.animate(withDuration: 6, delay: 0) {
          blurView.effect = UIBlurEffect(style: .light)
        }
      }
      timer.fire()
      self.timer = timer
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      self.timer?.invalidate()
    }
  }
}

private func textPath(text: NSMutableAttributedString) -> UIBezierPath {
  let  letters: CGMutablePath = CGMutablePath()
  let line: CTLine = CTLineCreateWithAttributedString(text as CFAttributedString)
  let runArray: CFArray = CTLineGetGlyphRuns(line)

  for runIndex: CFIndex in 0..<CFArrayGetCount(runArray) {
    let run = CFArrayGetValueAtIndex(runArray, runIndex)
    let runb = unsafeBitCast(run, to: CTRun.self)

    let  CTFontName = unsafeBitCast(kCTFontAttributeName, to: UnsafeRawPointer.self)
    let runFontC = CFDictionaryGetValue(CTRunGetAttributes(runb),CTFontName)
    let runFontS: CTFont = unsafeBitCast(runFontC, to: CTFont.self)

    for runGlyphIndex: CFIndex in 0..<CTRunGetGlyphCount(runb) {
      let thisGlyphRange: CFRange = CFRangeMake(runGlyphIndex, 1)
      let glyph: UnsafeMutablePointer<CGGlyph> = UnsafeMutablePointer<CGGlyph>.allocate(capacity: 1)
      glyph.initialize(to: 0)
      let position: UnsafeMutablePointer<CGPoint> = UnsafeMutablePointer<CGPoint>.allocate(capacity: 1)
      position.initialize(to: CGPoint.zero)
      CTRunGetGlyphs(runb, thisGlyphRange, glyph)
      CTRunGetPositions(runb, thisGlyphRange, position)

      let letter: CGPath = CTFontCreatePathForGlyph(runFontS, glyph.pointee, nil)!
      let t: CGAffineTransform = CGAffineTransform(translationX: position.pointee.x, y: position.pointee.y)
      letters.addPath(letter, transform: t)
      //            glyph.deinitialize()
      //            glyph.deallocate(capacity: 1)
      //            position.deinitialize()
      //            position.deallocate(capacity: 1)
    }
  }

  let path: UIBezierPath = UIBezierPath.init(cgPath: letters)
  let  boundingBox: CGRect = letters.boundingBox
  path.apply(CGAffineTransform(scaleX: 1.0, y: -1.0))
  path.apply(CGAffineTransform(translationX: 0.0, y: boundingBox.size.height))

  return path
}

private func bezierPathFrom(string: String) -> UIBezierPath? {
  let paths = CGMutablePath()
  let fontName = __CFStringMakeConstantString("MicrosoftYaHei")
  let fontRef:AnyObject = CTFontCreateWithName(fontName!, 14, nil)

  let attrString = NSAttributedString(string: string, attributes: [NSAttributedString.Key(String(kCTFontAttributeName)) : fontRef])
  let line = CTLineCreateWithAttributedString(attrString as CFAttributedString)
  let runA = CTLineGetGlyphRuns(line)

  for runIndex: CFIndex in 0 ..< CFArrayGetCount(runA) {
    let run = CFArrayGetValueAtIndex(runA, runIndex)
    let runb = unsafeBitCast(run, to: CTRun.self)

    let  CTFontName = unsafeBitCast(kCTFontAttributeName, to: UnsafeRawPointer.self)

    let runFontC = CFDictionaryGetValue(CTRunGetAttributes(runb),CTFontName)
    let runFontS = unsafeBitCast(runFontC, to: CTFont.self)

    let width = UIScreen.main.bounds.width

    var temp = 0
    var offset:CGFloat = 0.0

    for i in 0 ..< CTRunGetGlyphCount(runb){
      let range = CFRangeMake(i, 1)
      let glyph:UnsafeMutablePointer<CGGlyph> = UnsafeMutablePointer<CGGlyph>.allocate(capacity: 1)
      glyph.initialize(to: 0)
      let position:UnsafeMutablePointer<CGPoint> = UnsafeMutablePointer<CGPoint>.allocate(capacity: 1)
      position.initialize(to: CGPoint.zero)
      CTRunGetGlyphs(runb, range, glyph)
      CTRunGetPositions(runb, range, position)

      let temp3 = CGFloat(position.pointee.x)
      let temp2 = (Int) (temp3 / width)
      let temp1 = 0
      if(temp2 > temp1){

        temp = temp2
        offset = position.pointee.x - (CGFloat(temp) * width)
      }
      let path = CTFontCreatePathForGlyph(runFontS,glyph.pointee,nil)
      let x = position.pointee.x - (CGFloat(temp) * width) - offset
      let y = position.pointee.y - (CGFloat(temp) * 80)
      let transform = CGAffineTransform(translationX: x, y: y)
      paths.addPath(path!, transform: transform)
      //            glyph.deinitialize()
      //            glyph.deallocate(capacity: 1)
      //            position.deinitialize()
      //            position.deallocate(capacity: 1)
    }

  }

  let bezierPath = UIBezierPath()
  bezierPath.move(to: CGPoint.zero)
  bezierPath.append(UIBezierPath.init(cgPath: paths))

  return bezierPath
}
