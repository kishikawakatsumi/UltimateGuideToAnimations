import UIKit

final class TitleOnlySlideViewController: UIViewController, PresentationSlideViewController {
  static let identifier = "TitleOnly"

  var slideTitle: String = "Presentation Title" {
    didSet {
      slideTitleLabel?.text = slideTitle
    }
  }
  var slideSubtitle: String = "Presentation Subtitle" {
    didSet {
      slideSubtitleLabel?.text = slideSubtitle
    }
  }

  @IBOutlet private var slideTitleLabel: UILabel!
  @IBOutlet private var slideSubtitleLabel: UILabel!
  @IBOutlet private(set) var contentViewContainer: UIView!
  private(set) var contentView = UIView()

  override func viewDidLoad() {
    super.viewDidLoad()

    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentViewContainer.addSubview(contentView)
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: contentViewContainer.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: contentViewContainer.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: contentViewContainer.trailingAnchor),
      contentView.bottomAnchor.constraint(equalTo: contentViewContainer.bottomAnchor),
    ])

    slideTitle = itself(slideTitle)
    slideSubtitle = itself(slideSubtitle)
  }
}
