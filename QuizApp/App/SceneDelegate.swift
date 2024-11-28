//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Tamuna Kakhidze on 12.11.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let viewController: UIViewController
        
        let viewModel = LoginViewModel()
        if viewModel.userExists {
            let homeViewModel = HomeViewModel()
            viewController = HomeViewController(viewModel: homeViewModel)
        } else {
            let loginViewModel = LoginViewModel()
            viewController = LoginViewController(viewModel: loginViewModel)
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
