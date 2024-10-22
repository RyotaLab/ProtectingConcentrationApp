//
//  OnePageView.swift
//  ProtectConcentration
//
//  Created by 渡邊涼太 on 2024/10/19.
//

import SwiftUI
import RealmSwift

import StoreKit

struct OnePageView: View {
    
    @ObservedResults(OpenReasonList.self) var OpenReasons
    
    @State var inputReason:String = ""
    @State var deleteItemSet: Set<ObjectId> = []
    @State var isAchievedSet: Set<ObjectId> = []
    
    //レビュー関連
    @Environment(\.openURL) var openURL
    @State var isShow:Bool = false
    @State var isShow1:Bool = false
    let launchCount = UserDefaults.standard.integer(forKey: "launchCount")
    let isRequestReview = UserDefaults.standard.bool(forKey: "isRequest")
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background
                    .onTapGesture {
                        focusedField = nil
                    }
                VStack{
                    //Text("スマホを開いた回数　○回")
                    
                    //Todo形式で用意（アニメーションつけたい）
                    ScrollView(showsIndicators: false){
                        ForEach(OpenReasons, id: \.id) { openReason in
                            HStack(alignment: .center){
                                Text(openReason.reason)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(nil)
                                    .foregroundColor(.text)
                                Spacer()
                                
                                Button{
                                    isAchievedSet.insert(openReason.id)
                                    deleteItemSet.insert(openReason.id)
                                    //Realmオブジェクトを削除
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        deleteRealmItem(id: openReason.id)
                                    }
                                }label:{
                                    Image(systemName: isAchievedSet.contains(openReason.id) ? "checkmark.square" : "square")
                                        .font(Font.system(size: 35, weight: .thin))
                                        .foregroundStyle(.green)
                                        .animation(.easeInOut(duration: 0.3), value: deleteItemSet)
                                }
                            }//HStack
                            .padding(.horizontal, 20)
                            .padding(.bottom, 5)
                            Divider()
                                .padding(.bottom, 5)
                        }
                        .onTapGesture {
                            focusedField = nil
                        }
                    }//ScrollView
                    .padding(.bottom, 30)
                    .padding(.top, 10)
                    
                    Spacer()
                    //Realmで追加する
                    HStack{
                        TextField("何をするか入力", text: $inputReason)
                            .focused($focusedField, equals: .inputReason)
                            .overlay(
                                    RoundedRectangle(cornerSize: CGSize(width: 8.0, height: 8.0))
                                    .stroke(Color.gray, lineWidth: 1)
                                    .padding(-8.0)
                            )
                            .padding(8)
                            .background(.parts, in: RoundedRectangle(cornerRadius: 8))
                        
                        Button{
                            //Realmに保存する
                            if !(inputReason == "") {
                                
                                let openReason = OpenReasonList()
                                openReason.reason = inputReason
                                $OpenReasons.append(openReason)
                                
                                inputReason = ""
                            }
                        }label:{
                            Image(systemName: "plus.circle")
                                .font(.system(size: 30))
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.gray, .green)
                        }
                    }//HStack
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
                .onTapGesture {
                    focusedField = nil
                }
            }
            .navigationBarTitle("スマホ開いて何する？", displayMode: .inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.parts ,for: .navigationBar)
            .onAppear{
                if !isRequestReview{
                    if launchCount == 15{
                        //リクエストを出し、今後リクエストが出ないようにする
                        UserDefaults.standard.setValue(true, forKey: "isRequest")
                        isShow = true
                    }
                }
            }
            .alert("使い心地はいかがですか？", isPresented: $isShow){
                Button("満足", role: .cancel){
                    requestReview()
                }
                Button("不満", role: .destructive){
                    isShow1 = true
                }
            }message:{
                Text("アプリ改善のため、ご協力お願いいたします！")
            }
            .alert("ご満足いただけず申し訳ございません", isPresented: $isShow1){
                Button("YES", role: .cancel){
                    openURL(URL(string: "https://forms.gle/UTQBe7bNW8y1v4RB7")!)
                }
                Button("NO", role: .destructive){
                    
                }
            }message:{
                Text("ご意見を頂けませんか？")
            }
        }//navigationStack
    }
    
    //Realm削除メソッド
    func deleteRealmItem(id: ObjectId){
        let realm = try! Realm()
        
        //idに一致するitem取得
        if let deleteItem = realm.object(ofType: OpenReasonList.self, forPrimaryKey: id){
            do {
                try realm.write{
                    realm.delete(deleteItem)
                }
            }catch{
                print("error")
            }
        }else{
            print("not found")
        }
    }
    
    private func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
}


