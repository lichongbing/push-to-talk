//
//  PickerView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import SwiftUI

struct PickerView: View {
    @EnvironmentObject var bankDao: BankDao
    @State var selection = 1 //默认选择
    var body: some View {
        VStack{
            Picker(selection: $selection, label: Text("选择信用卡")) {
                ForEach(bankDao.moneys, id: \.self){ item in
                    Text(item.name)
                        .font(.system(size: 18))
                }
            }
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}
