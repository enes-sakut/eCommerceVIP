//
//  Encodable+Extensions.swift
//  eCommerceVIP
//
//  Created by enes.sakut on 19.04.2023.
//

import Foundation

public extension Encodable {
    
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
    
}

public extension Dictionary {
    
    func decodable<T: Decodable>() -> T? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        return nil
    }
    
}
