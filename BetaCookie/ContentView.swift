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

//#Preview {
//    ContentView()
//}

extension Color {
    static let background = Color(uiColor: UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1))
    
    static let cardBackground = Color(uiColor: UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1))
}

struct DonutShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var thickness: CGFloat = 40

    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        var path = Path()
        
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )
        
        path.addArc(
            center: center,
            radius: radius - thickness,
            startAngle: endAngle,
            endAngle: startAngle,
            clockwise: true
        )
        
        path.closeSubpath()
        
        return path
    }
}

struct RotatableDonutChartView: View {
    @State private var rotationAngle: Angle = .zero

    var body: some View {
        ZStack {
            DonutShape(startAngle: .degrees(0), endAngle: .degrees(120))
                .fill(Color.blue)
            DonutShape(startAngle: .degrees(120), endAngle: .degrees(240))
                .fill(Color.green)
            DonutShape(startAngle: .degrees(240), endAngle: .degrees(360))
                .fill(Color.red)
        }
        .frame(width: 200, height: 200)
        .rotationEffect(rotationAngle)
        .gesture(
            RotationGesture()
                .onChanged { angle in
                    self.rotationAngle = angle
                    print(angle)
                }
        )
        .animation(.easeInOut, value: rotationAngle)
    }
}

#Preview {
//    RotatableDonutChartView()
//    Content2View()
//    DraggableCircle()
    CircularSlider()
}

struct Content2View: View {
    @State private var angle: Angle = .degrees(0)
    
    var body: some View {
        Rectangle()
            .fill(Color.blue)
            .frame(width: 150, height: 100)
            .rotationEffect(angle)
            .gesture(
//                RotationGesture()
//                    .onChanged { angle in
//                        self.angle = angle
//                    }
                DragGesture()
            )
    }
}

struct DraggableCircle: View {
    // 드래그된 오프셋 값을 저장할 변수
    @State private var dragOffset = CGSize.zero

    var body: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: 100, height: 100)
            .offset(dragOffset)  // 드래그한 만큼 오프셋을 이동
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        // 드래그 중일 때 위치를 업데이트
                        dragOffset = gesture.translation
                    }
                    .onEnded { _ in
                        // 드래그가 끝나면, 원하는 동작을 추가 가능
                    }
            )
    }
}

import SwiftUI

struct CircularSlider: View {
    @State private var angle: Double = 0.0
    let radius: CGFloat = 100
    let handleRadius: CGFloat = 15

    var sliderValue: Double {
        return angle / 360 * 100
    }
    
    @State private var expenses: [Double] = []
    
    private let todayBudget: Double = 150_000 // 하루 예산
    @State private var newExpenseValue: Double = 0.0 // 소비 금액
    private var expenseRatioByBudget: Double {
        newExpenseValue / todayBudget
    }

