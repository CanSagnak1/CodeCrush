import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = AppConstants.Colors.background

        let titleLabel = UILabel()
        titleLabel.text = "CODE CRUSH"
        titleLabel.font = AppConstants.Fonts.codeDisplay(size: 40)
        titleLabel.textColor = AppConstants.Colors.accent
        titleLabel.textAlignment = .center

        // Play Button
        let playButton = UIButton(type: .system)
        playButton.setTitle(" BUILD & RUN ", for: .normal)
        playButton.titleLabel?.font = AppConstants.Fonts.codeDisplay(size: 24)
        playButton.backgroundColor = AppConstants.Colors.surfaceHighlight
        playButton.setTitleColor(AppConstants.Colors.success, for: .normal)
        playButton.layer.cornerRadius = 12
        playButton.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(playButton)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),

            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            playButton.widthAnchor.constraint(equalToConstant: 200),
            playButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

    @objc private func didTapPlay() {
        let levelVC = LevelSelectViewController()
        navigationController?.pushViewController(levelVC, animated: true)
    }
}
