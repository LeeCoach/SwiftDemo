//
//  DRHomeHeaderView.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/28.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit
import FSPagerView

class DRHomeHeaderView: UIView,FSPagerViewDelegate,FSPagerViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.pagerView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var imageUrls:Array<String> = Array.init()
    var adsArr = [DRAdsModel]() {
         didSet{
        
            imageUrls.removeAll()
            for model:DRAdsModel in adsArr {
                imageUrls.append(model.image_url ?? "")
                DRLog(model.image_url)
            }
            self.pagerView?.reloadData()
        }
    }
    var categoryArr = [DRCategoryBaseModel]() {
        didSet {
            
        }
    }

    
    
    lazy var pagerView:FSPagerView? = {
        let pager = FSPagerView.init(frame: CGRect(x: 0, y: 0, width: DRScreen_Width, height: 170))
        pager.transformer = FSPagerViewTransformer(type: .linear)
        pager.itemSize = CGSize(width: DRScreen_Width - 74, height: DRScreen_Width*0.42)
        pager.isInfinite = true
        pager.delegate = self
        pager.dataSource = self
        pager.automaticSlidingInterval = 3
        pager.interitemSpacing = 10
        pager.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "pagerViewCell")
        return pager
    }()

    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageUrls.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "pagerViewCell", at: index)
        cell.imageView?.kf.setImage(with: URL(string: imageUrls[index] as! String))
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.layer.cornerRadius = 5
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        DRLog("选中了\(index)")
    }

}
