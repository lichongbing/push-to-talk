//
//  MouthReport.swift
//  wallet
//
//  Created by lichongbing on 2022/8/10.
//

import Foundation
struct MouthReport: Identifiable, Encodable ,Decodable,Hashable{
    var id: String
    let money1: String
    let money0: String
    let pay1: String
    let pay2: String
    let duting:String
    let duted:String
}
