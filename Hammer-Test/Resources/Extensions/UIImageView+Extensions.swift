//
//  UIImageView+Extensions.swift
//  Hammer-Test
//
//  Created by Александр Горелкин on 14.01.2024.
//

import UIKit
extension UIImageView {
    
    func setImage(url: URL, placeholder: UIImage?) {
        self.image = placeholder
        
        Task { [weak self] in
            let (data, _) = try await URLSession.shared.data(from: url)
            self?.image = UIImage(data: data)
        }
    }
    func setImage(url: URL, completion: @escaping (Bool) -> Void) {
        Task { [weak self] in
            let (data, _) = try await URLSession.shared.data(from: url)
            self?.image = UIImage(data: data) ?? UIImage(named: "pizza")
            completion(true)
        }
    }
}
