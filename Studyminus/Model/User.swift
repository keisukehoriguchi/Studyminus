//
//  User.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/20.
//

import Foundation

struct User {
    var email: String
    var id: String
    var username: String
    var profileImg: String
    var selfIntro: String
    
    init(email:String = "",
         id:String = "",
         username:String = "",
         profileImg:String = "",
         selfIntro: String = ""){
        self.email = email
        self.id = id
        self.username = username
        self.profileImg = profileImg
        self.selfIntro = selfIntro
    }
    
    init(data: [String:Any]) {
        email = data["email"] as? String ?? ""
        id = data["id"] as? String ?? ""
        username = data["username"] as? String ?? ""
        profileImg = data["profileImg"] as? String ?? ""
        selfIntro = data["selfIntro"] as? String ?? ""
    }
    
    static func modelToData(user: User) -> [String: Any] {
        let data: [String: Any] = [
            "email" : user.email,
            "id" : user.id,
            "username" : user.username,
            "profileImg" : user.profileImg,
            "selfIntro" : user.selfIntro
        ]
        return data
    }
}
