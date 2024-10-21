//
//  ContentView.swift
//  BetaCookie
//
//  Created by Anjin on 10/20/24.
//

import SwiftUI

struct CookieOffset {
    var x: CGFloat
    var y: CGFloat
    var rotation: CGFloat
}

struct ContentView: View {
    @State private var expense: String = ""
    
    @State private var expensesAnimation: [Bool] = []
    @State private var expenses: [Double] = []
    var sumOfAllExpenses: Double {
        expenses.reduce(0, +)
    }
    
    private let todayBudget: Double = 4_000 // 하루 예산
    @State private var newExpenseValue: Double = 0.0 // 소비 금액
    private var expenseRatioByBudget: Double {
        newExpenseValue / todayBudget
    }
    
    @State private var down: Bool = true
//    let offsets: [[Int]] = [[-90, -60, 40], [180, 80, 40]]
    let offsets: [CookieOffset] = [CookieOffset(x: -60, y: 40, rotation: -90),
                                   CookieOffset(x: 80, y: 40, rotation: 180),
                                   CookieOffset(x: -120, y: 0, rotation: 90),
                                   CookieOffset(x: 120, y: 0, rotation: 90),
                                   CookieOffset(x: -140, y: 0, rotation: 230)]
    
    var body: some View {
//        ScrollView {
        ZStack {
            VStack {
                Spacer()
                
                let radius: CGFloat = 100
                let handleRadius: CGFloat = 15
                
                ZStack {
                    ForEach(expenses.indices, id: \.self) { index in
                        DonutsShape(startAngle: .degrees(0), endAngle: .degrees(360 * (expenses[index] / todayBudget)), innerRadiusRatio: 0.60)
                            .fill(expenses[...index].reduce(0, +) > todayBudget ? Color.cookieRed : Color.cookieYellow)
                            .stroke(expenses[...index].reduce(0, +) > todayBudget ? Color.cookieRed : Color.cookieYellow, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))  // 외곽선과 선 두께 설정
                            .frame(width: 2 * (radius + handleRadius), height: 2 * (radius + handleRadius))
                            .offset(x: 0, y: 0)
                            .rotationEffect(.degrees(expensesAnimation[index] ? 40 : offsets[index % 5].rotation))
                            .offset(x: expensesAnimation[index] ? offsets[index % 5].x : 30, y: expensesAnimation[index] ? (offsets[index % 5].y + (CGFloat(index / 5) * -80)) : -200)
                            .opacity(expensesAnimation[index] ? 1.0 : 0.0)
                    }
                    
//                    DonutsShape(startAngle: .degrees(0), endAngle: .degrees(60), innerRadiusRatio: 0.60)
//                        .fill(Color(red: 1, green: 0.85, blue: 0.37))
//                        .stroke(Color(red: 1, green: 0.85, blue: 0.37), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))  // 외곽선과 선 두께 설정
//                        .frame(width: 2 * (radius + handleRadius), height: 2 * (radius + handleRadius))
//                        .offset(x: -136, y: 44)
//                        .rotationEffect(.degrees(300))
//                    
//                    DonutsShape(startAngle: .degrees(0), endAngle: .degrees(64), innerRadiusRatio: 0.60)
//                        .fill(Color(red: 1, green: 0.85, blue: 0.37))
//                        .stroke(Color(red: 1, green: 0.85, blue: 0.37), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))  // 외곽선과 선 두께 설정
//                        .frame(width: 2 * (radius + handleRadius), height: 2 * (radius + handleRadius))
//                        .offset(x: 100, y: 0)
//                        .rotationEffect(.degrees(20))
//                    
//                    DonutsShape(startAngle: .degrees(0), endAngle: .degrees(160), innerRadiusRatio: 0.60)
//                        .fill(Color(red: 1, green: 0.85, blue: 0.37))
//                        .stroke(Color(red: 1, green: 0.85, blue: 0.37), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))  // 외곽선과 선 두께 설정
//                        .frame(width: 2 * (radius + handleRadius), height: 2 * (radius + handleRadius))
//                        .offset(x: -70, y: 80)
//                        .rotationEffect(.degrees(30))
                }
            }
            .padding(.bottom, 92)
            
            VStack(spacing: 28) {
                // "DAY3 지출", 리셋버튼
                TitleView {
                    expenses = []
                    expensesAnimation = []
                    newExpenseValue = 0
                }
                
                VStack(spacing: 0) {
                    // TextField
                    VStack(spacing: 8) {
                        HStack(spacing: 4) {
                            Text("태국(THB)")
                                .font(.cookieGmarketMedium15)
                            
                            Image(systemName: "chevron.down")
                                .font(.system(size: 10))
                            
                            Spacer()
                            
                            Text("1바트 = 41원")
                                .font(.cookieGmarketLight12)
                        }
                        .padding(.horizontal, 12)
                        
                        HStack {
//                            TextField("\(Int(newExpenseValue))", text: $expense)
//                                .font(.cookieGmarketMedium26)
//                                .keyboardType(.numberPad)
                            
                            Text("\(Int(newExpenseValue))")
                                .font(.cookieGmarketMedium26)
                                .foregroundColor(.black.opacity(newExpenseValue > 0 ? 1.0 : 0.2))
                            
                            Spacer()
                            
                            Button {
                                expensesAnimation.append(false)
                                expenses.append(newExpenseValue)
                                
                                withAnimation(Animation.easeInOut(duration: 0.6)) {
                                    expensesAnimation[expensesAnimation.count - 1] = true
                                }
                                
                                newExpenseValue = 0
                            } label: {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 26)).bold()
                                    .foregroundColor(.black.opacity(newExpenseValue > 0 ? 1.0 : 0.2))
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background {
                            if newExpenseValue > 0 {
                                if (sumOfAllExpenses + newExpenseValue) / todayBudget > 1 {
                                    Color.red
                                } else {
                                    Color.cookieYellow
                                }
                            } else {
                                Color.cardBackground
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    // 원 전체
                    ZStack {
                        ZStack(alignment: .top) {
                            ZStack {
                                // 초록색
                                ZStack {
                                    Circle()
                                        .trim(from: 0, to: ((todayBudget - expenses.reduce(0, +) - newExpenseValue) / todayBudget))
                                        .rotation(.degrees(270))
                                        .stroke(Color.white, lineWidth: 64)
                                    
                                    Circle()
                                        .trim(from: 0, to: ((todayBudget - expenses.reduce(0, +) - newExpenseValue) / todayBudget))
                                        .rotation(.degrees(270))
                                        .stroke(AngularGradient(
                                            stops: [
                                                Gradient.Stop(color: Color(red: 0.47, green: 0.63, blue: 0.38), location: 0.00),
                                                Gradient.Stop(color: Color(red: 0.31, green: 0.56, blue: 0.42), location: 1.00),
                                            ],
                                            center: UnitPoint(x: 0.5, y: 0.5),
                                            angle: Angle(degrees: 270)
                                        ), lineWidth: 60)
                                }
                                .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                                
                                // 회색
                                ForEach(expenses.indices.reversed(), id: \.self) { index in
                                    ZStack {
                                        Circle()
                                            .trim(from: expenseRatioByBudget, to: (expenses.reversed()[...index].reduce(0, +) / todayBudget) + expenseRatioByBudget + 0.004)
                                            .rotation(.degrees(270))
                                            .stroke(Color.white, lineWidth: 64)
                                        
                                        Circle()
                                            .trim(from: expenseRatioByBudget, to: (expenses.reversed()[...index].reduce(0, +) / todayBudget) + expenseRatioByBudget)
                                            .rotation(.degrees(270))
                                            .stroke((expenses.reversed()[index...].reduce(0, +) / todayBudget) >= 1.0 ? Color(red: 0.48, green: 0.48, blue: 0.48) : Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 60)
                                    }
                                }
                                
                                // 노란색
                                Circle()
                                    .trim(from: ((expenses.reduce(0, +) + newExpenseValue) / todayBudget) >= 1 ? (expenseRatioByBudget + (expenses.reduce(0, +) / todayBudget) - 1.0) : 0, to: expenseRatioByBudget)
                                    .rotation(.degrees(270))
                                    .stroke(Color.cookieYellow, lineWidth: 64)
                                
                                // 빨간색
                                if newExpenseValue > 0 {
                                    Circle()
                                        .trim(from: 0, to: ((expenses.reduce(0, +) + newExpenseValue) / todayBudget) >= 1 ? (expenseRatioByBudget + (((expenses.reduce(0, +)) / todayBudget) >= 1 ? 0 : (expenses.reduce(0, +) / todayBudget) - 1.0)) : (expenseRatioByBudget - 1))
                                        .rotation(.degrees(270))
                                        .stroke(Color.cookieRed, lineWidth: 64)  // 외곽선과 선 두께 설정
                                }
                                
                                //                                    Circle()
                                //                                        .fill(Color.blue)
                                //                                        .frame(width: handleRadius * 2, height: handleRadius * 2)
                                //                                        .offset(x: getHandlePosition().x, y: getHandlePosition().y)
                                //                                        .gesture(
                                //                                            DragGesture()
                                //                                                .onChanged { gesture in
                                //                                                    self.updateAngle(for: gesture.location)
                                //                                                }
                                //                                        )
                                //                                        .animation(.easeInOut, value: angle)  // 애니메이션 추가
                                //
                                //                                    Text(String(format: "%.0f", sliderValue))
                                //                                        .font(.title)
                                //                                        .foregroundColor(.black)
                                //                                        .offset(y: radius + 40)
                            }
                            
                            VStack {
                                Rectangle()
                                    .frame(width: 2, height: 80)
                                    .foregroundStyle(Color.white)
                                
                                Spacer()
                                
                                Slider(value: $newExpenseValue, in: 0...8000, step: 1)
                                    .padding(.horizontal, 40)
                            }
                        }
                        .padding(.horizontal, 32)
                        .frame(height: UIScreen.main.bounds.width - 24)
                        //                    .background { Color.red }
                        
                        // 원 가운데 글자
                        VStack {
                            Text("DAY3 예산 \(Int(todayBudget))")
                                .font(.cookieGmarketLight12)
                            
                            HStack {
                                Text("\(Int(todayBudget - newExpenseValue - sumOfAllExpenses))")
                                    .font(.cookieGlodok32)
                                
                                Text("바트")
                                    .font(.cookieGmarketMedium12)
                            }
                            
                            Text("(\(Int(todayBudget - newExpenseValue - sumOfAllExpenses) * 41)원)")
                                .font(.cookieGmarketLight12)
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    
                    // 분석 화면 - 통계, 오늘 총 소비
                    AnalysisView(sumOfAllExpenses: sumOfAllExpenses)
                }
                .padding(.bottom, 8)
                //                .background(Color.red)
            }
            .padding(.horizontal, 28)
            .padding(.top, 30)
        }
        .background(Color.background)
        .ignoresSafeArea(.keyboard)
//        }
//        .background {
//            Color.background
//                .ignoresSafeArea()
//        }
    }
}

#Preview {
    ContentView()
}

struct TitleView: View {
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text("DAY3 지출")
                .font(.cookieGmarketMedium32)
            
            Spacer()
            
            Button {
                action()
            } label: {
                Image(systemName: "list.bullet")
                    .font(.system(size: 26))
                    .foregroundStyle(Color.black)
            }
        }
    }
}
