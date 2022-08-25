import SwiftUI

enum SwiftUIAnimation {}

extension SwiftUIAnimation {
  enum Implicit {
    class SimpleAnimationViewController: UIViewController {
      override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 40
        view.layer.cornerCurve = .continuous
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor

        let hostingController = UIHostingController(rootView: ContentView())

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        NSLayoutConstraint.activate([
          hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
          hostingController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          hostingController.view.widthAnchor.constraint(equalToConstant: 320),
          hostingController.view.heightAnchor.constraint(equalToConstant: 568),
        ])
      }

      override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      }
    }

    struct ContentView: View {
      @State private var heartChange = false

      var body: some View {
        ZStack {
          Image(systemName: heartChange ? "heart.fill" : "heart")
            .font(.system(size: 100))
            .foregroundColor(heartChange ? .red : .black)
            .scaleEffect(heartChange ? 1.5 : 1.0)
            .animation(.default, value: heartChange)
        }
        .onTapGesture {
          self.heartChange.toggle()
        }
      }
    }
  }

  enum Explicit {
    class SimpleAnimationViewController: UIViewController {
      override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 40
        view.layer.cornerCurve = .continuous
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray.cgColor

        let hostingController = UIHostingController(rootView: ContentView())

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)

        NSLayoutConstraint.activate([
          hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
          hostingController.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          hostingController.view.widthAnchor.constraint(equalToConstant: 320),
          hostingController.view.heightAnchor.constraint(equalToConstant: 568),
        ])
      }

      override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      }
    }
    
    struct ContentView: View {
      @State private var heartChange = false

      var body: some View {
        ZStack {
          Image(systemName: heartChange ? "heart.fill" : "heart")
            .font(.system(size: 100))
            .foregroundColor(heartChange ? .red : .black)
            .scaleEffect(heartChange ? 1.5 : 1.0)
        }
        .onTapGesture {
          withAnimation(.default) {
            self.heartChange.toggle()
          }
        }
      }
    }
  }
}
