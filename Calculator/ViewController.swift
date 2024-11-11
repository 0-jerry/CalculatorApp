//
//  ViewController.swift
//  Calculator
//
//  Created by t2023-m0072 on 11/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let inputTextLabel = UILabel()

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
}
//미리보기
#Preview("ViewController") {
    ViewController()
    
}
