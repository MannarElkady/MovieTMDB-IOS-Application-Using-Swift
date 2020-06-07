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
      //  let currentViewController = self.currentTopViewController()
        self.present(alert, animated: true, completion: nil)
    }
//    func currentTopViewController() -> UIViewController {
//        var topVC: UIViewController? = UIApplication.shared.delegate?.window??
//            .rootViewController
//        while ((topVC?.presentedViewController) != nil) {
//            topVC = topVC?.presentedViewController
//        }
//        return topVC!
//    }
}

    
extension UIView {
    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
    
    class func getBlankViewFullScreen(parentView: UIView) -> UIView{
        let view = UIView()
        view.bounds = UIScreen.main.bounds
        view.center = parentView.center
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        return view
    }
    func addCenteredActivityIndicator() -> UIActivityIndicatorView{
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.color = UIColor.gray
        activityView.center = self.center
        self.addSubview(activityView)
        return activityView
    }
}
