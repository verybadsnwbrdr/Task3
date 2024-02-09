import UIKit

final class ViewController: UIViewController {
	private let squareView = SquareView(initialSquareSize: 100, rotationAngle: .pi / 2, scale: 1.5)
	private let slider = UISlider()
	private let animator = UIViewPropertyAnimator(duration: 1, curve: .linear)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		setupAnimations()
	}
	
	private func setupUI() {
		view.backgroundColor = .white
		
		view.addSubview(squareView)
		view.addSubview(slider)
		
		squareView.translatesAutoresizingMaskIntoConstraints = false
		slider.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			squareView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 40),
			squareView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
			squareView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
			squareView.heightAnchor.constraint(equalToConstant: 100),
			
			slider.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 60),
			slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
			slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
		])
	}
	
	private func setupAnimations() {
		animator.pausesOnCompletion = true
		animator.addAnimations { [weak self] in
			self?.squareView.slide()
		}
		
		slider.addAction(UIAction { [weak self] _ in self?.slideAction() }, for: .valueChanged)
		slider.addAction(UIAction { [weak self] _ in self?.touchAction() }, for: .touchUpInside)
	}
	
	private func slideAction() {
		animator.fractionComplete = CGFloat(slider.value)
	}
	
	private func touchAction() {
		animator.continueAnimation(withTimingParameters: nil, durationFactor: 1 - CGFloat(slider.value))
		UIView.animate(
			withDuration: 1 - Double(slider.value),
			delay: 0,
			options: [.allowUserInteraction, .beginFromCurrentState]
		) { [self] in
			slider.setValue(1, animated: true)
		}
	}
}
