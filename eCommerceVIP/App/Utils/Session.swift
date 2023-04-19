//
//  Session.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 19.04.2023.
//
import Foundation

class Session {
    
    static let shared = Session()
   
//    var currentUsersStorage: UserDefaults? {
//        get {
//            guard let currentUserId = currentUser?.info?.userId else { return nil }
//            return UserDefaults(suiteName: currentUserId)
//        }
//    }
//
//    private init() {
//        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateTokenNotification(_:)), name: NSNotification.Name(rawValue: "didUpdateRefreshToken"), object: nil)
//        currentUser = users?.first(where: { $0.active == true })
//    }
    
    var currentBasketCount: Int? {
        didSet {
            UserDefaults.standard.setValue(currentBasketCount, forKey: "currentBasketCount")
        }
    }

    var basketCountNotification: Int? {
        didSet {
            UserDefaults.standard.setValue(basketCountNotification, forKey: "basketCountNotification")
        }
    }
    
}

