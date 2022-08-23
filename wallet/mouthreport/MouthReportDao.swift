//
//  MouthReportDao.swift
//  wallet
//
//  Created by lichongbing on 2022/8/10.
//

import Foundation
import Alamofire
import SwiftyJSON
import SwiftUI
import SwiftUICharts
class MouthReportDao:ObservableObject {
    @Published var report = MouthReport(id: "String", money1: "", money0: "", pay1: "", pay2: "", duting: "", duted: "",balance: "")
    @Published var days = [DataPoint(value: 130, label: "5", legend: Legend(color: .yellow, label: "持平", order: 4))]
    let baseurl = Config.pro
    func getMonth(date:Date) -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let month =  (dateFormatter.string(from: date) as NSString).integerValue
        return month
    }
    init(){
        getMouthReport()
        getMouthDays()
    }
    func getMouthReport(){
        let token = UserDefaults(suiteName:"group.com.lichongbing.lyoggl")?.object(forKey: "tokenA")
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token as! String
        ]
        let mouth = self.getMonth(date: Date())
        AF.request("\(baseurl)/report/\(mouth)",
                   method: .post,
                   headers: headers).validate().responseJSON
        { res in
            switch res.result{
            case .success(let value):
                let json = JSON(value)
                let data  = json["data"]
                let code = json["code"].int
                if(code==200){
                    let report = JSON(data)
                    let id = "lichongbing"
                    let money1 = report["money1"].stringValue
                    let money0 = report["money0"].stringValue
                    let pay1 = report["pay1"].stringValue
                    let pay2 = report["pay2"].stringValue
                    let duted = report["duted"].stringValue
                    let duting = report["duting"].stringValue
                    let balance = report["balance"].stringValue
                    let repor = MouthReport(id: id, money1: money1, money0: money0, pay1: pay1, pay2: pay2, duting: duting, duted: duted,balance: balance)
                    self.report = repor
                }else{
                    let login = false
                    UserDefaults.standard.set(login,forKey: "loginA")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func getMouthDays(){
        let token = UserDefaults(suiteName:"group.com.lichongbing.lyoggl")?.object(forKey: "tokenA")
        let headers: HTTPHeaders = [
            "Content-Type": "application/json;charset=UTF-8",
            "token": token as! String
        ]
        let mouth = self.getMonth(date: Date())
        AF.request("\(baseurl)/report/day/\(mouth)",
                   method: .post,
                   headers: headers).validate().responseJSON
        { res in
            switch res.result{
            case .success(let value):
                let json = JSON(value)
                let code = json["code"].int
                if(code==200){
                    guard let data  = json["data"].arrayValue else {
                        return
                    }
                    for index in 0 ..< data.count{
                        
                      let item = JSON(data[index])
                        let value = item["\(index+1)"].doubleValue
                        if(value > 500.00){
                            let point =  DataPoint(value: value, label: "\(index+1)", legend: Legend(color: .red, label: "超高", order: 1))
                            self.days.append(point)
                        }else if(value > 90 && value < 1000){
                            let point =  DataPoint(value: value, label: "\(index+1)", legend: Legend(color: .yellow, label: "较高", order: 2))
                            self.days.append(point)
                        }else  if(value > 50 && value < 90){
                            let point =  DataPoint(value: value, label: "\(index+1)", legend: Legend(color: .blue, label: "偏高", order: 3))
                            self.days.append(point)
                        }else{
                            let point =  DataPoint(value: value, label: "\(index+1)", legend: Legend(color: .blue, label: "正常", order: 4))
                            self.days.append(point)
                        }

                    }
  
                }else{
                    let login = false
                    UserDefaults.standard.set(login,forKey: "loginA")
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

