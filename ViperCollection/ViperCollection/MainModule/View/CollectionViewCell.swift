//
//  CollectionViewCell.swift
//  ViperCollection
//
//  Created by 17515726 on 17/06/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//
import UIKit
import Foundation
import AlamofireImage
import Alamofire

protocol CollectionViewCellDelegate: AnyObject {
    func didPressCell(with view: CollectionViewCell)
}

class CollectionViewCell: UICollectionViewCell {
    
    struct Appearance {
        static let leftTwenty = 20
        static let upTwentyFour = 24
        static let eightBetween = 8
        static let shadowTopOffset: CGFloat = 16
        static let shadowSideOffset: CGFloat = 8
        static let shadowColor = UIColor.black.cgColor
        static let shadowOpacity: Float = 0.16
        static let shadowRadius: CGFloat = 10
    }
    
    let primaryGreen = UIColor(displayP3Red: 25.0/255.0, green: 187.0/255.0, blue: 79.0/255.0, alpha: 1.0)
    let myBly = UIColor(displayP3Red: 211.0/255.0, green: 233.0/255.0, blue: 244.0/255.0, alpha: 1.0)

    let mainView = UIView()
    let image = UIImageView()
    var url = URL(string: "https://httpbin.org/image/png")
    let placeholder = UIImage(named: "tatepon")!
    let titleLabel = UILabel()
    let previewText = UILabel()
    let dateLabel = UILabel()
    let sourceLabelView = UIView()
    let sourceLabelTag = UILabel()
    
    var infoToShow: ShortItem?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    weak var delegate: CollectionViewCellDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        //
    }
    
    func update(info: ShortItem) {
//        switch info.isNewsOfTheDay {
//        case true:/
            sourceLabelTag.snp.updateConstraints{ make in
                make.width.equalTo(119)
            }
            sourceLabelTag.text = "Новость дня"
            dateLabel.text = "Сегодня"
            dateLabel.snp.updateConstraints{ make in
                make.width.equalTo(132)
            }
            
            titleLabel.snp.remakeConstraints{ make in
                make.width.equalTo(550)
                make.left.equalToSuperview().offset(Appearance.leftTwenty)
                make.top.equalTo(image).offset(Appearance.upTwentyFour)
            }
            titleLabel.text = info.title
            url = URL(string: "\(info.imageLink)")
//        case false:
            sourceLabelTag.text = info.resourceTag
            dateLabel.text = info.date
            titleLabel.text = info.title
            
            titleLabel.snp.remakeConstraints{ make in
                make.top.equalTo(image.snp.bottom).offset(Appearance.upTwentyFour)
                make.left.equalToSuperview().offset(Appearance.leftTwenty)
                make.width.equalTo(296)
            }
            mainView.addSubview(previewText)
            previewText.numberOfLines = 3
            previewText.snp.makeConstraints{ make in
                make.width.equalTo(titleLabel.snp.width)
                make.top.equalTo(titleLabel.snp.bottom).offset(Appearance.eightBetween)
                make.left.equalTo(titleLabel.snp.left)
            }
            previewText.text = info.imageLink
            url = URL(string: "\(info.imageLink)")
//        }
        image.af_setImage(withURL: url!, placeholderImage: placeholder)
        updateShadow()
    }

    private func updateShadow() {
        let shadowRect = CGRect(x: Appearance.shadowSideOffset,
                                y: Appearance.shadowTopOffset,
                                width: bounds.width - Appearance.shadowSideOffset * 2,
                                height: bounds.height - Appearance.shadowTopOffset)
        
        guard shadowRect.size != layer.shadowPath?.boundingBoxOfPath.size else { return }
        
        layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
        layer.shadowRadius = Appearance.shadowRadius
        layer.shadowColor = Appearance.shadowColor
        layer.shadowOpacity = Appearance.shadowOpacity
        layer.shadowOffset = .zero
    }
    
    func prepareView() {
        addSubview(mainView)
        mainView.snp.makeConstraints{ make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 10.0
        mainView.clipsToBounds = true
        
        
        mainView.addSubview(image)
        image.backgroundColor = myBly
        image.snp.makeConstraints { make in
            make.height.equalTo(204)
            make.top.equalTo(mainView)
            make.width.equalTo(mainView)
        }
        
        image.addSubview(sourceLabelView)
        sourceLabelView.backgroundColor = primaryGreen
        sourceLabelView.layer.cornerRadius = 10.0
        sourceLabelView.clipsToBounds = true
        sourceLabelView.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(93)
            make.right.top.equalToSuperview()
        }
        
        sourceLabelView.addSubview(sourceLabelTag)
        sourceLabelTag.numberOfLines = 1
        sourceLabelTag.textAlignment = .center
        sourceLabelTag.textColor = .white
        sourceLabelTag.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.equalTo(61)
            make.height.equalTo(20)
        }
        
        mainView.addSubview(dateLabel)
        dateLabel.textColor = .gray
        dateLabel.snp.makeConstraints{ make in
            make.bottom.equalTo(-16)
            make.left.equalTo(20)
            make.width.equalTo(116)
        }
        
        mainView.addSubview(titleLabel)
        titleLabel.numberOfLines = 3
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(image.snp.bottom).offset(Appearance.upTwentyFour)
            make.left.equalToSuperview().offset(Appearance.leftTwenty)
            make.width.equalTo(296)
        }
        updateShadow()
    }
    
}

