//
//  MainPresenter.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 12.01.2024
//

protocol MainPresenterProtocol: AnyObject {
    func fetchCategories()
    func setupCategories(with categories: [String])
    func fetchDishes()
    func setupDishes(with dishes: [String: [Dish]])
    func showCategory(with number: Int)
    func didSelectItemAt(section number: Int)
}

class MainPresenter {
    weak var view: MainViewProtocol?
    weak var collectionView: CategoryCollectionView?
    var router: MainRouterProtocol
    var interactor: MainInteractorProtocol

    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension MainPresenter: MainPresenterProtocol {
    func fetchCategories() {
        interactor.fetchCategories { stringArray in
            self.setupCategories(with: stringArray)
            self.fetchDishes()
        }
    }
    
    func setupCategories(with categories: [String]) {
//        self.view?.setupCategories(categories: ["Nigerian", "Pizzas", "Sea Foods", "Snacks", "Veget"])
        self.view?.setupCategories(categories: categories)
    }
    func fetchDishes() {
       
        interactor.fetchDish { dishes in
            self.setupDishes(with: dishes)
        }
    }
    
    func setupDishes(with dishes: [String : [Dish]]) {
        self.view?.setupTableViewData(with: dishes)
    }
    
  
    
    func didSelectItemAt(section number: Int) {
        view?.moveToSection(with: number)
    }
    func showCategory(with number: Int) {
        collectionView?.changeCategory(number: number)
    }
    
   
}
