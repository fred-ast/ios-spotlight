//
//  ViewController.swift
//  ios-spotlight
//
//  Created by Frédéric ASTIC on 02/08/2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let indexer: SpotLightManagerProtocol = SpotLightManager()
    override var canResignFirstResponder: Bool {
        return true
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        guard motion == .motionShake else {
            return
        }
        indexer.clear(completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //Indexation des éléments statiques pour créer des raccourcis 
        //vers des actions dans votre app  
        let createContactShortcut = ContactModel(firstName: "Créer un nouveau contact", 
                                                 lastName: "", 
                                                 fullAddress: "", 
                                                 email: "new", 
                                                 photoURL: nil, 
                                                 photoData: nil)
        
        let createEventShortcut = EventModel(identifier: "new", 
                                             title: "Créer un nouvel évènement", 
                                             description: nil, 
                                             place: nil, 
                                             startOn: Date(), 
                                             endOn: Date.tomorrow)
        
        indexElements(items: [createContactShortcut, createEventShortcut])
        
        // chargements des données depuis le serveur
        loadContacts()
        loadEvents()
    }
    
    private func loadContacts() {
        ContactProvider.fetch { [weak self] values in
            guard let contacts = values else {
                return
            }
            self?.indexElements(items: contacts)
        }
    }
    
    private func loadEvents() {
        EventProvider.fetch { [weak self] values in
            guard let events = values else {
                return
            }
            self?.indexElements(items: events)
        }
    }
    
    private func indexElements(items: [IndexableItem]) {
        indexer.indexItems(elements: items) { err in
            guard let error = err else {
                //indexation réussie
                return
            }
            // gestion d'erreur
        }
    }
}
