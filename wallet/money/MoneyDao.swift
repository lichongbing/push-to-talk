//
//  MoneyDao.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import Foundation
import Alamofire
import SwiftyJSON
class MoneyDao: ObservableObject{
    @Published var moneys : [Money] = []
    let baseurl = Config.pro
    func addMony(newItem:Money){
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        AF.request("\(baseurl)/money/create",
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
        AF.request("\(baseurl)/money/findByUid",
                   method: .post,
                   headers: headers).validate().responseJSON
        { response in
            switch response.result {
            case .success(let value):
                var itemss: [Money] = []
                let Json =  JSON(value);
                let data  = Json["data"].arrayValue
                let code = Json["code"].int
                              if(code==200){
                JSON(data).forEach { (JSON, json) in
                    let id  =  json["id"].stringValue
                    let dateTime  =  json["dateTime"].stringValue
                    let money  =  json["money"].stringValue
                    let type  =  json["type"].stringValue
                    let ways  =  json["ways"].stringValue
                    let mouth  =  json["mouth"].stringValue
                    let year  =  json["year"].stringValue
                    let mo = Money(id: id, dateTime: dateTime, money: money, type: type, ways: ways, mouth: mouth, year: year)
                    itemss.append(mo)
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
        AF.request("\(baseurl)/money/delete/"+id,
                   method: .post,
                   headers: headers).response
        { response in
            debugPrint(response)
        }
       
    }
    func updateItem(item: Money) {
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        AF.request("\(baseurl)/money/update",
                   method: .post,
                   parameters: item, encoder: JSONParameterEncoder.default, headers: headers).response
        { response in
            debugPrint(response)
           
        }
        getItems()
    }
    
}
