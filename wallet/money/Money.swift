//
//  Money.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import Foundation
struct Money: Identifiable,Encodable,Decodable,Hashable{
    var id: String
    let dateTime: String
    let money: String
    let type: String
    let ways: String
    let mouth: String
    let year: String
}
