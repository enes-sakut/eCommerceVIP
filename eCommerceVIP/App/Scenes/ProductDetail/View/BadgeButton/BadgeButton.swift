//
//  BadgeButton.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 19.04.2023.
//

import UIKit

public class BadgeButton: UIButton {
    
    private let badgeView = BadgeView()
    
    public init(image: UIImage) {
        super.init(frame: .zero)
        initialize()
        setImage(image, for: .normal)
    }

    override private init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        widthAnchor.constraint(equalToConstant: 30).isActive = true
        heightAnchor.constraint(equalToConstant: 30).isActive = true
        setBadgeView()
    }
    
    private func setBadgeView() {
        addSubview(badgeView)
        badgeView.translatesAutoresizingMaskIntoConstraints = false
        badgeView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        badgeView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        badgeView.isHidden = true
    }
    
    public func setBadgeCount(count: Int?) {
        if let count = count {
            badgeView.isHidden = count <= 0
            badgeView.badge = count
        } else {
            badgeView.isHidden = true
        }
    }
    
    public func getBadgeCount() -> Int? {
        badgeView.badge
    }
    
    public func shouldDisplayBadgeWithoutCount(value: Bool) {
        badgeView.isHidden = !value
    }

}
