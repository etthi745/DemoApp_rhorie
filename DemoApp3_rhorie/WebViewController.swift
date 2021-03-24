//
//  WebViewController.swift
//  DemoApp3_rhorie
//
//  Created by rhorie on 2021/03/10.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate{

    @IBOutlet weak var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let myURL = URL(string: "https://www.sonix.asia/")
        let myRequest = URLRequest(url: myURL!)
        webView.navigationDelegate = self
        webView.load(myRequest)
    }
    
    /// WebView表示完了
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
        // ここに処理を書く！
        let title = self.webView?.title
        navigationItem.title = title
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
