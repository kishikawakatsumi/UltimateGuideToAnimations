import UIKit

final class TitleSlideViewController: UIViewController, PresentationSlideViewController {
  static let identifier = "Title"

  var presentationTitle: String = "Presentation Title" {
    didSet {
      presentationTitleLabel?.text = presentationTitle
    }
  }
  var presentationSubtitle: String = "Presentation Subtitle" {
    didSet {
      presentationSubtitleLabel?.text = presentationSubtitle
    }
  }
  var authorAndDate: String = "Author and Date" {
    didSet {
      authorAndDateLabel?.text = authorAndDate
    }
  }

  @IBOutlet private var presentationTitleLabel: UILabel!
  @IBOutlet private var presentationSubtitleLabel: UILabel!
  @IBOutlet private var authorAndDateLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    presentationTitleLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: UIFont.boldSystemFont(ofSize: presentationTitleLabel.font.pointSize))
    presentationSubtitleLabel.font = UIFontMetrics(forTextStyle: .title2).scaledFont(for: UIFont.boldSystemFont(ofSize: presentationSubtitleLabel.font.pointSize))
    authorAndDateLabel.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.boldSystemFont(ofSize: authorAndDateLabel.font.pointSize))

    presentationTitle = itself(presentationTitle)
    presentationSubtitle = itself(presentationSubtitle)
    authorAndDate = itself(authorAndDate)
  }
}
