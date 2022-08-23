//
//  BankDetailView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import SwiftUI

struct BankDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var projectDao: BankDao
    var item : Bank
    var id : String
    @State var textFieldText = ""
    @State var textFieldText1 = ""
    @State var textFieldText2 = ""
    @State var textFieldText3 = ""
    @State var textFieldText4 = ""
    @State var textFieldText5 = ""
    var body: some View {
        if(item.type == 0 || item.type == 2){
            VStack {
                TextField(item.name, text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                TextField(item.card, text:$textFieldText1 )
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                TextField(item.date0, text:$textFieldText2 )
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                TextField(item.date1, text:$textFieldText3 )
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                TextField(item.balance, text:$textFieldText4 )
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                TextField(item.duted, text:$textFieldText5 )
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                Spacer()
            }.navigationBarTitle(item.name,displayMode: .inline)
                .navigationBarItems(trailing: trailing)
        }else{
            VStack{
            TextField(item.name, text: $textFieldText)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            TextField(item.card, text:$textFieldText1 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
            TextField(item.balance, text:$textFieldText4 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
                Spacer()
            }.navigationBarTitle(item.name,displayMode: .inline)
                .navigationBarItems(trailing: trailing)
        }
        
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
        let project = Bank(id: id, name: textFieldText, card: textFieldText1, date0: textFieldText2, date1: textFieldText3,type: item.type,balance: textFieldText4,duted: textFieldText5)
        projectDao.updateItem(item: project)
    }
}

//struct BankDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BankDetailView()
//    }
//}
