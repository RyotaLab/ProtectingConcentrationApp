//
//  OpenReason_Realm.swift
//  ProtectConcentration
//
//  Created by 渡邊涼太 on 2024/10/19.
//

import Foundation
import RealmSwift


class OpenReasonList: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var reason: String
    
    override class func primaryKey() -> String? {
        "id"
    }
}


