//
//  CalculatorView.swift
//  Calculator
//
//  Created by t2023-m0072 on 11/19/24.
//

import Foundation

//MARK: - CalculatorModel
class CalculatorModel {
  
  private(set) var currentInput: String = ""
  
  private(set) var integers: [Int] = []
  
  private(set) var operators: [CalculatorOperator] = []
  
  private lazy var errorHandler: CalculatorInputErrorHandler = .init(calculatorModel: self)
  
  var lastInput: Character? {
    self.currentInput.last
  }
  
  var state: State {
    guard integers.count == operators.count else {
      return .error
    }
    
    switch currentInput {
    case "": return .firstInput
    case "-": return .firstNumber
    default: return .continueNumber
    }
  }
  
  
  // 연산자 열거형
  enum CalculatorOperator: Character, CaseIterable {
    case add = "+"
    case subtract = "-"
    case multiply = "×"
    case divide = "÷"
    
    //연산 메서드를 위한 형태
    var calculateForm: String {
      switch self {
      case .add: return "+"
      case .subtract: return "-"
      case .multiply: return "*"
      case .divide: return "/"
      }
    }
    
    //뷰를 위한 형태
    var viewForm: String {
      String(self.rawValue)
    }
  }
  
  // 상태 열거형
  enum State: Equatable {
    // 첫 번째 입력 대기 (-,1...9 입력 가능)
    case firstInput
    // 첫 번째 숫자 입력 대기 (1...9 입력 가능)
    case firstNumber
    // 모든 계산기 입력 처리 가능
    case continueNumber
    // 에러 상태
    case error
  }
  
  // 입력 데이터 형태 열거형
  enum InputForm {
    case calculate
    case view
  }
  
}


//MARK: - CalculatorModel (input)
extension CalculatorModel {
  
  //외부 사용 메서드
  func input(_ str: String) throws -> String {
    
    //AC를 입력받을 경우 reset 후 "0"을 반환
    guard str != "AC" else {
      reset()
      return wholeInput(form: .view)
    }
    
    let input = Character(str)
    
    //입력값을 검증
    try errorHandler.verifyError(of: input)
    
    //입력값 처리
    let result = try inputMethod(input)
    
    //뷰를 위한 반영 결과 반환
    return result
  }
  
}


//MARK: - CalculatorModel (inputMethod)
extension CalculatorModel {
  
  //입력 처리 메서드
  private func inputMethod(_ input: Character) throws -> String {
    if input == "=" {
      return try inputEqual()
    }
    
    if let integer = Int(String(input)) {
      inputInteger(integer)
      
    } else if (state == .firstInput), input == "-" {
      inputMinus()
      
    } else if let calculateOperator = CalculatorOperator(rawValue: input) {
      try inputOperator(calculateOperator)
    }
    
    return self.wholeInput(form: .view)
  }
  
}


//MARK: - CalculatorModel input 형태별 지원 메서드
extension CalculatorModel {
  
  //연산자를 입력받는 경우
  private func inputOperator(_ calculatorOperator: CalculatorOperator) throws {
    
    // 정수형으로 생성 가능한지 검증 (OverFlow, UnderFlow)
    guard let integer = Int(self.currentInput) else {
      reset()
      throw CalculateError.excursion
    }
    
    //현재 입력값 초기화
    self.currentInput = ""
    
    //정수와 연산자가 저장된 배열에 append
    self.integers.append(integer)
    self.operators.append(calculatorOperator)
  }
  
  //"="을 입력받을 경우
  private func inputEqual() throws -> String {
    
    //연산을 위한 전체 문자열 연산
    let wholeInput = self.wholeInput(form: .calculate)
    //문자열을 통한 결과값 계산
    let result = try self.calculate(expression: wholeInput)
    let strResult = String(result)
    
    return strResult
  }
  
  //연산자가 아닌 "-"를 입력받는 경우
  private func inputMinus() {
    currentInput += "-"
  }
  
  //숫자를 입력받는 경우
  private func inputInteger(_ int: Int) {
    currentInput += String(int)
  }
  
  //계산기 저장 데이터 리셋
  private func reset() {
    self.operators = []
    self.integers = []
    self.currentInput = ""
  }
}


//MARK: - CalculatorModel (wholeInput): View와 calculate메서드를 위한 형태 제공 메서드
extension CalculatorModel {
  
  //currentInput, integers, operators를 통해 전체 문자열 반환
  private func wholeInput(form: InputForm) -> String {
    var wholeInput = ""
    
    // integers와 operators를 문자열 연산을 위한 형태로 저장
    let integersForm = self.integers.map { String ($0) }
    let formOperators = (form == .view) ? self.operators.map { $0.viewForm } : self.operators.map { $0.calculateForm }
    
    integersForm.enumerated().forEach { integer in
      wholeInput += integer.element
      wholeInput += formOperators[integer.offset]
    }
    
    wholeInput += currentInput
    
    //전체 입력값이 비어있는 경우 "0", 아닌 경우 연산된 전체 문자열 반환
    return !wholeInput.isEmpty ? wholeInput : "0"
  }
  
}

extension CalculatorModel {
  
  //문자열을 통한 연산 메서드
  private func calculate(expression: String) throws -> Int {
    
    //연산이 끝난 후 공통적으로 호출
    defer { reset() }
    
    //0으로 나눌 경우에 대해 Error throw
    guard !expression.contains("/0") else {
      throw CalculateError.divideByZero
    }
    
    let expression = NSExpression(format: expression)
    
    if let result = expression.expressionValue(with: nil, context: nil) as? Int {
      return result
    } else {
      throw CalculateError.calculateFail
    }
  }
  
}
