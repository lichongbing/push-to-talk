//
//  BankDao.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import Foundation
import Alamofire
import SwiftyJSON
class BankDao: ObservableObject{
    @Published var moneys : [Bank] = []
    let baseurl = Config.pro
    func addMony(newItem:Bank){
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        AF.request("\(baseurl)/bank/create",
                   method: .post,
                   parameters: newItem, encoder: JSONParameterEncoder.default, headers: headers).response
        { response in
            debugPrint(response)
        }
    }
    func getItems() {
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        AF.request("\(baseurl)/bank/findByUid",
                   method: .post,
                   headers: headers).validate().responseJSON
        { response in
            switch response.result {
            case .success(let value):
                var itemss: [Bank] = []
                let Json =  JSON(value);
                let data  = Json["data"].arrayValue
                let code = Json["code"].int
                              if(code==200){
                JSON(data).forEach { (JSON, json) in
                    let id  =  json["id"].stringValue
                    let name  =  json["name"].stringValue
                    let card  =  json["card"].stringValue
                    let date0  =  json["date0"].stringValue
                    let date1  =  json["date1"].stringValue
                    let type  =  json["type"].intValue
                    let balance = json["balance"].stringValue
                    let duted = json["duted"].stringValue
                    let bk = Bank(id: id, name: name, card: card, date0: date0, date1: date1,type: type,balance: balance,duted: duted)
                    itemss.append(bk)
                }
                self.moneys = itemss
                }else{
                  let login = false
                  UserDefaults.standard.set(login,forKey: "loginA")
                 }
            case .failure(let error):
                print(error)
            }
        }
       
    }
    func deleteItem(indexSet: IndexSet) {
        let item = indexSet[indexSet.startIndex]
        let id =  moneys[item].id
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        AF.request("\(baseurl)/bank/delete/"+id,
                   method: .post,
                   headers: headers).response
        { response in
            debugPrint(response)
        }
       
    }
    func updateItem(item: Bank) {
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        AF.request("\(baseurl)/bank/update",
                   method: .post,
                   parameters: item, encoder: JSONParameterEncoder.default, headers: headers).response
        { response in
            debugPrint(response)
           
        }
        getItems()
    }
    
}
