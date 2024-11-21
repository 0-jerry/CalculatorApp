//
//  Style.swift
//  Calculator
//
//  Created by t2023-m0072 on 11/20/24.
//

import UIKit

struct UIStyle {
  
  let spacing: CGFloat = UIScreen.main.bounds.width / 50
  
  var constant: CGFloat {
    spacing * 4
  }
  
  var buttonSize: CGFloat {
    let sum = self.constant * 2 + self.spacing * 3
    return (UIScreen.main.bounds.width - sum) / 4
  }
  
  var fontSize: CGFloat {
    buttonSize * 0.4
  }
  
}


// 미리보기
#Preview("CalculatorViewController") {
  CalculatorViewController()
}
