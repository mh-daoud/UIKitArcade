//
//  DetailsViewController.swift
//  PetitionBrowser
//
//  Created by admin on 18/12/2023.
//

import Foundation
import UIKit
import WebKit

class DetailsViewController : UIViewController {
    let webView = WKWebView()
    var petition : Petition!
    override func loadView() {
        view = webView
    }
    
    init(petition: Petition) {
        self.petition = petition
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension DetailsViewController {
    func setup() {
        let html = """
            <html>
            <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style> body { font-size: 150%; } </style>
            </head>
            <body>
            \(petition.body)
            </body>
            </html>
            """
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    
}

