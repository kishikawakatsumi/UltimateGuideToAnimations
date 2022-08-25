import UIKit

extension UIViewAnimations {
  class AnimateAutoLayoutViewController: UIViewController {
    let textView = UITextView()

    override func viewDidLoad() {
      super.viewDidLoad()

      view.backgroundColor = .systemBackground
      view.layer.cornerRadius = 40
      view.layer.cornerCurve = .continuous
      view.layer.borderWidth = 1
      view.layer.borderColor = UIColor.systemGray.cgColor

      textView.backgroundColor = .clear
      textView.isScrollEnabled = false
      textView.isEditable = false
      textView.textContainer.lineBreakMode = .byTruncatingTail
      textView.font = UIFont.systemFont(ofSize: 20)
      textView.text = """
        吾輩は猫である。名前はまだ無い。

        どこで生れたかとんと見当がつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。吾輩はここで始めて人間というものを見た。しかもあとで聞くとそれは書生という人間中で一番獰悪な種族であったそうだ。この書生というのは時々我々を捕えて煮て食うという話である。しかしその当時は何という考もなかったから別段恐しいとも思わなかった。ただ彼の掌に載せられてスーと持ち上げられた時何だかフワフワした感じがあったばかりである。
        """

      textView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(textView)

      let heightConstraint = textView.heightAnchor.constraint(equalToConstant: 200)
      
      NSLayoutConstraint.activate([
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
        heightConstraint,
      ])

      let textView = self.textView

      let button: UIButton
      if #available(iOS 15.0, *) {
        button = UIButton(configuration: .filled())
      } else {
        button = UIButton(type: .custom)
        button.backgroundColor = .systemBlue
      }
      button.setTitle(NSLocalizedString("Read More...", comment: ""), for: .normal)
      button.addAction(
        UIAction { _ in
          textView.superview?.layoutIfNeeded()

          UIView.animate(withDuration: 4, delay: 0, options: [.curveEaseInOut]) {
            heightConstraint.isActive.toggle()
            textView.superview?.layoutIfNeeded()
          }
        },
        for: .touchUpInside
      )

      button.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(button)

      NSLayoutConstraint.activate([
        button.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8),
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      ])
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
    }
  }
}
