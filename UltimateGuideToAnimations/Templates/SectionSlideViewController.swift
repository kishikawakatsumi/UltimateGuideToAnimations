import UIKit

final class SectionSlideViewController: UIViewController, PresentationSlideViewController {
  static let identifier = "Section"

  var sectionTitle: String = "Section Title" {
    didSet {
      sectionTitleLabel?.text = sectionTitle
    }
  }

  @IBOutlet private var sectionTitleLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    sectionTitle = itself(sectionTitle)
  }
}
