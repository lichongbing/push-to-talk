//
//  MouthReportView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/10.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import SwiftUICharts
struct MouthReportView: View {
    @EnvironmentObject var mouthReportDao: MouthReportDao
    let limit = DataPoint(value: 500, label: "5", legend: Legend(color: .yellow, label: "持平", order: 4))
    var body: some View {
        VStack{
            Text("本月报告").bold()
            HStack{
                Text("收入").bold()
                Spacer()
                Text(mouthReportDao.report.money0).bold()
                Spacer()
            }
     
            HStack{
                Text("支出").bold()
                Spacer()
                Text(mouthReportDao.report.money1).bold()
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
                Text("可用现金").bold()
                Spacer()
                Text(mouthReportDao.report.balance).bold()
                Spacer()
            }
            HStack{
                Text("可用额度").bold()
                Spacer()
                Text(mouthReportDao.report.duting).bold()
                Spacer()
            }
            HStack{
                Text("总欠款").bold()
                Spacer()
                Text(mouthReportDao.report.duted).bold()
                Spacer()
            }
            Text("本月每天支出统计").bold()
           BarChartView(dataPoints: mouthReportDao.days, limit: limit)
            //LineChartView(dataPoints: mouthReportDao.days)
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
