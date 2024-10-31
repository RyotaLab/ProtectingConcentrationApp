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
    @State private var keyboardHeight: CGFloat = 0
    
    let screenHeight: CGFloat
    let screenSize = UIScreen.main.bounds
    
    init() {
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
                VStack{
                    TextEditor(text: $ideaMemo)
                        .focused($focusedField, equals: .ideaMemo)
                        .frame(minHeight: (screenHeight / 2) - keyboardHeight) // 初期の高さを設定
                        .foregroundColor(.text)
                        .overlay(alignment: .topLeading) {
                            if ideaMemo.isEmpty {
                                Text("Memo")
                                    .allowsHitTesting(false) // タップ判定を無効化
                                    .foregroundColor(Color(uiColor: .placeholderText))
                                    .padding(6)
                            }
                        }
                        .padding(.horizontal, 10)
                        .animation(.easeOut(duration: 0.3), value: keyboardHeight)
//                    Spacer()
//                        .onTapGesture {
//                            focusedField = .ideaMemo
//                            print("tap")
//                        }
                }
            }
            .onAppear {
                // キーボードの高さを監視
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        keyboardHeight = keyboardFrame.height - 100
                        print("hello")
                    }
                }
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    keyboardHeight = 0
                    print("good bye")
                }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self)
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


