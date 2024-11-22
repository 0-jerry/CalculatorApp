//
//  CalculatorButton.swift
//  Calculator
//
//  Created by t2023-m0072 on 11/12/24.
//

import UIKit
import SnapKit
import Then

//MARK: - CalculatorButton 커스텀 계산기 버튼
class CalculatorButton: UIButton {
  
  // 버튼 라벨
  private let buttonLabel = UILabel().then { label in
    label.textAlignment = .center
    label.numberOfLines = 1
    label.textColor = .white
    label.font = .boldSystemFont(ofSize: UIStyle().fontSize)
  }
  
  // 버튼 사이즈
  private let buttonSize: CGFloat = UIStyle().buttonSize
  
  // 버튼 타이틀
  var buttonTitle: String? {
    buttonLabel.text
  }
  
  // addSubview 시 실행
  override func didMoveToSuperview() {
    super.didMoveToSuperview()
    
    setUpUI()
  }
}


//MARK: - CalculatorButton 버튼 데이터 설정

extension CalculatorButton {
  
  // 사용 메서드 버튼 라벨 데이터 설정
  func setData(_ title: String) {
    self.buttonLabel.text = title
    setButtonColor()
  }
  
  
  // 버튼 색상 반영 뷰
  private func setButtonColor() {
    guard let title = self.buttonLabel.text else { return }
    
    let backgroundColor: UIColor
    if nil == Int(title) {
      backgroundColor = .orange
    } else {
      backgroundColor =  UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
    }
    self.backgroundColor = backgroundColor
    
    setConfigurationUpdateHandler()
  }
  
  
  //버튼 상태 별 투명도 설정
  private func setConfigurationUpdateHandler() {
    
    self.configurationUpdateHandler = { button in
      
      if button.state == .highlighted { self.buttonColorAlphaDown() }
      else { self.buttonColorAlphaNormal() }
    }
  }
  
  //버튼이 눌리는 동안 투명도 조절
  private func buttonColorAlphaDown() {
    
    self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.5)
    self.buttonLabel.textColor = self.buttonLabel.textColor.withAlphaComponent(0.1)
  }
  
  //버튼을 기존 색으로 조절
  private func buttonColorAlphaNormal() {
    
    self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
    self.buttonLabel.textColor = self.buttonLabel.textColor.withAlphaComponent(1)
  }
}


//MARK: - CalculatorButton 버튼 Set Up UI

extension CalculatorButton {
  
  // Set Up UI
  private func setUpUI() {
    setUpButtonLayout()
    setUpButtonLabel()
    setRoundCorner()
  }
  
  // 버튼 레이아웃 설정
  private func setUpButtonLayout() {
    self.snp.makeConstraints { buttonView in
      buttonView.size.equalTo(CGSize(width: buttonSize, height: buttonSize))
    }
  }
  
  // 버튼 라벨 설정
  private func setUpButtonLabel() {
    self.addSubview(buttonLabel)
    setButtonLabelLayout()
  }
  
  // 버튼 라벨 레이아웃 설정
  private func setButtonLabelLayout() {
    self.buttonLabel.snp.makeConstraints { label in
      label.centerX.centerY.size.equalTo(self)
    }
  }
  
  // 버튼 둥글기 설정
  private func setRoundCorner() {
    self.layer.cornerRadius = buttonSize / 2
    self.clipsToBounds = true
  }
}
