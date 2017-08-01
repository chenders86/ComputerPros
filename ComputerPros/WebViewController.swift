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
        webView.loadRequest(webRequest)
        UIApplication.shared.statusBarStyle = .lightContent
        self.toolBar.barTintColor = toolBarCPColor
        self.toolBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        pageBackButton.isEnabled = false
        pageForwardButton.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .default
    }
    
    @IBAction func doneButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pageBackAction(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func pageForwardAction(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var pageBackButton: UIBarButtonItem!
    @IBOutlet weak var pageForwardButton: UIBarButtonItem!
    
    var webRequest: URLRequest!
    let toolBarCPColor = UIColor(hue: 0.5361111111, saturation: 1.00, brightness: 0.85, alpha: 1.0)
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.canGoBack {
            pageBackButton.isEnabled = true
        } else if !webView.canGoBack {
            pageBackButton.isEnabled = false
        }
        if webView.canGoForward {
            pageForwardButton.isEnabled = true
        } else if !webView.canGoForward {
            pageForwardButton.isEnabled = false
        }
    }
}
