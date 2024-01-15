//
//  MenuLabelView.swift
//  Hammer-Test
//
//  Created by Александр Горелкин on 13.01.2024.
//

import UIKit

final class MenuLabelView: UIView {
    
    
    private lazy var cityNameLabel = {
       let label = UILabel()
        label.text = "Москва"
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        addView(cityNameLabel)
        NSLayoutConstraint.activate([
        
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor),
            cityNameLabel.leftAnchor.constraint(equalTo: leftAnchor),
            cityNameLabel.rightAnchor.constraint(equalTo: rightAnchor),
            cityNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
