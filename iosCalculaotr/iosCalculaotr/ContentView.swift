//
//  ContentView.swift
//  iosCalculaotr
//
//  Created by JungHoonPark on 2022/05/29.
//

import SwiftUI

enum CalcButtonContent:String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case substract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "+/-"
    
    var buttonColor: Color {
        switch self {
        case .add, .substract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, substract, multiply, divide, none
}



struct ContentView: View {
    
    @State var value = "0"
    @State var runningNum = 0
    @State var currentOperation: Operation = .none
    @State var operationArray = []
    @State var runningNumArray = []
    
    let buttonContentRows: [[CalcButtonContent]] = [
        [.clear,.negative,.percent, .divide],
        [.seven,.eight,.nine, .multiply],
        [.four,.five,.six, .substract],
        [.one,.two,.three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                //InPut
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .frame(width: UIScreen.main.bounds.width, height: 120, alignment: .trailing)
                        .minimumScaleFactor(0.7)
//                        .background(Color.red)
                        .padding(.trailing, 30)
                }
                .padding()
                
                //Buttons
                ForEach(buttonContentRows, id: \.self){ row in
                    HStack(spacing: Constants.buttonSpacing){
                        ForEach(row, id: \.self){ item in
                            Button(action: {
                                self.onTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(item: item), height:self.buttonHeight())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                                    .multilineTextAlignment(.trailing)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func onTap(button: CalcButtonContent){
        
//        let numberFormatter = NumberFormatter()
//        numberFormatter.roundingMode = .floor         // 버림 형식
//        numberFormatter.maximumSignificantDigits = 4  // 자르길 원하는 자릿수
//
//        let valueFormatted = numberFormatter.string(for: value)

        switch button {
            
        case .add:
            self.currentOperation = .add
            self.runningNum = Int(self.value) ?? 0
            self.operationArray.append(Int(self.value) ?? 0)
//            self.runningNumArray.append(Int(self.value) ?? 0)
            self.value = "0"
        case .substract:
            self.currentOperation = .substract
            self.runningNum = Int(self.value) ?? 0
            self.operationArray.append(Int(self.value) ?? 0)
//            self.runningNumArray.append(Int(self.value) ?? 0)
            self.value = "0"
        case .multiply:
            self.currentOperation = .multiply
            self.runningNum = Int(self.value) ?? 0
            self.operationArray.append(Int(self.value) ?? 0)
//            self.runningNumArray.append(Int(self.value) ?? 0)
            self.value = "0"
        case .divide:
            self.currentOperation = .divide
            self.runningNum = Int(self.value) ?? 0
            self.operationArray.append(Int(self.value) ?? 0)
//            self.runningNumArray.append(Int(self.value) ?? 0)
            self.value = "0"
        case .equal:
            let runningValue = self.runningNum
            let currentValue = Int(self.value) ?? 0
            switch self.currentOperation {
            case .add: self.value = "\(runningValue + currentValue)"
            case .substract: self.value = "\(runningValue - currentValue)"
            case .multiply:
                //곱셈과 덧셈이 있다면 곱셈 먼저 계산하도록
                self.value = "\(runningValue * currentValue)"
            case .divide:
                //+-와 같이 있다면 나눗셈 먼저 계산하도록
                self.value = "\(runningValue / currentValue)"
            case .none:
                break
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
        print(operationArray)
    }
    
    func buttonWidth(item: CalcButtonContent) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    func buttonHeight()->CGFloat{
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
