//
//  DRHomeCourseItemCell.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/29.
//  Copyright © 2019 Coach. All rights reserved.
//

import UIKit

class DRHomeCourseItemCell: UITableViewCell {
    
    lazy fileprivate var courseImgView: UIImageView = {
        let imageView = UIImageView.init()
        imageView.backgroundColor = UIColor.colorHexStr("#dddddd")
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        return imageView
    }()
    lazy fileprivate var nameLabel: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor.colorHexStr("#000000")
        label.font = UIFont.font()//UIFont.font(size: 13)
        
        return label
    }()
    lazy fileprivate var lookBgView: UIView = {
        let view = UIView.init()
        return view
    }()
    lazy fileprivate var lookLabel: UILabel = {
        let label = UILabel.init()
        return label
    }()
    
    public var courseModel = DRCourseBaseModel() {
        didSet {
            courseImgView.kf.setImage(with: URL(string: courseModel.wimagePath ?? ""))
            nameLabel.text = courseModel.name
            lookLabel.text = courseModel.browseNumber! + "人看过"
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(courseImgView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(lookBgView)
        contentView.addSubview(lookLabel)
        
        courseImgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(courseImgView.snp.width).multipliedBy(DRScale_course)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(courseImgView.snp.left)
            make.top.equalTo(courseImgView.snp.bottom).offset(5)
            make.right.equalTo(courseImgView.snp.right).offset(-5)
        }
        
        lookBgView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(courseImgView)
            make.height.equalTo(18)
        }
        
        lookLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(lookBgView.snp.centerY)
            make.left.equalTo(lookBgView.snp.left).offset(5)
        }
        
        courseImgView.dr_setCornerRadius(cornerRadius: 2, roundingCorners: .allCorners)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
