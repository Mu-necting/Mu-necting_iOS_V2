import UIKit

class LoginViewController: UIViewController {
    
    let titleLabel = UILabel()
    let logoImageView = UIImageView()
    let spotifyButton = UIButton()
    let emailButton = UIButton()
    let registerButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        logoImageView.image = UIImage(named: "logoImageName") // 이미지 이름 설정
        view.addSubview(logoImageView)
        
        titleLabel.text = "Mu:necting"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 34)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        spotifyButton.setTitle("스포티파이로 계속하기", for: .normal)
        spotifyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        spotifyButton.backgroundColor = UIColor(hexCode: "1ED760")
        spotifyButton.layer.cornerRadius = 28
        spotifyButton.addTarget(self, action: #selector(spotifyLoginTapped), for: .touchUpInside)
        view.addSubview(spotifyButton)
        
        emailButton.setTitle("이메일로 로그인하기", for: .normal)
        emailButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        emailButton.backgroundColor = .white
        emailButton.layer.borderWidth = 1
        emailButton.layer.borderColor = UIColor(hexCode: "#6C6C6C").cgColor
        emailButton.layer.cornerRadius = 28
        emailButton.setTitleColor(UIColor(hexCode: "#6C6C6C"), for: .normal)
        emailButton.addTarget(self, action: #selector(emailLoginTapped), for: .touchUpInside)
        view.addSubview(emailButton)
        
        registerButton.setTitle("회원가입하기", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        registerButton.titleLabel?.setUnderline(range: NSRange(location: 0, length: registerButton.currentTitle?.count ?? 0))
        registerButton.backgroundColor = .white
        registerButton.setTitleColor(UIColor(hexCode: "#6C6C6C"), for: .normal)
        registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        view.addSubview(registerButton)
        
        // Auto Layout 설정
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        spotifyButton.translatesAutoresizingMaskIntoConstraints = false
        emailButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 오토레이아웃 제약 조건 설정
        NSLayoutConstraint.activate([
            // 로고 이미지뷰 중앙 정렬 및 상단 여백 설정
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            logoImageView.widthAnchor.constraint(equalToConstant: 150), // 로고 크기 조정
            logoImageView.heightAnchor.constraint(equalToConstant: 150), // 로고 크기 조정
            
            // 타이틀 레이블 중앙 정렬 및 로고 이미지뷰 바로 아래 위치 설정
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            
            // 스포티파이 로그인 버튼 설정
            spotifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spotifyButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            spotifyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            spotifyButton.heightAnchor.constraint(equalToConstant: 56),
            
            // 이메일 로그인 버튼 설정
            emailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailButton.topAnchor.constraint(equalTo: spotifyButton.bottomAnchor, constant: 8),
            emailButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            emailButton.heightAnchor.constraint(equalToConstant: 56),
            
            // 회원가입 버튼 설정
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 20),
        ])
    }
    
    @objc private func spotifyLoginTapped() {
        // 스포티파이 로그인 버튼 액션 구현
    }
    
    @objc private func emailLoginTapped() {
        let emailLoginVC = EmailLoginViewController()
        navigationController?.pushViewController(emailLoginVC, animated: true)
    }
    
    @objc private func registerTapped() {
        // 회원가입 버튼 액션 구현
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
