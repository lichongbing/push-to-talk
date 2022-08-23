//
//  AcountDao.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import Foundation
import Alamofire
import SwiftyJSON
class AcountDao: ObservableObject{
    @Published var moneys : [Acount] = []
    let baseurl = Config.pro
    func addMony(newItem:Acount){
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        AF.request("\(baseurl)/account/create",
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
        AF.request("\(baseurl)/account/findByUid",
                   method: .post,
                   headers: headers).validate().responseJSON
        { response in
            switch response.result {
            case .success(let value):
                var itemss: [Acount] = []
                let Json =  JSON(value);
                let data  = Json["data"].arrayValue
                let code = Json["code"].int
                if(code==200){
                JSON(data).forEach { (JSON, json) in
                    let id  =  json["id"].stringValue
                    let name  =  json["bank"].stringValue
                    let card  =  json["idcard"].stringValue
                    let date0  =  json["date0"].stringValue
                    let date1  =  json["date1"].stringValue
                    let money  =  json["money"].stringValue
                    let money1  =  json["money1"].stringValue
                    let money2  =  json["money2"].stringValue
                    let money3  =  json["money3"].stringValue
                    let pay  =  json["pay"].stringValue
                    let pay1  =  json["pay1"].stringValue
                    let mouth  =  json["mouth"].stringValue
                    let year  =  json["year"].stringValue
                    let ac = Acount(id: id, bank: name, idcard: card, date0: date0, date1: date1, money: money, money1: money1, money2: money2, money3: money3, pay: pay, pay1: pay1, mouth: mouth, year: year,bankid:" ")
                    itemss.append(ac)
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
        AF.request("\(baseurl)/account/delete/"+id,
                   method: .post,
                   headers: headers).response
        { response in
            debugPrint(response)
        }
       
    }
    func updateItem(item: Acount) {
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        AF.request("\(baseurl)/account/update",
                   method: .post,
                   parameters: item, encoder: JSONParameterEncoder.default, headers: headers).response
        { response in
            debugPrint(response)
           
        }
        getItems()
    }
    
}
