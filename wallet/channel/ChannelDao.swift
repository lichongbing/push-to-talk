//
//  ChannelDao.swift
//  ppts
//
//  Created by lichongbing on 2022/12/2.
//

import Foundation
import Alamofire
import SwiftyJSON
class ChannelDao: ObservableObject{
    @Published var moneys : [Channel] = []
    @Published var moneys1 : [JoinChannel] = []
    @Published var check : Bool = false
    let baseurl = Config.pro
    func addItem(newItem:Channel){
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        AF.request("\(baseurl)/channel/addupdate",
                   method: .post,
                   parameters: newItem, encoder: JSONParameterEncoder.default, headers: headers).response
        { response in
            debugPrint(response)
        }
    }
    //uuid    Foundation.UUID?    70DC486D-0100-0000-8C91-9702018004F8    <invalid> (0x70)
    func getItems() {
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8"
        ]
        AF.request("\(baseurl)/channel/getallChannel",
                   method: .post,
                   headers: headers).validate().responseJSON
        { response in
            switch response.result {
            case .success(let value):
                var itemss: [Channel] = []
                let Json =  JSON(value);
                let data  = Json["data"].arrayValue
                let code = Json["code"].int
                if(code==200){
                JSON(data).forEach { (JSON, json) in
                    let id  =  json["id"].stringValue
                    let uid  =  json["uid"].stringValue
                    let title  =  json["title"].stringValue
                    let des  =  json["des"].stringValue
                    let uuid = UUID.init(uuidString: id)
                    let bk = Channel(id: uuid!, uid: uid, title: title, des: des)
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
        let index = indexSet[indexSet.startIndex]
        let item =  moneys[index]
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        AF.request("\(baseurl)/channel/delete",
                   method: .post,
                   parameters: item, encoder: JSONParameterEncoder.default,
                   headers: headers).response
        { response in
            debugPrint(response)
        }
       
    }
    func updateItem(item: Channel) {
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        AF.request("\(baseurl)/channel/addupdate",
                   method: .post,
                   parameters: item, encoder: JSONParameterEncoder.default, headers: headers).response
        { response in
            debugPrint(response)
           
        }
        getItems()
    }
    func moveItem(from: IndexSet, to: Int) {
        moneys.move(fromOffsets: from, toOffset: to)
    }
    
    func getjoinchannel(channel:Channel){
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
        
        AF.request("\(baseurl)/channel/getJoinChannels",
                   method: .post,
                   parameters: channel, encoder: JSONParameterEncoder.default,
                   headers: headers).response
        { response in
            switch response.result {
            case .success(let value):
                var itemss: [JoinChannel] = []
                let Json =  JSON(value);
                let data  = Json["data"].arrayValue
                let code = Json["code"].int
                if(code==200){
                JSON(data).forEach { (JSON, json) in
                    let id  =  json["cid"].stringValue
                    let uid  =  json["uid"].stringValue
                    let join  =  json["joins"].stringValue
                    let cid = UUID.init(uuidString: id)
                    let bk = JoinChannel(id: uid, cid: cid!, join: join)
                    itemss.append(bk)
                }
                self.moneys1 = itemss
                }else{
                  let login = false
                  UserDefaults.standard.set(login,forKey: "loginA")
                 }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkJoinChannels(channel:UUID){
        
        let uid =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "uid") as! String
        let checkChannel =   Channel(id: channel, uid: uid, title: "String", des: "String")
 
        let token =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "tokenA") as! String
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token
        ]
       
        AF.request("\(baseurl)/channel/checkJoinChannels",
                   method: .post,
                   parameters: checkChannel, encoder: JSONParameterEncoder.default,
                   headers: headers).response
        { response in
            switch response.result {
            case .success(let value):
                let Json =  JSON(value);
                let data  = Json["data"].intValue
                if data == 1{
                    self.check = true
                }else{
                    self.check = false
                }
                
            case .failure(let error):
                print(error)
                self.check = false
            }
        }
  
    }
    
    
    
    
}
