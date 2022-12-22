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
        
                HStack {
                    HStack{
                        
                        Button {
                            appDelegate.leaveChannel(channelUUID: item.id)
                        } label: {
                            
                            HStack{
                                Image(systemName: "multiply")
                                Text(  "离开")
                                
                            }.padding(EdgeInsets(top: 15, leading: 40, bottom: 15, trailing: 40))
                                .foregroundColor(.white)
                                .background(Color.red)
                                .clipShape(RoundedRectangle(cornerRadius: 28))
                            
                        }
                        
                        
                        
                    }
                    HStack{
                        
                        Button {
                            appDelegate.startTransmitting(channelUUID: item.id)
                        } label: {
                            
                            HStack{
                                Image(systemName: "waveform")
                                Text(  "对话")
                                
                            }.padding(EdgeInsets(top: 15, leading: 40, bottom: 15, trailing: 40))
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 28))
                            
                        }
                        
                        
                        
                    }
                    
                }.padding()
            
               
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




