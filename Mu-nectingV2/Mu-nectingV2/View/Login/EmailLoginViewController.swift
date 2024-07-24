import UIKit

class EmailLoginViewController: UIViewController {
    
    let titleLabel = UILabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = UIButton()
    let registerButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white // 배경색 설정
        
        // 타이틀 레이블 설정
        setupTitleLabel()
        
        // 이메일 텍스트필드 설정
        setupTextField(emailTextField, placeholder: "이메일", iconName: "envelope")
        
        // 비밀번호 텍스트필드 설정
        setupTextField(passwordTextField, placeholder: "비밀번호", iconName: "lock")
        
        // 로그인 버튼 설정
        loginButton.setTitle("로그인", for: .normal)
        loginButton.backgroundColor = UIColor(hexCode: "BB00CB")
        loginButton.layer.cornerRadius = 24
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        registerButton.setTitle("회원가입하기", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        registerButton.titleLabel?.setUnderline(range: NSRange(location: 0, length: registerButton.currentTitle?.count ?? 0))
        registerButton.backgroundColor = .white
        registerButton.setTitleColor(UIColor(hexCode: "#6C6C6C"), for: .normal)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        view.addSubview(registerButton)
        
        // Auto Layout 설정
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        // 오토레이아웃 제약조건 설정
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 12),
            loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
        ])
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
    
    private func setupTitleLabel() {
        titleLabel.text = "Mu:necting"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        view.addSubview(titleLabel)
    }
    
    @objc private func loginButtonTapped() {
        // 로그인 버튼 액션 구현
    }
    @objc private func registerTapped() {
        // 회원가입 버튼 액션 구현
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
