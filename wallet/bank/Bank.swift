//
//  Bank.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import Foundation
struct Bank: Identifiable,Encodable,Decodable,Hashable{
    var id: String
    let name: String
    let card: String
    let date0: String
    let date1: String
    let type: Int
    let balance: String
    let duted:String
}
