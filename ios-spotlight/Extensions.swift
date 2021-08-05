//
//  Extensions.swift
//  ios-spotlight
//
//  Created by Frédéric ASTIC on 04/08/2021.
//

import Foundation
extension Date {
    private func add(value: Int, component: Calendar.Component) -> Date {
        guard let value = Calendar.current.date(byAdding: component, value: value, to: self) else {
            return self
        }
        return value
    }
    
    static var tomorrow: Date {
        return Date().add(value: 1, component: .day)
        
    }
}
