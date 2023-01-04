//
//  UniversitiesViewController.swift
//  week-4-hw-2
//
//  Created by Mahmut Yazar on 2.01.2023.
//

import UIKit

class UniversitiesViewController: UIViewController {
    
    @IBOutlet weak var universitiesTableView: UITableView!
    
    var countryName: String?
    
    private var universities: [University]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        universitiesTableView.separatorStyle = .none
        universitiesTableView.delegate = self
        universitiesTableView.dataSource = self
        universitiesTableView.register(.init(nibName: "UniversityTableViewCell", bundle: nil), forCellReuseIdentifier: "UniversityTableViewCell")
 
        NotificationCenter.default.addObserver(self, selector: #selector(self.didGetNotification(_:)), name: Notification.Name("Text"), object: nil)
        
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc func didGetNotification(_ notification: Notification) {
        let text = notification.object as! String?
        self.countryName = text
        fetchData()
    }
        
    private func fetchData() {
        
        if let url = URL(string: "http://universities.hipolabs.com/search?country=\(countryName ?? "")") {
            var request: URLRequest = .init(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if error != nil {
                    return
                }
                
                if let data = data {
                    do {
                        let universities = try! JSONDecoder().decode([University].self, from: data)
                        self.universities? = universities
                        DispatchQueue.main.async {
                            self.universitiesTableView.reloadData()
                        }
                    } catch {
                        print("decoding error")
                    }
                }
            }
            task.resume()
        }
    }
}

extension UniversitiesViewController: UITableViewDelegate {
    
    
}

extension UniversitiesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = universitiesTableView.dequeueReusableCell(withIdentifier: "UniversityTableViewCell", for: indexPath) as! UniversityTableViewCell
        
        cell.universityNameLabel.text = universities?[indexPath.row].name
        cell.universityWebPageLabel.text = universities?[indexPath.row].webPages?.joined()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
