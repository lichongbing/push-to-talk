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
    @Binding var textFieldText4: String
    @Binding var textFieldText5: String
    @State var select = 0 //默认选择
    struct BankType: Encodable {
                   let value: String
                   let label: String
    }
    let types = [BankType(value: "0", label: "信用卡"),BankType(value: "1", label: "储蓄卡"),BankType(value: "3", label: "网贷卡")]
    var body: some View {
        NavigationView{
            VStack {
                HStack{
                    Text("选择")
                    PickerBankTypeView.frame(width: 300,height: 55)
                }
                if(select==0 || select==2){
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
                    TextField("可以额度", text:$textFieldText4 )
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                    TextField("总欠金额", text:$textFieldText5 )
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                    Spacer()
                    
                }else{
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
                    TextField("可用现金", text:$textFieldText4 )
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                   
                    Spacer()
                }
                
               
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
            item.addMony(newItem: Bank(id: "String", name:  textFieldText, card: textFieldText1, date0: textFieldText2, date1: textFieldText3 ,type: select,balance: textFieldText4,duted: textFieldText5))
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("提交")
        }

    }
    var PickerBankTypeView:some View{
        HStack{
            VStack{
                Picker(selection: $select, label: Text("选择")) {
                    ForEach(types.indices, id: \.self){ i in
                                    Text(types[i].label)
                                }
                }
            }.pickerStyle(.segmented)
        }
    }
  
}


//struct BankaddView_Previews: PreviewProvider {
//    static var previews: some View {
//        BankaddView()
//    }
//}
