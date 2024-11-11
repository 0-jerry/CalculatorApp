//
//  ViewController.swift
//  Calculator
//
//  Created by t2023-m0072 on 11/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    private var inputTextLabel: UILabel?
    private var stackView: UIStackView?
    
    private let stackViewBlankConstant: CGFloat = 30
    private let stackViewSpacing: CGFloat = 10
    
    private let buttonTitle: [[String]] = [["7","8","9","+"],
                                           ["4","5","6","−"],
                                           ["1","2","3","×"],
                                           ["AC","0","=","÷"]]
                       
    
    private var countOfButtonRow: Int { buttonTitle[0].count }
    private var buttonWidth: CGFloat {
        let width = (self.view.bounds.width - (2 * stackViewBlankConstant) - (3 * stackViewSpacing)) / CGFloat(countOfButtonRow)
        
        return width
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpUI()
    }
}

//MARK: - Set Up UI
extension ViewController {
    
    private func setUpUI() {
        self.view.backgroundColor = .black
        
        setUpInputLabel()
        
        var horizontalStackViews: [UIStackView] = []
        for row in buttonTitle {
            var buttons: [UIButton] = []
            for title in row {
                let button = makeButton(title: title)
                buttons.append(button)
            }
            let horizontalStackView = makeHorizontalStackView(buttons)
            horizontalStackViews.append(horizontalStackView)
        }
        
        setVerticalStackView(horizontalStackViews)
    }
    
    
    //라벨 생성 메서드
    private func setUpInputLabel() {
        let inputTextLabel = UILabel()
        
        self.view.addSubview(inputTextLabel)
        
        inputTextLabel.backgroundColor = .clear
        inputTextLabel.font = .boldSystemFont(ofSize: 60)
        inputTextLabel.textColor = .white
        inputTextLabel.text = "0"
        inputTextLabel.textAlignment = .right
        
        inputTextLabel.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = inputTextLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300)
        let leadingConstraint = inputTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)
        let trailingConstraint = inputTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)
        
        inputTextLabel.frame.size.height = 100
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint])
        
        self.inputTextLabel = inputTextLabel
    }
    
    //수평 스택 뷰 생성
    private func makeHorizontalStackView(_ views: [UIView]) -> UIStackView {
        let stackView = UIStackView()
        
        for view in views {
            stackView.addArrangedSubview(view)
        }
        
        stackView.backgroundColor = .clear
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = stackViewSpacing
        stackView.axis = .horizontal
        
//        stackView.frame.size =
        
        return stackView
    }
    
    private func setVerticalStackView(_ views: [UIStackView]){
        let stackView = UIStackView()
        
        self.view.addSubview(stackView)
        
        views.forEach { view in
            stackView.addArrangedSubview(view)
        }
        
        guard let inputTextLabel = self.inputTextLabel else { return }
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = self.stackViewSpacing
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = stackView.topAnchor.constraint(equalTo: inputTextLabel.bottomAnchor, constant: 60)
        let centerX = stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        stackView.frame.size.width = 350
        
        NSLayoutConstraint.activate([topConstraint, centerX])
    }
    
    
    //버튼 생성
    //TODO: 추상화 필요
    private func makeButton(title: String) -> UIButton {
        let button = UIButton()
        
        if nil != Int(title) {
            button.backgroundColor = UIColor(red: 58/255,
                                             green: 58/255,
                                             blue: 58/255,
                                             alpha: 1.0)
        } else {
            button.backgroundColor = .orange
        }
        
        button.addTarget(self, action: #selector(touchInsideButton), for: .touchUpInside)
        button.setTitle(title, for: .normal)
        
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        button.titleLabel?.textColor = .white
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let width = button.widthAnchor.constraint(equalToConstant: buttonWidth)
        let height = button.heightAnchor.constraint(equalToConstant: buttonWidth)
        NSLayoutConstraint.activate([width, height])
        
        button.layer.cornerRadius = buttonWidth / 2
        button.clipsToBounds = true
        
        return button
    }
    
    //FIXME: 버튼 타겟 액션
    //1. 예외처리 (연산자를 입력받을 경우)
    //2. 연산 메서드 (= 버튼 입력 시)
    //3. 추상화: AC / = / 연산자 / 숫자 로 메서드 분리
    @objc private func touchInsideButton(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else {
            return
        }
        print(sender.titleLabel?.text)
        
        switch text {
        case "AC":
            self.inputTextLabel?.text = "0"
            return
        case "=":
            //입력 연산처리 메서드 필요
            return
        default:
            //에러처리 필요
            self.inputTextLabel?.text = (self.inputTextLabel?.text ?? "") + text
        }
    }

}



//미리보기
#Preview("ViewController") {
    ViewController()
}
