//
//  RecommendationView.swift
//  ProtectConcentration
//
//  Created by 渡邊涼太 on 2024/10/19.
//

import SwiftUI

struct RecommendationView: View {
    @Environment(\.dismiss) var dismiss
    @State var tabFlag: Visibility = .hidden
    
    var body: some View {
        ZStack{
            Color.threePage
            ScrollView(showsIndicators:false){
                VStack{
                    Image(systemName: "book.closed.fill")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 100))
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                    VStack(alignment : .leading, spacing: 20){
                        Text("当アプリを使い始めた方におすすめしたい本は「スマホ脳」です。")
                            .foregroundColor(.text)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .padding(.horizontal, 15)
                        Text("私たちがなんとなく触っているアプリやサービスは本当に私たちがやりたいことなのでしょうか？")
                            .foregroundColor(.text)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .padding(.horizontal, 15)
                        Text("早く寝た方が良いのに、なんでスマホを触り続けてしまうのでしょうか？")
                            .foregroundColor(.text)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .padding(.horizontal, 15)
                        Text("「スマホ脳」はスマホとの上手な付き合い方について考えるきっかけになると思います！")
                            .foregroundColor(.text)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .padding(.horizontal, 15)
                    }
                    Link(destination:URL(string: "https://amzn.to/4eRflNw")!, label: {
                        HStack{
                            Text("\(Image(systemName: "link"))")
                                .foregroundColor(.green).frame(width:30)
                            Text("スマホ脳のURL（Amazon）を開く")
                                .frame(height: 37)
                                .foregroundColor(.text)
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.text, lineWidth: 1.0)
                        )
                        .background(Color.parts, in: RoundedRectangle(cornerRadius: 8))
                        .padding(.vertical, 20)
                        
                    })
                    Text("ちなみに私も夜のゲームはやめれません...笑")
                        .foregroundColor(.text)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.horizontal, 15)
                        
                    
                    
                }
            }
        }//ZStack
        .navigationBarTitle("おすすめ本", displayMode: .inline)
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

