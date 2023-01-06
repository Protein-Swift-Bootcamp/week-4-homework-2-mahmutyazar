//
//  UniversitiesViewController.swift
//  week-4-hw-2
//
//  Created by Mahmut Yazar on 2.01.2023.
//

import UIKit

class UniversitiesViewController: UIViewController {
    
    //MARK: - universitiesTableView, activityView and activityIndicator dragged from storyBoard. Activity Indicator is inside of activityView.
    
    @IBOutlet weak var universitiesTableView: UITableView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var countryName: String?
    
    //MARK: - universities Data comes from server according do University model.
    
    private var universities: [University]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        universitiesTableView.separatorStyle = .none
        universitiesTableView.delegate = self
        universitiesTableView.dataSource = self
        universitiesTableView.register(.init(nibName: "UniversityTableViewCell", bundle: nil), forCellReuseIdentifier: "UniversityTableViewCell")
 
    //MARK: - String data is receiving from previous VC to add end of server API. It's being hold as countryName variable.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.didGetNotification(_:)), name: Notification.Name("Text"), object: nil)
        
        
    //MARK: - Activity Indicator starts animating as soon as page loaded.
    
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc func didGetNotification(_ notification: Notification) {
        let text = notification.object as! String?
        self.countryName = text
        fetchData()
    }
        
    //MARK: - Data is being fetched from server by GET request.
    
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
                        
                        //MARK: Data is being saved to universities variable. When data received, activity indicator stops animating. Activity view is being hidden.
                        
                        self.universities? = universities
                        DispatchQueue.main.async {
                            self.universitiesTableView.reloadData()
                            self.activityIndicator.stopAnimating()
                            self.activityView.isHidden = true
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

    //MARK: - Decide what to do when tableView cells tapped according to indexPath value.

extension UniversitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: universities?[indexPath.row].name, message: universities?[indexPath.row].webPages?.joined(), preferredStyle: .alert)
        let action = UIAlertAction(title: "OKAY", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

    //MARK: - universitiesTableView data source. Each university's name and web page being shown.

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
