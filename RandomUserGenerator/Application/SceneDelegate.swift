//
//  SceneDelegate.swift
//  RandomUserGenerator
//
//  Created by Малышев Максим Алексеевич on 10/28/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = makeTabBarController()
        window?.makeKeyAndVisible()
    }
    
    private func makeTabBarController() -> UITabBarController {
            
        let generatorNavigation = makeNavigationController(title: "User Generator", iconName: "die.face.5", type: .userGenerator)
        let savedNavigation = makeNavigationController(title: "Saved", iconName: "person", type: .savedUser)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([generatorNavigation, savedNavigation], animated: true)
        return tabBarController
    }
    
    private func makeNavigationController(title: String, iconName: String, type: FactoryType) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: iconName), selectedImage: nil)
        configureRouter(type: type, subjectNavigationController: navigationController)
        return navigationController
    }
    
    private func configureRouter(type: FactoryType, subjectNavigationController: UINavigationController) {
        let container = RouterInjector()
        let router = container.get(type: type, subjectNavigation: subjectNavigationController)
        router?.initialSubjectNavigationController()
    }
}
