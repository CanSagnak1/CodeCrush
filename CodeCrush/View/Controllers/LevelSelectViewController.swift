import UIKit

class LevelSelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = AppConstants.Colors.background

        let titleLabel = UILabel()
        titleLabel.text = "SELECT LEVEL"
        titleLabel.font = AppConstants.Fonts.codeDisplay(size: 30)
        titleLabel.textColor = AppConstants.Colors.primaryText
        titleLabel.textAlignment = .center

        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])

        // Simple Vertical Stack for Levels
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fillEqually

        for i in 1...3 {
            let btn = createLevelButton(level: i)
            stack.addArrangedSubview(btn)
        }

        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stack.heightAnchor.constraint(equalToConstant: 240),
        ])
    }

    private func createLevelButton(level: Int) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle("LEVEL \(level) - \(level * 1000) pts", for: .normal)
        btn.titleLabel?.font = AppConstants.Fonts.codeDisplay(size: 20)
        btn.backgroundColor = AppConstants.Colors.surface
        btn.setTitleColor(AppConstants.Colors.accent, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 1
        btn.layer.borderColor = AppConstants.Colors.accent.cgColor
        btn.tag = level
        btn.addTarget(self, action: #selector(didTapLevel(_:)), for: .touchUpInside)
        return btn
    }

    @objc private func didTapLevel(_ sender: UIButton) {
        let levelIdx = sender.tag
        let gameVC = GameViewController(levelIndex: levelIdx)
        navigationController?.pushViewController(gameVC, animated: true)
    }
}
