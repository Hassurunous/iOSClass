//
//  ViewController.swift
//  API-Sandbox
//
//  Created by Dion Larson on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class ViewController: UIViewController {

    @IBOutlet weak var podcastTitleLabel: UILabel!
    @IBOutlet weak var rightsOwnerLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var summaryDescriptionView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        exerciseOne()
//        exerciseTwo()
//        exerciseThree()
        
        let apiToContact = "https://itunes.apple.com/us/rss/toppodcasts/limit=25/genre=1318/explicit=true/json"
        // This code will call the iTunes top 25 podcasts endpoint listed above
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let podcastsData = JSON(value)
                    
                    // Do what you need to with JSON here!
                    // The rest is all boiler plate code you'll use for API requests
//                    guard let jsonURL = Bundle.main.url(forResource: "iTunes-Movies", withExtension: "json") else {
//                        print("Could not find Random-User.json!")
//                        return
//                    }
//                    let jsonData = try! Data(contentsOf: jsonURL)
                    
//                    let moviesData = JSON(data: jsonData)
                    
                    let allPodcastsData = podcastsData["feed"]["entry"].arrayValue
                    
                    var allPodcasts: [Podcast] = []
                    
                    for podcasts in allPodcastsData {
                        let newPodcast = Podcast(json: podcasts)
                        allPodcasts.append(newPodcast)
                    }
                    
                    //print("All podcasts = \(allPodcasts)")
                    
                    let randPodcast = Int(arc4random_uniform(UInt32(24)))
                    
                    self.podcastTitleLabel.text = allPodcasts[randPodcast].name
                    self.rightsOwnerLabel.text = allPodcasts[randPodcast].rightsOwner
                    self.releaseDateLabel.text = allPodcasts[randPodcast].releaseDate
                    self.priceLabel.text = String(allPodcasts[randPodcast].price)
                    self.loadPoster(urlString: allPodcasts[randPodcast].poster)
                    self.summaryDescriptionView.text = allPodcasts[randPodcast].summary
                    print(allPodcasts[randPodcast].summary)
                    
                    
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Updates the image view when passed a url string
    func loadPoster(urlString: String) {
        posterImageView.af_setImage(withURL: URL(string: urlString)!)
    }
    
    @IBAction func viewOniTunesPressed(_ sender: AnyObject) {
        UIApplication.shared.openURL(URL(string: "http://itunes.com")!)
    }
    
}

