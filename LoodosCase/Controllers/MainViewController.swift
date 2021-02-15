//
//  MainViewController.swift
//  LoodosCase
//
//  Created by Huseyin Can Dayan on 14.02.2021.
//

import UIKit
import Firebase
import Alamofire
import Kingfisher

class MainTableViewController: UITableViewController {
    
    private var films: [Film] = []
    private var selectedFilm: Film?
    
    @IBOutlet weak var searchBar: UISearchBar!
    private let loader = Loader.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailViewController else {
            return
        }
        destinationVC.data = selectedFilm
    }
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath)
        cell.textLabel?.text = films[indexPath.row].title
        cell.detailTextLabel?.text = films[indexPath.row].year
        cell.imageView?.kf.setImage(with: URL(string: films[indexPath.row].poster ?? ""), placeholder: UIImage(systemName: "film"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedFilm = films[indexPath.row]
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemName: "\(String(describing: films[indexPath.row].title))"
        ])
    }
}

// MARK: - UISearchBarDelegate
extension MainTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let filmTitle = searchBar.text else { return }
        loader.showOverlayView(view: view)
        searchFilm(for: filmTitle)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        self.films = []
        tableView.reloadData()
    }
}

// MARK: - Alamofire
extension MainTableViewController {
    private func showNoResponseAlert(with title: String) {
        let alert = UIAlertController(title: "No Result!", message: "There is no result for '\(title)'.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Search something else", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func searchFilm(for title: String) {
        let url = "http://www.omdbapi.com/?apikey=b8fe3979"
        let parameters: [String: String] = ["s": title]
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: SearchResult.self) { response in
                self.loader.hideOverlayView(view: self.view)
                guard let searchResult = response.value?.search else {
                    self.showNoResponseAlert(with: title)
                    return
                }
                self.films = searchResult
                self.tableView.reloadData()
            }
    }
}
