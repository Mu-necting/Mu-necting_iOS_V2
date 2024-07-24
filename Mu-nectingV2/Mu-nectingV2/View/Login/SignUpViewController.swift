//
//  SignUpViewController.swift
//  Mu-nectingV2
//
//  Created by seonwoo on 4/29/24.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    let titleLabel = UILabel()
    
    let emailTextField = UITextField()
    let verificationCodeTextField = UITextField()
    let passwordTextField = UITextField()
    let nicknameTextField = UITextField()
    let signUpButton = UIButton()
    
    let sendButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        layoutViews()
        setupSendButton()
        updateSignUpButtonState()
    }
    
    private func setupViews() {
        
        titleLabel.text = "Mu:necting이 처음이신가요?"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(titleLabel)
        
        
        view.backgroundColor = .white
        setupTextField(emailTextField, placeholder: "이메일", iconName: "envelope")
        setupTextField(verificationCodeTextField, placeholder: "인증번호", iconName: "envelope.open")
        setupTextField(passwordTextField,placeholder: "비밀번호", iconName: "lock")
        setupTextField(nicknameTextField,placeholder: "닉네임", iconName: "person")
        setupButton(signUpButton, withTitle: "가입하기")
        
        // 모든 텍스트 필드의 delegate 설정
        [emailTextField, verificationCodeTextField, passwordTextField, nicknameTextField].forEach {
            $0.delegate = self
            $0.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupButton(_ button: UIButton, withTitle title: String) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = UIColor(hexCode: "BB00CB")
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
    }
    
    private func layoutViews() {
        let textFields = [emailTextField, verificationCodeTextField, passwordTextField, nicknameTextField]
        
        let stackView = UIStackView(arrangedSubviews: textFields)
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            signUpButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            signUpButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        textFields.forEach { textField in
            textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    
    private func setupSendButton() {
        sendButton.setTitle("전송", for: .normal)
        sendButton.backgroundColor = UIColor(hexCode: "BB00CB")
        sendButton.setTitleColor(.white, for: .normal) // 타이틀 색상 설정
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12) // 폰트 설정
        sendButton.layer.cornerRadius = 16 // 둥근 모서리 설정
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(sendButton)
        
        NSLayoutConstraint.activate([
            sendButton.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 8),
            sendButton.bottomAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: -8),
            sendButton.rightAnchor.constraint(equalTo: verificationCodeTextField.rightAnchor, constant: -8),
            sendButton.widthAnchor.constraint(equalToConstant: 72)
        ])
    }
    
    private func updateSignUpButtonState() {
        // 모든 필드가 채워져 있는지 확인하고 '가입하기' 버튼의 활성화 상태를 업데이트
        signUpButton.isEnabled = emailTextField.hasText &&
        verificationCodeTextField.hasText &&
        passwordTextField.hasText &&
        nicknameTextField.hasText
        signUpButton.backgroundColor = signUpButton.isEnabled ? UIColor(hexCode: "BB00CB") : UIColor(hexCode: "BB00CB", alpha: 0.2)
    }
    
    @objc private func textFieldChanged(_ textField: UITextField) {
        updateSignUpButtonState()
    }
    
    @objc private func sendEmailVerification() {
        // 이메일 전송 로직 구현
    }
    
    // UITextFieldDelegate 메서드 추가
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 여기에서 각 필드의 유효성을 검사합니다
        if textField == emailTextField {
            if !isValidEmail(textField.text) {
                // 이메일이 유효하지 않은 경우 사용자에게 알립니다
                // 예를 들어, 경고 메시지를 표시할 수 있습니다
            }
        } else if textField == passwordTextField {
            if !isValidPassword(textField.text) {
                // 비밀번호가 유효하지 않은 경우 사용자에게 알립니다
            }
        }
        // 기타 필드에 대한 유효성 검사 로직을 추가할 수 있습니다
    }
    
    private func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        // 여기에 이메일 유효성 검사 로직을 구현하세요
        return true
    }
    
    private func isValidPassword(_ password: String?) -> Bool {
        guard let password = password else { return false }
        // 여기에 비밀번호 유효성 검사 로직을 구현하세요
        return true
    }
    
    @objc private func signUpButtonTapped() {
        // Handle sign up action
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String, iconName: String) {
        textField.placeholder = placeholder
        textField.tintColor = UIColor(hexCode: "888888")
        textField.backgroundColor = UIColor(hexCode: "F5F5F5")
        textField.layer.cornerRadius = 24
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0) // 패딩 추가
        textField.leftView = UIImageView(image: UIImage(systemName: iconName))
        textField.leftView?.bounds
        textField.leftViewMode = .always
        
        if(placeholder == "비밀번호"){
            textField.isSecureTextEntry = true
        }
        view.addSubview(textField)
    }
}
