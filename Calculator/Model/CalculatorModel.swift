//
//  CalculatorView.swift
//  Calculator
//
//  Created by t2023-m0072 on 11/19/24.
//

import Foundation
import Then

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
    if currentInput == "0", integers.isEmpty, operators.isEmpty {
      return State.initial
    } else if integers.count == operators.count {
      return currentInput.isEmpty ? State.firstNumber : State.continueNumber
    } else {
      return State.initial
    }
  }
  
  
  // 연산자 열거형
  enum CalculatorOperator: Character, CaseIterable {
    case add = "+"
    case subtract = "-"
    case multiply = "×"
    case divide = "÷"
    
    var calculateForm: String {
      switch self {
      case .add: return "+"
      case .subtract: return "-"
      case .multiply: return "*"
      case .divide: return "/"
      }
    }
    
    var viewForm: String {
      String(self.rawValue)
    }
  }
  
  // 상태 열거형
  enum State: Equatable {
    // 초기 상태
    case initial
    // 첫 번째 입력 대기
    case firstNumber
    // 두 번째 숫자 입력 중인 상태
    case continueNumber
    // 에러 상태
    case error
  }
  
  // 형태 열거형
  enum InputForm {
    case calculate
    case view
  }
}

//MARK: - Input
extension CalculatorModel {
  
  func input(_ str: String) throws -> String {
    
    guard str != "AC" else {
      reset()
      return try wholeInput(form: .view)
    }
    
    
    let char = Character(str)
    try errorHandler.verifyError(of: char)
    let result = try inputMethod(char)
    
    return result
  }
  
}


//MARK: - CalculatorModel (State Method)

extension CalculatorModel {
  
  private func inputMethod(_ input: Character) throws -> String {
    let interger = Int(String(input))
    let isInteger: Bool = interger != nil
    
    let calculateOperator = CalculatorOperator(rawValue: input)
    let isOperator: Bool = calculateOperator != nil
    
    let enableInputMinus: Bool = state == .firstNumber || state == .initial
    let isMinus: Bool = input == "-"
    let isEqual: Bool = input == "="
    
    if isInteger, let integer = interger {
      inputInteger(integer)
    } else if enableInputMinus, isMinus {
      inputMinus()
    } else if isOperator, let calculateOperator = calculateOperator {
      try inputOperator(calculateOperator)
    } else if isEqual {
      return try inputEqual()
    }
    //    } else {
    //      throw CalculatorError.invalid
    //    }
    //
    return try self.wholeInput(form: .view)
  }
  
  
  private func inputOperator(_ calculatorOperator: CalculatorOperator) throws  {
    
    let checkedCurrentInput = currentInput.filter { $0.isNumber || $0 == "-" }
    guard self.currentInput == checkedCurrentInput else {
      reset()
      throw CalculatorError.unknown
    }
    
    guard let integer = Int(self.currentInput) else {
      reset()
      throw CalculatorError.excursion
    }
    
    self.currentInput = ""
    
    self.integers.append(integer)
    self.operators.append(calculatorOperator)
  }
  
  private func inputEqual() throws -> String {
    
    let wholeInput = try self.wholeInput(form: .calculate)
    let result = try self.calculate(expression: wholeInput)
    let strResult = String(result)
    
    reset()
    
    return strResult
  }
  
  private func inputMinus() {
    currentInput += "-"
  }
  
  private func inputInteger(_ int: Int) {
    currentInput += String(int)
  }
  
  private func reset() {
    self.operators = []
    self.integers = []
    self.currentInput = ""
  }
}

//MARK: - CalculatorModel (Form)
extension CalculatorModel {
  
  private func wholeInput(form: InputForm) throws -> String {
    guard integers.count >= operators.count else { throw CalculatorError.unknown }
    
    var wholeInput = ""
    
    var integersForm = self.integers.map { String ($0) }
    var formOperators = (form == .view) ? self.operators.map { $0.viewForm } : self.operators.map { $0.calculateForm }
    
    integersForm.enumerated().forEach { integer in
      wholeInput += integer.element
      wholeInput += formOperators[integer.offset]
    }
    
    wholeInput += currentInput
    
    return wholeInput != "" ? wholeInput : "0"
  }
}

extension CalculatorModel {
  
  private func calculate(expression: String) throws -> Int {
    print(expression)
    guard !expression.contains("/0") else {
      reset()
      throw CalculatorError.divideByZero }
    
    let expression = NSExpression(format: expression)
    
    if let result = expression.expressionValue(with: nil, context: nil) as? Int {
      return result
    } else {
      throw CalculatorError.calculateFail
    }
  }
  
}

enum CalculatorError: Error, CustomStringConvertible {
  
  case divideByZero
  case calculateFail
  case unknown
  case excursion
  
  var description: String {
    switch self {
    case .divideByZero: return "0으로 나눔"
    case .calculateFail: return "연산 실패"
    case .unknown: return "알 수 없는 에러"
    case .excursion: return "범위 초과"
      
      
    }
  }
  
}




//
/*
 1. 문서화 (목표 설정 & 일정 체크)  / 기한 설정 및 피드백을 통한 현 상태 검토 -> 역량 검토?
 2. 간소화 ( or 단계 나누기 ) - 우선 뷰 용 Data 구조 만들기 -> 유저 데이터 반영 방식 (공부) 설정하기
 3. 나누는 시간을 어느정도 가져야 할 것 같다.
 4. 이번주에 어떻게 해야할지?
 */

import UIKit

// 미리보기
#Preview("CalculatorViewController") {
  CalculatorViewController()
}
