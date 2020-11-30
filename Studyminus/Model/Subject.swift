//
//  Subject.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/29.
//

import Foundation
import Firebase

struct Subject {
    var name: String
    var detail: String
    var subjectImg: String
    var userid: String
    var id:String
    
    init(name:String = "",
         detail:String = "",
         subjectImg:String = "",
         userid:String = "",
         id:String = ""){
        self.name = name
        self.detail = detail
        self.subjectImg = subjectImg
        self.userid = userid
        self.id = id
    }

    init(data: [String:Any]) {
        name = data["name"] as? String ?? ""
        detail = data["detail"] as? String ?? ""
        subjectImg = data["subjectImg"] as? String ?? ""
        userid = data["userid"] as? String ?? ""
        id = data["id"] as? String ?? ""
    }
    
    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        let Dic = document.data()
        name = Dic["name"] as? String ?? ""
        detail = Dic["detail"] as? String ?? ""
        subjectImg = Dic["subjectImg"] as? String ?? ""
        userid = Dic["userid"] as? String ?? ""
    }

    static func modelToData(subject: Subject) -> [String: Any] {
        let data: [String: Any] = [
            "name" : subject.name,
            "detail" : subject.detail,
            "subjectImg" : subject.subjectImg,
            "userid" : subject.userid,
            "id" : subject.id
        ]
        return data
    }
}
