//
//  AcountDetailView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import SwiftUI

struct AcountDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var acountDao: AcountDao
    var item : Acount
    var id : String
    @State var textFieldText = ""
    @State var textFieldText1 = ""
    @State var textFieldText2 = ""
    @State var textFieldText3 = ""
    @State var textFieldText4 = ""
    @State var textFieldText5 = ""
    @State var textFieldText6 = ""
    @State var textFieldText7 = ""
    @State var textFieldText8 = ""
    @State var textFieldText9 = ""
    var body: some View {
        VStack {
            TextField(item.date0, text: $textFieldText)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            TextField(item.date1, text:$textFieldText1 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
            TextField(item.money, text:$textFieldText2 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
            TextField(item.money1, text:$textFieldText3 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            TextField(item.money2, text:$textFieldText4 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            TextField(item.money3, text:$textFieldText5 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            TextField(item.pay, text:$textFieldText6 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            TextField(item.pay1, text:$textFieldText7 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            TextField(item.mouth, text:$textFieldText8 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            TextField(item.year, text:$textFieldText9 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
        }.navigationBarTitle(item.idcard,displayMode: .inline)
            .navigationBarItems(trailing: trailing)
    }
    var trailing: some View{
        Button {
            save()
            presentationMode.wrappedValue.dismiss()
           
        } label: {
            Text("保存")
        }

    }
    private func save(){
        let project = Acount(id: id, bank: "textFieldText", idcard: "textFieldText1", date0: "textFieldText", date1: "textFieldText1",money: textFieldText2,money1: textFieldText3,money2: textFieldText4,money3: textFieldText5, pay: textFieldText6,pay1: textFieldText7,mouth: textFieldText8, year: textFieldText9,bankid: "")
        acountDao.updateItem(item: project)
    }
}
//
//struct AcountDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AcountDetailView()
//    }
//}
