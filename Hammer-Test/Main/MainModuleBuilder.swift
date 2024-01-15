//
//  MainModuleBuilder.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 12.01.2024
//

import UIKit

class MainModuleBuilder {
    static func build() -> MainViewController {
        let interactor = MainInteractor()
        let router = MainRouter()
        let presenter = MainPresenter(interactor: interactor, router: router)
        let viewController = MainViewController()
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
