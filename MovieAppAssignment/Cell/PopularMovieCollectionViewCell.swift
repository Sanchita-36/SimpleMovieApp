//
//  PopularMovieCollectionViewCell.swift
//  MovieAppAssignment
//
//  Created by Mac on 04/03/22.
//

import UIKit

protocol DeletePopularMovieCell {
    func deletePopularMovieCell(index: Int)
}

class PopularMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageViewPopular: UIImageView!
    
    var deletegatePopular: DeletePopularMovieCell?
    var indexPopular: IndexPath?
    
    @IBAction func videoBtn(_ sender: UIButton) {
    }
    
    @IBAction func deletePopularMovie(_ sender: UIButton) {
        deletegatePopular?.deletePopularMovieCell(index: (indexPopular?.row)!)
    }
}
