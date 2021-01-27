//
//  KesfetModel.swift
//  LoadMore
//
//  Created by Ruken Sancar on 25.01.2021.
//

import Foundation

class KesfetModel: Codable {
    
    var aciklama: String = ""
    var fotoList: [FotografModel] = []
        
    func toJSON() -> [String: Any] {
        return [
            "aciklama": aciklama as Any,
            "fotoList": fotoList as Any
        ]
    }
}
