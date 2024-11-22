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
      
    case .firstInput:
      return firstInputError
      
    case .firstNumber:
      return firstNumberError
      
    case .continueNumber:
      return continueNumberError
      
    case .error:
      return stateError
    }
  }
}

//MARK: - CalculatorInputErrorHandler (firstInput)
extension CalculatorInputErrorHandler {
  // firstInput 상태에 대한 입력 검증 메서드
  private func firstInputError(_ input: Character) throws {
    
    guard firstInputVaildInput(input) else {
      throw CalculatorInputError.invalidInput
    }
  }
  
  private func firstInputVaildInput(_ input: Character) -> Bool {
    
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
    
    return isValidInteger
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
  
  private func continueNumberValidInput(_ input: Character) -> Bool {

    return true
  }
  
}

//MARK: - CalculatorInputErrorHandler (error)
extension CalculatorInputErrorHandler {
  
  // stateError 상태에 대한 입력 검증 메서드
  private func stateError(_ input: Character) throws {
    throw CalculatorInputError.unknown
  }
  
}
