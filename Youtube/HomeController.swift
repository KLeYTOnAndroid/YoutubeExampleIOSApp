//
//  ViewController.swift
//  Youtube
//
//  Created by Kleyton Santos on 9/3/17.
//  Copyright © 2017 Kleyton Santos. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout{

//    var videos: [Video] = {
//        var bielaChannel = Channel()
//        bielaChannel.name = "Biela torta"
//        bielaChannel.profimeImageName = "biela_torta_avatar"
//        
//        var tobiasKemerichChannel = Channel()
//        tobiasKemerichChannel.name = "Tobias Kemerich"
//        tobiasKemerichChannel.profimeImageName = "tobias_avatar"
//        
//        var bielatortaVideo = Video()
//        bielatortaVideo.title = "Motivos para ter uma BMW 1000RR"
//        bielatortaVideo.thumbnail = "thumbnail_youtube1"
//        bielatortaVideo.channel = bielaChannel
//        bielatortaVideo.numberOfViews = 234234
//        
//        var guitarraHumanaVideo = Video()
//        guitarraHumanaVideo.title = "Guitarra Humana | Guitar Flash Custom. S I N C R O N I A"
//        guitarraHumanaVideo.thumbnail = "guitarra_humana"
//        guitarraHumanaVideo.channel = tobiasKemerichChannel
//        guitarraHumanaVideo.numberOfViews = 325243
//        
//        return [bielatortaVideo,guitarraHumanaVideo,bielatortaVideo]
//    }()

    var videos: [Video]?
    
    func fetchVideos(){
        let urlExample = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        
        URLSession.shared.dataTask(with: urlExample!) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]]{
                    
                    let video = Video()
                    video.title = (dictionary["title"]! as! String)
                    video.thumbnail = (dictionary["thumbnail_image_name"]! as! String)
                    
                    let channelDictionary = (dictionary["channel"]! as! [String: AnyObject])
                    
                    let channel = Channel()
                    channel.name = (channelDictionary["name"]! as! String)
                    channel.profimeImageName = (channelDictionary["profile_image_name"]! as! String)
                    
                    video.channel = channel
                    self.videos?.append(video)
                    
                }
                self.collectionView?.reloadData()
            
            }catch let jsonError{
                print(jsonError)
            }
            
        }.resume()
            
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationController?.navigationBar.isTranslucent = false
    
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupNavBarItens()
    }
    
    func setupNavBarItens(){
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handlerMore))
        
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        
        navigationItem.rightBarButtonItems = [moreButton,searchBarButtonItem]
    }
    
    func handleSearch(){
        print(123)
    }
    
    func handlerMore(){
        print(123)
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    func setupMenuBar(){
        view.addSubview(menuBar)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:|[v0(50)]|", views: menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell

        cell.video = videos?[indexPath.item]
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let hight = (view.frame.width - 16 - 16) * 9 / 16
        
        return CGSize(width: view.frame.width, height: hight + 88)
    }

}
