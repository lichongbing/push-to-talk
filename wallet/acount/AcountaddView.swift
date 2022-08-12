//
//  AcountaddView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import SwiftUI

struct AcountaddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var item: AcountDao
    @EnvironmentObject var bankDao: BankDao
    @Binding var isPresented: Bool
    @Binding var textFieldText: String
    @Binding var textFieldText1: String
    @Binding var textFieldText2: String
    @Binding var textFieldText3: String
    @Binding var textFieldText4: String
    @Binding var textFieldText5: String
    @State var selection = 1 //默认选择
    var body: some View {
        NavigationView{
            VStack {
                HStack{
                    Text("卡片选择")
                    Spacer()
                    pickerView.frame(width: 30,height: 150)
                    Spacer()
                }
                HStack{
                    TextField("账单金额", text: $textFieldText)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                    TextField("最低还款", text: $textFieldText1)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                }
                HStack{
                    TextField("剩余额度", text: $textFieldText2)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                    TextField("利息费用", text:$textFieldText3 )
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                }
                HStack{
                    TextField("手续费", text:$textFieldText4 )
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                    TextField("刷卡费", text:$textFieldText5 )
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                }
                Spacer()
              
            }
            .navigationBarTitle("新增账单",displayMode: .inline)
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
            item.addMony(newItem: Acount(id: "id", bank: "name", idcard: "card", date0: "date0", date1: "date1", money: textFieldText, money1: textFieldText1, money2: textFieldText2, money3: textFieldText3, pay: textFieldText4, pay1: textFieldText5, mouth: "mouth", year: "year",bankid: bankDao.moneys[selection].id))
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("提交")
        }

    }
    var pickerView: some View{
        VStack{
            Picker(selection: $selection, label: Text("选择卡片")) {
                ForEach(bankDao.moneys.indices, id: \.self){ i in
                                Text(bankDao.moneys[i].name)
                            }
            }
        }.onAppear(perform: {
            bankDao.getItems()
        })
        .pickerStyle(.inline)
      
    }
  
}

//struct AcountaddView_Previews: PreviewProvider {
//    static var previews: some View {
//        AcountaddView()
//    }
//}
