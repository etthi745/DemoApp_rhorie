//
//  ViewPagerViewController.swift
//  DemoApp3_rhorie
//
//  Created by rhorie on 2021/03/10.
//

import UIKit

class ViewPagerViewController: UIViewController {

    @IBOutlet weak var imageScrollView: UIScrollView!
    
    var scrollScreenHeight:CGFloat!
    var scrollScreenWidth:CGFloat!
    
    let img:[String] = ["Image","Image-1","Image-2"]
    
    var pageNum:Int!
     
    var imageWidth:CGFloat!
    var imageHeight:CGFloat!
    var screenSize:CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        screenSize = UIScreen.main.bounds
        scrollScreenWidth = screenSize.width
        let imageTop:UIImage = UIImage(named:img[0])!
        pageNum = img.count
        
        imageWidth = imageTop.size.width
        imageHeight = imageTop.size.height
        scrollScreenHeight = scrollScreenWidth * imageHeight/imageWidth
        
        for i in 0 ..< pageNum {
                    // UIImageViewのインスタンス
                    let image:UIImage = UIImage(named:img[i])!
                    let imageView = UIImageView(image:image)
                    
                    var rect:CGRect = imageView.frame
                    rect.size.height = scrollScreenHeight
                    rect.size.width = scrollScreenWidth
         
                    imageView.frame = rect
                    imageView.tag = i + 1
                    
                    // UIScrollViewのインスタンスに画像を貼付ける
                    self.imageScrollView.addSubview(imageView)
                    
                }
                
                setupScrollImages()

        
    }
    
    func setupScrollImages(){
        // ダミー画像
                let imageDummy:UIImage = UIImage(named:img[0])!
                var imgView = UIImageView(image:imageDummy)
                let subviews:Array = imageScrollView.subviews
                
                // 描画開始の x,y 位置
                var px:CGFloat = 0.0
                let py:CGFloat = (screenSize.height - scrollScreenHeight)/2
                
                // verticalScrollIndicatorとhorizontalScrollIndicatorが
                // デフォルトで入っているので2から始める
                for i in 2 ..< subviews.count {
                    imgView = subviews[i] as! UIImageView
                    if (imgView.isKind(of: UIImageView.self) && imgView.tag > 0){
                        
                        var viewFrame:CGRect = imgView.frame
                        viewFrame.origin = CGPoint(x: px, y: py)
                        imgView.frame = viewFrame
                        
                        px += (scrollScreenWidth)
                        
                    }
                }
                // UIScrollViewのコンテンツサイズを画像のtotalサイズに合わせる
                let nWidth:CGFloat = scrollScreenWidth * CGFloat(pageNum)
                imageScrollView.contentSize = CGSize(width: nWidth, height: scrollScreenHeight)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
