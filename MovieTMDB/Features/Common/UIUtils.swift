//
//  Common.swift
//  MovieTMDB
//
//  Created by Manar on 6/5/20.
//  Copyright © 2020 Manar. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable
class CustomSearchBar: UISearchBar {
    @IBInspectable var placeholderColor: UIColor? {
        didSet {
            let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
            let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
            textFieldInsideSearchBarLabel?.textColor = placeholderColor
        }
    }
    @IBInspectable var textColor: UIColor? {
        didSet {
            let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
            textFieldInsideSearchBar?.textColor = textColor
        }
    }

    @IBInspectable var magnifyingGlassColor: UIColor? {

        didSet {

            if let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField,
                let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {

                //Magnifying glass
                glassIconView.image = glassIconView.image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
                glassIconView.tintColor = magnifyingGlassColor

            }
        }
    }
}

extension UIViewController {
    public func showSimpleAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


