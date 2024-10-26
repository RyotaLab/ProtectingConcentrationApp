//
//  TwoPageView.swift
//  ProtectConcentration
//
//  Created by 渡邊涼太 on 2024/10/19.
//

import SwiftUI

struct TwoPageView: View {
    
    @State var ideaMemo: String
    @State var isChanged: Bool = false
    @State var deleteAlert: Bool = false
    
    @FocusState private var focusedField: Field?
    
    let screenHeight: CGFloat
    
    init() {
        let screenSize = UIScreen.main.bounds
        self.screenHeight = screenSize.height
        
        if let memoRecord = UserDefaults.standard.string(forKey: "ideaMemo"){
            _ideaMemo = State(initialValue: memoRecord)
        }else{
            _ideaMemo = State(initialValue: "")
        }
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background
                
                
                TextEditor(text: $ideaMemo)
                    .focused($focusedField, equals: .ideaMemo)
                    .frame(minHeight: screenHeight) // 初期の高さを設定
                    .frame(maxHeight: .infinity) // 無限大に広がるようにする
                    .foregroundColor(.text)
                    .overlay(alignment: .topLeading) {
                        if ideaMemo.isEmpty {
                            Text("Memo")
                                .allowsHitTesting(false) // タップ判定を無効化
                                .foregroundColor(Color(uiColor: .placeholderText))
                                .padding(6)
                        }
                    }
                    .padding(10)
                
                
                
                
            }
            .onChange(of: ideaMemo, initial: false){
                isChanged = true
                UserDefaults.standard.setValue(ideaMemo, forKey: "ideaMemo")
            }
            .onChange(of: focusedField, initial: false){
                if !(focusedField == nil){
                    isChanged = true
                }
            }
            
            .navigationBarTitle("アイデア＆雑記", displayMode: .inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.parts ,for: .navigationBar)
            .toolbar {
                if isChanged{
                    ToolbarItem(placement: .topBarTrailing){
                        Button{
                            isChanged = false
                            focusedField = nil
                        }label:{
                            Text("完了")
                                .foregroundColor(Color.green)
                        }
                    }
                }
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        deleteAlert = true
                    }label:{
                        Text("全削除")
                            .foregroundColor(Color.pink)
                        
                    }
                }
            }
            .alert(Text("確認"), isPresented: $deleteAlert){
                Button("削除", role: .destructive){
                    ideaMemo = ""
                    UserDefaults.standard.setValue(ideaMemo, forKey: "ideaMemo")
                }
                Button("やめる", role: .cancel){
                }
            }message: {
                Text("操作を戻すことはできません")
            }
        }//navigationStack
    }
}


