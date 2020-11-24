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
        let generatorUserNavigationController = UINavigationController()
        generatorUserNavigationController.tabBarItem = UITabBarItem(title: "User Generator", image: UIImage(systemName: "die.face.5"), selectedImage: nil)
        
        let savedUsersNavigationController = UINavigationController()
        savedUsersNavigationController.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "person"), selectedImage: nil)
        
        configureRouter(type: .userGenerator, subjectNavigationController: generatorUserNavigationController)
        configureRouter(type: .savedUser, subjectNavigationController: savedUsersNavigationController)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([generatorUserNavigationController, savedUsersNavigationController], animated: true)
        return tabBarController
    }
    
    private func configureRouter(type: FactoryType, subjectNavigationController: UINavigationController) {
        let container = RouterDIContainer()
        let router = container.get(type: type, subjectNavigation: subjectNavigationController)
        router?.initialSubjectNavigationController()
    }
}
