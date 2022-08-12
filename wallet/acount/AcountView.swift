//
//  AcountView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import SwiftUI

struct AcountView: View {
    @EnvironmentObject var acountDao: AcountDao
    @State var isPresentAddView = false
    @State var textFieldText = ""
    @State var textFieldText1 = ""
    @State var textFieldText2 = ""
    @State var textFieldText3 = ""
    @State var textFieldText4 = ""
    @State var textFieldText5 = ""
    var body: some View {
        List{
            ForEach(acountDao.moneys,id:\.self) { item in
                NavigationLink (
                    destination: AcountDetailView(item: item, id:item.id),
                    label: {
                        VStack(alignment: .leading) {
                            Text(item.bank)
                            Text(item.money)
                        }.font(.title2)
                        .padding(.vertical, 8)
                        
                    })
            }.onDelete(perform: acountDao.deleteItem)
           
            
        }.onAppear(perform: {
            acountDao.getItems()
        })
        .refreshable {
            acountDao.getItems()
        }
        .listStyle(PlainListStyle())
        .navigationTitle("账单")
        .navigationBarItems(trailing: plusButton)
        .sheet(isPresented: $isPresentAddView, content:{AcountaddView(isPresented: $isPresentAddView, textFieldText: $textFieldText, textFieldText1: $textFieldText1, textFieldText2: $textFieldText2,textFieldText3: $textFieldText3,textFieldText4: $textFieldText4,textFieldText5: $textFieldText5)})
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

struct AcountView_Previews: PreviewProvider {
    static var previews: some View {
        AcountView()
    }
}
