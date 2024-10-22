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
                    Label("理由", systemImage: "gear")
                }.tag(1)
            
            TwoPageView()
                .tabItem {
                    Label("アイデア", systemImage: "gear")
                }.tag(2)
            
            ThreePageView()
                .tabItem {
                    Label("設定", systemImage: "gear")
                }.tag(3)
            
        }
    }
}

//#Preview {
//    ContentView()
//}
