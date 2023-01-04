//
//  MusicViewController.swift
//  week-4-hw-2
//
//  Created by Mahmut Yazar on 4.01.2023.
//

import UIKit
import SDWebImage

class MusicViewController: UIViewController {
    
    @IBOutlet weak var musicTableView: UITableView!
    
    var genres: [Genre]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicTableView.delegate = self
        musicTableView.dataSource = self
        musicTableView.register(.init(nibName: "MusicTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicTableViewCell")
        musicTableView.separatorStyle = .none
        
        fetchMusicData()
    }
    
    public func configure(with genres: [Genre]) {
            self.genres = genres
            DispatchQueue.main.async { [weak self] in
                self?.musicTableView.reloadData()
            }
        }
    
    
    func fetchMusicData() {
        
        if let url = URL(string: "https://www.trtdinle.com/api/search/main") {
            var request: URLRequest = .init(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                if error != nil {
                    return
                }
                
                if let data = data {
                    do {
                        let music = try! JSONDecoder().decode(Music.self, from: data)
                        let genres = music.genres
                        
                        self.genres = genres
                        
                        
                        DispatchQueue.main.async {
                            self.musicTableView.reloadData()
                        }
                    } catch {
                        print("decoding error")
                    }
                }
            }
            task.resume()
        }
    }
    
    
    @IBAction func doneClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
}


extension MusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "COMING SOON", message: "Radio feature will be added soon.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Close", style: .cancel)
        alert.addAction(okButton)
        self.present(alert, animated: true)
        
    }
}

extension MusicViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = musicTableView.dequeueReusableCell(withIdentifier: "MusicTableViewCell", for: indexPath) as! MusicTableViewCell
        
//        cell.textLabel?.text = genres?[indexPath.row].title
        cell.musicImageView.sd_setImage(with: URL(string: genres?[indexPath.row].imageURL ?? ""))
        cell.musicImageView.contentMode = .scaleAspectFill
        cell.musicImageView.clipsToBounds = true
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
