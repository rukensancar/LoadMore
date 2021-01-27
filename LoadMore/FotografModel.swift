//
//  FotografModel.swift
//  LoadMore
//
//  Created by Ruken Sancar on 25.01.2021.
//

import Foundation

class FotografModel: Codable {
    
    var fotografId: Int = 0
    var fotografUrl: String = ""
        
    func toJSON() -> [String: Any] {
        return [
            "fotografId": fotografId as Any,
            "fotografUrl": fotografUrl as Any
        ]
    }
}
