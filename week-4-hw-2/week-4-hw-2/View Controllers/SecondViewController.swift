//
//  SecondViewController.swift
//  week-4-hw-2
//
//  Created by Mahmut Yazar on 1.01.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var countryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    @IBAction func searchClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UniversitiesVC") as! UniversitiesViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
        NotificationCenter.default.post(name: Notification.Name("Text"), object: countryTextField.text)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
