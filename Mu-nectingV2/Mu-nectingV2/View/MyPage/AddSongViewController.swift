import Foundation
import UIKit


class AddSongViewController: UIViewController, UITextFieldDelegate {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "곡 찾기"
        textField.borderStyle = .none
        textField.backgroundColor = UIColor(hexCode: "F5F5F5")
        textField.layer.cornerRadius = 20
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // 왼쪽에 아이콘 추가
        let iconView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        iconView.tintColor = .gray
        iconView.contentMode = .scaleAspectFit
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        iconView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)  // 아이콘의 위치 조정
        paddingView.addSubview(iconView)
        
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    lazy var completeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonTapped))
        button.tintColor = UIColor(hexCode: "BB00CB")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        setupScrollView()
        setupNicknameTextField()
    }
    
    func setupHeader(){
        title = "곡 추가하기"
        navigationItem.rightBarButtonItem = completeButton
        
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        cancelButton.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        cancelButton.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .highlighted)
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func setupScrollView() {
        view.backgroundColor = .white
        
        // ScrollView 설정
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // ContentView 설정
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)])
    }
    
    func setupNicknameTextField() {
        searchTextField.placeholder = "곡 찾기"
        searchTextField.font = UIFont.systemFont(ofSize: 17)
        searchTextField.delegate = self
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func addButtonTapped() {
        // 버튼이 눌렸을 때의 동작을 여기에 추가
        let vc = AddSongViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func completeButtonTapped(){
        print("프로필 설정이 완료되었습니다..")
        //        if let changedName = nicknameTextField.text{
        //            delegate?.profileNameChanged (changedName, profileImage)
        //            print(changedName)
        //        }
        //
        navigationController?.popViewController(animated: true)
    }
    
}
