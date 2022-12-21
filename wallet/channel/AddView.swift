//
//  AddView.swift
//  ppts
//
//  Created by lichongbing on 2022/12/2.
//

import SwiftUI

struct AddView: View {
    // MARK: PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ChannelDao
    @State var textFieldText: String = ""
    @State var textFieldText1: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    var body: some View {
        ScrollView {
            VStack {
                TextField("填写频道名称", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                TextField("填写频道描述", text:$textFieldText1 )
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(14)
        }
        .navigationTitle("创建一个频道吧")
        .alert(isPresented: $showAlert, content: getAlert)
     
    }
    
    // MARK: FUNCTIONS
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            let uid =  UserDefaults(suiteName: "group.com.lichongbing.lyoggl")?.object(forKey: "uid") as! String
            let channnel =  Channel(id: UUID(), uid: uid, title: textFieldText, des: textFieldText1)
            listViewModel.addItem(newItem: channnel)
            DispatchQueue.main.async {
                listViewModel.getItems()}
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 1 && textFieldText.count > 2 {
            alertTitle = "输入两字就行!!! 😨😰😱"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
    
}

    // MARK: PREVIEW

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.light)
            .environmentObject(ChannelDao())
            NavigationView {
                AddView()
            }
            .preferredColorScheme(.dark)
            .environmentObject(ChannelDao())

        }
    }
}
