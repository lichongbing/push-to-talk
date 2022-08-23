//
//  BankView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import SwiftUI

struct BankView: View {
    @EnvironmentObject var bankDao: BankDao
    @State var isPresentAddView = false
    @State var textFieldText = ""
    @State var textFieldText1 = ""
    @State var textFieldText2 = ""
    @State var textFieldText3 = ""
    @State var textFieldText4 = ""
    @State var textFieldText5 = ""
    var body: some View {
        List{
            ForEach(bankDao.moneys,id:\.self) { item in
                NavigationLink (
                    destination: BankDetailView(item: item, id:item.id),
                    label: {
                        VStack(alignment: .leading) {
                            Text(item.name)
                            Text(item.card)
                        }.font(.title2)
                        .padding(.vertical, 8)
                        
                    })
            }.onDelete(perform: bankDao.deleteItem)
           
            
        }.onAppear(perform: {
            bankDao.getItems()
        })
        .refreshable {
            bankDao.getItems()
        }
        .listStyle(PlainListStyle())
        .navigationTitle("信用卡")
        .navigationBarItems(trailing: plusButton)
        .sheet(isPresented: $isPresentAddView, content:{BankaddView(isPresented: $isPresentAddView, textFieldText: $textFieldText, textFieldText1: $textFieldText1, textFieldText2: $textFieldText2,textFieldText3: $textFieldText3,textFieldText4:$textFieldText4, textFieldText5: $textFieldText5)})
    Spacer()
    }
    var plusButton: some View{
        Button {
            isPresentAddView.toggle()
        } label: {
//                Image(systemName: "plus")
            Text("添加")
        }

    }
}

struct BankView_Previews: PreviewProvider {
    static var previews: some View {
        BankView()
    }
}

