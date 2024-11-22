//
//  ViewController.swift
//  Calculator
//
//  Created by t2023-m0072 on 11/11/24.
//

import UIKit
import SnapKit
import Then

//MARK: - 계산기 뷰 컨트롤러
class CalculatorViewController: UIViewController {
  
  override var textInputContextIdentifier: String? {
    "CalculatorViewController"
  }
  
  //입력 반영 라벨
  private var inputTextLabel = UILabel().then { inputTextLabel in
    inputTextLabel.font = .boldSystemFont(ofSize: UIStyle().fontSize * 1.8)
    inputTextLabel.textAlignment = .right
    inputTextLabel.text = "0"
    inputTextLabel.textColor = .white
    inputTextLabel.backgroundColor = .clear
    inputTextLabel.adjustsFontSizeToFitWidth = true
    inputTextLabel.minimumScaleFactor = 0.7
  }
  
  //버튼 격자 스택 뷰
  private var gridStackView = UIStackView().then { gridStackView in
    gridStackView.axis = .vertical
    gridStackView.alignment = .center
    gridStackView.distribution = .fillEqually
    gridStackView.backgroundColor = .clear
    gridStackView.spacing = UIStyle().spacing
  }
  
  // 버튼 반영 라벨
  private let gridButtonTitles: [[String]] = [["7","8","9","+"],
                                              ["4","5","6","-"],
                                              ["1","2","3","×"],
                                              ["AC","0","=","÷"]]
  
  private let calculator = CalculatorModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpUI()
  }
}


//MARK: - Set Up UI
extension CalculatorViewController {
  
  // Set Up UI
  private func setUpUI() {
    self.view.backgroundColor = .black
    
    setUpGridStackView()
    setUpInputLabel()
  }
}


//MARK: - inputLabel 라벨 설정
extension CalculatorViewController {
  
  // 라벨 설정 메서드
  private func setUpInputLabel() {
    self.view.addSubview(inputTextLabel)
    setInputLabelLayout()
  }
  
  // 라벨 레이아웃 설정
  private func setInputLabelLayout() {
    inputTextLabel.snp.makeConstraints { textLabel in
      textLabel.leading.trailing.equalToSuperview().inset(UIStyle().constant)
      textLabel.bottom.equalTo(self.gridStackView.snp.top).inset(-UIStyle().constant)
    }
  }
  
  // 라벨 텍스트 수정
  private func inputLabelUpdate(_ str: String) {
    self.inputTextLabel.text = str
  }
}


//MARK: - 격자 스택 뷰 설정
extension CalculatorViewController {
  
  // 격자 스택 뷰 설정
  private func setUpGridStackView() {
    self.view.addSubview(gridStackView)
    setUpGridStackViewLayout()
    setGridStackViewAddSubview()
  }
  
  // 격자 스택 뷰 레이아웃 설정
  private func setUpGridStackViewLayout() {
    gridStackView.snp.makeConstraints { stackView in
      stackView.leading.trailing.bottom.equalToSuperview().inset(UIStyle().constant)
    }
  }
}


//MARK: - 격자 스택 서브 뷰 설정
extension CalculatorViewController {
  
  // 격자 스택 서브 뷰 설정
  private func setGridStackViewAddSubview() {
    
    let horizontalStackViewArray = makeHorizontalStackViewArray(gridButtonTitles)
    gridStackViewAddSubView(horizontalStackViewArray)
  }
  
  // 격자 스택 뷰에 수평 스택 뷰 추가
  private func gridStackViewAddSubView(_ horizontalStackViewArray: [UIStackView]) {
    return horizontalStackViewArray
      .filter { $0.axis != gridStackView.axis }
      .forEach { gridStackView.addArrangedSubview($0) }
  }
  
  // 수평 스택 뷰 배열 생성
  private func makeHorizontalStackViewArray(_ gridButtonTitles: [[String]]) -> [UIStackView] {
    
    let horizontalStackViewArray = gridButtonTitles
      .map { titles in
        makeHorizontalStackView(titles)
      }
    
    return horizontalStackViewArray
  }
  
  // 수평 스택 뷰 생성
  private func makeHorizontalStackView(_ titles: [String]) -> UIStackView {
    
    let stackView = UIStackView().then { stackView in
      stackView.backgroundColor = .clear
      stackView.alignment = .center
      stackView.distribution = .fillEqually
      stackView.spacing = UIStyle().spacing
      stackView.axis = .horizontal
    }
    
    let buttons = makeCalculatorButtonArray(titles)
    
    for button in buttons { stackView.addArrangedSubview(button) }
    
    return stackView
  }
  
  // 버튼 배열 생성
  private func makeCalculatorButtonArray(_ titles: [String]) -> [UIButton] {
    titles.map { title in makeCalculatorButton(title) }
  }
  
  // 버튼 생성
  private func makeCalculatorButton(_ title: String) -> UIButton {
    
    let button = CalculatorButton()
    self.view.addSubview(button)
    button.setData(title)
    
    button.addTarget(self,
                     action: #selector(touchUpInsideButton),
                     for: .touchUpInside)
    
    return button
  }
}


//MARK: - 버튼 연산 액션
extension CalculatorViewController {
  
  @objc private func touchUpInsideButton(_ sender: CalculatorButton) {
    guard let input = sender.buttonTitle else { return }
    
    do {
      let result = try self.calculator.input(input)
      self.inputLabelUpdate(result)

    } catch CalculatorInputError.invalidInput {
      return
      
    } catch let error as CalculateError {
      let description = String(describing: error)
      self.inputLabelUpdate(description)
      
    } catch {
      let errorMessage = "알 수 없는 에러"
      self.inputLabelUpdate(errorMessage)
      return
    }
  }
}
