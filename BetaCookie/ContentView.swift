//
//  ContentView.swift
//  BetaCookie
//
//  Created by Anjin on 10/20/24.
//

import SwiftUI

struct ContentView: View {
    @State private var expense: String = ""
    
    var body: some View {
        VStack(spacing: 28) {
            HStack {
                Text("오늘의 지출")
                    .font(.cookieGmarketMedium32)
                    
                Spacer()
                
                Image(systemName: "list.bullet")
                    .font(.system(size: 26))
            }
            
            VStack(spacing: 8) {
                HStack(spacing: 4) {
                    Text("태국(THB)")
                        .font(.cookieGmarketMedium15)
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 10))
                    
                    Spacer()
                    
                    Text("1THB = 41 KRW")
                        .font(.cookieGmarketLight12)
                }
                .padding(.horizontal, 12)
                
                HStack {
                    TextField("498 - 38 * 3", text: $expense)
                        .font(.cookieGmarketMedium26)
                        .keyboardType(.numberPad)
                        
                    Spacer()
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 26)).bold()
                        .foregroundColor(.black.opacity(0.2))
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
                .background(Color.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Circle()
            
            Spacer()
            
            HStack(spacing: 12) {
                RoundedRectangle(cornerRadius: 10)
                    .background(Color.cardBackground)
                
                RoundedRectangle(cornerRadius: 10)
                    .background(Color.cardBackground)
            }
            .frame(height: 92)
        }
        .padding(28)
        .background(Color.background)
    }
}

#Preview {
    ContentView()
}

extension Color {
    static let background = Color(uiColor: UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1))
    
    static let cardBackground = Color(uiColor: UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1))
}
