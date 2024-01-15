//
//  MainViewController.swift
//  Super easy dev
//
//  Created by Александр Горелкин on 12.01.2024
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func setupCategories(categories: [String])
    func setupTableViewData(with food: [String: [Dish]])
    func moveToSection(with number: Int)
}

class MainViewController: UIViewController {
    
    
    
    
    // MARK: - Public
    var presenter: MainPresenter?
    
    var categoryDishesDict: [String: [Dish]] = [:]
    var keysArray: [String] = []
    
    let defaultBackgroundColor = UIColor(hexString: "#F3F5F9")
    
    private let minConstraintConstant: CGFloat = 0
    private let maxConstraintConstant: CGFloat = 130
    
    
    private var avatarHeightConstraint: NSLayoutConstraint?
    private var animatedConstraint: NSLayoutConstraint?
    private var previousContentOffsetY: CGFloat = 0
    private var animationCompletionPercent: CGFloat = 0
    
    
    private let bannerCollectionView = BannerCollectionView()
    private let navCollectionView = CategoryCollectionView()
    
    
   
    private let activityIndicator = {
       let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let customTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PizzaTableViewCell.self, forCellReuseIdentifier: PizzaTableViewCell.identifier)
        tableView.layer.cornerRadius = 10
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }()
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        customTableView.dataSource = self
        customTableView.delegate = self
        presenter?.fetchCategories()
        view.backgroundColor = defaultBackgroundColor
        navigationItem.leftBarButtonItems = makeNavigationBarMenu()
        setupBannerCollection()
        setupCategoryCollection()
        setupTableView()
        setupActivityIndicator()
    }
}

// MARK: - Private functions
 extension MainViewController {
    
    
    func makeNavigationBarStack() -> UIBarButtonItem{
        
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        
        
        let navCollectionView = CategoryCollectionView()
        let bannerCollectionView = BannerCollectionView()
        
        stackView.addArrangedSubview(navCollectionView)
        stackView.addArrangedSubview(bannerCollectionView)
        
        return UIBarButtonItem(customView: stackView)
        
    }
    
    
     func setupActivityIndicator() {
         customTableView.addView(activityIndicator)
         activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
         activityIndicator.startAnimating()
     }
    
    
    func makeNavigationBarMenu() -> [UIBarButtonItem] {
        let cityNameView = UIBarButtonItem(customView: MenuLabelView())
        
        let dropDownItem = UIBarButtonItem(title: "Москва", image: UIImage(systemName: "chevron.down"), target: self, action: nil, menu: createDropDownMenu())
        
        return [cityNameView, dropDownItem]
    }
    
    func createDropDownMenu() -> UIMenu {
        let firstSubItem = UIAction(title: "Москва") { _ in
            print("Москва")
        }
        let secondSubItem = UIAction(title: "Казань") { _ in
            print("Казань")
        }
        return UIMenu(title: "Москва", children: [firstSubItem, secondSubItem])
    }
    
    
    
    
    func setupBannerCollection() {
        view.addView(bannerCollectionView)
        
        NSLayoutConstraint.activate([
            bannerCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bannerCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bannerCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bannerCollectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    func setupCategoryCollection() {
        view.addView(navCollectionView)
        
        animatedConstraint = navCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: maxConstraintConstant)
        NSLayoutConstraint.activate([
           animatedConstraint!,
            navCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            navCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            navCollectionView.heightAnchor.constraint(equalToConstant: 52)
            
            
        ])
        
    }
    
    func setupTableView() {
        view.addView(customTableView)
        NSLayoutConstraint.activate([
            customTableView.topAnchor.constraint(equalTo: navCollectionView.bottomAnchor, constant: 10),
            customTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            customTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
}
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentContentOffsetY = scrollView.contentOffset.y
        let scrollDiff = currentContentOffsetY - previousContentOffsetY
        
        // Верхняя граница начала bounce эффекта
        let bounceBorderContentOffsetY = -scrollView.contentInset.top
        
        let contentMovesUp = scrollDiff > 0 && currentContentOffsetY > bounceBorderContentOffsetY
        let contentMovesDown = scrollDiff < 0 && currentContentOffsetY < bounceBorderContentOffsetY
        
        let currentConstraintConstant = animatedConstraint!.constant
        var newConstraintConstant = currentConstraintConstant
        
        if contentMovesUp {
            // Уменьшаем константу констрэйнта
            newConstraintConstant = max(currentConstraintConstant - scrollDiff, minConstraintConstant)
            
            
        } else if contentMovesDown {
            // Увеличиваем константу констрэйнта
            newConstraintConstant = min(currentConstraintConstant - scrollDiff, maxConstraintConstant)
        }
        
        // Меняем высоту и запрещаем скролл, только в случае изменения константы
        if newConstraintConstant != currentConstraintConstant {
            animatedConstraint?.constant = newConstraintConstant
            scrollView.contentOffset.y = previousContentOffsetY
        }
        // Процент завершения анимации
        animationCompletionPercent = (maxConstraintConstant - currentConstraintConstant) / (maxConstraintConstant - minConstraintConstant)
        
        customTableView.layer.cornerRadius = 10 * (1 - animationCompletionPercent)
        bannerCollectionView.layer.opacity = Float(1 - animationCompletionPercent)
        previousContentOffsetY = scrollView.contentOffset.y
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryDishesDict.keys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryDishesDict[keysArray[section]]?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PizzaTableViewCell.identifier, for: indexPath) as! PizzaTableViewCell
        cell.setup(dish: categoryDishesDict[keysArray[indexPath.section]]![indexPath.row])
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        10
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 10))
            
            return headerView
        }
  
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        presenter?.showCategory(with: section)
    }
    
}

// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol {
    func setupCategories(categories: [String]) {
        navCollectionView.presenter = presenter
        presenter?.collectionView = navCollectionView
        navCollectionView.reloadData(categories: categories)
        self.keysArray = categories
    }
    func setupTableViewData(with food: [String: [Dish]]) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.categoryDishesDict = food
            self.customTableView.reloadData()
        }
    }
    func moveToSection(with number: Int) {
        let indexPath = IndexPath(row: 0, section: number)
        customTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    
}
