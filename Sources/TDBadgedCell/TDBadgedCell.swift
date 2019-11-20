//
//  TDBadgedCell.swift
//  TDBadgedCell
//
//  Created by Tim Davies on 07/09/2016.
//  Copyright © 2016 Tim Davies. All rights reserved.
//

import UIKit

public class TDBadgedCell: UITableViewCell {

    // Badge value
    public var badgeString : String = "" {
        didSet {
            if(badgeString == "") {
                badgeView.removeFromSuperview()
                layoutSubviews()
            } else {
                contentView.addSubview(badgeView)
                drawBadge()
            }
        }
    }
    
    // Badge background colours
    public var badgeColor : UIColor = UIColor(red: 0, green: 0.478, blue: 1, alpha: 1.0)
    public var badgeColorHighlighted : UIColor = .darkGray
    
    // Font and style
    public var badgeFontSize : Float = 11.0;
    public var badgeRadius : Float = 20;
    public var badgeOffset = CGPoint(x:10, y:0);
    private let badgeView = UIImageView()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout our badge's position
        var offsetX = badgeOffset.x
        if(isEditing == false && accessoryType != .none || (accessoryView) != nil) {
            offsetX = 0 // Accessory types are a pain to get sizing for?
        }
        
        badgeView.frame.origin.x = floor(contentView.frame.width - badgeView.frame.width - offsetX)
        badgeView.frame.origin.y = floor((frame.height / 2) - (badgeView.frame.height / 2))
        
        // Now lets update the width of the cells text labels to take the badge into account
        textLabel?.frame.size.width -= badgeView.frame.width + (offsetX * 2)
        if((detailTextLabel) != nil) {
            detailTextLabel?.frame.size.width -= badgeView.frame.width + (offsetX * 2)
        }
    }
    
    // When the badge
    public override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        drawBadge()
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        drawBadge()
    }
    
    // Draw the bagde image
    private func drawBadge() {
        // Calculate the size of our string
        let textSize: CGSize = NSString(
            string: badgeString
        ).size(withAttributes:[
            .font: UIFont.boldSystemFont(ofSize: CGFloat(badgeFontSize))
        ])
        
        // Create a frame with padding for our badge
        let height = textSize.height + 10
        var width = textSize.width + 16
        if(width < height) {
            width = height
        }
        let badgeFrame : CGRect = CGRect(x:0, y:0, width:width, height:height)
        
        let badge = CALayer()
        badge.frame = badgeFrame
        
        if(isHighlighted || isSelected) {
            badge.backgroundColor = badgeColorHighlighted.cgColor
        } else {
            badge.backgroundColor = badgeColor.cgColor
        }

        badge.cornerRadius = (CGFloat(badgeRadius) < (badge.frame.size.height / 2)) ? CGFloat(badgeRadius) : CGFloat(badge.frame.size.height / 2)
        
        // Draw badge into graphics context
        UIGraphicsBeginImageContextWithOptions(badge.frame.size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        badge.render(in:ctx)
        ctx.saveGState()
        
        // Draw string into graphics context
        ctx.setBlendMode(CGBlendMode.clear)
        NSString(string: badgeString).draw(
            in:CGRect(x:8, y:5, width:textSize.width, height:textSize.height),
            withAttributes: [
                .font:UIFont.boldSystemFont(ofSize:CGFloat(badgeFontSize)),
                .foregroundColor: UIColor.clear
            ]
        )
        
        let badgeImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        badgeView.frame = CGRect(x:0, y:0, width:badgeImage.size.width, height:badgeImage.size.height)
        badgeView.image = badgeImage
        
        layoutSubviews()
    }
}
