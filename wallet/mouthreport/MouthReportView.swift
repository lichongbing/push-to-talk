//
//  MouthReportView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/10.
//

import SwiftUI
import Alamofire
import SwiftyJSON
struct MouthReportView: View {
    @EnvironmentObject var mouthReportDao: MouthReportDao
    var body: some View {
        VStack{
            Text("本月报告").bold()
            Spacer()
            HStack{
                Text("收入").bold()
                Spacer()
                Text(mouthReportDao.report.money1).bold()
                Spacer()
            }
     
            HStack{
                Text("支出").bold()
                Spacer()
                Text(mouthReportDao.report.money0).bold()
                Spacer()
            }
          
            HStack{
                Text("最低还款").bold()
                Spacer()
                Text(mouthReportDao.report.pay1).bold()
                Spacer()
            }
       
            HStack{
                Text("产生费用").bold()
                Spacer()
                Text(mouthReportDao.report.pay2).bold()
                Spacer()
            }
      
            HStack{
                Text("可用额度").bold()
                Spacer()
                Text(mouthReportDao.report.duting).bold()
                Spacer()
            }
            Spacer()
        }.onAppear(perform: {
            mouthReportDao.getMouthReport()
        })
        
    }
}

struct MouthReportView_Previews: PreviewProvider {
    static var previews: some View {
        MouthReportView()
    }
}
