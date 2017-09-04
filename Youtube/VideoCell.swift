//
//  VideoCell.swift
//  Youtube
//
//  Created by Kleyton Santos on 9/3/17.
//  Copyright © 2017 Kleyton Santos. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoCell: BaseCell {
    
    var video: Video? {
        didSet{
            titleLabel.text = video?.title
            
            setupThumbnailImageView()
            
            setupProfileImageView()

            if let profileImageName = video?.channel?.profimeImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews{
                let numberFormater = NumberFormatter()
                numberFormater.numberStyle = .decimal
                
                subTitleTextView.text = "\(channelName) • \(String(describing: numberFormater.string(from: numberOfViews)!)) visualizações • 9 Meses atrás"
            }
            
            //measure title text
            if let title = video?.title{
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimetedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimetedRect.size.height > 20{
                    titleHighLabelConstraint?.constant = 44
                }else{
                    titleHighLabelConstraint?.constant = 20
                }
                
            }
            
        }
    }
    
    func setupThumbnailImageView(){
        if let thumbnailImageUrl = video?.thumbnail{
            thubnailImageView.loadImageUsingUrl(urlString: thumbnailImageUrl)
        }
    }
    
    func setupProfileImageView(){
        if let profileImageUrl = video?.channel?.profimeImageName{
            
            profileImageView.loadImageUsingUrl(urlString: profileImageUrl)
        
        }
        
    }
    
    let thubnailImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "thumbnail_youtube1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(named: "avatar")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Motivos para ter uma BMW S1000RR"
        label.numberOfLines = 2
        return label
    }()
    
    let subTitleTextView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "Biela torta • 223 mil visualizações • 9 Meses atrás"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = UIColor.lightGray
        return textView
    }()
    
    let separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorLiteralRed: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    var titleHighLabelConstraint: NSLayoutConstraint?
    
    override func setupViews(){
        addSubview(thubnailImageView)
        addSubview(separatorView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(subTitleTextView)
        
        //Horizontal Constraints
        addConstraintWithFormat(format: "H:|-16-[v0]-16-|",views: thubnailImageView)
        addConstraintWithFormat(format: "H:|-16-[v0(44)]",views: profileImageView)
        addConstraintWithFormat(format: "H:|[v0]|",views: separatorView)
        
        //Vertical Constraints
        addConstraintWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|",views: thubnailImageView,profileImageView,separatorView)
        
        //Top Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thubnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //Left Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        //Right Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thubnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height Constraint
        titleHighLabelConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        
        addConstraint(titleHighLabelConstraint!)
        
        //Top Constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //Left Constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        //Right Constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: thubnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height Constraint
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
    }
    
}



