//
//  DetailViewController.swift
//  LoodosCase
//
//  Created by Huseyin Can Dayan on 14.02.2021.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    public var filmData: Film?
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetailView()
    }
    
    private func setupDetailView() {
        guard let film = filmData else { return }
        let viewModel = DetailViewModel(film: film)
        coverImage.kf.setImage(with: URL(string: viewModel.poster ?? ""))
        firstLabel.text = viewModel.title
        secondLabel.text = viewModel.year
        thirdLabel.text = viewModel.type
    }
}
