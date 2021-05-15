//
//  DogModel.swift
//  DogApiUdacity
//
//  Created by bevan christian on 14/05/21.
//

import Foundation

struct DogModel:Codable {
    var message:String
    var status:String
}

struct DogListModel:Codable {
    var message:[String:[String]]
    var status:String
}
