//
//  PizzaTableViewCell.swift
//  Hammer-Test
//
//  Created by Александр Горелкин on 12.01.2024.
//

import UIKit


final class PizzaTableViewCell: UITableViewCell {
    static var identifier = String(describing: PizzaTableViewCell.self)
    
    
    private lazy var pizzaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pizza")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.heightAnchor.constraint(equalToConstant: 132).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 132).isActive = true
        return imageView
    }()
    
    
    private let pizzaNameLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "Ветчина и грибы"
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 3
        label.textAlignment = .left
        label.textColor = UIColor(hexString: "#AAAAAD")
        label.text = "Ветчина,шампиньоны, увеличинная порция моцареллы, томатный соус"
        return label
    }()
    
    private let priceButton = {
        var conf = UIButton.Configuration.filled()
        conf.baseBackgroundColor = .white
        conf.baseForegroundColor = .systemPink
        
        let button = UIButton(configuration: conf)
        button.setTitle("от 345 р", for: .normal)
        button.layer.borderColor = UIColor.systemPink.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    func setup(dish: Dish) {
        pizzaImageView.setImage(url: dish.image.asUrl!, placeholder: UIImage(named: "pizza"))
        pizzaNameLabel.text = dish.name
        descriptionLabel.text = dish.description
        priceButton.setTitle("от \(dish.calories) р", for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addView(pizzaImageView)
        addView(pizzaNameLabel)
        addView(descriptionLabel)
        addView(priceButton)
        
        NSLayoutConstraint.activate([
            pizzaImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            pizzaImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            pizzaNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            pizzaNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            pizzaNameLabel.leftAnchor.constraint(equalTo: pizzaImageView.rightAnchor, constant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: pizzaNameLabel.bottomAnchor, constant: 5),
            descriptionLabel.leftAnchor.constraint(equalTo: pizzaImageView.rightAnchor, constant: 24),
            descriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            priceButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            priceButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            priceButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
            
            
        ])
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
