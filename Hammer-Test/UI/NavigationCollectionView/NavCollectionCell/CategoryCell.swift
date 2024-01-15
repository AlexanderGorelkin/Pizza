//
//  NavCollectionCell.swift
//  Hammer-Test
//
//  Created by Александр Горелкин on 13.01.2024.
//

import UIKit
final class CategoryCell: UICollectionViewCell {
    static let identifier = String(describing: CategoryCell.self)
    
    
    
    private var headerLabel = {
        let lbl = UILabel()
        lbl.font = .systemFont(ofSize: 13, weight: .regular)
        lbl.textAlignment = .center
        lbl.text = "Пицца"
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor(hexString: "#FD3A69").withAlphaComponent(0.4).cgColor
        layer.cornerRadius = 15.5
        addView(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            headerLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            headerLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            headerLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7)
        ])
    }
    func setup(categoryName: String) {
        headerLabel.text = categoryName
    }
    func getTextForLabel() -> String {
        return headerLabel.text ?? ""
    }
    
    func setupForDefault() {
        backgroundColor = .white
        layer.borderColor = UIColor(hexString: "#FD3A69").withAlphaComponent(0.4).cgColor
        headerLabel.textColor = UIColor(hexString: "#FD3A69").withAlphaComponent(0.4)
    }
    func setupForChoosen() {
        headerLabel.textColor = UIColor(hexString: "#FD3A69")
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = UIColor(hexString: "#FD3A69").withAlphaComponent(0.4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

