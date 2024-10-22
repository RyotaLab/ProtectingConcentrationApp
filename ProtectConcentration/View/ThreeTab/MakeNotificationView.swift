//
//  MakeNotificationView.swift
//  ProtectConcentration
//
//  Created by 渡邊涼太 on 2024/10/19.
//

import SwiftUI
import UserNotifications

struct MakeNotificationView: View {
    
    //標準セット：変更不可
    @Environment(\.dismiss) var dismiss
    @State var tabFlag: Visibility = .hidden
    
    //通知関連
    let NotifyManager = NotificationManagement()
    @State private var notificationDate:Date = Date()
    
    //保存アラート
    @State private var saveAlert:Bool = false
    @State private var alertContent:String = ""
    
    @AppStorage("setHour") var nowNotifyHour: Int = 0
    @AppStorage("setMinute") var nowNotifyMinute: Int = 0
    @AppStorage("isNotify") var isNotify: Bool = false
    
    var body: some View {
        ZStack{
            Color.threePage
            
            VStack{
                
                Text("当アプリを使うことを忘れないために、通知を作成できます。通知の内容は時間帯によって変化します。")
                    .foregroundColor(.text)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.horizontal,15)
                    .padding(.bottom, 30)
                
                Text("通知の時刻")
                    .foregroundColor(.text)
                    .fontWeight(.bold)
                    .overlay(
                        Rectangle()
                            .fill(.green)
                            .frame(width: 80, height: 1)
                        , alignment: .bottom
                    )
                
                if isNotify {
                    Text("現在設定されている通知は\(nowNotifyHour)時\(nowNotifyMinute)分です")
                        .foregroundColor(.text)
                        .padding(.top, 5)
                } else {
                    Text("通知は登録されていません")
                        .padding(.top, 5)
                        .foregroundColor(.text)
                }
                
                DatePicker("Date",
                           selection: $notificationDate,
                           displayedComponents: [.hourAndMinute]
                ).labelsHidden()
                    .datePickerStyle(.wheel)
                    .background(Color.parts, in: RoundedRectangle(cornerRadius: 8))
                
                HStack{
                    //保存ボタン
                    Button{
                        NotifyManager.makeNotification(date: notificationDate)
                        alertContent = "通知を作成しました"
                        
                        let notificationTime = Calendar.current.dateComponents([ .hour, .minute], from: notificationDate)
                        nowNotifyHour = notificationTime.hour ?? 0
                        nowNotifyMinute = notificationTime.minute ?? 0
                        isNotify = true
                        
                        UserDefaults.standard.setValue(true, forKey: "isNotify")
                        UserDefaults.standard.setValue(nowNotifyHour, forKey: "setHour")
                        UserDefaults.standard.setValue(nowNotifyMinute, forKey: "setMinute")
                        
                        saveAlert = true
                        
                    }label:{
                        Text("通知作成")
                            .frame(width: 100, height: 50, alignment: .center)
                            .foregroundColor(.text)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.text, lineWidth: 1.0)
                            )
                            .background(Color.parts, in: RoundedRectangle(cornerRadius: 8))
                            .padding(.vertical, 40)
                            .padding(.horizontal,10)
                    }
                    //削除ボタン
                    Button{
                        NotifyManager.removeNotification()
                        alertContent = "通知を削除しました"
                        isNotify = false
                        
                        UserDefaults.standard.setValue(false, forKey: "isNotify")
                        
                        saveAlert = true
                    }label:{
                        Text("通知削除")
                            .frame(width: 100, height: 50, alignment: .center)
                            .foregroundColor(.pink)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.pink, lineWidth: 1.0)
                            )
                            .background(Color.parts, in: RoundedRectangle(cornerRadius: 8))
                            .padding(.vertical, 40)
                            .padding(.horizontal,10)
                    }
                }
            }//Vstack
        }//ZStack
        .alert(alertContent, isPresented: $saveAlert){
            Button("OK", role: .cancel){
            }
        }message: {
        }
        
        .navigationBarTitle("通知の設定", displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(.parts ,for: .navigationBar)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                Button{
                    //戻るボタン
                    dismiss()
                    tabFlag = .visible
                    
                }label:{
                    Text("\(Image(systemName: "chevron.backward")) 戻る")
                        .foregroundColor(Color.green)
                    
                }
            }
        }
        .toolbar(tabFlag, for: .tabBar)
    }
}






