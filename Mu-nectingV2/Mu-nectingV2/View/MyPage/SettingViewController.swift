import UIKit

class SettingsViewController: UIViewController {
    // 테이블 뷰
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "설정"
        // 화면의 배경색 설정
        view.backgroundColor = .white
        
        // 테이블 뷰의 데이터 소스와 델리게이트 설정
        tableView.dataSource = self
        tableView.delegate = self
        
        // 테이블 뷰를 화면에 추가
        view.addSubview(tableView)
        
        // 오토레이아웃 설정
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // 테이블 뷰의 선 제거
        tableView.separatorStyle = .none
        
        // 테이블 뷰에 섹션 헤더와 푸터 등록
        tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
    }
    
    func showLogoutConfirmation() {
           let alertController = UIAlertController(title: nil, message: "정말로 로그아웃 하시겠습니까?", preferredStyle: .alert)
           
           let cancelAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
           let logoutAction = UIAlertAction(title: "네", style: .destructive) { _ in
               // 로그아웃 로직을 여기에 추가하세요.
               print("로그아웃됨")
           }
           
           alertController.addAction(cancelAction)
           alertController.addAction(logoutAction)
           
           present(alertController, animated: true, completion: nil)
       }
    
    // 회원 탈퇴 확인 모달 표시
    func showDeleteAccountConfirmation() {
        let alertController = UIAlertController(title: "안내", message: "회원 탈퇴를 하면 뮤넥팅의 \n 모든 데이터가 지워집니다.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "탈퇴", style: .destructive) { _ in
            // 회원 탈퇴 로직을 여기에 추가하세요.
            print("회원 탈퇴됨")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    // 섹션 수 설정
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 각 섹션의 행 수 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // 각 셀 구성 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        if indexPath.section == 0 {
            // 첫 번째 섹션
            if indexPath.row == 0 {
                // 버전 정보
                cell.textLabel?.text = "버전 정보"
            } else {
                // 서비스 이용 안내
                cell.textLabel?.text = "서비스 이용 안내"
                cell.accessoryType = .disclosureIndicator
            }
        } else {
            // 두 번째 섹션
            if indexPath.row == 0 {
                // 회원 탈퇴
                cell.textLabel?.text = "회원 탈퇴"
            } else {
                // 로그아웃
                cell.textLabel?.text = "로그아웃"
                cell.textLabel?.textColor = .red
            }
        }
        
        return cell
    }
    
    // 섹션 헤더의 내용 설정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeaderView") as! SectionHeaderView
        headerView.titleLabel.text = section == 0 ? "앱 정보" : "계정"
        return headerView
    }
    
    // 섹션 헤더의 높이 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    // 섹션 푸터의 내용 설정 (옵션)
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView() // 푸터 없음
    }
    
    // 섹션 푸터의 높이 설정 (옵션)
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01 // 푸터 높이 0
    }
}

// MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    // 셀 선택 시 동작 설정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 각 셀 선택 시 필요한 동작 구현
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 && indexPath.row == 1 {
            // 로그아웃 셀 선택 시
            showLogoutConfirmation()
        } else if indexPath.section == 1 && indexPath.row == 0 {
            // 회원 탈퇴 셀 선택 시
            showDeleteAccountConfirmation()
        }
    }
}

// 섹션 헤더 뷰
class SectionHeaderView: UITableViewHeaderFooterView {
    // 섹션 제목 라벨
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor(hexCode: "888888")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 초기화
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
