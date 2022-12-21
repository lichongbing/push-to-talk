//
//  Channel.swift
//  ppts
//
//  Created by lichongbing on 2022/12/2.
//

import Foundation
struct Channel: Identifiable,Encodable,Decodable,Hashable{
    var id: UUID
    let uid: String
    let title: String
    let des: String
}

struct JoinChannel: Identifiable,Encodable,Decodable,Hashable{
    var id: String
    let cid: UUID
    let join: String
}

struct JoinChannelToken: Identifiable,Encodable,Decodable,Hashable{
    var id: UUID
    let deviceToken :String
}
