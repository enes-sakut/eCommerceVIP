//
//  BasketCountNotificationHandler.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 19.04.2023.
//

import Foundation

class BasketCountNotificationHandler {
    
    var handleUpdates: (() -> Void)?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateBasketCount(_:)), name: NSNotification.Name.basketCountNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func updateBasketCount(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let productCountInfo: BasketCountNotificationInfo = userInfo.decodable() else {
            return
        }
        
        Session.shared.basketCountNotification = productCountInfo.productCount
        handleUpdates?()
    }
    
    static func updateBasketCount(productCount: Int?) {
        let info = BasketCountNotificationInfo(productCount: productCount)
        NotificationCenter.default.post(name: NSNotification.Name.basketCountNotification, object: nil, userInfo: info.dictionary)
    }
}

extension Notification.Name {
    static let basketCountNotification = Notification.Name.init("basketCountNotification")
}

struct BasketCountNotificationInfo: Codable {
    var productCount: Int?
}
