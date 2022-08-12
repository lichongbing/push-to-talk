//
//  BankaddView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import SwiftUI

struct BankaddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var item: BankDao
    @Binding var isPresented: Bool
    @Binding var textFieldText: String
    @Binding var textFieldText1: String
    @Binding var textFieldText2: String
    @Binding var textFieldText3: String
    var body: some View {
        NavigationView{
            VStack {
                TextField("银行名称", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                TextField("卡号", text:$textFieldText1 )
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                TextField("账单日", text:$textFieldText2 )
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                TextField("还款日", text:$textFieldText3 )
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                Spacer()
            }
            .navigationBarTitle("新增明细",displayMode: .inline)
            .navigationBarItems(leading:leading,trailing: trailing)
        }
    }
    var leading: some View{
        Button {
            isPresented.toggle()
        } label: {
               Text("取消")
        }

    }
    var trailing: some View{
        Button {
            item.addMony(newItem: Bank(id: "String", name:  textFieldText, card: textFieldText1, date0: textFieldText2, date1: textFieldText3 ))
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("提交")
        }

    }
  
}


//struct BankaddView_Previews: PreviewProvider {
//    static var previews: some View {
//        BankaddView()
//    }
//}
