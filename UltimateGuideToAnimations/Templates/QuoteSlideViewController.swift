import UIKit

final class QuoteSlideViewController: UIViewController, PresentationSlideViewController {
  static let identifier = "Quote"

  var quote: String = "“Notable Quote”" {
    didSet {
      quoteLabel?.text = quote
    }
  }

  var attribution: String = "Attribution" {
    didSet {
      attributionLabel?.text = attribution
    }
  }

  @IBOutlet private var quoteLabel: UILabel!
  @IBOutlet private var attributionLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()

    self.quote = itself(quote)
    self.attribution = itself(attribution)
  }
}
