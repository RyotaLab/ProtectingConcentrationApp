//
//  DonationView.swift
//  ProtectConcentration
//
//  Created by 渡邊涼太 on 2024/10/19.
//

import SwiftUI

struct DonationView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var tabFlag: Visibility = .hidden
    
    @EnvironmentObject private var purchaseManager: PurchaseManager
    
    @State var isShowPig:Bool = false
    
    var body: some View {
        ZStack{
            Color.threePage
            VStack(spacing:20){
                Image("pig")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .padding()
                
                Text("\"奢る\"とは、開発者に対し「良いアプリだ！これくらい奢ってやるよ！」というものです。")
                    .foregroundColor(.text)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.horizontal, 15)
                Text("当アプリは、私が私のために作ったアプリを「使いたい人がいればぜひ！」と公開しているアプリになります。")
                    .foregroundColor(.text)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.horizontal,15)
                Text("そのため、広告をつけていません。もし、お金に余裕があり、当アプリで人生が良い方向に向かった時、\"奢る\"をいただけたら嬉しいです！")
                    .foregroundColor(.text)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .padding(.horizontal,15)
                
                VStack{
                    Divider()
                    HStack{
                        Image("juice")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                        Text("ジュースを奢る")
                        Spacer()
                        Button{
                            //ジュース購入処理
                            Task{
                                do{
                                    let juice = purchaseManager.ConsumableProducts.first(where: {$0.id == "tanabi.ProtectConcentration.donation.item1"})
                                    if juice != nil {
                                        try await purchaseManager.purchase(juice!)
                                    }
                                }catch{
                                    print(error)
                                }
                            }
                        }label:{
                            Text("120円")
                                .frame(width: 65, height: 40, alignment: .center)
                                .foregroundColor(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.orange, lineWidth: 1.0)
                                )
                                .background(Color.orange, in: RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    Divider()
                    HStack{
                        Image("gyoza")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                        Text("餃子を奢る")
                        Spacer()
                        Button{
                            //餃子購入処理
                            Task{
                                do{
                                    let gyoza = purchaseManager.ConsumableProducts.first(where: {$0.id == "tanabi.ProtectConcentration.donation.item2"})
                                    if gyoza != nil {
                                        try await purchaseManager.purchase(gyoza!)
                                    }
                                }catch{
                                    print(error)
                                }
                            }
                        }label:{
                            Text("490円")
                                .frame(width: 65, height: 40, alignment: .center)
                                .foregroundColor(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.orange, lineWidth: 1.0)
                                )
                                .background(Color.orange, in: RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    Divider()
                    HStack{
                        Image("ra-men")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                        Text("ラーメンを奢る")
                        Spacer()
                        Button{
                            //ラーメン購入処理
                            Task{
                                do{
                                    let ramen = purchaseManager.ConsumableProducts.first(where: {$0.id == "tanabi.ProtectConcentration.donation.item3"})
                                    if ramen != nil {
                                        try await purchaseManager.purchase(ramen!)
                                    }
                                }catch{
                                    print(error)
                                }
                            }
                        }label:{
                            Text("980円")
                                .frame(width: 65, height: 40, alignment: .center)
                                .foregroundColor(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.orange, lineWidth: 1.0)
                                )
                                .background(Color.orange, in: RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    Divider()
                }//Vstack
                .padding(.horizontal, 20)
                
            }//VStack
            
        }
        .navigationBarTitle("奢る", displayMode: .inline)
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

