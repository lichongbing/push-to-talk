//
//  MoneyDetailView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import SwiftUI

struct MoneyDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var projectDao: MoneyDao
    var item : Money
    var id : String
    @State var textFieldText = ""
    @State var textFieldText1 = ""
    @State var textFieldText2 = ""
    @State var textFieldText3 = ""
    @State var textFieldText4 = ""
    @State var textFieldText5 = ""
    var body: some View {
        VStack {
            TextField(item.dateTime, text: $textFieldText)
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            TextField(item.money, text:$textFieldText1 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
            TextField(item.type, text:$textFieldText2 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
            TextField(item.mouth, text:$textFieldText3 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            TextField(item.ways, text:$textFieldText4 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            TextField(item.year, text:$textFieldText5 )
                .padding(.horizontal)
                .frame(height: 55)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(10)
            Spacer()
        }.navigationBarTitle(item.dateTime,displayMode: .inline)
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
        let project = Money(id: id, dateTime: textFieldText, money: textFieldText1, type: textFieldText2, ways: textFieldText4, mouth: textFieldText3, year: textFieldText5)
        projectDao.updateItem(item: project)
    }
}

//struct MoneyDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoneyDetailView()
//    }
//}
