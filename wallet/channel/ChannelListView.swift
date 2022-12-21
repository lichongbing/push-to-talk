//
//  ChannelListView.swift
//  ppts
//
//  Created by lichongbing on 2022/12/2.
//

import SwiftUI
struct ChannelListView: View {
    @EnvironmentObject var channels: ChannelDao
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some View {
          ZStack
            {
                if channels.moneys.isEmpty {
                    NoItemsView()
                        .transition(AnyTransition.opacity.animation(.easeIn))
                } else {
                    List {
                        ForEach(channels.moneys) { item in
                            NavigationLink(
                                destination: ChannelDetailView(item: item),
                                label: {
                                    ListRowView(item: item)
                                        .onTapGesture {
                                            withAnimation(.linear) {
                                              // listViewModel.updateItem(item: item)
                                              update(item: item)
                                            }
                                        }
                                }
                            )
                        }.onDelete(perform: delete)
                        //.onDelete(perform: listViewModel.deleteItem)
                        .onMove(perform: channels.moveItem)
                    }
                    .listStyle(PlainListStyle())
                }
            }.onAppear(perform: channels.getItems
            )
                .refreshable{
                    channels.getItems()
                }
            .navigationTitle("频道列表")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    NavigationLink("创建", destination: AddView())
                )
        }
        func delete(indexSet: IndexSet){
            channels.deleteItem(indexSet: indexSet)
            
            
            DispatchQueue.main.async {
                channels.getItems()}
        }
        func update(item: Channel){
            channels.updateItem(item: item)
            DispatchQueue.main.async {
                channels.getItems()}
    }
}

struct ChannelListView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelListView()
    }
}
