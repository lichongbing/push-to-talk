//
//  Acount.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import Foundation
struct Acount: Identifiable,Encodable,Decodable,Hashable{
    var id: String
    let bank: String
    let idcard: String
    let date0: String
    let date1: String
    let money: String
    let money1: String
    let money2: String
    let money3: String
    let pay: String
    let pay1: String
    let mouth: String
    let year: String
    let bankid: String
}
