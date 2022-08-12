//
//  MoneyView.swift
//  wallet
//
//  Created by lichongbing on 2022/8/11.
//

import SwiftUI

struct MoneyView: View {
    @EnvironmentObject var moneyDao: MoneyDao
    @State var isPresentAddView = false
    @State var textFieldText = ""
    @State var textFieldText1 = ""
    @State var textFieldText2 = ""
    var body: some View {
        List{
            ForEach(moneyDao.moneys,id:\.self) { item in
                NavigationLink (
                    destination: MoneyDetailView(item: item, id:item.id),
                    label: {
                        VStack(alignment: .leading) {
                            Text(item.ways).font(.system(size: 25))
                            HStack{
                                Text(item.dateTime).font(.system(size: 15))
                                Spacer()
                                if item.type=="0" {
                                    Text(item.money) .font(.system(size: 20)).foregroundColor(.gray)
                                }else if item.type=="1"{
                                    Text(item.money) .font(.system(size: 20)).foregroundColor(.red)
                                }
                                Spacer()
                            }
                        }
                        .padding(.vertical, 4)
                        
                    })
            }.onDelete(perform: moneyDao.deleteItem)
           
            
        }.onAppear(perform: {
            moneyDao.getItems()
        })
        .refreshable {
            moneyDao.getItems()
        }
        .listStyle(PlainListStyle())
        .navigationTitle("明细")
        .navigationBarItems(trailing: plusButton)
        .sheet(isPresented: $isPresentAddView, content:{MoneyaddView(isPresented: $isPresentAddView, textFieldText: $textFieldText, textFieldText1: $textFieldText1)})
    Spacer()
    }
    var plusButton: some View{
        Button {
            isPresentAddView.toggle()
        } label: {
//                Image(systemName: "plus")
            Text("记账")
        }

    }
}

struct MoneyView_Previews: PreviewProvider {
    static var previews: some View {
        MoneyView()
    }
}
