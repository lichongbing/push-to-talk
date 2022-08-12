//
//  MoneyaddView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import SwiftUI

struct MoneyaddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var item: MoneyDao
    @Binding var isPresented: Bool
    @Binding var textFieldText: String
    @Binding var textFieldText1: String
    @State var select = 0 //默认选择
    struct MoneyType: Encodable {
                   let value: String
                   let label: String
               }
    let types = [MoneyType(value: "0", label: "支出"),MoneyType(value: "1", label: "收入")]
    var body: some View {
        NavigationView{
            VStack {
                HStack{
                    Text("选择")
                    picker.frame(width: 100,height: 55)
                }
                TextField("在这里填写金额,小数点2位", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                TextField("在这里填写用途", text:$textFieldText1 )
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
            item.addMony(newItem: Money(id: "String", dateTime: " ", money: textFieldText, type: types[select].value, ways: textFieldText1, mouth: " " , year: " "))
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("提交")
        }

    }
    var picker:some View{
        VStack{
            Picker(selection: $select, label: Text("选择")) {
                ForEach(types.indices, id: \.self){ i in
                                Text(types[i].label)
                            }
            }
        }.pickerStyle(.segmented)
    }
  
}

//struct MoneyaddView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoneyaddView()
//    }
//}
