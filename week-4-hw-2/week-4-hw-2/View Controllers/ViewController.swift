//
//  ViewController.swift
//  week-4-hw-2
//
//  Created by Mahmut Yazar on 29.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var categories: [Category] = [
        .init(name: "University Search"),
        .init(name: "Music")
    ]
    
    @IBOutlet weak var mainPageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPageTableView.separatorStyle = .none
        mainPageTableView.delegate = self
        mainPageTableView.dataSource = self
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "SecondVC") as! SecondViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
        if indexPath.row == 1 {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MusicVC") as! MusicViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

struct Category {
    let name: String
}
