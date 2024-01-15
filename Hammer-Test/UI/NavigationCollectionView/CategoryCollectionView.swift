//
//  NavCollectionView.swift
//  Hammer-Test
//
//  Created by Александр Горелкин on 12.01.2024.
//

import UIKit

final class CategoryCollectionView: UIView {
    weak var presenter: MainPresenterProtocol?
    private var categoryArray: [String] = []
    private var choosen: Int = 0
    private var choosenCell: CategoryCell = CategoryCell()
    
    private let activityIndicator = {
       let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private var collectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.sectionInset = .init(top: 0, left: 10, bottom: 0, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        
        setup()
        setupActivityIndicator()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setup()
        setupActivityIndicator()
    }
    func reloadData(categories: [String]) {
        activityIndicator.stopAnimating()
        self.categoryArray = categories
        collectionView.reloadData()
    }
    
    func setupActivityIndicator() {
        addView(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    func setup() {
        
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        addView(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension CategoryCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        cell.setup(categoryName: categoryArray[indexPath.row])
        cell.setupForDefault()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        choosenCell.setupForDefault()
        choosenCell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        choosenCell.setupForChoosen()
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        presenter?.didSelectItemAt(section: indexPath.row)
        
//        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
//        if choosen != indexPath.row {
//            let lastCell = collectionView.cellForItem(at: IndexPath(row: choosen, section: 0)) as! CategoryCell
//            lastCell.setupForDefault()
//            cell.setupForChoosen()
//            presenter?.didSelectItemAt(section: indexPath.row)
//            choosen = indexPath.row
//            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//        }
    }
    
   

    
}
extension CategoryCollectionView {
    
    func changeCategory(number: Int) {
        let indexPath = IndexPath(row: number, section: 0)
        let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        if choosenCell != cell {
            print(number)
            choosenCell.setupForDefault()
            choosenCell = cell
            choosenCell.setupForChoosen()
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
//        choosenCell = collectionView.cellForItem(at: indexPath) as! CategoryCell
        
        
        
        
//        if let number = number {
//            if number == choosen {
//                let indexPath = IndexPath(row: number, section: 0)
//                let cell = collectionView.cellForItem(at: indexPath) as! CategoryCell
//                cell.setupForChoosen()
//                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//            } else  {
//                let currenctChoosenCell = collectionView.cellForItem(at: IndexPath(row: choosen, section: 0)) as! CategoryCell
//                currenctChoosenCell.setupForDefault()
//                print("Choosen", choosen, "Number", number)
//                let newCell = collectionView.cellForItem(at: IndexPath(row: number, section: 0)) as! CategoryCell
//                newCell.setupForChoosen()
//                choosen = number
//                collectionView.scrollToItem(at: IndexPath(row: choosen, section: 0), at: .centeredHorizontally, animated: true)
//               
//            }
//        }
    }
}
