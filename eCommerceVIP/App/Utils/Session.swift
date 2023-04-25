//
//  Session.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 19.04.2023.
//
import Foundation

class Session {
    
    static let shared = Session()
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

