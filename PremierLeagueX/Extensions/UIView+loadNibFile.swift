//
//  UIView+loadNibFile.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 19/04/2024.
//

import UIKit


extension UIView {
    
    /// Loads a view from a nib file and adds it as a subview to the current view instance..
    func loadViewFromNib(bundle: Bundle? = nil) {
        let nibName = String(describing: Self.self)
        let bundle = Bundle(for: Self.self)
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        guard let contentView = nib.instantiate(withOwner: self).first as? UIView else {
            assertionFailure("unable to find the content view")
            return
        }
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
}
