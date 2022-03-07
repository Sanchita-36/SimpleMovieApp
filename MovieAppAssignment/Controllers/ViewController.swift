//
//  ViewController.swift
//  MovieAppAssignment
//
//  Created by Mac on 04/03/22.
//

import UIKit

class ViewController: UIViewController, NetworkingProtocol {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    var posterPathArray = [String]()
    var backdropPathArray = [String]()
    var voteCountArray = [Double]()
    var posterImage = String()
    var backdropImage = String()
    var movieOverviewArray = [String]()
    var movieTitleArray = [String]()
    var releaseDateArray = [String]()
    var videoKeyArray = [String]()
    
    //for searching data
    var posterPathArraySearch = [String]()
    var backdropPathArraySearch = [String]()
    var voteCountArraySearch = [Double]()
    var posterImageSearch = String()
    var backdropImageSearch = String()
    var movieOverviewArraySearch = [String]()
    var movieTitleArraySearch = [String]()
    var releaseDateArraySearch = [String]()
    var videoKeyArraySearch = [String]()
    
    var data: [Result]! = []
    var searchingData: [Result]! = []
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBool = false
    var searchString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        configureSearchController()
        
        NetworkingService.sharedInstance.getNowPlayingData()
        NetworkingService.sharedInstance.getTrailerData()
        NetworkingService.sharedInstance.delegate = self
        
    }
    
    private func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.search
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search"
    }
    
    //api delegate response for nowPlaying list
    func getNetworkingResponse() {
        let data = NetworkingService.sharedInstance.data_Fetched
        self.data = data
        self.searchingData = data
        
        let voteCount = NetworkingService.sharedInstance.voteCount
        let poster_path = NetworkingService.sharedInstance.posterPath
        let backdrop_path = NetworkingService.sharedInstance.backdropPath
        let movieTitle = NetworkingService.sharedInstance.movieTitle
        let movieOverview = NetworkingService.sharedInstance.movieOverview
        let releaseDate = NetworkingService.sharedInstance.releaseDate
        
        //vote count
        if self.voteCountArray.isEmpty == true{
            for item in voteCount {
                self.voteCountArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }else {
            self.voteCountArray.removeAll()
            for item in voteCount {
                self.voteCountArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }
        
        //poster path
        if self.posterPathArray.isEmpty == true{
            for item in poster_path {
                self.posterPathArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }else {
            self.posterPathArray.removeAll()
            for item in poster_path {
                self.posterPathArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }
        
        //backdrop path
        if self.backdropPathArray.isEmpty == true{
            for item in backdrop_path {
                self.backdropPathArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }else {
            self.backdropPathArray.removeAll()
            for item in backdrop_path {
                self.backdropPathArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }
        
        //movie title
        if self.movieTitleArray.isEmpty == true{
            for item in movieTitle {
                self.movieTitleArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }else {
            self.movieTitleArray.removeAll()
            for item in movieTitle {
                self.movieTitleArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }
        
        //movie overview
        if self.movieOverviewArray.isEmpty == true{
            for item in movieOverview {
                self.movieOverviewArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }else {
            self.movieOverviewArray.removeAll()
            for item in movieOverview {
                self.movieOverviewArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }
        
        //release date
        if self.releaseDateArray.isEmpty == true{
            for item in releaseDate {
                self.releaseDateArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }else {
            self.releaseDateArray.removeAll()
            for item in releaseDate {
                self.releaseDateArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }
    }
    
    //api delegate response for movie trailer data
    func getTrailerResponse() {
        let videoKey = NetworkingService.sharedInstance.video_key
        
        //vote count
        if self.videoKeyArray.isEmpty == true{
            for item in videoKey {
                self.videoKeyArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }else {
            self.videoKeyArray.removeAll()
            for item in videoKey {
                self.videoKeyArray.append(item)
            }
            self.movieCollectionView.reloadData()
        }
    }
}

extension ViewController: DeletePopularMovieCell, DeleteUnpopularMovieCell {
    
    func deletePopularMovieCell(index: Int) {
        if searchBool == true {
            searchingData.remove(at: index)
            voteCountArraySearch.remove(at: index)
            posterPathArraySearch.remove(at: index)
            backdropPathArraySearch.remove(at: index)
            movieOverviewArraySearch.remove(at: index)
            movieTitleArraySearch.remove(at: index)
            releaseDateArraySearch.remove(at: index)
            self.movieCollectionView.reloadData()
        }else  {
            data.remove(at: index)
            voteCountArray.remove(at: index)
            posterPathArray.remove(at: index)
            backdropPathArray.remove(at: index)
            movieOverviewArray.remove(at: index)
            movieTitleArray.remove(at: index)
            releaseDateArray.remove(at: index)
            self.movieCollectionView.reloadData()
        }
    }
    
    func deleteUnpopularMovieCell(index: Int) {
        if searchBool == true {
            var titleFetched = String()
            
            for item in searchingData {
                titleFetched = item.title
            }
            
            for item in 0..<movieTitleArray.count {
                if movieTitleArray[item] == titleFetched {
                    //without search
                    data.remove(at: item)
                    voteCountArray.remove(at: item)
                    posterPathArray.remove(at: item)
                    backdropPathArray.remove(at: item)
                    movieOverviewArray.remove(at: item)
                    movieTitleArray.remove(at: item)
                    releaseDateArray.remove(at: item)
                    break
                }
            }
            
            searchingData.remove(at: index)
            voteCountArraySearch.remove(at: index)
            posterPathArraySearch.remove(at: index)
            backdropPathArraySearch.remove(at: index)
            movieOverviewArraySearch.remove(at: index)
            movieTitleArraySearch.remove(at: index)
            releaseDateArraySearch.remove(at: index)
        
            self.movieCollectionView.reloadData()
        }else  {
            data.remove(at: index)
            voteCountArray.remove(at: index)
            posterPathArray.remove(at: index)
            backdropPathArray.remove(at: index)
            movieOverviewArray.remove(at: index)
            movieTitleArray.remove(at: index)
            releaseDateArray.remove(at: index)
            
//            //search
//            searchingData.remove(at: index)
//            voteCountArraySearch.remove(at: index)
//            posterPathArraySearch.remove(at: index)
//            backdropPathArraySearch.remove(at: index)
//            movieOverviewArraySearch.remove(at: index)
//            movieTitleArraySearch.remove(at: index)
//            releaseDateArraySearch.remove(at: index)
            
            self.movieCollectionView.reloadData()
        }
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchBool == true {
            return searchingData.count
        }else {
            return voteCountArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if searchBool == true {
            for item in 0..<searchingData.count {
                if !voteCountArraySearch.isEmpty || voteCountArraySearch.isEmpty {
                    self.voteCountArraySearch.append(searchingData[item].vote_average)
                }
                
                if !posterPathArraySearch.isEmpty || posterPathArraySearch.isEmpty {
                    self.posterPathArraySearch.append(searchingData[item].poster_path)
                }
                
                if !backdropPathArraySearch.isEmpty || backdropPathArraySearch.isEmpty {
                    self.backdropPathArraySearch.append(searchingData[item].backdrop_path)
                }
                
                if !movieOverviewArraySearch.isEmpty || movieOverviewArraySearch.isEmpty {
                    self.movieOverviewArraySearch.append(searchingData[item].overview)
                }
                
                if !movieTitleArraySearch.isEmpty || movieTitleArraySearch.isEmpty {
                    self.movieTitleArraySearch.append(searchingData[item].title)
                }
                
                if !releaseDateArraySearch.isEmpty || releaseDateArraySearch.isEmpty {
                    self.releaseDateArraySearch.append(searchingData[item].release_date)
                }
            }
            
            if voteCountArraySearch[indexPath.item] >= 7 {
                let popularCell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularMovieCell", for: indexPath) as? PopularMovieCollectionViewCell
                self.backdropImageSearch = backdropPathArraySearch[indexPath.item]
                do{
                    let urlString = "https://image.tmdb.org/t/p/original\(backdropImageSearch)"
                    try popularCell?.imageViewPopular.image = UIImage(data: NSData(contentsOf: NSURL(string: urlString)! as URL) as Data)
                }catch {
                    print("Image not shown")
                }
                popularCell?.indexPopular = indexPath
                popularCell?.deletegatePopular = self
                return popularCell!
            } else {
                let unpopularCell = collectionView.dequeueReusableCell(withReuseIdentifier: "unpopularMovieCell", for: indexPath) as? UnpopularMovieCollectionViewCell
                unpopularCell?.movieName.text = "\(movieTitleArraySearch[indexPath.item])"
                unpopularCell?.movieDescription.text = "\(movieOverviewArraySearch[indexPath.item])"
                self.posterImageSearch = posterPathArraySearch[indexPath.item]
                do{
                    let urlString = "https://image.tmdb.org/t/p/w342\(posterImageSearch)"
                    try unpopularCell?.imageViewUnpopular.image = UIImage(data: NSData(contentsOf: NSURL(string: urlString)! as URL) as Data)
                }catch {
                    print("Image not shown")
                }
                unpopularCell?.indexUnPopular = indexPath
                unpopularCell?.deletegateUnPopular = self
                return unpopularCell!
            }
        }else {
            if voteCountArray[indexPath.item] >= 7 {
                let popularCell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularMovieCell", for: indexPath) as? PopularMovieCollectionViewCell
               
                self.backdropImage = backdropPathArray[indexPath.item]
                do{
                    let urlString = "https://image.tmdb.org/t/p/original\(backdropImage)"
                    try popularCell?.imageViewPopular.image = UIImage(data: NSData(contentsOf: NSURL(string: urlString)! as URL) as Data)
                }catch {
                    print("Image not shown")
                }
                popularCell?.indexPopular = indexPath
                popularCell?.deletegatePopular = self
                return popularCell!
            } else {
                let unpopularCell = collectionView.dequeueReusableCell(withReuseIdentifier: "unpopularMovieCell", for: indexPath) as? UnpopularMovieCollectionViewCell
                unpopularCell?.movieName.text = "\(movieTitleArray[indexPath.item])"
                unpopularCell?.movieDescription.text = "\(movieOverviewArray[indexPath.item])"
                self.posterImage = posterPathArray[indexPath.item]
                do{
                    let urlString = "https://image.tmdb.org/t/p/w342\(posterImage)"
                    try unpopularCell?.imageViewUnpopular.image = UIImage(data: NSData(contentsOf: NSURL(string: urlString)! as URL) as Data)
                }catch {
                    print("Image not shown")
                }
                
                unpopularCell?.indexUnPopular = indexPath
                unpopularCell?.deletegateUnPopular = self
                return unpopularCell!
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if voteCountArray[indexPath.item] < 7 {
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            self.addChild(popOverVC)
            popOverVC.view.frame = self.view.frame
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParent: self)
            
            UserDefaults.standard.set(videoKeyArray[indexPath.item], forKey: "videoLinkString")
            popOverVC.titleLabel.text = movieTitleArray[indexPath.item]
            popOverVC.releaseDateLabel.text = releaseDateArray[indexPath.item]
            popOverVC.descriptionLabel.text = movieOverviewArray[indexPath.item]
           // popOverVC.videoKeySelected = videoKeyArray[indexPath.item]
        }
    }
}

extension ViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        self.searchString = searchText
        if !searchText.isEmpty {
            UserDefaults.standard.set(true, forKey: "SearchTextUpdated")
            searchBool = true
            searchingData.removeAll()
            
            for item in data {
                if item.title.lowercased().contains(searchText.lowercased()) {
                    searchingData.append(item)
                }
            }
            
            if searchString.count > 1 {
                voteCountArraySearch.removeAll()
                posterPathArraySearch.removeAll()
                backdropPathArraySearch.removeAll()
                movieTitleArraySearch.removeAll()
                movieOverviewArraySearch.removeAll()
                releaseDateArraySearch.removeAll()
            }
        }else {
            searchBool = false
            searchingData.removeAll()
            searchingData = data
        }
        self.movieCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBool = false
        searchingData.removeAll()
        self.movieCollectionView.reloadData()
    }
}

