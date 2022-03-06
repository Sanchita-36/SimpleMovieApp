//
//  UnpopularMovieCollectionViewCell.swift
//  MovieAppAssignment
//
//  Created by Mac on 04/03/22.
//

import UIKit

protocol DeleteUnpopularMovieCell {
    func deleteUnpopularMovieCell(index: Int)
}


class UnpopularMovieCollectionViewCell: UICollectionViewCell {
    
    var deletegateUnPopular: DeleteUnpopularMovieCell?
    var indexUnPopular: IndexPath?
    
    @IBOutlet weak var imageViewUnpopular: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    @IBAction func deleteUnpopularMovieCell(_ sender: UIButton) {
        deletegateUnPopular?.deleteUnpopularMovieCell(index: (indexUnPopular?.row)!)
    }
}
