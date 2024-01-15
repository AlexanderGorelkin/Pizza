//
//  UIView+Extensions.swift
//  Hammer-Test
//
//  Created by Александр Горелкин on 12.01.2024.
//

import UIKit
fileprivate var ActivityIndicatorViewAssociativeKey = "ActivityIndicatorViewAssociativeKey"

    
    
extension UIView {
    
   
    func addView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}

