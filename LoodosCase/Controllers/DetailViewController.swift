//
//  DetailViewController.swift
//  LoodosCase
//
//  Created by Huseyin Can Dayan on 14.02.2021.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    public var data: Film?
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        coverImage.kf.setImage(with: URL(string: data?.poster ?? ""))
        firstLabel.text = data?.title
        secondLabel.text = data?.year
        thirdLabel.text = data?.type
        // Do any additional setup after loading the view.
    }
    

}
