//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class SBOLImage: UIImageView {
    let imageCache = NSCache<NSString, UIImage>()

    var placeholder: UIImage? {
        didSet {
            image = placeholder
        }
    }

    var pictureUrl: String? {
        didSet {
            setImage()
        }
    }

    func setImage(){

        if let cachedImage = imageCache.object(forKey: NSString(string: pictureUrl ?? "")) {
            image = cachedImage
            print("im here1")
            return
        }

        if let url = URL(string: pictureUrl ?? "") {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, errror) in
                if errror != nil {
                    DispatchQueue.main.async {
                        self.image = self.placeholder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data{
                        if let downloadedImage = UIImage(data: data){
                            self.imageCache.setObject(downloadedImage, forKey: NSString(string: self.pictureUrl ?? ""))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let image = SBOLImage(image: UIImage(named: "tatepon.png"))
        var stringUrl = "https://avatars.mds.yandex.net/get-pdb/70729/382796fe-5ce9-4f76-91d7-88b34c1e49ed/s1200"
        image.pictureUrl = stringUrl

        image.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        view.addSubview(image)

        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
