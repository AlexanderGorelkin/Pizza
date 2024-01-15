//
//  BannerCollectionCelll.swift
//  Hammer-Test
//
//  Created by Александр Горелкин on 13.01.2024.
//

import UIKit
final class BannerCollectionCell: UICollectionViewCell {
    static let identifier = String(describing: BannerCollectionCell.self)
    
    
    private lazy var bannerImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "banner")
        imageView.contentMode = .center
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        layer.cornerRadius = 10
        addView(bannerImageView)
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: topAnchor),
            bannerImageView.leftAnchor.constraint(equalTo: leftAnchor),
            bannerImageView.rightAnchor.constraint(equalTo: rightAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
