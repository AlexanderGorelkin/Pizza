//
//  MainInteractor.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 12.01.2024
//
import UIKit
protocol MainInteractorProtocol: AnyObject {
    func fetchCategories(completion: @escaping ([String]) -> Void)
    func fetchDish(completion: @escaping ([String: [Dish]]) -> Void)
}

class MainInteractor: MainInteractorProtocol {
    weak var presenter: MainPresenterProtocol?
    let myGroup = DispatchGroup()
    var categoryNameDict: [String: String] = [:]
    var categoryDishesDict: [String: [Dish]] = [:]
    
    func fetchCategories(completion: @escaping ([String]) -> Void) {
        NetworkService.shared.fetchAllCategories { [weak self] result in
            switch result {
            case .success(let success):
                success.categories.forEach { self?.categoryNameDict[$0.id] = $0.name }
                completion(self?.categoryNameDict.toArray() ?? ["Error"])
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    func fetchDish(completion: @escaping ([String: [Dish]]) -> Void) {
        for id in categoryNameDict.keys {
            myGroup.enter()
            NetworkService.shared.fetchCategoryDishes(categoryId: id) { [weak self] result in
                switch result {
                case .success(let success):
                    self?.categoryDishesDict[(self?.categoryNameDict[id])!] = success
                    self?.myGroup.leave()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
            
        }
        myGroup.notify(queue: .main) {
            completion(self.categoryDishesDict)
        }
        
    }
}
/*
 completion(self.categoryDishesDict ?? ["Error": [.init(id: "Nil", name: "Error to fetch", description: "Error to fetch", image: "nil", calories: 110)]])
 */
