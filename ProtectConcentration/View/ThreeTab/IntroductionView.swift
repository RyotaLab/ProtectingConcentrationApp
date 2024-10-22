//
//  Introduction.swift
//  ProtectConcentration
//
//  Created by 渡邊涼太 on 2024/10/19.
//

import SwiftUI

struct IntroductionView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var tabFlag: Visibility = .hidden
    
    var body: some View {
        ZStack{
            Color.threePage
            ScrollView(showsIndicators: false){
                VStack(alignment : .leading, spacing: 20){
                    Image("introduction")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(15)
                    Text("タブの\"何する\"とは、スマホを触る前に、今から何をするのかをメモする場所になります。")
                        .foregroundColor(.text)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.horizontal, 15)
                    Text("これにより、やることが明確化され、ついでにゲームをログインしたり、メッセージアプリを開くことを防ぎます。")
                        .foregroundColor(.text)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.horizontal, 15)
                    Text("また、メモとして書いてみると、「必要ない」と気づくかもしれません。")
                        .foregroundColor(.text)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.horizontal, 15)
                    
                    Image("introduction1")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(15)
                    Text("タブの\"クイックメモ\"とは、今重要ではないけど、気になったり、忘れないためにメモして置く場所です。")
                        .foregroundColor(.text)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.horizontal, 15)
                    Text("気にはなるけど、今じゃないと気づけたらこちらにメモをしましょう。")
                        .foregroundColor(.text)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.horizontal, 15)
                    Text("あとで考えたら必要ないものだったりするので。")
                        .foregroundColor(.text)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.horizontal, 15)
                }
            }//Scroll
        }//ZStack
        .navigationBarTitle("アプリの使い方", displayMode: .inline)
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


