//
//  SecretView.swift
//  ProtectConcentration
//
//  Created by 渡邊涼太 on 2024/10/20.
//

import SwiftUI

struct SecretView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var tabFlag: Visibility = .hidden
    
    var body: some View {
        ZStack{
            Color.threePage
            VStack(alignment:.center, spacing:20){
                //ヒューマンピクトグラム
                Image("pict")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding()
                Text("ここを見つけるとは、あなたは運が良い")
                    .foregroundColor(.text)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.horizontal,15)
                Text("そんなあなたにはこのアイコンを差し上げよう。")
                    .foregroundColor(.text)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding(.horizontal,15)
                
                HStack(alignment:.center){
                    Image("AppIconImage1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .padding()
                    Button{
                        print("change")
                        if UIApplication.shared.supportsAlternateIcons {
                            UIApplication.shared.setAlternateIconName("AppIcon1") {error in
                                if let error = error {
                                    print(error.localizedDescription)
                                    return
                                }
                            }
                        }else{
                            print("erorr")
                        }
                    }label:{
                        Text("Newアイコンに変更する")
                            .padding()
                            .foregroundColor(.text)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.text, lineWidth: 1.0)
                            )
                            .background(Color.parts, in: RoundedRectangle(cornerRadius: 15))
                    }
                }//HStack
                
                HStack(alignment:.center){
                    Image("AppIconImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 0.5)
                        )
                        .padding()
                    Button{
                        UIApplication.shared.setAlternateIconName(nil)
                    }label:{
                        Text("初期アイコンに戻す")
                            .padding()
                            .foregroundColor(.text)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.text, lineWidth: 1.0)
                            )
                            .background(Color.parts, in: RoundedRectangle(cornerRadius: 15))
                    }
                    
                }
            }
        }
        .navigationBarTitle("隠し扉の先", displayMode: .inline)
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