    var body: some View {
        VStack {
            Text("하루 예산: \(Int(todayBudget))원")
            Text("소비 금액: \(Int(newExpenseValue))원")
            Text("하루 예산 대비 소비 금액 비율: \(expenseRatioByBudget)")
            HStack {
                Text("소비 금액")
                ForEach(expenses.indices, id: \.self) { index in
                    Text("\(index + 1): \(Int(expenses[index]))")
                }
            }
            
            Button {
                expenses.append(newExpenseValue)
                newExpenseValue = 0
            } label: {
                Text("소비 확정 버튼")
            }
            
            Slider(value: $newExpenseValue, in: 0...500000, step: 100)
                .padding(.horizontal, 40)
                .padding(.bottom, 100)
            
//            Spacer()
            
            ZStack {
                ZStack {
                    Circle()
                        .trim(from: 0, to: ((todayBudget - expenses.reduce(0, +) - newExpenseValue) / todayBudget))
                        .rotation(.degrees(270))
                        .stroke(Color.white, lineWidth: 64)
                        .frame(width: radius * 2.5, height: radius * 2.5)
                    
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
                        .frame(width: radius * 2.5, height: radius * 2.5)
                }
                .rotation3DEffect(.degrees(180), axis: (x: 0.0, y: 1.0, z: 0.0))
                
                ForEach(expenses.indices.reversed(), id: \.self) { index in
                    ZStack {
                        Circle()
                            .trim(from: expenseRatioByBudget, to: (expenses.reversed()[...index].reduce(0, +) / todayBudget) + expenseRatioByBudget + 0.004)
                            .rotation(.degrees(270))
                            .stroke(Color.white, lineWidth: 64)
                            .frame(width: radius * 2.5, height: radius * 2.5)
                        
                        Circle()
                            .trim(from: expenseRatioByBudget, to: (expenses.reversed()[...index].reduce(0, +) / todayBudget) + expenseRatioByBudget)
                            .rotation(.degrees(270))
                            .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 60)
                            .frame(width: radius * 2.5, height: radius * 2.5)
                    }
                    
                    // numbers[startIndex...].reduce(0, +)
                }
                
                // 노란색
                Circle()
                    .trim(from: ((expenses.reduce(0, +) + newExpenseValue) / todayBudget) >= 1 ? (expenseRatioByBudget + (expenses.reduce(0, +) / todayBudget) - 1.0) : 0, to: expenseRatioByBudget)
                    .rotation(.degrees(270))
                    .stroke(Color(red: 1, green: 0.85, blue: 0.37), lineWidth: 64)
                    .frame(width: radius * 2.5, height: radius * 2.5)
                
                // 빨간색
                Circle()
                    .trim(from: 0, to: ((expenses.reduce(0, +) + newExpenseValue) / todayBudget) >= 1 ? (expenseRatioByBudget + (expenses.reduce(0, +) / todayBudget) - 1.0) : (expenseRatioByBudget - 1))
                    .rotation(.degrees(270))
                    .stroke(Color.red, lineWidth: 64)  // 외곽선과 선 두께 설정
                    .frame(width: radius * 2.5, height: radius * 2.5)
                
                Rectangle()
                    .frame(width: 2, height: 80)
                    .offset(y: -radius - 34)
                
                //            Circle()
                //                .fill(Color.blue)
                //                .frame(width: handleRadius * 2, height: handleRadius * 2)
                //                .offset(x: getHandlePosition().x, y: getHandlePosition().y)
                //                .gesture(
                //                    DragGesture()
                //                        .onChanged { gesture in
                //                            self.updateAngle(for: gesture.location)
                //                        }
                //                )
                //                .animation(.easeInOut, value: angle)  // 애니메이션 추가
                //
                //            Text(String(format: "%.0f", sliderValue))
                //                .font(.title)
                //                .foregroundColor(.black)
                //                .offset(y: radius + 40)
            }
            .frame(width: 2 * (radius + handleRadius), height: 2 * (radius + handleRadius))
            
            ZStack {
                DonutsShape(startAngle: .degrees(0), endAngle: .degrees(60), innerRadiusRatio: 0.60)
                    .fill(Color(red: 1, green: 0.85, blue: 0.37))
                    .stroke(Color(red: 1, green: 0.85, blue: 0.37), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))  // 외곽선과 선 두께 설정
                    .frame(width: 2 * (radius + handleRadius), height: 2 * (radius + handleRadius))
                    .offset(x: -134, y: 40)
                    .rotationEffect(.degrees(300))
                
                DonutsShape(startAngle: .degrees(0), endAngle: .degrees(60), innerRadiusRatio: 0.60)
                    .fill(Color(red: 1, green: 0.85, blue: 0.37))
                    .stroke(Color(red: 1, green: 0.85, blue: 0.37), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))  // 외곽선과 선 두께 설정
                    .frame(width: 2 * (radius + handleRadius), height: 2 * (radius + handleRadius))
                    .offset(x: 90, y: 0)
                    .rotationEffect(.degrees(20))
                
                DonutsShape(startAngle: .degrees(0), endAngle: .degrees(160), innerRadiusRatio: 0.60)
                    .fill(Color(red: 1, green: 0.85, blue: 0.37))
                    .stroke(Color(red: 1, green: 0.85, blue: 0.37), style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))  // 외곽선과 선 두께 설정
                    .frame(width: 2 * (radius + handleRadius), height: 2 * (radius + handleRadius))
                    .offset(x: -70, y: 80)
                    .rotationEffect(.degrees(30))
            }
        }
    }

    func getHandlePosition() -> CGPoint {
        let xPos = radius * cos(angle * .pi / 180)
        let yPos = radius * sin(angle * .pi / 180)
        return CGPoint(x: xPos, y: yPos)
    }

    func updateAngle(for location: CGPoint) {
        let vector = CGVector(dx: location.x - radius, dy: location.y - radius)
        let angleInRadians = atan2(vector.dy, vector.dx)
        let angleInDegrees = angleInRadians * 180 / .pi
        angle = angleInDegrees >= 0 ? angleInDegrees : 360 + angleInDegrees
    }
}

import SwiftUI

struct DonutsShape: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var innerRadiusRatio: CGFloat // 내부 원의 비율 (구멍 크기)

    func path(in rect: CGRect) -> Path {
        let radius = min(rect.width, rect.height) / 2
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let innerRadius = radius * innerRadiusRatio

        var path = Path()

        // 바깥쪽 원호
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false
        )

        // 안쪽 원호로 이어지기 위해서 선을 연결
        path.addLine(
            to: CGPoint(
                x: center.x + innerRadius * cos(CGFloat(endAngle.radians)),
                y: center.y + innerRadius * sin(CGFloat(endAngle.radians))
            )
        )

        // 안쪽 원호
        path.addArc(
            center: center,
            radius: innerRadius,
            startAngle: endAngle,
            endAngle: startAngle,
            clockwise: true
        )

        // 다시 바깥쪽 원호 시작점으로 이어서 닫기
        path.addLine(
            to: CGPoint(
                x: center.x + radius * cos(CGFloat(startAngle.radians)),
                y: center.y + radius * sin(CGFloat(startAngle.radians))
            )
        )

        return path
    }
}
