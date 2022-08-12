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
class MouthReportDao:ObservableObject {
    @Published var report = MouthReport(id: "String", money1: "", money0: "", pay1: "", pay2: "", duting: "", duted: "")
    func getMonth(date:Date) -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let month =  (dateFormatter.string(from: date) as NSString).integerValue
        return month
    }
    init(){
        getMouthReport()
    }
    func getMouthReport(){
        let baseurl = Config.pro
        let token = UserDefaults(suiteName:"group.com.lichongbing.lyoggl")?.object(forKey: "token")
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
                let report = JSON(data)
                let id = "lichongbing"
                let money1 = report["money1"].stringValue
                let money0 = report["money0"].stringValue
                let pay1 = report["pay1"].stringValue
                let pay2 = report["pay2"].stringValue
                let duted = report["duted"].stringValue
                let duting = report["duting"].stringValue
                let repor = MouthReport(id: id, money1: money1, money0: money0, pay1: pay1, pay2: pay2, duting: duting, duted: duted)
                self.report = repor
            case .failure(let error):
                print(error)
            }
        }
    }
}

