//
//  String+Extensions.swift
//  Hammer-Test
//
//  Created by Александр Горелкин on 14.01.2024.
//

import Foundation
extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
extension Dictionary {
    
    func toArray() -> [String] {
        var array: [String] = []
        for values in self.values {
            array.append(values as! String)
        }
        return array.sorted()
    }
    
}
