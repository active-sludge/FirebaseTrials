//
//  TableViewCell.swift
//  LoodosCase
//
//  Created by Huseyin Can Dayan on 16.02.2021.
//

import UIKit
import Kingfisher

class FilmTableViewCell: UITableViewCell {
    
    public static let identifier = "FilmTableViewCell"
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    public static func nib() -> UINib {
        return UINib(nibName: "FilmTableViewCell", bundle: nil)
    }
    
    func setupCell(using viewModel: FilmCellViewModel) {
        coverImage.kf.setImage(with: URL(string: viewModel.poster ?? ""), placeholder: UIImage(systemName: "film"))
        firstLabel.text = viewModel.title
        secondLabel.text = viewModel.year
    }
}
