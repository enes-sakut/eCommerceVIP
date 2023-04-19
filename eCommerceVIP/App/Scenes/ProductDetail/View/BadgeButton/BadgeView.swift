//
//  BadgeView.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 19.04.2023.
//

import Foundation
import UIKit

public class BadgeView: UIView {
        
    let badgeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 14, height: 14))
    
    public var badge: Int? {
        didSet {
            if let badge = badge {
                badgeLabel.text = "\(badge)"
            } else {
                badgeLabel.text = ""
            }
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
        
    public convenience init (badge: Int, frame: CGRect) {
        defer { self.badge = badge }
        self.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        self.layer.cornerRadius = 6
        self.backgroundColor = .white
        self.addBadgeLabel()
    }
    
    private func addBadgeLabel() {
        badgeLabel.textAlignment = .center
        badgeLabel.font = .latoSemiBold10
        badgeLabel.textColor = .red
        self.addSubview(badgeLabel)
        heightAnchor.constraint(equalToConstant: 14).isActive = true
        widthAnchor.constraint(equalTo: badgeLabel.widthAnchor).isActive = true
    }
}

