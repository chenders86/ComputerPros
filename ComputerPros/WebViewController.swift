//
//  WebViewController.swift
//  ComputerPros
//
//  Created by Casey Henderson on 6/8/17.
//  Copyright © 2017 Casey Henderson. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        let url = URL(string: "https://www.apple.com".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        
        let request = URLRequest(url: url!)
        print(request)
        webView.loadRequest(request)
    }
    @IBOutlet weak var webView: UIWebView!
}
