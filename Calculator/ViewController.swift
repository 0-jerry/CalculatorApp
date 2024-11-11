//
//  ViewController.swift
//  Calculator
//
//  Created by t2023-m0072 on 11/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let inputTextLabel = UILabel()
    private let stackView = UIStackView()
    
    private let stackViewBlankConstant: CGFloat = 30
    private let stackViewSpacing: CGFloat = 5
    
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
        setUpStackView()
        for str in buttonTitle[0] {
            let button = self.makeButton()
            button.setTitle(str, for: .normal)
            self.stackView.addArrangedSubview(button)
        }
    }
    
    private func setUpInputLabel() {
        let inputTextLabel = self.inputTextLabel
        
        self.view.addSubview(inputTextLabel)
        
        inputTextLabel.backgroundColor = .clear
        inputTextLabel.font = .boldSystemFont(ofSize: 60)
        inputTextLabel.textColor = .white
        inputTextLabel.text = "12345"
        inputTextLabel.textAlignment = .right
        
        inputTextLabel.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = inputTextLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300)
        let leadingConstraint = inputTextLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30)
        let trailingConstraint = inputTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30)
        let heightConstraint = inputTextLabel.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, heightConstraint])
    }
    
    private func setUpStackView() {
        let stackView = self.stackView
        self.view.addSubview(stackView)
        
        stackView.backgroundColor = .clear
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = stackViewSpacing
        stackView.axis = .horizontal
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: stackViewBlankConstant)
        let trailingConstraint = stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -stackViewBlankConstant)
        let topConstraint = stackView.topAnchor.constraint(equalTo: self.inputTextLabel.bottomAnchor, constant: 30)
        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
    
    
    private func makeButton() -> UIButton {
        let button = UIButton()
                
        button.backgroundColor = UIColor(red: 58/255,
                                         green: 58/255,
                                         blue: 58/255,
                                         alpha: 1.0)
        
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
}


//미리보기
#Preview("ViewController") {
    ViewController()
}
