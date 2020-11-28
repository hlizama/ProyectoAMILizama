//
//  PlaceTableViewCell.swift
//  DemoCocoaPods
//
//  Created by Kenyi Rodriguez on 10/30/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    @IBOutlet weak private var imgPlace     : UIImageView!
    @IBOutlet weak private var lblName      : UILabel!
    @IBOutlet weak private var lblAddress   : UILabel!
    
    public var objPlace: PlaceBE! {
        didSet {
            self.updateData()
        }
    }
    
    
    private func updateData() {
        
        self.lblName.text       = self.objPlace.place_name
        self.lblAddress.text    = self.objPlace.place_address
    }
    
    override func draw(_ rect: CGRect) {
        
        self.imgPlace.layer.cornerRadius = 20
    }
}
