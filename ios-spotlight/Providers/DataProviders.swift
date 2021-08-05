//
//  DataProviders.swift
//  ios-spotlight
//
//  Created by Frédéric ASTIC on 03/08/2021.
//

import Foundation
import UIKit

class ContactProvider {
    class func fetch(completion: @escaping ([ContactModel]?) -> Void) {
        let contactImage = UIImage(named: "contact")?.pngData()
        let datas = [
            ContactModel(firstName: "Marc", lastName: "DUPONT", fullAddress: "1 rue de la liberté", email: "marc.dupont@provider.org", photoURL: nil, photoData: contactImage),
            ContactModel(firstName: "Suzy", lastName: "WHAN", fullAddress: "2 place du maréchal", email: "suzy@whan.net", photoURL: "http://photo.org/suzy-whan", photoData: contactImage),
            ContactModel(firstName: "Jean", lastName: "DULAC", fullAddress: "1 avenue des champs Elysés", email: "j.dulac@mail.net", photoURL: nil, photoData: contactImage)
        ]
        completion(datas)
    }
}
class EventProvider {
    class func fetch(completion: @escaping ([EventModel]?) -> Void)  {
        let datas = [
            EventModel(identifier: "wwdc-2021", title: "Apple WWDC", description: "Les dernières actus Apple", place: "Cuppertino", startOn: Date(timeIntervalSince1970: 1623099600), endOn: Date(timeIntervalSince1970: 1623434400)),
            EventModel(identifier: "frenkit-2020", title: "French Kit", description: "La conférence Apple Française de référence", place: "Paris", startOn: Date(timeIntervalSince1970: 1601629200), endOn: Date(timeIntervalSince1970: 1601661600)),
            EventModel(identifier: "https://medium.com/@frederic.astic", title: "Eye Of the Senior", description: "Blog tech iOS d'un developpeur senior", place: "World Wide Web", startOn: Date(), endOn: Date(timeIntervalSince1970: 4102444799))
        ]
        completion(datas)
    }
}
