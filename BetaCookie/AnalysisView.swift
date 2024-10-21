//
//  AnalysisView.swift
//  BetaCookie
//
//  Created by Anjin on 10/21/24.
//

import SwiftUI

struct AnalysisView: View {
    @State private var showStats: Bool = false
    let sumOfAllExpenses: Double
    
    var body: some View {
        VStack(spacing: 4) {
            Spacer(minLength: 0)
            
            if showStats {
                VStack(spacing: 12) {
                    Button {
                        withAnimation {
                            showStats.toggle()
                        }
                    } label: {
                        Image(systemName: "chevron.down")
                            .resizable()
                            .frame(width: 60, height: 14)
                            .foregroundStyle(Color.gray)
                    }
                    
                    HStack(spacing: 6) {
                        Text("오늘은 어제보다")
                            .font(.cookieGmarketMedium12)
                            .foregroundStyle(Color.black.opacity(0.7))
                        HStack {
                            Spacer(minLength: 0)
                            Text("\(abs(Int(4000 - sumOfAllExpenses)))")
                                .font(.cookieGmarketBold12)
                                .foregroundStyle(Int(4000 - sumOfAllExpenses) >= 0 ? Color.black.opacity(0.7) : Color.cookieRed)
                            Spacer(minLength: 0)
                        }
                        .padding(.vertical, 4)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text(Int(4000 - sumOfAllExpenses) >= 0 ? "덜 썼어요" : "더 썼어요")
                            .font(.cookieGmarketMedium12)
                            .foregroundStyle(Color.black.opacity(0.7))
                    }
                    
                    let avg = (8000 + sumOfAllExpenses) / 3
                    HStack(spacing: 6) {
                        Text("하루 지출 평균이")
                            .font(.cookieGmarketMedium12)
                            .foregroundStyle(Color.black.opacity(0.7))
                        HStack(spacing: 2) {
                            Spacer(minLength: 0)
                            Text("4,000")
                                .foregroundStyle(Color.black.opacity(0.7))
                            Image(systemName: "arrow.right")
                                .foregroundStyle(Color.black.opacity(0.7))
                            Text("\(Int(avg))")
                                .foregroundStyle(avg <= 4000 ? Color.cookieGreen : Color.cookieRed)
                            Spacer(minLength: 0)
                        }
                        .font(.cookieGmarketBold12)
                        .padding(.vertical, 4)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text(avg <= 4000 ? "로 줄었어요" : "로 늘었어요")
                            .font(.cookieGmarketMedium12)
                            .foregroundStyle(Color.black.opacity(0.7))
                    }
                    
                    HStack(spacing: 6) {
                        Text("예상되는 지출 총 금액은")
                            .font(.cookieGmarketMedium12)
                            .foregroundStyle(Color.black.opacity(0.7))
                            .frame(width: 130)
                        HStack {
                            Spacer(minLength: 0)
                            Text("\(Int(16000 + sumOfAllExpenses))")
                                .font(.cookieGmarketBold12)
                                .foregroundStyle(sumOfAllExpenses > 4000 ? Color.cookieRed : Color.black.opacity(0.7))
                            Spacer(minLength: 0)
                        }
                        .padding(.vertical, 4)
                        .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text("입니다")
                            .font(.cookieGmarketMedium12)
                            .foregroundStyle(Color.black.opacity(0.7))
                    }
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 20)
                .background(Color.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Button {
                    withAnimation {
                        showStats.toggle()
                    }
                } label: {
                    Image(systemName: "chevron.up")
                        .resizable()
                        .frame(width: 60, height: 14)
                        .foregroundStyle(Color.gray)
                }
            }
            
            HStack {
                Text("오늘 총 소비")
                    .font(.cookieGmarketMedium12)
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    Text("\(Int(sumOfAllExpenses))")
                        .font(.cookieGmarketBold28)
                    
                    Text("바트")
                        .font(.cookieGmarketMedium12)
                        .offset(y: -2)
                }
            }
            .foregroundStyle(Color.black.opacity(0.7))
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .background(Color.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    ContentView()
}
