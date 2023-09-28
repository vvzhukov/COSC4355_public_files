//
//  DataModel.swift
//  exc5
//
//  Created by Vitalii Zhukov on 9/28/23.
//

import Foundation


// user model
struct Language: Codable {
    var id: Int
    var name: String
    var designed_by: String
    var logo: URL
    var first_appeared: Int
    var website: String
    var about: String
}
