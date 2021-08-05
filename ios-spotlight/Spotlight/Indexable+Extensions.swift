//
//  Indexable+Extensions.swift
//  ios-spotlight
//
//  Created by Frédéric ASTIC on 02/08/2021.
//

import Foundation
import CoreSpotlight
import CoreServices

struct Constants {
    struct App {
        static let bundleIdentifier = "org.fred-ast.ios.spotlight"
    }
    struct Spotlight {
        static let itemIdentifierKey: String = "kCSSearchableItemActivityIdentifier"
    }
}

enum IndexableDomain: String, CaseIterable {
    case contact
    case event
    case product
}

protocol IndexableItem {
    var title: String { get }
    var identifier: String { get }
    var domain: IndexableDomain { get }
    var expireAt: Date? { get }
    var description: String? { get }
    var actionIdentifier: String? { get }
    var imageURL: URL? { get }
    var imageData: Data? { get }
    var keywords: [String]? { get }
}

extension IndexableDomain {
    init?(activityIdentifier: String) {
        guard let foundItem = IndexableDomain.allCases.first(where: { activityIdentifier.starts(with: $0.value) == true }) else {
            return nil
        }
        self = foundItem
    }
    var value: String {
        return "\(Constants.App.bundleIdentifier).\(self.rawValue)"
    }
}

extension IndexableItem {
    private var spotlightAttributes: CSSearchableItemAttributeSet {
        return {
            let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeCompositeContent as String)
            attributeSet.title = title
            attributeSet.contentDescription = description
            attributeSet.keywords = keywords ?? title.components(separatedBy: " ").filter { $0.count > 2 }
            attributeSet.addedDate = Date()
            attributeSet.containerIdentifier = actionIdentifier
            attributeSet.thumbnailData = imageData
            attributeSet.contentURL = imageURL
            return attributeSet
        }()
    }
    
    var searchableItem: CSSearchableItem {
        return { 
            let item = CSSearchableItem(uniqueIdentifier: identifier, 
                                        domainIdentifier: domain.value, 
                                        attributeSet: spotlightAttributes)
            item.expirationDate = expireAt
            return item
        }()
    }
}
