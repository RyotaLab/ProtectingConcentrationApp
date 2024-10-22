//
//  ThreePageView.swift
//  ProtectConcentration
//
//  Created by 渡邊涼太 on 2024/10/19.
//

import SwiftUI
import StoreKit

struct ThreePageView: View {
    
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.threePage
                VStack{
                    List{
                        Section(header: Text("アプリについて")) {
                            //アプリの使い方
                            NavigationLink(destination: IntroductionView()) {
                                HStack{
                                    Text("\(Image(systemName: "info.circle"))")
                                        .foregroundColor(.green).frame(width:30)
                                    Text("アプリの使い方")
                                        .frame(height: 37)
                                        .foregroundColor(.text)
                                }
                            }
                            .listRowBackground(Color.parts)
                            
                            //おすすめの本
                            NavigationLink(destination: RecommendationView()) {
                                HStack{
                                    Text("\(Image(systemName: "text.book.closed.fill"))")
                                        .foregroundColor(.green).frame(width:30)
                                    Text("おすすめ本")
                                        .frame(height: 37)
                                        .foregroundColor(.text)
                                }
                            }
                            .listRowBackground(Color.parts)
                            
                        }
                        Section(header: Text("その他")) {
                            //通知設定
                            NavigationLink(destination: MakeNotificationView()) {
                                HStack{
                                    Text("\(Image(systemName: "alarm"))")
                                        .foregroundColor(.green).frame(width:30)
                                    Text("通知の設定")
                                        .frame(height: 37)
                                        .foregroundColor(.text)
                                }
                            }
                            .listRowBackground(Color.parts)
                            
                            //寄付機能
                            NavigationLink(destination: DonationView()) {
                                HStack{
                                    Text("\(Image(systemName: "takeoutbag.and.cup.and.straw"))")
                                        .foregroundColor(.green).frame(width:30)
                                    Text("開発者に奢る")
                                        .foregroundColor(.text)
                                        .frame(height: 37)
                                }
                            }
                            .listRowBackground(Color.parts)
                            
                            //不具合報告
                            Link(destination:URL(string: "https://forms.gle/UTQBe7bNW8y1v4RB7")!, label: {
                                HStack{
                                    Text("\(Image(systemName: "link"))")
                                        .foregroundColor(.green).frame(width:30)
                                    Text("要望または不具合報告")
                                        .frame(height: 37)
                                        .foregroundColor(.text)
                                }
                                
                            })
                            .listRowBackground(Color.parts)
                        }
                    }//List
                    .scrollContentBackground(.hidden)
                    .background(Color.threePage)
                    
                    NavigationLink(destination: SecretView()) {
                        Image("water")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .padding()
                    }
                }//VStack
            }
            .navigationBarTitle("設定", displayMode: .inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.parts ,for: .navigationBar)
        }//navigationStack
    }
}


