//
//  User.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/20.
//

import Foundation

struct User: Codable {
    var email: String
    var id: String
    var username: String
    var profileImg: String
    var selfIntro: String
}
