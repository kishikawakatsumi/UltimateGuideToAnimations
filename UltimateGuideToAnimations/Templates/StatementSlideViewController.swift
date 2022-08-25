import UIKit

final class StatementSlideViewController: UIViewController, PresentationSlideViewController {
  static let identifier = "Statement"

  var statement: String = "Statement" {
    didSet {
      statementLabel?.text = statement
    }
  }

  @IBOutlet private var statementLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    statement = itself(statement)
  }
}
