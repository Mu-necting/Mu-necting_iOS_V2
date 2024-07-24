
import Foundation
import UIKit

protocol ProfileViewDelegate : AnyObject{
    func profileNameChanged(_ userName : String, _ profileImage : UIImage?)
    
}
class ProfileViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let nicknameTextField = UITextField()
    let nicknameRuleLabel = UILabel()
    let characterCountLabel = UILabel()
    
    lazy var completeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonTapped))
        button.tintColor = UIColor(hexCode: "BB00CB")
        return button
    }()

    
    private var userName: String?
    var profileImage: UIImage?
    
    weak var delegate: ProfileViewDelegate?
    
    let picContainer : UIView = {
        let view = UIView()
        return view
    }()
    let picButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Munecting"), for: .normal)
        
        button.imageView?.layer.cornerRadius = 45
        button.layer.cornerRadius = 45
        button.layer.masksToBounds = false
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.05
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        
        return button
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "이름"
        return label
    }()
    
    init(tempUserName: String?) {
        super.init(nibName: nil, bundle: nil)
        self.userName = tempUserName
        nicknameTextField.text = userName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = "프로필 편집"
        view.backgroundColor = .systemBackground
        
        picButton.addTarget( self, action: #selector(editProfileImage), for: .touchUpInside) //이름 수정 가능하게
        
        setupNavigationBar()
        setupPic()
        setupNicknameTextField()
        setupNicknameRuleLabel()
        setupCharacterCountLabel()
        
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = completeButton
    }
    
    func setupNicknameTextField() {
        nicknameTextField.placeholder = "현재 닉네임"
        nicknameTextField.font = UIFont.systemFont(ofSize: 18)
        nicknameTextField.borderStyle = .none
        nicknameTextField.delegate = self
        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nicknameTextField)
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = .lightGray
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomLine)
        
        NSLayoutConstraint.activate([
            nicknameTextField.topAnchor.constraint(equalTo: picContainer.bottomAnchor, constant: 32),
            nicknameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nicknameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            bottomLine.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 8),
            bottomLine.leadingAnchor.constraint(equalTo: nicknameTextField.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: nicknameTextField.trailingAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupNicknameRuleLabel() {
        nicknameRuleLabel.text = "{{닉네임 규칙}}"
        nicknameRuleLabel.font = UIFont.systemFont(ofSize: 14)
        nicknameRuleLabel.textColor = .gray
        nicknameRuleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nicknameRuleLabel)
        
        NSLayoutConstraint.activate([
            nicknameRuleLabel.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 8),
            nicknameRuleLabel.leadingAnchor.constraint(equalTo: nicknameTextField.leadingAnchor)
        ])
    }
    
    
    
    private func setupPic(){
        // 컨테이너 추가
        view.addSubview(picContainer)
        picContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            picContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picContainer.heightAnchor.constraint(equalToConstant: 90),
            picContainer.widthAnchor.constraint(equalToConstant: 90)
        ])
        // 버튼 추가
        picContainer.addSubview(picButton)
        picButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            picButton.topAnchor.constraint(equalTo: picContainer.topAnchor),
            picButton.leadingAnchor.constraint(equalTo: picContainer.leadingAnchor),
            picButton.trailingAnchor.constraint(equalTo: picContainer.trailingAnchor),
            picButton.bottomAnchor.constraint(equalTo: picContainer.bottomAnchor)
        ])
        let plus: UIView = {
            let view = UIView()
            //                 view.backgroundColor = .mpWhite
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            return view
        }()
        let plusImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "plus.circle.fill")?
                .withTintColor(.gray, renderingMode: .alwaysOriginal)
                .withConfiguration(UIImage.SymbolConfiguration(pointSize: 20, weight: .medium))
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        view.addSubview(plus)
        plus.addSubview(plusImageView)
        
        plus.translatesAutoresizingMaskIntoConstraints = false
        plusImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            plus.heightAnchor.constraint(equalToConstant: 20),
            plus.widthAnchor.constraint(equalToConstant: 20),
            plus.trailingAnchor.constraint(equalTo: picContainer.trailingAnchor),
            plus.bottomAnchor.constraint(equalTo: picContainer.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            plusImageView.topAnchor.constraint(equalTo: plus.topAnchor),
            plusImageView.leadingAnchor.constraint(equalTo: plus.leadingAnchor),
            plusImageView.trailingAnchor.constraint(equalTo: plus.trailingAnchor),
            plusImageView.bottomAnchor.constraint(equalTo: plus.bottomAnchor),
        ])
        
        
    }
    
    
    func setupCharacterCountLabel() {
        characterCountLabel.text = "\(userName?.count ?? 0)/15"
        characterCountLabel.font = UIFont.systemFont(ofSize: 14)
        characterCountLabel.textColor = .gray
        characterCountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(characterCountLabel)
        
        NSLayoutConstraint.activate([
            characterCountLabel.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 8),
            characterCountLabel.trailingAnchor.constraint(equalTo: nicknameTextField.trailingAnchor)
        ])
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        characterCountLabel.text = "\(updatedText.count)/15"
        return updatedText.count <= 15
    }
    
    // 이미지 선택이 완료되면 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // 선택한 이미지를 버튼에 적용
            picButton.setImage(selectedImage, for: .normal)
            profileImage = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func completeButtonTapped(){
        print("프로필 설정이 완료되었습니다..")
        if let changedName = nicknameTextField.text{
            delegate?.profileNameChanged (changedName, profileImage)
            print(changedName)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func editProfileImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
}
