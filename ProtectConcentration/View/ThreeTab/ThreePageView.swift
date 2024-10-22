//
//  ThreePageView.swift
//  ProtectConcentration
//
//  Created by 渡邊涼太 on 2024/10/19.
//

import SwiftUI

struct ThreePageView: View {
    var body: some View {
        NavigationStack{
            ZStack{
                Color.background
                VStack{
                    
                }
            }
            .navigationBarTitle("設定", displayMode: .inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.parts ,for: .navigationBar)
        }//navigationStack
    }
}


