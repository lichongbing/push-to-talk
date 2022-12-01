//
//  HomeView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/10.
//

import SwiftUI

struct HomeView: View {

    @StateObject var moneyDao: MoneyDao = MoneyDao()
    @StateObject var bankDao: BankDao = BankDao()
    @StateObject var acountDao: AcountDao = AcountDao()
    var index:Int
    var body: some View {
        if index==0{
            NavigationView {
                MoneyView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(moneyDao)
        }else if index==1{
            NavigationView {
                AcountView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(acountDao)
            .environmentObject(bankDao)
        }else if index==2{
            NavigationView {
                BankView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(bankDao)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(index: 1)
    }
}
