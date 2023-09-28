//
//  userModel.swift
//  exc5
//
//  Created by Vitalii Zhukov on 9/28/23.
//

import UIKit


struct Languagezz: Codable {

    init() {
        name = ""
        designed_by = ""
        logo = URL(string: "http://www.google.com")!
        first_appeared = 0
        website = ""
        about = ""
    }
    
    let name: String
    let designed_by: String
    let logo: URL
    let first_appeared: Int
    let website: String
    let about: String
}
