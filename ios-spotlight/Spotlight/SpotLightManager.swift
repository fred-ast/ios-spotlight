//
//  SpotLightManager.swift
//  ios-spotlight
//
//  Created by Frédéric ASTIC on 02/08/2021.
//

import Foundation
import CoreSpotlight

typealias SpotLightCompletionCallback = (Error?) -> Void

struct IndexedActivityResult {
    let identifier: String
    let domain: IndexableDomain
    
    init?(userActivity: NSUserActivity) {
        guard userActivity.activityType == CSSearchableItemActionType,
              let activityIdentifier = userActivity.userInfo?[CSSearchableItemActivityIdentifier] as? String,
              let uniqueIdentifier = userActivity.userInfo?[Constants.Spotlight.itemIdentifierKey] as? String,
              let domainExist = IndexableDomain(activityIdentifier: activityIdentifier) else {
            return nil
        }
        
        self.domain = domainExist
        self.identifier = uniqueIdentifier
    } 
}

protocol SpotLightManagerProtocol: AnyObject {
    func indexItems(elements: [IndexableItem], completion: SpotLightCompletionCallback?) 
    func deIndexItems(domains: [IndexableDomain], completion: SpotLightCompletionCallback?)
    func clear(completion: SpotLightCompletionCallback?)
}

class SpotLightManager: SpotLightManagerProtocol {
    
    private let defaultEngine = CSSearchableIndex.default()
    
    func indexItems(elements: [IndexableItem], completion: SpotLightCompletionCallback?) {
        let toIndex = elements.map { $0.searchableItem }
        defaultEngine.indexSearchableItems(toIndex) { err in
            completion?(err)
        }
    }
    
    func deIndexItems(domains: [IndexableDomain], completion: SpotLightCompletionCallback?) {
        let toDeIndex = domains.map { $0.value }
        defaultEngine.deleteSearchableItems(withDomainIdentifiers: toDeIndex) { err in
            completion?(err)
        }
    }

    func clear(completion: SpotLightCompletionCallback?) {
        defaultEngine.deleteAllSearchableItems { err in
            completion?(err)
        }
    }
}
