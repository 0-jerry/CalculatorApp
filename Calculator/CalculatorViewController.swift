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
        inputTextLabel.font = .boldSystemFont(ofSize: 60)
        inputTextLabel.textAlignment = .right
        inputTextLabel.text = "0"
        inputTextLabel.textColor = .white
        inputTextLabel.backgroundColor = .clear
    }
    
    
    //버튼 격자 스택 뷰
    private var gridStackView = UIStackView().then { gridStackView in
        gridStackView.axis = .vertical
        gridStackView.alignment = .center
        gridStackView.distribution = .fillEqually
        gridStackView.backgroundColor = .clear
        gridStackView.spacing = 10
    }
    
    
    //격자 사이즈
    private var countOfButtonRow: Int {
        guard gridButtonTitles.count > 0 else { return 0 }
        return gridButtonTitles[0].count
    }
    private var countOfButtonLine: Int { gridButtonTitles.count }
    
    
    // 버튼 반영 라벨
    private let gridButtonTitles: [[String]] = [["7","8","9","+"],
                                                ["4","5","6","−"],
                                                ["1","2","3","×"],
                                                ["AC","0","=","÷"]]
    
    
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
        
        setUpInputLabel()
        setUpGridStackView()
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
            textLabel.leading.trailing.equalToSuperview().inset(30)
            textLabel.top.equalTo(self.view).offset(300)
            textLabel.height.equalTo(100)
        }
    }
}


//MARK: - gridStackView 격자 스택 뷰 설정
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
            stackView.width.equalTo(350)
            stackView.top.equalTo(self.inputTextLabel.snp.bottom).offset(60)
            stackView.centerX.equalTo(self.view)
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
            stackView.spacing = 10
            stackView.axis = .horizontal
        }
        
        let buttons = makeCalculatorButtonArray(titles)
        
        for button in buttons {
            stackView.addArrangedSubview(button)
        }
        
        return stackView
    }
    
    // 버튼 배열 생성
    private func makeCalculatorButtonArray(_ titles: [String]) -> [UIButton] {
        titles.map { title in
            makeCalculatorButton(title)
        }
    }
    
    // 버튼 생성
    private func makeCalculatorButton(_ title: String) -> UIButton {
        let button = CalculatorButton()
        self.view.addSubview(button)
        button.setData(title)
        return button
    }
}


//MARK: -
extension CalculatorViewController {
    
    
    //FIXME: 버튼 타겟 액션
    //1. 예외처리 (연산자를 입력받을 경우)
    //2. 연산 메서드 (= 버튼 입력 시)
    //3. 추상화: AC / = / 연산자 / 숫자 로 메서드 분리
    @objc private func touchInsideButton(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else {
            return
        }
        
        switch text {
        case "AC":
            touchACButton()
            
        case "=":
            //입력 연산처리 메서드 필요
            touchEqualButton()
            
        case "+","−","×","÷":
            touchOperatorButton()
            
        default:
            touchIntButton()
        }
    }
    
}

//MARK: - 버튼 별 메서드 구현
extension CalculatorViewController {
    
    private func touchIntButton() {
        
    }
    
    private func touchOperatorButton() {
        
    }
    
    private func touchACButton() {
        
    }
    
    private func touchEqualButton() {
        
    }
  
  @objc private func touchInsideButton(_ sender: CalculatorButton) {
    guard let input = sender.buttonTitle else { return }
    
    do {
      let result = try self.calculator.input(input)
      self.inputLabelUpdate(result)
      
    } catch let error as CalculatorError {
      let description = String(describing: error)
      self.inputLabelUpdate(description)
      
    } catch CalculatorInputError.invalidInput {
      return
      
    } catch let error {
      print(error)
      return
    }
  }
}


//MARK: - 미리보기

#Preview("CalculatorViewController") {
  CalculatorViewController()
}

