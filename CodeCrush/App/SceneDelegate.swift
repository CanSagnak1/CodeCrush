import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene, willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Create the window
        let window = UIWindow(windowScene: windowScene)

        // Enforce Dark Mode
        window.overrideUserInterfaceStyle = .dark

        // Set Root View Controller (Navigation Controller wrapping Home VC)
        let homeVC = HomeViewController()
        let nav = UINavigationController(rootViewController: homeVC)
        nav.isNavigationBarHidden = true  // Custom UI, hiding default nav bar

        window.rootViewController = nav
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}
