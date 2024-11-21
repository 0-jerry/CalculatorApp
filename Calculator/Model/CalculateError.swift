//
//  CalculateError.swift
//  Calculator
//
//  Created by t2023-m0072 on 11/21/24.
//

import Foundation

enum CalculateError: Error, CustomStringConvertible {
  //0으로 나눌 경우
  case divideByZero
  //연산 실패
  case calculateFail
  //Int 범위 초과
  case excursion
  //알 수 없는 에러
  case unknown
  
  var description: String {
    switch self {
    case .divideByZero: return "0으로 나눔"
    case .calculateFail: return "연산 실패"
    case .excursion: return "범위 초과"
    case .unknown: return "알 수 없는 에러"
    }
  }
}
