import UIKit

class ItemView: UIImageView {

    var itemType: ItemType?
    var gridPosition: (col: Int, row: Int)?

    init() {
        super.init(frame: .zero)
        contentMode = .scaleAspectFit
        isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with type: ItemType) {
        self.itemType = type
        self.image = UIImage(named: type.spriteName)
    }

    func setHighlight(_ highlighted: Bool) {
        if highlighted {
            layer.borderWidth = 3.0
            layer.borderColor = UIColor.white.cgColor  // or Accent
            alpha = 1.0
            transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } else {
            layer.borderWidth = 0
            alpha = 1.0
            transform = .identity
        }
    }
}
