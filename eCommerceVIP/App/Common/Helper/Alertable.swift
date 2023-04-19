//
//  Alertable.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 19.04.2023.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
    func showAlert(title: String? = nil,
                       message: String? = nil,
                       cancelButtonTitle: String? = nil,
                       handler: ((UIAlertAction) -> Void)? = nil ) {
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: handler)
            
            if let cancelButtonTitle {
                let cancelAction = UIAlertAction(title: cancelButtonTitle,
                                                 style: .cancel)
                alertController.addAction(cancelAction)
            }
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true)
        }
}

