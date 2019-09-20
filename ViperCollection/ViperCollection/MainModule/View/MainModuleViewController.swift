//
//  MainModuleViewController.swift
//  ViperCollection
//
//  Created on 17/06/2019.
//  Copyright © 2019 Zakirov. All rights reserved.
//

import UIKit
import SnapKit
import CoreData

class MainModuleViewController: UICollectionViewController, MainModuleViewAssemblyProtocol {
    
    
//    private var newsArray = [ShortItem(title: "Firstwelkmdfwlekmdwelkdmwlkemdwlkedmwlekdmwelkdm", date: "сегодня", resourceTag: "Известия", isNewsOfTheDay: true, imageLink: "https://myskatingmall.com/wp-content/uploads/2018/12/wesaturate.jpg.optimal.jpg")]
    static let background = UIColor(displayP3Red: 241.0/255.0, green: 242.0/255.0, blue: 243.0/255.0, alpha: 1.0)
    
    struct Appearance{
        static let verticalSectionInset: CGFloat = 16
        static let leftSectionInset: CGFloat = 40
        static let rightSectionInset: CGFloat = 40
        static let offsetBetweenCells: CGFloat = 16

    }
    private let cellIdent = "CollectionViewCell"
    
    private lazy var popUp = PopupTransitioningManager()
    
    private var collectionViewFlowLayout: UICollectionViewFlowLayout {
        // swiftlint:disable:next force_cast
        return collectionViewLayout as! UICollectionViewFlowLayout
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        renderCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var presenter: MainModuleViewToPresenterProtocol?
    // MARK: Life cycle
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
        fillingNews()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let news = newsArray[indexPath.row]
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellIdent, for: indexPath) as! CollectionViewCell
//        cell.update(info: news)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let alert =  UIAlertController(title: "AAahhh", message: "\(newsArray[indexPath.row].isNewsOfTheDay)", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//        let feedbackViewController = POPModuleRouter.createModule()
//        let popNC = UINavigationController(rootViewController: feedbackViewController)
//        feedbackViewController.preferredContentSize = CGSize(width: 300, height: 500)
//        popUp.presentationStyle = .none
//        popNC.transitioningDelegate = popUp
//        popNC.modalPresentationStyle = .custo
        
        let childVC = UIViewController()
        childVC.preferredContentSize = CGSize(width: 300, height: 500)
        childVC.modalPresentationStyle = .formSheet
        present(childVC, animated: true, completion: nil)
        
        //about see
    }
    

    private func renderCollectionView() {
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.sectionInset = .init(
            top: Appearance.verticalSectionInset,
            left: Appearance.leftSectionInset,
            bottom: Appearance.verticalSectionInset,
            right: Appearance.rightSectionInset
        )
        collectionViewFlowLayout.minimumInteritemSpacing = Appearance.offsetBetweenCells
        collectionViewFlowLayout.minimumLineSpacing = Appearance.offsetBetweenCells
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellIdent)
        collectionView?.backgroundColor = MainModuleViewController.background
        collectionView?.showsVerticalScrollIndicator = false
        
        collectionView.snp.makeConstraints{ make in
            make.width.left.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    func fillingNews(){
//        var image = UIImage(named: "tatepon")!
//        let coreDataManager = CoreDataManager(withDataModelName: "NewsModel", bundle: .main)
//        let singleNews = ShortItem(context: coreDataManager.mainContext)
//        singleNews.date = "pig"
//        singleNews.imageLink = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJ_u12Pt-b0QPjnqhB2Dw9NurTKWEZLoLtpcEGj0hPCnmExJLS"
//        singleNews.isNewsOfTheDay = true
//        singleNews.resourceTag = "Известия"
//        singleNews.title = "Eeeeeeee"
//        singleNews.imageString = imageToString(image: image)
//        print(singleNews.imageString!)
        
        
//        coreDataManager.saveContext(synchronously: true)
        loadData()


    }
    
    
    func loadData() {
        let coreDataManager = CoreDataManager(withDataModelName: "NewsModel", bundle: .main)
        let fetchResult = coreDataManager.fetchObjects(entity: ShortItem.self, context: coreDataManager.mainContext)
        var i = 0
        for data in fetchResult {
            i+=1
            print(i)
            print(data.date!)
            print(data.imageLink!)
            print(data.resourceTag!)
            print(data.isNewsOfTheDay)
            print(data.title!)
            if data.imageString != nil {
            let nicepic = stringToImage(imageString: data.imageString ?? ".")
                nicepic.self
                print("hey")
            }
        }
    }
    
    func imageToString(image: UIImage) -> String {
        let imageData = image.pngData()!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    func stringToImage(imageString: String) -> UIImage {
        let imageData = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imageData)!
    }
}

extension MainModuleViewController: MainModulePresenterToViewProtocol {
    func showItem() {
        //
    }
    

}

extension MainModuleViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 336, height: 433)
    }
    
}
