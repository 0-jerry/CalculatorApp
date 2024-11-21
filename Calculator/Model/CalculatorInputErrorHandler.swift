//
//  CalculatorInputErrorHandler.swift
//  Calculator
//
//  Created by t2023-m0072 on 11/21/24.
//

import Foundation

//MARK: - CalculatorInputErrorHandler 입력 에러 검증 객체
class CalculatorInputErrorHandler {
  
  private var calculatorModel: CalculatorModel
  
  private var calculatorState: CalculatorModel.State {
    self.calculatorModel.state
  }
  
  private var lastInput: Character? {
    calculatorModel.lastInput
  }
  
  private var integersCount: Int {
    calculatorModel.integers.count
  }
  
  private var operatorsCount: Int {
    calculatorModel.operators.count
  }
  
  private let validFirstInteger: Set<Character> = ["1","2","3","4","5",
                                                   "6","7","8","9"]
  
  init(calculatorModel: CalculatorModel) {
    self.calculatorModel = calculatorModel
  }
  
  // 외부 사용 메서드
  func verifyError(of input: Character) throws {
    
    let verifyError = methodNavigate()
    
    try verifyError(input)
  }
  
  // calculatorState별 에러 검증 메서드 반환
  private func methodNavigate() -> ((Character) throws -> Void) {
    switch calculatorState {
    case .initial:
      return initialError
      
    case .firstNumber:
      return firstNumberError
      
    case .continueNumber:
      return continueNumberError
      
    case .error:
      return stateError
    }
  }
}

//MARK: - CalculatorInputErrorHandler (initial)
extension CalculatorInputErrorHandler {

  // initial 상태에 대한 입력 검증 메서드
  private func initialError(_ input: Character) throws {
    
    guard initialValidInput(input) else {
      throw CalculatorInputError.invalidInput }
  }
  
  private func initialValidInput(_ input: Character) -> Bool {
    
    let isValidInteger: Bool = validFirstInteger.contains(input)
    
    let isMinus: Bool = input == "-"
    
    return isValidInteger || isMinus
  }

}
 
//MARK: - CalculatorInputErrorHandler (firstNumber)
extension CalculatorInputErrorHandler {
  
  // firstNumber 상태에 대한 입력 검증 메서드
  private func firstNumberError(_ input: Character) throws {
    
    guard firstNumberValidInput(input) else {
      throw CalculatorInputError.invalidInput
    }
  }
  
  private func firstNumberValidInput(_ input: Character) -> Bool {
    
    let isValidInteger: Bool = validFirstInteger.contains(input)
    
    let isMinus: Bool = input == "-"
    
    return isValidInteger || isMinus
  }
  
}
 
//MARK: - CalculatorInputErrorHandler (continueNumber)
extension CalculatorInputErrorHandler {
  
  // continueNumberError - continueNumber 상태에 대한 입력 검증 메서드
  private func continueNumberError(_ input: Character) throws {
    
    guard continueNumberValidInput(input) else {
      throw CalculatorInputError.invalidInput
    }
  }
  
  // continueNumberValidInput - 
  private func continueNumberValidInput(_ input: Character) -> Bool {
    let lastInputIsMinus = self.lastInput == "-"
    
    if lastInputIsMinus {
      let isValidInteger: Bool = validFirstInteger.contains(input)
      return isValidInteger
    } else {
      return true
    }
  }
  
}
 
//MARK: - CalculatorInputErrorHandler (error)
extension CalculatorInputErrorHandler {
  
  // stateError 상태에 대한 입력 검증 메서드
  private func stateError(_ input: Character) throws {
    throw CalculatorInputError.unknown
  }
  
}

enum CalculatorInputError: Error, CustomStringConvertible {
  
  case invalidInput
  case unknown
  
  var description: String {
    switch self {
    case .invalidInput: return "부적합한 입력"
    case .unknown: return "알 수 없는 에러"
    }
  }
}

import UIKit

// 미리보기
#Preview("CalculatorViewController") {
  CalculatorViewController()
}
