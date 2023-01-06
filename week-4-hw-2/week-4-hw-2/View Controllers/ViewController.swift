//
//  ViewController.swift
//  week-4-hw-2
//
//  Created by Mahmut Yazar on 29.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Initialization of tableView categories.

    private var categories: [Category] = [
        .init(name: "University Finder"),
        .init(name: "Music")
    ]
    
    //MARK: - MainPage Table View, scroll disabled.
    
    @IBOutlet weak var mainPageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainPageTableView.separatorStyle = .none
        mainPageTableView.delegate = self
        mainPageTableView.dataSource = self
        mainPageTableView.isScrollEnabled = false
    }


}

//MARK: - Decide what to do when tableView cells tapped according to indexPath value.

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

//MARK: - TableView data source.

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        cell.textLabel?.font = .systemFont(ofSize: 30)
        cell.textLabel?.textAlignment = .center
        
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = .blue.withAlphaComponent(0.2)
        }
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .green.withAlphaComponent(0.2)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 3
    }
    
}

//MARK: - Category struct for tableView.

struct Category {
    let name: String
}
