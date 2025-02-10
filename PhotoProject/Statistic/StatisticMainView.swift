//
//  StatisticMainView.swift
//  PhotoProject
//
//  Created by 정인선 on 1/19/25.
//

import UIKit
import SnapKit

final class StatisticMainView: BaseView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private let contentView = UIView()
    private let userProfileView = UserProfileView()
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let infoView = InfoView()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(userProfileView)
        contentView.addSubview(photoImageView)
        contentView.addSubview(infoView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        userProfileView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(userProfileView.snp.bottom).offset(12)
            make.width.equalToSuperview()
            make.height.equalTo(photoImageView.snp.width)
        }
        infoView.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(100)
            make.bottom.equalToSuperview().inset(40)
        }
    }
}

extension StatisticMainView {
    func configureContent(photo: PhotoInfo, statistics: StatisticsInfo) {
        userProfileView.configureContent(user: photo.userInfo, createAt: photo.createdAt)
        photoImageView.setKFImage(strURL: photo.rawImageURL)
        infoView.configureContent(size: photo.size,
                                  views: statistics.views.total,
                                  downLoad: statistics.downloads.total)
        
        photoImageView.snp.remakeConstraints { make in
            make.top.equalTo(userProfileView.snp.bottom).offset(12)
            make.width.equalToSuperview()
            make.height.equalTo(photoImageView.snp.width).multipliedBy(photo.heightToWidthRatio)
        }
    }

}
