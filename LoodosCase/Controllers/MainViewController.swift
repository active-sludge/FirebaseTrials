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

class MainViewController: UIViewController {
    
    private var films: [Film] = []
    private var selectedFilm: Film?
    private let searchController = UISearchController(searchResultsController: nil)
    private let loader = Loader.instance
    
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - MainViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        setupSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailViewController else {
            return
        }
        destinationVC.filmData = selectedFilm
    }
    
    //MARK: - MainViewController class functions

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilmTableViewCell.nib(), forCellReuseIdentifier: FilmTableViewCell.identifier)
        tableView.keyboardDismissMode = .onDrag
    }

    private func setupNavigationBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    private func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    private func showNoResponseAlert(with title: String) {
        let alert = UIAlertController(title: "No Result!", message: "There is no result for '\(title)'.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Search something else", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: FilmTableViewCell.identifier,
            for: indexPath) as! FilmTableViewCell
        let viewModel = FilmCellViewModel(film: films[indexPath.row])
        
        cell.setupCell(using: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.selectedFilm = films[indexPath.row]
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemName: "\(String(describing: films[indexPath.row].title))"
        ])
        performSegue(withIdentifier: "toDetailView", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
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
extension MainViewController {
    
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
