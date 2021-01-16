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
        
        let assembly = ModuleAssembly()
        let tabBarController = UITabBarController()
        
        let userGeneratorModule = assembly.makeGenerateUserModule()
        let savedUserModule = assembly.makeSavedUserModule()
        
        let generatorNavigation = UINavigationController(rootViewController: userGeneratorModule)
        let savedUserNavigation = UINavigationController(rootViewController: savedUserModule)
        
        tabBarController.setViewControllers([generatorNavigation, savedUserNavigation], animated: true)
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}
