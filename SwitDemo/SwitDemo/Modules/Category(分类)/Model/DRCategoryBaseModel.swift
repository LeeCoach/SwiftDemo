//
//  DRCategoryBaseModel.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/27.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit
import HandyJSON

class DRCategoryBaseModel: HandyJSON {

    var category_id:String? = ""
    var name:String? = ""
    var image:String? = ""
    var hg:String? = ""
    
    required init() {
        
    }
}
