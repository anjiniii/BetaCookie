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
                    
                Spacer()
                
                Image(systemName: "list.bullet")
            }
            .font(.title).bold()
            
            VStack(spacing: 8) {
                HStack {
                    Text("태국(THB)")
                    
                    Spacer()
                    
                    Text("1THB = 41 KRW")
                        .fontWeight(.light)
                }
                .padding(.horizontal, 12)
                
                HStack {
                    TextField("지출할 금액을 입력해라", text: $expense)
                        .keyboardType(.numberPad)
                        
                    Spacer()
                    
                    Image(systemName: "checkmark")
                        .foregroundColor(.black.opacity(0.2))
                        .bold()
                }
                .font(.system(size: 26))
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
