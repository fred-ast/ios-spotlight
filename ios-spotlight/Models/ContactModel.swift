//
//  ContactModel.swift
//  ios-spotlight
//
//  Created by Frédéric ASTIC on 02/08/2021.
//

import Foundation
import UIKit

struct ContactModel: Codable {
    let firstName: String
    let lastName: String
    let fullAddress: String?
    let email: String?
    let photoURL: String?
    let photoData: Data?
}

extension ContactModel: IndexableItem {
    var title: String { return "\(firstName) \(lastName)" }
    var identifier: String { return email ?? ""}
    var domain: IndexableDomain { return .contact }
    var expireAt: Date? { return Date.tomorrow }
    var description: String? {
        var content = [String]()
        if let email = email {
            content.append("E-mail : \(email)") 
        }
        if let addressContent = fullAddress {
            content.append("Adresse : \(addressContent)")
        }
        return content.joined(separator: "\n")
    }
    
    var actionIdentifier: String? { return nil}
    var imageURL: URL? {
        guard let url = photoURL else { return nil }
        return URL(string: url)
    }
    var imageData: Data? { return photoData }
    var keywords: [String]? { return ["Contact", "Copain", "Ami" , firstName, lastName]}
}
