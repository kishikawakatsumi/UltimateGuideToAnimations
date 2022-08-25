import UIKit

class MainController: UIViewController, PresentationTransitionControllerDelegate {
  override var prefersStatusBarHidden: Bool { true }
  override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge { .bottom }

  private let progressBar = UIProgressView(progressViewStyle: .default)
  private let pageLabel = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()

    overrideUserInterfaceStyle = .light

    let transitionController = PresentationTransitionController(
      slides: [
        TitleSlideViewController.makeViewController {
          $0.presentationTitle = NSLocalizedString("アニメーションのすべて", comment: "")
          $0.presentationSubtitle = NSLocalizedString("iOSDC 2022", comment: "")
          $0.authorAndDate = NSLocalizedString("kishikawa katsumi", comment: "")
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("iOSのアニメーションAPI", comment: "")
          $0.slideSubtitle = ""
          $0.slideBullets = [
            NSLocalizedString("UIView animation methods", comment: ""),
            NSLocalizedString("UIView animation methods (Block-based)", comment: ""),
            NSLocalizedString("Core Animation", comment: ""),
            NSLocalizedString("UIViewPropertyAnimator", comment: ""),
            NSLocalizedString("UIKit Dynamics", comment: ""),
            NSLocalizedString("3D Animations", comment: ""),
            NSLocalizedString("SwiftUI Animation", comment: ""),
          ]
        },
        SectionSlideViewController.makeViewController {
          $0.sectionTitle = NSLocalizedString("UIView animation methods", comment: "")
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIView animation methods", comment: "")
          $0.slideSubtitle = NSLocalizedString("iOS 2.0 – 13.0 Deprecated", comment: "")

          let textView = UINib(nibName: "UIView animation methods", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIView animation methods (Block-based)", comment: "")
          $0.slideSubtitle = NSLocalizedString("iOS 4.0+", comment: "")

          let textView = UINib(nibName: "UIView animation methods (Block-based)", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIView animation methods (Block-based)", comment: "")
          $0.slideSubtitle = NSLocalizedString("クロージャの中でbeginAnimations()とcommitAnimations()が呼ばれるだけ。まったく同じもの。", comment: "")

          let textView = UINib(nibName: "UIView animation methods (Block-based)", bundle: nil).instantiate(withOwner: nil)[1] as! UIView
          textView.layer.cornerRadius = 12
          
          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIView animation methods (Block-based)", comment: "")
          $0.slideSubtitle = NSLocalizedString("クロージャの中で変更したプロパティがアニメーションする。複数プロパティを一度に変更できる。", comment: "")

          let textView = UINib(nibName: "UIView animation methods (Block-based)", bundle: nil).instantiate(withOwner: nil)[2] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = UIViewAnimations.SimpleAnimationViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIView animation methods", comment: "")
          $0.slideSubtitle = NSLocalizedString("Animatable Properties", comment: "")

          let columnView = UIStackView()
          columnView.axis = .horizontal
          columnView.spacing = 16
          columnView.alignment = .fill
          columnView.distribution = .fillEqually

          columnView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(columnView)
          NSLayoutConstraint.activate([
            columnView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            columnView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            columnView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            columnView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let leftColumnView = UIStackView()
          leftColumnView.axis = .vertical
          leftColumnView.spacing = 16
          leftColumnView.alignment = .fill
          leftColumnView.distribution = .fillEqually

          leftColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(leftColumnView)

          let middleColumnView = UIStackView()
          middleColumnView.axis = .vertical
          middleColumnView.spacing = 16
          middleColumnView.alignment = .fill
          middleColumnView.distribution = .fillEqually

          middleColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(middleColumnView)

          let rightColumnView = UIStackView()
          rightColumnView.axis = .vertical
          rightColumnView.spacing = 16
          rightColumnView.alignment = .fill
          rightColumnView.distribution = .fillEqually

          rightColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(rightColumnView)

          for viewController in [UIViewAnimations.AnimateFrameViewController(), UIViewAnimations.AnimateBoundsViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            leftColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)
          }

          for viewController in [UIViewAnimations.AnimateCenterViewController(), UIViewAnimations.AnimateTransformViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            middleColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)
          }

          for viewController in [UIViewAnimations.AnimateAlphaViewController(), UIViewAnimations.AnimateBackgroundColorViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            rightColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)
          }
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIView animation methods", comment: "")
          $0.slideSubtitle = NSLocalizedString("Example: Popover", comment: "")

          let textView = UINib(nibName: "PopoverViewController", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = UIViewAnimations.PopoverExampleViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIView animation methods", comment: "")
          $0.slideSubtitle = NSLocalizedString("Indirectly Animatable Properties", comment: "")

          let textView = UINib(nibName: "UIView animation methods (AutoLayout)", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = UIViewAnimations.AnimateAutoLayoutViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        SectionSlideViewController.makeViewController {
          $0.sectionTitle =  NSLocalizedString("Core Animation", comment: "")
        },
        QuoteSlideViewController.makeViewController {
          $0.quote =  NSLocalizedString("“It is an infrastructure for compositing and manipulating your app’s content in hardware.”", comment: "")
          $0.attribution =  NSLocalizedString("Core Animation Programming Guide", comment: "")
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("Core Animation", comment: "")
          $0.slideSubtitle = NSLocalizedString("What is Core Animation?", comment: "")
          $0.slideBullets = [
            NSLocalizedString("あらゆる視覚的要素をデバイスに表示するため汎用システム", comment: ""),
            NSLocalizedString("アニメーションのためだけの仕組みではない", comment: ""),
            NSLocalizedString("パフォーマンスの良い画面表示とアニメーションをサポートする技術", comment: ""),
            NSLocalizedString("UIKitのすべて、そしてiOSアプリケーションの画面上に表示されるすべてのものの基礎", comment: ""),
          ]
        },
        SectionSlideViewController.makeViewController {
          $0.sectionTitle =  NSLocalizedString("CALayer", comment: "")
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CALayer", comment: "")
          $0.slideSubtitle = NSLocalizedString("Layer Tree", comment: "")
          $0.slideBullets = [
            NSLocalizedString("UIViewは必ず対応するCALayerを１つ持つ", comment: ""),
            NSLocalizedString(
            """
            ビューの階層構造を作ると、自動的に同じ形のレイヤーの
            階層構造がビューによって作られる
            """,
            comment: ""
            ),
          ]

          let exampleViewController = CoreAnimation.LayerTreeExampleViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.view.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.view.trailingAnchor, constant: -200),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.view.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])

          let imageView = UIImageView(image: UIImage(named: "ViewLayerTree"))
          imageView.contentMode = .scaleAspectFit

          imageView.translatesAutoresizingMaskIntoConstraints = false
          $0.view.addSubview(imageView)

          NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: $0.view.leadingAnchor, constant: 120),
            imageView.bottomAnchor.constraint(equalTo: $0.view.bottomAnchor, constant: -120),
          ])
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CALayer", comment: "")
          $0.slideSubtitle = NSLocalizedString("Layer Tree", comment: "")
          $0.slideBullets = [
            NSLocalizedString("UIViewは必ず対応するCALayerを１つ持つ", comment: ""),
            NSLocalizedString(
            """
            ビューの階層構造を作ると、自動的に同じ形のレイヤーの
            階層構造がビューによって作られる
            """,
            comment: ""
            ),
            NSLocalizedString(
            """
            自分で直接CALayerの階層構造に追加することもできる。
            """,
            comment: ""
            ),
          ]

          let exampleViewController = CoreAnimation.SublayerExampleViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.view.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.view.trailingAnchor, constant: -200),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.view.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])

          let imageView = UIImageView(image: UIImage(named: "ViewLayerTree2"))
          imageView.contentMode = .scaleAspectFit

          imageView.translatesAutoresizingMaskIntoConstraints = false
          $0.view.addSubview(imageView)

          NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: $0.view.leadingAnchor, constant: 120),
            imageView.bottomAnchor.constraint(equalTo: $0.view.bottomAnchor, constant: -120),
          ])
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CALayerのラッパー", comment: "")
          $0.slideSubtitle = ""
          $0.slideBullets = [
            NSLocalizedString("UIViewは視覚要素に関するすべてをCALayerに移譲している", comment: ""),
            NSLocalizedString("CALayerはUIViewの内部実装ともいえる", comment: ""),
            NSLocalizedString("UIViewの視覚要素に関わるプロパティを設定すると、CALayerの対応するプロパティが変更される", comment: ""),
            NSLocalizedString("視覚要素のことだけを考えた場合、UIViewはCALayerのラッパーと捉えてもよい", comment: ""),
            NSLocalizedString("アニメーションAPIにおける関係も同様", comment: ""),
          ]
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIViewとCALayerの違い", comment: "")
          $0.slideSubtitle = NSLocalizedString("UIView", comment: "")
          $0.slideBullets = [
            NSLocalizedString("UIViewはイベントハンドリングを担う", comment: ""),
            NSLocalizedString("UIView自身は視覚要素を一切扱わない", comment: ""),
            NSLocalizedString("Auto Layoutが使える", comment: ""),
          ]
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIViewとCALayerの違い", comment: "")
          $0.slideSubtitle = NSLocalizedString("CALayer", comment: "")
          $0.slideBullets = [
            NSLocalizedString("視覚要素（見た目）に関するすべてを扱う", comment: ""),
            NSLocalizedString("標準でアニメーションを効率よく処理する仕組みを備えている", comment: ""),
            NSLocalizedString("UIViewに公開されていない高度な視覚要素のプロパティを持つ", comment: ""),
          ]
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIViewとCALayerの使い分け", comment: "")
          $0.slideSubtitle = NSLocalizedString("UIView vs CALayer", comment: "")
          $0.slideBullets = [
            NSLocalizedString("UIViewはCALayerのラッパーで、UIViewのほうが高レベルな操作を備えている", comment: ""),
            NSLocalizedString("UIViewが使えるときはUIViewを使う", comment: ""),
            NSLocalizedString("UIViewではできないより高度な表現が必要な場合はCALayerを使う", comment: ""),
            NSLocalizedString("CALayerにはAuto Layoutがないので配置もUIViewを使った方が良い", comment: ""),
            NSLocalizedString("（CALayerだけを直接追加するよりUIViewとして追加するほうが扱いが簡単）", comment: ""),
          ]
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CALayerが持つ見た目に関するプロパティ", comment: "")
          $0.slideSubtitle = NSLocalizedString("Visual Properties", comment: "")

          let columnView = UIStackView()
          columnView.axis = .horizontal
          columnView.spacing = 16
          columnView.alignment = .fill
          columnView.distribution = .fillEqually

          columnView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(columnView)
          NSLayoutConstraint.activate([
            columnView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            columnView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            columnView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            columnView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let leftColumnView = UIStackView()
          leftColumnView.axis = .vertical
          leftColumnView.spacing = 16
          leftColumnView.alignment = .fill
          leftColumnView.distribution = .fillEqually

          leftColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(leftColumnView)

          let rightColumnView = UIStackView()
          rightColumnView.axis = .vertical
          rightColumnView.spacing = 16
          rightColumnView.alignment = .fill
          rightColumnView.distribution = .fillEqually

          rightColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(rightColumnView)

          for viewController in [LayerProperties.CornerRadiusViewController(), LayerProperties.BorderViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            leftColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)

            viewController.codeButton.isHidden = true
          }

          for viewController in [LayerProperties.ShadowViewController(), LayerProperties.TransformViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            rightColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)

            viewController.codeButton.isHidden = true
          }
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CALayerが持つ見た目に関するプロパティ", comment: "")
          $0.slideSubtitle = NSLocalizedString("Animatable Properties", comment: "")

          let columnView = UIStackView()
          columnView.axis = .horizontal
          columnView.spacing = 16
          columnView.alignment = .fill
          columnView.distribution = .fillEqually

          columnView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(columnView)
          NSLayoutConstraint.activate([
            columnView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            columnView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            columnView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            columnView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let leftColumnView = UIStackView()
          leftColumnView.axis = .vertical
          leftColumnView.spacing = 16
          leftColumnView.alignment = .fill
          leftColumnView.distribution = .fillEqually

          leftColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(leftColumnView)

          let rightColumnView = UIStackView()
          rightColumnView.axis = .vertical
          rightColumnView.spacing = 16
          rightColumnView.alignment = .fill
          rightColumnView.distribution = .fillEqually

          rightColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(rightColumnView)

          for viewController in [LayerProperties.Animating.CornerRadiusViewController(), LayerProperties.Animating.BorderViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            leftColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)
          }

          for viewController in [LayerProperties.Animating.ShadowViewController(), LayerProperties.Animating.TransformViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            rightColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)
          }
        },
        QuoteSlideViewController.makeViewController {
          $0.quote =  NSLocalizedString("“The UIView class disables layer animations by default but reenables them inside animation blocks.”", comment: "")
          $0.attribution =  NSLocalizedString("Core Animation Programming Guide", comment: "")
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("Reenable Layer Animation inside Animation Block", comment: "")
          $0.slideSubtitle = NSLocalizedString("アニメーションブロックの中ではAction（＝アニメーション）オブジェクトが返る", comment: "")

          let textView = UINib(nibName: "UIView animation methods (Block-based)", bundle: nil).instantiate(withOwner: nil)[3] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("何が起こるでしょう？", comment: "")
          $0.slideSubtitle = "アニメーションブロックQuiz"

          let textView = UINib(nibName: "UIView animation methods", bundle: nil).instantiate(withOwner: nil)[2] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])
        },
        StatementSlideViewController.makeViewController {
          $0.statement =  NSLocalizedString(
            """
            レイヤーのアニメーションが常に有効になる。
            """,
            comment: ""
          )
        },
        StatementSlideViewController.makeViewController {
          $0.statement =  NSLocalizedString(
            """
            すべてのアニメーション可能プロパティの変更がアニメーションする。
            """,
            comment: ""
          )
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("何が起こるでしょう？", comment: "")
          $0.slideSubtitle = "アニメーションブロックQuiz"

          let textView = UINib(nibName: "UIView animation methods (Block-based)", bundle: nil).instantiate(withOwner: nil)[4] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])
        },
        StatementSlideViewController.makeViewController {
          $0.statement =  NSLocalizedString(
            """
            alphaプロパティの変更はアニメーションするが、backgroundColorプロパティの変更はアニメーションしない。
            """,
            comment: ""
          )
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CATransaction", comment: "")
          $0.slideSubtitle = ""

          let textView = UINib(nibName: "CATransaction", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("暗黙のアニメーション", comment: "")
          $0.slideSubtitle = "Implicit Animations"
          $0.slideBullets = [
            NSLocalizedString("CALayerのほとんどのプロパティは標準でアニメーションを伴って変化する（暗黙のアニメーション）", comment: ""),
            NSLocalizedString("UIViewが管理するCALayerは暗黙のアニメーションがデフォルトで無効化されている", comment: ""),
            NSLocalizedString("UIViewが管理するCALayerのActionは通常nilを返す（ように設定されている）", comment: ""),
            NSLocalizedString("UIViewのアニメーションブロックは暗黙のアニメーションを一時的に有効化する", comment: ""),
          ]
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("明示的なアニメーション", comment: "")
          $0.slideSubtitle = "Explicit Animations"
          $0.slideBullets = [
            NSLocalizedString("非線形のアニメーションなどより高度で複雑なアニメーションを表現できる", comment: ""),
            NSLocalizedString("直感的に使える暗黙的なアニメーションに比べて、コードは難しくなる", comment: ""),
          ]
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CABasicAnimation", comment: "")
          $0.slideSubtitle = NSLocalizedString("", comment: "")

          let textView = UINib(nibName: "CABasicAnimation", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = BasicAnimation.RotateAnimationViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CABasicAnimation", comment: "")
          $0.slideSubtitle = NSLocalizedString("明示的なアニメーションは見た目の変更だけ", comment: "")

          let textView = UINib(nibName: "CABasicAnimation", bundle: nil).instantiate(withOwner: nil)[1] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = BasicAnimation.BackgroundColorAnimationViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CABasicAnimation", comment: "")
          $0.slideSubtitle = NSLocalizedString(".fillMode = .forwards; isRemovedOnCompletion = false;", comment: "")

          let textView = UINib(nibName: "CABasicAnimation", bundle: nil).instantiate(withOwner: nil)[2] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = BasicAnimation.BackgroundColorFillModeAnimationViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CABasicAnimation", comment: "")
          $0.slideSubtitle = NSLocalizedString("あらかじめアニメーション終了後の値に設定しておく", comment: "")

          let textView = UINib(nibName: "CABasicAnimation", bundle: nil).instantiate(withOwner: nil)[3] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = BasicAnimation.BackgroundColorSetPropertyAnimationViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CABasicAnimation", comment: "")
          $0.slideSubtitle = "イージング関数"

          let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CABasicAnimation", comment: "")
          $0.slideSubtitle = "イージング関数"

          let columnView = UIStackView()
          columnView.axis = .horizontal
          columnView.spacing = 16
          columnView.alignment = .fill
          columnView.distribution = .fillEqually

          columnView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(columnView)
          NSLayoutConstraint.activate([
            columnView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            columnView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            columnView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            columnView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let leftColumnView = UIStackView()
          leftColumnView.axis = .vertical
          leftColumnView.spacing = 16
          leftColumnView.alignment = .fill
          leftColumnView.distribution = .fillEqually

          leftColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(leftColumnView)

          let middleColumnView = UIStackView()
          middleColumnView.axis = .vertical
          middleColumnView.spacing = 16
          middleColumnView.alignment = .fill
          middleColumnView.distribution = .fillEqually

          middleColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(middleColumnView)

          let rightColumnView = UIStackView()
          rightColumnView.axis = .vertical
          rightColumnView.spacing = 16
          rightColumnView.alignment = .fill
          rightColumnView.distribution = .fillEqually

          rightColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(rightColumnView)

          for viewController in [EasingFunctions.LinearViewController(), EasingFunctions.EaseInViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            leftColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)
          }

          for viewController in [EasingFunctions.EaseOutViewController(), EasingFunctions.EaseInEaseOutViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            middleColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)
          }

          for viewController in [EasingFunctions.DefaultViewController(), EasingFunctions.BlankViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            rightColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)
          }
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CABasicAnimation", comment: "")
          $0.slideSubtitle = NSLocalizedString("カスタムのイージング関数", comment: "")

          let textView = UINib(nibName: "EasingFunctions", bundle: nil).instantiate(withOwner: nil)[1] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CABasicAnimation", comment: "")
          $0.slideSubtitle = NSLocalizedString("カスタムのイージング関数 (https://easings.net/)", comment: "")

          let columnView = UIStackView()
          columnView.axis = .horizontal
          columnView.spacing = 16
          columnView.alignment = .fill
          columnView.distribution = .fillEqually

          columnView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(columnView)
          NSLayoutConstraint.activate([
            columnView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            columnView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            columnView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            columnView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let leftColumnView = UIStackView()
          leftColumnView.axis = .vertical
          leftColumnView.spacing = 16
          leftColumnView.alignment = .fill
          leftColumnView.distribution = .fillEqually

          leftColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(leftColumnView)

          let middleColumnView = UIStackView()
          middleColumnView.axis = .vertical
          middleColumnView.spacing = 16
          middleColumnView.alignment = .fill
          middleColumnView.distribution = .fillEqually

          middleColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(middleColumnView)

          let rightColumnView = UIStackView()
          rightColumnView.axis = .vertical
          rightColumnView.spacing = 16
          rightColumnView.alignment = .fill
          rightColumnView.distribution = .fillEqually

          rightColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(rightColumnView)

          for viewController in [EasingFunctions.EaseInSineViewController(), EasingFunctions.EaseOutSineViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            leftColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)
          }

          for viewController in [EasingFunctions.EaseInOutSineViewController(), EasingFunctions.EaseInCubicViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            middleColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)
          }

          for viewController in [EasingFunctions.EaseOutCubicViewController(), EasingFunctions.EaseInOutCubicViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            rightColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)
          }
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("３次ベジェ曲線では実装できないイージング", comment: "")
          $0.slideSubtitle = "CAKeyframeAnimation"

          let columnView = UIStackView()
          columnView.axis = .horizontal
          columnView.spacing = 16
          columnView.alignment = .fill
          columnView.distribution = .fillEqually

          columnView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(columnView)
          NSLayoutConstraint.activate([
            columnView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            columnView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            columnView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            columnView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let leftColumnView = UIStackView()
          leftColumnView.axis = .vertical
          leftColumnView.spacing = 16
          leftColumnView.alignment = .fill
          leftColumnView.distribution = .fillEqually

          leftColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(leftColumnView)

          let rightColumnView = UIStackView()
          rightColumnView.axis = .vertical
          rightColumnView.spacing = 16
          rightColumnView.alignment = .fill
          rightColumnView.distribution = .fillEqually

          rightColumnView.translatesAutoresizingMaskIntoConstraints = false
          columnView.addArrangedSubview(rightColumnView)

          let vc = EasingFunctions.EaseInElasticViewController()
          $0.addChild(vc)
          vc.view.translatesAutoresizingMaskIntoConstraints = false
          leftColumnView.addArrangedSubview(vc.view)
          vc.view.layer.zPosition = 100
          vc.didMove(toParent: $0)

          for viewController in [EasingFunctions.EaseInBounceViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            leftColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)
          }

          for viewController in [EasingFunctions.EaseOutElasticViewController(), EasingFunctions.EaseOutBounceViewController()] {
            $0.addChild(viewController)
            viewController.view.translatesAutoresizingMaskIntoConstraints = false
            rightColumnView.addArrangedSubview(viewController.view)
            viewController.didMove(toParent: $0)
          }
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("３次ベジェ曲線では実装できないイージング", comment: "")
          $0.slideSubtitle = "CAKeyframeAnimation"

          let textView = UINib(nibName: "KeyframeAnimation", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = EasingFunctions.EaseOutBounceViewController()
          exampleViewController.view.layer.borderColor = UIColor.systemBackground.cgColor
          exampleViewController.view.layer.borderWidth = 2
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor, constant: 100),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 716),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 292),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIViewのキーフレームアニメーション", comment: "")
          $0.slideSubtitle = ""

          let textView = UINib(nibName: "KeyframeAnimation", bundle: nil).instantiate(withOwner: nil)[1] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = KeyframeAnimations.SimpleAnimationViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("パスに沿って動かす", comment: "")
          $0.slideSubtitle = "CAKeyframeAnimation"

          let textView = UINib(nibName: "PathAnimation", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = PathAnimation.PathAnimationExampleViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor, constant: -40),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("ばねのような動き", comment: "")
          $0.slideSubtitle = ""

          let textView = UINib(nibName: "SpringAnimation", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = SpringAnimation.SpringAnimationExampleViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("ばねのような動き", comment: "")
          $0.slideSubtitle = "CASpringAnimation"

          let textView = UINib(nibName: "SpringAnimation", bundle: nil).instantiate(withOwner: nil)[1] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = SpringAnimation.SpringCAAnimationExampleViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("インタラクティブなアニメーション", comment: "")
          $0.slideSubtitle = "speed, timeOffset"

          let textView = UINib(nibName: "InteractiveAnimation", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = InteractiveAnimation.PathAnimationViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 640),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 200),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("インタラクティブなアニメーション", comment: "")
          $0.slideSubtitle = "UIViewPropertyAnimator"

          let textView = UINib(nibName: "InteractiveAnimation", bundle: nil).instantiate(withOwner: nil)[1] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = InteractiveAnimation.BlurHeaderViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("📝 UIVisualEffectViewをアニメーションする", comment: "")
          $0.slideSubtitle = ""

          let textView = UINib(nibName: "InteractiveAnimation", bundle: nil).instantiate(withOwner: nil)[2] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = InteractiveAnimation.BlurAnimationViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -100),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIViewPropertyAnimator", comment: "")
          $0.slideSubtitle = "さらに高レベルなアニメーションAPI"
          $0.slideBullets = [
            NSLocalizedString("iOS 10.0から導入されたアニメーションAPI", comment: ""),
            NSLocalizedString("もっとも高レベルな操作として抽象化されている", comment: ""),
            NSLocalizedString("UIViewのAPIでできることは全部できる", comment: ""),
            NSLocalizedString("UIViewPropertyAnimatorを常に使っても良いが、コードのわかりやすさはUIViewのAPIの方が優れている", comment: ""),
          ]
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIKit Dynamics", comment: "")
          $0.slideSubtitle = "UIGravityBehavior, UICollisionBehavior"

          let textView = UINib(nibName: "UIDynamics", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = UIDynamics.ExampleViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -40),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIKit Dynamics", comment: "")
          $0.slideSubtitle = "UISnapBehavior"

          let textView = UINib(nibName: "UIDynamics", bundle: nil).instantiate(withOwner: nil)[1] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = UIDynamics.CardViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -40),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("UIKit Dynamics", comment: "")
          $0.slideSubtitle = "UICollectionView + UIKit Dynamics"

          let exampleViewController = UIDynamics.SampleCollectionViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.centerXAnchor.constraint(equalTo: $0.contentView.centerXAnchor),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("3D Animation", comment: "")
          $0.slideSubtitle = "CALayer + CATransform3D"

          let textView = UINib(nibName: "CA3DAnimations", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = CA3DAnimations.ExampleViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -40),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("3D Animation", comment: "")
          $0.slideSubtitle = "Cube Transition"

          let exampleViewController = CA3DAnimations.CubeTransitionViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.centerXAnchor.constraint(equalTo: $0.contentView.centerXAnchor),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("SwiftUI Animation", comment: "")
          $0.slideSubtitle = ".animation()"

          let textView = UINib(nibName: "SwiftUIAnimation", bundle: nil).instantiate(withOwner: nil)[0] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = SwiftUIAnimation.Implicit.SimpleAnimationViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -40),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("SwiftUI Animation", comment: "")
          $0.slideSubtitle = ".withAnimation()"

          let textView = UINib(nibName: "SwiftUIAnimation", bundle: nil).instantiate(withOwner: nil)[1] as! UIView
          textView.layer.cornerRadius = 12

          textView.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(textView)
          NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: $0.contentView.topAnchor),
            textView.leadingAnchor.constraint(equalTo: $0.contentView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: $0.contentView.bottomAnchor),
          ])

          let exampleViewController = SwiftUIAnimation.Explicit.SimpleAnimationViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.trailingAnchor.constraint(equalTo: $0.contentView.trailingAnchor, constant: -40),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 320),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 568),
          ])
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("SwiftUI Animation", comment: "")
          $0.slideSubtitle = ""
          $0.slideBullets = [
            NSLocalizedString(".animation(): Modifierを付けたビューの変更をアニメーションする", comment: ""),
            NSLocalizedString(".withAnimation(): 関数の中で変更したStateが影響するビューをアニメーションする", comment: ""),
            NSLocalizedString("イージングは基本のeaseIn、easeOut、,easeInOutが用意されている", comment: ""),
            NSLocalizedString("timingCurve()で任意の３次ベジェ曲線のイージングも使える", comment: ""),
            NSLocalizedString("springとinterpolatingSpringの２種類のばねの動きが用意されている", comment: ""),
            NSLocalizedString("SwiftUIも最終的にはCore Animationを使うが今のところ純粋なSwiftUIからCore Animationを直接触る手段はない", comment: ""),
          ]
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("Specialized Layers", comment: "")
          $0.slideSubtitle = ""
          $0.slideBullets = [
            NSLocalizedString("CAShapeLayer", comment: ""),
            NSLocalizedString("CAReplicatorLayer", comment: ""),
            NSLocalizedString("CAEmitterLayer", comment: ""),
            NSLocalizedString("etc.", comment: ""),
          ]
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CAShapeLayer", comment: "")
          $0.slideSubtitle = "Marching Ants"

          let exampleViewController = MarchingAntsViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.centerXAnchor.constraint(equalTo: $0.contentView.centerXAnchor),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 1200),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 800),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CAReplicatorLayer", comment: "")
          $0.slideSubtitle = "Circular Loader"

          let exampleViewController = CircularLoaderViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.centerXAnchor.constraint(equalTo: $0.contentView.centerXAnchor),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 1200),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 800),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CAReplicatorLayer", comment: "")
          $0.slideSubtitle = "Sound Wave"

          let exampleViewController = SoundWaveViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.centerXAnchor.constraint(equalTo: $0.contentView.centerXAnchor),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 1200),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 800),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CAReplicatorLayer", comment: "")
          $0.slideSubtitle = "Mirror Reflection"

          let exampleViewController = ReflectionViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.centerXAnchor.constraint(equalTo: $0.contentView.centerXAnchor),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 1200),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 800),
          ])
        },
        TitleOnlySlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("CAEmitterLayer", comment: "")
          $0.slideSubtitle = "Confetti"

          let exampleViewController = ConfettiViewController()
          $0.addChild(exampleViewController)
          exampleViewController.view.translatesAutoresizingMaskIntoConstraints = false
          $0.contentView.addSubview(exampleViewController.view)
          exampleViewController.didMove(toParent: $0)

          NSLayoutConstraint.activate([
            exampleViewController.view.centerXAnchor.constraint(equalTo: $0.contentView.centerXAnchor),
            exampleViewController.view.centerYAnchor.constraint(equalTo: $0.contentView.centerYAnchor),
            exampleViewController.view.widthAnchor.constraint(equalToConstant: 1200),
            exampleViewController.view.heightAnchor.constraint(equalToConstant: 800),
          ])
        },
        SectionSlideViewController.makeViewController {
          $0.sectionTitle = NSLocalizedString("github.com/kishikawakatsumi/UltimateGuideToAnimations", comment: "")
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("Conclusion", comment: "")
          $0.slideSubtitle = "使えるときは高レベルなAPIを使い、より高度な表現が必要になったらCore Animationを直接使う"
          $0.slideBullets = [
            NSLocalizedString("Core AnimationはiOSの視覚表現のすべてを支える", comment: ""),
            NSLocalizedString("Core Animationはなんでもできるが低レベルな操作と仕組みの理解が必要", comment: ""),
            NSLocalizedString("UIViewのAPIはCore Animationをラップして使いやすくしてくれる", comment: ""),
            NSLocalizedString("表現力が足りるときは高レベルなAPIを使用する", comment: ""),
            NSLocalizedString("より高度な表現が求められるときはCore Animationを直接使う", comment: ""),
          ]
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("References", comment: "")
          $0.slideSubtitle = ""
          $0.slideBullets = [
            NSLocalizedString("https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/Introduction/Introduction.html", comment: ""),
            NSLocalizedString("https://qiita.com/hachinobu/items/57d4c305c907805b4a53", comment: ""),
            NSLocalizedString("https://snoozelag.hatenablog.com/entry/2021/12/18/003933", comment: ""),
            NSLocalizedString("https://snoozelag.hatenablog.com/entry/2021/12/18/004040", comment: ""),
            NSLocalizedString("https://medium.com/@theoben.hassen/ios-animations-uiview-part-1-d94305bee2f5", comment: ""),
            NSLocalizedString("https://medium.com/@theoben.hassen/ios-animations-coreanimation-part-2-58bb4676710f", comment: ""),
          ]
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("References", comment: "")
          $0.slideSubtitle = ""
          $0.slideBullets = [
            NSLocalizedString("https://www.appcoda.com/interactive-animation-uiviewpropertyanimator/", comment: ""),
            NSLocalizedString("https://useyourloaf.com/blog/animating-autolayout-constraints/", comment: ""),
            NSLocalizedString("https://viscircle.de/how-to-create-advanced-ios-animations-with-automatic-layout-2/?lang=en", comment: ""),
            NSLocalizedString("https://lab.elconfidencial.com/demystifying-ios-animations-part-1-fd5fbcd45ee9", comment: ""),
            NSLocalizedString("https://lab.elconfidencial.com/demystifying-ios-animations-part-2-49db33e62628", comment: ""),
            NSLocalizedString("https://gist.github.com/nicklockwood/d374033b27c62662ac8d", comment: ""),
          ]
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("References", comment: "")
          $0.slideSubtitle = ""
          $0.slideBullets = [
            NSLocalizedString("https://tapadoo.com/animating-custom-calayer-properties-in-swift-and-what-to-check-for-when-they-arent-working/", comment: ""),
            NSLocalizedString("https://blog.codecentric.de/en/2016/07/custom-property-uiview-block-animation/", comment: ""),
            NSLocalizedString("https://medium.com/ios-os-x-development/demystifying-uikit-spring-animations-2bb868446773", comment: ""),
            NSLocalizedString("https://stackoverflow.com/questions/5161465/how-to-create-custom-easing-function-with-core-animation", comment: ""),
            NSLocalizedString("https://www.slideshare.net/kaniza1/core-animation-view", comment: ""),
            NSLocalizedString("https://www.slideshare.net/nakiwo/coreanimation-part1", comment: ""),
          ]
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("References", comment: "")
          $0.slideSubtitle = ""
          $0.slideBullets = [
            NSLocalizedString("https://www.merowing.info/details-matter---harnessing-the-power-of-core-animation/", comment: ""),
            NSLocalizedString("http://fancypixel.github.io/blog/2015/06/19/playing-with-uidynamics-in-ios-9/", comment: ""),
            NSLocalizedString("https://www.objc.io/issues/5-ios7/collection-views-and-uidynamics/", comment: ""),
            NSLocalizedString("https://www.hackingwithswift.com/example-code/calayer/how-to-create-a-marching-ants-effect-using-linedashphase", comment: ""),
            NSLocalizedString("https://marcocapano.dev/ios/2019/03/21/creating-a-custom-loader-with-coreanimation/", comment: ""),
            NSLocalizedString("https://www.slideshare.net/AlessandroLudovici/create-an-animation-with-careplicatorlayer", comment: ""),
          ]
        },
        TitleAndBulletsSlideViewController.makeViewController {
          $0.slideTitle = NSLocalizedString("References", comment: "")
          $0.slideSubtitle = ""
          $0.slideBullets = [
            NSLocalizedString("https://jordan-dixon.com/2018/03/31/seeing-the-light-with-careplicatorlayer/", comment: ""),
            NSLocalizedString("https://github.com/raywenderlich/LayerPlayer", comment: ""),
            NSLocalizedString("https://www.amazon.co.jp/iOS-Core-Animation-Advanced-Techniques-ebook/dp/B00EHJCORC", comment: ""),
          ]
        },
      ]
    )

    transitionController.delegate = self

    addChild(transitionController)
    transitionController.view.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(transitionController.view)
    transitionController.didMove(toParent: self)

    NSLayoutConstraint.activate([
      transitionController.view.topAnchor.constraint(equalTo: view.topAnchor),
      transitionController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      transitionController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      transitionController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    progressBar.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(progressBar)
    NSLayoutConstraint.activate([
      progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      progressBar.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])

    pageLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 20, weight: .regular)
    pageLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(pageLabel)
    NSLayoutConstraint.activate([
      pageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      pageLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
    ])

    updateProgress(transitionController)
  }

  func didMovePrevious(_ transitionController: PresentationTransitionController, current currentViewController: any PresentationSlideViewController, previous previousViewController: any PresentationSlideViewController) {
    updateProgress(transitionController)
  }

  func didMoveNext(_ transitionController: PresentationTransitionController, current currentViewController: any PresentationSlideViewController, next nextViewController: any PresentationSlideViewController) {
    updateProgress(transitionController)
  }

  private func updateProgress(_ controller: PresentationTransitionController) {
    progressBar.setProgress(controller.progress, animated: true)
    pageLabel.text = "\(controller.currentPage)/\(controller.pageCount)"
  }
}
