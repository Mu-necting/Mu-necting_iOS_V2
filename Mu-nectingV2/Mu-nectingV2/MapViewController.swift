//
//  MapViewController.swift
//  Mu-nectingV2
//
//  Created by seohuibaek on 3/7/24.
//

import UIKit

class MapViewController: UIViewController {

    var testImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testImage()

        // Do any additional setup after loading the view.
    }
    
    func testImage() {
        testImageView.image = UIImage(named: "Demo")
        testImageView.contentMode = .scaleAspectFill
        testImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(testImageView)
                
        NSLayoutConstraint.activate([
            testImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            testImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            testImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            testImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
