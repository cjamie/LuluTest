//
//  SceneDelegate.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import UIKit
import Combine

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    var mainCoordinator: Coordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let navigation = UINavigationController()
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navigation.navigationBar.standardAppearance = navBarAppearance
        navigation.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        self.window = window
        mainCoordinator = AppCoordinator(
            navigationController: navigation,
            window: window
        )

        mainCoordinator?.start()
    }
}
