
import SwiftUI
import Lottie
struct LottieView: UIViewRepresentable {
 typealias UIViewType = UIView
 var animationName: String
 var loopMode: LottieLoopMode = .loop
 func makeUIView(context: Context) -> UIView {
  let view = UIView(frame: .zero)
  let animationView = AnimationView()
  let animation = Animation.named(animationName)
  animationView.animation = animation
  animationView.contentMode = .scaleAspectFit
  animationView.loopMode = loopMode
  animationView.play()
  animationView.translatesAutoresizingMaskIntoConstraints = false
  view.addSubview(animationView)
  NSLayoutConstraint.activate([
  animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
  animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
  ])
  return view
 }
 func updateUIView(_ uiView: UIView, context: Context) {
 }
}
