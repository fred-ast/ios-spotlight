//
//  EventModel.swift
//  ios-spotlight
//
//  Created by Frédéric ASTIC on 02/08/2021.
//

import Foundation
import CoreLocation
import UIKit

struct EventModel: Codable {
    let identifier: String
    let title: String
    let description: String?
    let place: String?
    let startOn: Date
    let endOn: Date    
}

extension EventModel: IndexableItem {
    var domain: IndexableDomain { return .event }
    var expireAt: Date? { return endOn }
    var actionIdentifier: String? { return nil}
    var imageURL: URL? { return nil }
    var imageData: Data? { return UIImage(named: "event")?.pngData() }
    var keywords: [String]? { return ["Conférence", "Présentation", "meet-up", "Blog", title]}
}
