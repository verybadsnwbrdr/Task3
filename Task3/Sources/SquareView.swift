import UIKit

final class SquareView: UIView {
	
	private let rotationAngle: CGFloat
	private let scale: CGFloat
	private let initialSquareSize: CGFloat
	
	private let square = UIView()
	
	init(
		initialSquareSize: CGFloat,
		rotationAngle: CGFloat,
		scale: CGFloat
	) {
		self.initialSquareSize = initialSquareSize
		self.rotationAngle = rotationAngle
		self.scale = scale
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func slide() {
		square.transform = CGAffineTransform(rotationAngle: rotationAngle)
		let expectedSize = initialSquareSize * scale
		square.frame = CGRect(
			x: bounds.width - expectedSize,
			y: -(scale - 1) * initialSquareSize / 2,
			width: expectedSize,
			height: expectedSize
		)
	}
	
	private func setup() {
		addSubview(square)
		square.backgroundColor = .systemBlue
		square.layer.cornerRadius = 10
		square.frame = CGRect(
			x: 0,
			y: 0,
			width: initialSquareSize,
			height: initialSquareSize
		)
	}
}
