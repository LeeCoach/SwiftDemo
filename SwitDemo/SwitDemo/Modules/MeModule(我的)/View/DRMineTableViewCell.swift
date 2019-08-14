//
//  DRMineTableViewCell.swift
//  SwitDemo
//
//  Created by Coach on 2019/8/11.
//  Copyright © 2019年 Coach. All rights reserved.
//

import UIKit
import SnapKit

class DRMineTableViewCell: UITableViewCell {
    
    var iconImageView: UIImageView?
    var titleLabel:UILabel?
    var detailLabel:UILabel?
    
    var cellModel:DRCellConfingModel! {
        didSet {
            self.iconImageView?.image = UIImage.init(named: cellModel.imageName!)
            self.titleLabel?.text = cellModel.titleString
            self.detailLabel?.text = cellModel.detailString
        }
    }
        

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.titleLabel = UILabel.init()
        self.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        self.titleLabel!.textColor = UIColor.init(hexString: "#000000")
        self.contentView.addSubview(self.titleLabel!)
        
        self.iconImageView = UIImageView.init()
        self.iconImageView!.contentMode = .scaleAspectFit;
        self.contentView.addSubview(self.iconImageView!)
        
        self.detailLabel = UILabel.init()
        self.detailLabel!.font = UIFont.systemFont(ofSize: 14)
        self.detailLabel!.textColor = UIColor.init(hexString: "#f2f2f2")
        self.contentView.addSubview(self.detailLabel!)

        self.iconImageView?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 20, height: 20))
        })
        
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.iconImageView?.snp.right)!).offset(10)
            make.centerY.equalToSuperview()
        })
        
        self.detailLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-0)
            make.centerY.equalToSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("初始化失败")
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
