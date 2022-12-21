//
//  ChannelDetailView.swift
//  ppts
//
//  Created by lichongbing on 2022/12/2.
//

import SwiftUI

struct ChannelDetailView: View {
    @EnvironmentObject var channels: ChannelDao
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var item : Channel
    var body: some View {
        VStack{
            VStack{
                
                Button {
                    appDelegate.leaveChannels(channelUUID: item.id)
                } label: {
                    Text(  "点击退出频道(一旦退出将不再接收音频消息)")
                }
                Divider()
                Button {
                    appDelegate.leaveChannel(channelUUID: item.id)
                } label: {
                    Text(  "点击离开频道")
                }
                Divider()
            }
            List{
                ForEach(channels.moneys1,id:\.self) { item in
                            VStack(alignment: .leading) {
                                Text(item.join)
                            }.font(.title2)
                            .padding(.vertical, 8)
                }.onDelete(perform: channels.deleteItem)
            }.onAppear {
                channels.getjoinchannel(channel: item)
            }
            .refreshable {
                channels.getjoinchannel(channel: item)
               
            }
               
        }.navigationBarItems(trailing:joinButton)
        }
    var joinButton: some View{
        Button {
             appDelegate.joinChannel(channelUUID: item.id)
        } label: {
//                Image(systemName: "plus")
            Text( "加入频道🥳")
        }
        .onAppear{
        
            channels.checkJoinChannels(channel: item.id)
        }
       

    }
        
}




