import UIKit

protocol GridViewDelegate: AnyObject {
    func didTouchItem(at col: Int, row: Int)
}

class GridView: UIView {

    weak var delegate: GridViewDelegate?

    // 2D Array of Views corresponding to grid (some might be nil if empty/exploding)
    private var itemViews: [[ItemView?]] = []

    private let numCols = AppConstants.Game.columns
    private let numRows = AppConstants.Game.rows
    private let itemSpacing: CGFloat = 4.0

    override func layoutSubviews() {
        super.layoutSubviews()
        updateItemFrames()
    }

    private func updateItemFrames() {
        for col in 0..<numCols {
            for row in 0..<numRows {
                if let view = itemViews[col][row] {
                    view.frame = frameFor(col: col, row: row)
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGrid()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGrid()
    }

    private func setupGrid() {
        // Initialize array
        // Logic: itemViews[col][row]
        for _ in 0..<numCols {
            var colArray: [ItemView?] = []
            for _ in 0..<numRows {
                colArray.append(nil)
            }
            itemViews.append(colArray)
        }

        // Add Tap Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tap)
    }

    var itemSize: CGSize {
        let width = (bounds.width - (CGFloat(numCols + 1) * itemSpacing)) / CGFloat(numCols)
        let height = (bounds.height - (CGFloat(numRows + 1) * itemSpacing)) / CGFloat(numRows)
        // Keep square
        let size = min(width, height)
        return CGSize(width: size, height: size)
    }

    // MARK: - Layout
    // We calculate frames manually for easy animation

    func frameFor(col: Int, row: Int) -> CGRect {
        let size = itemSize
        // Origin logic:
        // (0,0) is Top-Left visually?
        // Game Logic said (0,0) might be bottom-left?
        // Let's stick to Standard UIKit: (0,0) in logic maps to (0,0) in UI (Top-Left).
        // If my GameEngine produced rows 0..7
        // Row 0 is Top.

        let x = itemSpacing + CGFloat(col) * (size.width + itemSpacing)
        let y = itemSpacing + CGFloat(row) * (size.height + itemSpacing)
        return CGRect(origin: CGPoint(x: x, y: y), size: size)
    }

    // MARK: - Updates

    func createItemView(item: GameItem) {
        // Remove existing if any
        if let existing = itemViews[item.column][item.row] {
            existing.removeFromSuperview()
        }

        let view = ItemView()
        view.configure(with: item.itemType)
        view.gridPosition = (item.column, item.row)

        addSubview(view)
        view.frame = frameFor(col: item.column, row: item.row)

        itemViews[item.column][item.row] = view
    }

    func removeItemView(col: Int, row: Int) {
        if let view = itemViews[col][row] {
            UIView.animate(
                withDuration: 0.2,
                animations: {
                    view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    view.alpha = 0
                }
            ) { _ in
                view.removeFromSuperview()
            }
            itemViews[col][row] = nil
        }
    }

    // Swap Animation
    func animateSwap(from: (Int, Int), to: (Int, Int), completion: @escaping () -> Void) {
        guard let viewA = itemViews[from.0][from.1],
            let viewB = itemViews[to.0][to.1]
        else {
            completion()
            return
        }

        // Bring to front
        bringSubviewToFront(viewA)
        bringSubviewToFront(viewB)

        let frameA = viewA.frame
        let frameB = viewB.frame

        UIView.animate(
            withDuration: AppConstants.Game.animationDuration,
            animations: {
                viewA.frame = frameB
                viewB.frame = frameA
            }
        ) { _ in
            // Update internal array
            self.itemViews[from.0][from.1] = viewB
            self.itemViews[to.0][to.1] = viewA
            completion()
        }
    }

    // Swap Invalid Animation (Bounce)
    func animateInvalidSwap(from: (Int, Int), to: (Int, Int)) {
        guard let viewA = itemViews[from.0][from.1],
            let viewB = itemViews[to.0][to.1]
        else { return }

        let frameA = viewA.frame
        let frameB = viewB.frame

        UIView.animateKeyframes(
            withDuration: 0.4, delay: 0, options: [],
            animations: {
                // Move there
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                    viewA.frame = frameB
                    viewB.frame = frameA
                }
                // Move back
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                    viewA.frame = frameA
                    viewB.frame = frameB
                }
            }, completion: nil)
    }

    // MARK: - Input Handle
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)

        // Determine Col/Row
        // Simple hit test loop
        for col in 0..<numCols {
            for row in 0..<numRows {
                let frame = frameFor(col: col, row: row)
                if frame.contains(location) {
                    delegate?.didTouchItem(at: col, row: row)
                    return
                }
            }
        }
    }
}
