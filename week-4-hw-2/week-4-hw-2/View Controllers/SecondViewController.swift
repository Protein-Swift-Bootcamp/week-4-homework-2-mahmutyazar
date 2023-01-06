//
//  SecondViewController.swift
//  week-4-hw-2
//
//  Created by Mahmut Yazar on 1.01.2023.
//

import UIKit

class SecondViewController: UIViewController {
    
    //MARK: - ImageView and TextField dragged from storyboard.

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var countryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    //MARK: - To make headerImageView more rounded.

        headerImageView.clipsToBounds = true
        headerImageView.layer.cornerRadius = 15
        
    }

    //MARK: - Search Button dragged from storyboard. Decide what to do when it clicked. Textfield sends the string data to next VC with notification center.
    
    @IBAction func searchClicked(_ sender: Any) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "UniversitiesVC") as! UniversitiesViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
        NotificationCenter.default.post(name: Notification.Name("Text"), object: countryTextField.text?.replacingOccurrences(of: " ", with: "+"))
    }
    
    @IBAction func backClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
