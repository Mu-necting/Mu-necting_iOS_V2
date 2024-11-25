import UIKit
import FirebaseCore
//import FirebaseAuth
import GoogleSignIn
import AuthenticationServices
import KakaoSDKUser
import KakaoSDKAuth

class LoginViewController: UIViewController, ASAuthorizationControllerDelegate {
    
    let logoImageView = UIImageView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "sns 계정으로 로그인"
        label.textAlignment = .center
        label.textColor = UIColor(hexCode: "6C6C6C")
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    private let thinLineView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "6C6C6C")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let thinLineView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "6C6C6C")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let kakaoButton = UIButton()
    let googleButton = UIButton()
    let emailButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        logoImageView.image = UIImage(named: "munecting_login")
        logoImageView.contentMode = .scaleAspectFill
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(thinLineView1)
        view.addSubview(thinLineView2)
        
        
        kakaoButton.setTitle("카카오톡으로 로그인", for: .normal)
        kakaoButton.setTitleColor(.black, for: .normal)
        kakaoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        kakaoButton.backgroundColor = UIColor(hexCode: "FEE500")
        kakaoButton.layer.cornerRadius = 28
        kakaoButton.addTarget(self, action: #selector(kakaoLoginTapped), for: .touchUpInside)
        kakaoButton.setImage(UIImage(named: "Kakao_login"), for: .normal)
        view.addSubview(kakaoButton)
        
        googleButton.setTitle("구글로 로그인", for: .normal)
        googleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        googleButton.layer.borderWidth = 1
        googleButton.layer.borderColor = UIColor(hexCode: "BEBEBE").cgColor
        googleButton.layer.cornerRadius = 28
        googleButton.setTitleColor(.black, for: .normal)
        googleButton.addTarget(self, action: #selector(googleLoginTapped), for: .touchUpInside)
        googleButton.setImage(UIImage(named: "Google_login"), for: .normal)
        view.addSubview(googleButton)
        
        emailButton.setTitle("애플로 로그인", for: .normal)
        emailButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        emailButton.backgroundColor = .white
        emailButton.layer.borderWidth = 1
        emailButton.layer.borderColor = UIColor(hexCode: "#BEBEBE").cgColor
        emailButton.layer.cornerRadius = 28
        emailButton.setTitleColor(.black, for: .normal)
        emailButton.addTarget(self, action: #selector(emailLoginTapped), for: .touchUpInside)
        view.addSubview(emailButton)
        
        // Auto Layout 설정
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        kakaoButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        emailButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.13),
            logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            logoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            
            thinLineView1.heightAnchor.constraint(equalToConstant: 0.5),
            thinLineView1.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            thinLineView1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            thinLineView1.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -8),
            
            thinLineView2.heightAnchor.constraint(equalToConstant: 0.5),
            thinLineView2.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            thinLineView2.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            thinLineView2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            kakaoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            kakaoButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            kakaoButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            kakaoButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            kakaoButton.heightAnchor.constraint(equalToConstant: 56),
            
            googleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            googleButton.topAnchor.constraint(equalTo: kakaoButton.bottomAnchor, constant: 8),
            googleButton.heightAnchor.constraint(equalToConstant: 56),
            googleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            googleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            emailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 8),
            emailButton.heightAnchor.constraint(equalToConstant: 56),
            emailButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            emailButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
        ])
    }
    
    @objc private func kakaoLoginTapped() {
        // 카톡으로 로그인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    LoginRepository.shared.socialLogin(type: "KAKAO", token: (oauthToken?.idToken)!){
                        (result) in
                        switch result{
                        case .success(let data):
                            print(data)
                    
                        case .failure(.failure(message: let message)):
                            print(message)
                        case .failure(.networkFail(let error)):
                            print(error)
                            print("networkFail in loginWithKakaoTalk")
                        }
                    }
                }
            }
        }
        
        // 카카오 회원가입으로 로그인
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                LoginRepository.shared.socialLogin(type: "KAKAO", token: (oauthToken?.idToken)!){
                    (result) in
                    switch result{
                    case .success(let data):
                        print(data)
                
                    case .failure(.failure(message: let message)):
                        print(message)
                    case .failure(.networkFail(let error)):
                        print(error)
                        print("networkFail in loginWithKakaoTalk")
                    }
                }
            }
        }
    }
    
    @objc private func googleLoginTapped() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            //          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
            //                                                         accessToken: user.accessToken.tokenString)
        }
    }
    
    @objc private func emailLoginTapped() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}
