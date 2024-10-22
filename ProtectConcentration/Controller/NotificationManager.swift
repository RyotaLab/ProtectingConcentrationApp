//
//  NotificationManager.swift
//  ProtectConcentration
//
//  Created by 渡邊涼太 on 2024/10/19.
//

//機能：0:00 ~ 10:00 ：おはようございます
//10:01 ~ 16:00 ：こんにちは
//16:01 ~ 14:00：　こんばんわ

import UserNotifications

class NotificationManagement {
    
    //通知の作成（Realm全体と、その日の時間を設定）
    func makeNotification(date: Date){
        
        //通知日時
        let notificationTime = Calendar.current.dateComponents([ .hour, .minute], from: date)
        let setHour = notificationTime.hour ?? 0
        let setMinute = notificationTime.minute ?? 0
        
        //トリガー用のデータコンポーネントを用意
        let triggerTime = DateComponents(hour: setHour, minute: setMinute)
        
        //トリガー（毎日繰り返す）
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: true)
        
        //通知内容
        let content = UNMutableNotificationContent()
        content.title = "通知"
        content.sound = .default
        
        if setHour < 7 {
            content.body = ""
        }else if setHour < 10 {
            content.body = "おはようございます。今日も自分のペースで頑張りましょう"
        }else if setHour < 15 {
            content.body = "一息ついてリフレッシュ。午後も頑張りましょう"
        }else if setHour < 18 {
            content.body = "あと少し。ラストスパートですね"
        }else if setHour < 21 {
            content.body = "今日はよく頑張りました。心と体をリフレッシュしましょう"
        }else {
            content.body = "おやすみなさい。明日も良い1日になるはずです"
        }
        
        //リクエスト
        let request = UNNotificationRequest(identifier: "dayMessage", content: content, trigger: trigger)
        
        //通知作成
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("通知作成Error : \(error.localizedDescription)")
            }else {
                print(trigger)
                print("通知が作成されました")
            }
        }
        
    }//makeNotification
    
    //idはあとで変更
    func removeNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["dayMessage"])
        print("通知が削除されました")
    }//removeNotification
}

//通知の権限リクエストに使うクラス
final class NotificationManager {
   static let instance: NotificationManager = NotificationManager()
    
   func requestPermission() {
       UNUserNotificationCenter.current()
           .requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
               print("Permission granted: \(granted)")
           }
   }
}
