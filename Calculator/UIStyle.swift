//
//  Style.swift
//  Calculator
//
//  Created by t2023-m0072 on 11/20/24.
//

import UIKit

//MARK: - UIStyle UI의 사이즈들을 연산해 저장해주는 데이터 형태
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
