//
//  CalculatorInputError.swift
//  Calculator
//
//  Created by t2023-m0072 on 11/21/24.
//

import Foundation

//MARK: - CalculatorInputError 계산기 입력 에러 처리
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
