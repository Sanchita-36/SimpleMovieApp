//
//  NetworkingService.swift
//  MovieAppAssignment
//
//  Created by Mac on 04/03/22.
//

import Foundation

public protocol NetworkingProtocol: NSObjectProtocol {
    func getNetworkingResponse()
    func getTrailerResponse()
}

class NetworkingService {
    static let sharedInstance: NetworkingService = NetworkingService()
    var delegate: NetworkingProtocol!
    var posterPath = [String]()
    var backdropPath = [String]()
    var voteCount = [Double]()
    var movieOverview = [String]()
    var movieTitle = [String]()
    var releaseDate = [String]()
    var video_key = [String]()
    var data_Fetched: [Result]! = []
    
    func getNowPlayingData() {
        let params = [URLQueryItem(name:"api_key", value: "a07e22bc18f5cb106bfe4cc1f83ad8ed")]
        
        if var urlComponents = URLComponents(string:"https://api.themoviedb.org/3/movie/now_playing") {
            
            urlComponents.queryItems = params
            
            if let url = urlComponents.url {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                let session = URLSession.shared
                session.dataTask(with: request) { (data, response, error) in
                    
                    if (response as? HTTPURLResponse) != nil {
                        
                        if let httpResponse = response as? HTTPURLResponse {
                            print("statusCode: \(httpResponse.statusCode)")
                            print(httpResponse)
                        }
                        
                        if let data = data {
                            do {
                                let nowPlayingData = try JSONDecoder().decode(NowPlaying.self, from: data)
                                self.data_Fetched = nowPlayingData.results
                                
                                for item in nowPlayingData.results {
                                    self.posterPath.append(item.poster_path)
                                    self.backdropPath.append(item.backdrop_path)
                                    self.voteCount.append(item.vote_average)
                                    self.movieTitle.append(item.title)
                                    self.movieOverview.append(item.overview)
                                    self.releaseDate.append(item.release_date)
                                }
                                DispatchQueue.main.async {
                                    self.delegate.getNetworkingResponse()
                                }
                            }catch {
                                print(error)
                            }
                        }
                    }
                }.resume()
            }
        }
    }
    
    func getTrailerData() {
        let params = [URLQueryItem(name:"api_key", value: "a07e22bc18f5cb106bfe4cc1f83ad8ed")]
        
        if var urlComponents = URLComponents(string:"https://api.themoviedb.org/3/movie/209112/videos") {
            
            urlComponents.queryItems = params
            
            if let url = urlComponents.url {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                
                let session = URLSession.shared
                session.dataTask(with: request) { (data, response, error) in
                    
                    if (response as? HTTPURLResponse) != nil {
                        
                        if let httpResponse = response as? HTTPURLResponse {
                            print("statusCode: \(httpResponse.statusCode)")
                            print(httpResponse)
                        }
                        
                        if let data = data {
                            do {
                                let trailerData = try JSONDecoder().decode(TrailerData.self, from: data)
                                for item in trailerData.results {
                                    self.video_key.append(item.key)
                                }
                                DispatchQueue.main.async {
                                    self.delegate.getTrailerResponse()
                                }
                            }catch {
                                print(error)
                            }
                        }
                    }
                }.resume()
            }
        }
    }
}


