//
//  ContentView.swift
//  ProtectConcentration
//
//  Created by 渡邊涼太 on 2024/10/19.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = 1
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            OnePageView()
                .tabItem {
                    Label("何する", systemImage: "list.bullet")
                }.tag(1)
            
            TwoPageView()
                .tabItem {
                    Label("クイックメモ", systemImage: "lightbulb.min.fill")
                }.tag(2)
            
            ThreePageView()
                .tabItem {
                    Label("設定", systemImage: "gear")
                }.tag(3)
            
        }//TabView
        .onAppear(){
            UITabBar.appearance().backgroundColor = .parts
        }
        .accentColor(Color.green)
    }
}

//#Preview {
//    ContentView()
//}
