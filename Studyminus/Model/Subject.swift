//
//  Subject.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/29.
//

import Foundation

struct Subject {
    var name: String
    var detail: String
    var subjectImg: String
    var userid: String
    
    init(name:String = "",
         detail:String = "",
         subjectImg:String = "",
         userid:String = ""){
        self.name = name
        self.detail = detail
        self.subjectImg = subjectImg
        self.userid = userid
    }

    init(data: [String:Any]) {
        name = data["name"] as? String ?? ""
        detail = data["detail"] as? String ?? ""
        subjectImg = data["subjectImg"] as? String ?? ""
        userid = data["userid"] as? String ?? ""
    }

    static func modelToData(subject: Subject) -> [String: Any] {
        let data: [String: Any] = [
            "name" : subject.name,
            "detail" : subject.detail,
            "subjectImg" : subject.subjectImg,
            "userid" : subject.userid,
        ]
        return data
    }
}
