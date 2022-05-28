//
//  AppCoordinator.swift
//  LuluTest
//
//  Created by Jamie Chu on 5/28/22.
//

import UIKit
import Combine

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    private let window: UIWindow

    init(
        childCoordinators: [Coordinator] = [],
        navigationController: UINavigationController,
        window: UIWindow
    ) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
        self.window = window
    }
    
    
    func start() {
        let vc = HomeScreenComposer.compose(onAddTapped: presentModal())
        navigationController.navigationBar.backgroundColor = .white

        navigationController.setViewControllers([vc], animated: false)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func presentModal() -> () -> Void {
        { [weak self] in
            guard let self = self else { return }
            
            self.navigationController.present(
                self.makeAddGarmentScreen(),
                animated: true
            )
        }
    }
    
    private func makeAddGarmentScreen() -> UIViewController {
        let textField = UITextField().then{
            $0.backgroundColor = .gray
        }
        
        let screen = AddGarmentScreen(
            model: .init(
                title: "{add}",
                headline: "{garment name:}",
                rightBanner: "{save}"
            ),
            textField: textField
        )
                
        let defaultsWrapper = UserDefaultsWrapper(.standard)
        let useCase = SaveUseCase(
            saver: defaultsWrapper,
            item: {
                [weak textField] in
                guard let textFieldText = textField?.text, UserInputPolicy.validate(textFieldText) else { return nil }
                return .init(
                    name: textFieldText,
                    creationTime: Date()
                )
            }
        )
        
        screen.userDidTapSave = useCase.start

        return UINavigationController(
            rootViewController: screen
        ).then {
            $0.navigationBar.backgroundColor = .systemMint
        }
    }
}

