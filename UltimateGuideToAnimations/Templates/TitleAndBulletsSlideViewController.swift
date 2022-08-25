import UIKit

final class TitleAndBulletsSlideViewController: UIViewController, PresentationSlideViewController {
  static let identifier = "TitleAndBullets"

  var slideTitle: String = "Slide Title" {
    didSet {
      slideTitleLabel?.text = slideTitle
    }
  }
  var slideSubtitle: String = "Slide Subtitle" {
    didSet {
      slideSubtitleLabel?.text = slideSubtitle
    }
  }
  var slideBullets: [String] = [] {
    didSet {
      bulletsContainer?.arrangedSubviews.forEach {
        bulletsContainer?.removeArrangedSubview($0)
      }
      for bullet in slideBullets {
        if let labelTemplate = bulletsLabelTemplate {
          let label = UILabel()
          label.font = labelTemplate.font
          label.numberOfLines = labelTemplate.numberOfLines
          label.text = "• \(bullet)"
          bulletsContainer?.addArrangedSubview(label)
        }
      }
    }
  }

  @IBOutlet private var slideTitleLabel: UILabel!
  @IBOutlet private var slideSubtitleLabel: UILabel!
  @IBOutlet private var bulletsContainer: UIStackView!
  @IBOutlet private var bulletsLabelTemplate: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    self.slideTitle = itself(slideTitle)
    self.slideSubtitle = itself(slideSubtitle)
    self.slideBullets = itself(slideBullets)
  }
}
