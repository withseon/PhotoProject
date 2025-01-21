//
//  SearchMainViewController.swift
//  PhotoProject
//
//  Created by 정인선 on 1/17/25.
//

import UIKit

final class SearchMainViewController: BaseViewController {
    private struct SearchParams: Encodable {
        let clientID = APIKEY.ACCESS_KEY
        let perPage = 20
        var page = 1
        var orderBy = Order.relevant
        var searchText = ""
        var color: Color?
        
        enum CodingKeys: String, CodingKey {
            case clientID = "client_id"
            case perPage = "per_page"
            case page
            case orderBy = "order_by"
            case searchText = "query"
            case color
        }
    }
    private let mainView = SearchMainView()
    private var searchParams = SearchParams()
    private var totalPage = 1
    private var photoData = [Photo]()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButton()
        mainView.showCenterLabel(isStart: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationItem.searchController?.searchBar.endEditing(true)
    }
    
    override func configureNavigation() {
        navigationItem.title = "SEARCH PHOTO"
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "키워드 검색"
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = false
        navigationItem.searchController = searchController
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: self, action: nil)
    }
    
    override func configureCollectionView() {
        // Color filter
        mainView.colorCollectionView.isScrollEnabled = false
        mainView.colorCollectionView.delegate = self
        mainView.colorCollectionView.dataSource = self
        mainView.colorCollectionView.register(ColorFilterCollectionViewCell.self, forCellWithReuseIdentifier: ColorFilterCollectionViewCell.identifier)
        
        // Photo
        mainView.photoCollectionView.delegate = self
        mainView.photoCollectionView.dataSource = self
        mainView.photoCollectionView.prefetchDataSource = self
        mainView.photoCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
    }
}

extension SearchMainViewController {
    private func configureButton() {
        mainView.sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func sortButtonTapped() {
        mainView.sortButton.isSelected.toggle()
        if mainView.sortButton.isSelected {
            searchParams.orderBy = .latest
        } else {
            searchParams.orderBy = .relevant
        }
        resetFetchState()
        fetchPhotoData()
    }
    
    private func resetFetchState() {
        totalPage = 1
        searchParams.page = 1
    }
    
    private func fetchPhotoData() {
        let url = APIURL.SEARCH_URL
        let parameters = searchParams.toParameters
        
        NetworkManager.networkRequest(url: url, parameters: parameters, type: SearchPhoto.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                guard success.total > 0 else {
                    mainView.showCenterLabel(isStart: false)
                    return
                }
                mainView.photoCollectionView.isHidden = false
                mainView.colorCollectionView.allowsSelection = true
                if searchParams.page == 1 {
                    totalPage = success.totalPages
                    photoData.removeAll()
                    photoData = success.results
                    mainView.photoCollectionView.reloadData()
                    mainView.photoCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .top)
                } else {
                    photoData.append(contentsOf: success.results)
                    mainView.photoCollectionView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

extension SearchMainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text,
              text.trimmingCharacters(in: .whitespaces).count >= 2  else {
            showAlert(title: "입력 오류", message: "두 글자 이상 검색해주세요.", actionTitle: "확인", withCancel: false)
            return
        }
        guard searchParams.searchText != text else { return }
        searchParams.searchText = text
        resetFetchState()
        fetchPhotoData()
    }
}

extension SearchMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Color filter
        if collectionView == mainView.colorCollectionView {
            return Color.allCases.count
        } else {
            // Photo
            return photoData.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Color filter
        if collectionView == mainView.colorCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorFilterCollectionViewCell.identifier, for: indexPath) as? ColorFilterCollectionViewCell else { return UICollectionViewCell() }
            cell.configureContent(color: Color.allCases[indexPath.item])
            return cell
        } else {
            // Photo
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
            cell.updateContent(photo: photoData[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Color filter
        if collectionView == mainView.colorCollectionView {
            collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            let selectedColor = Color.allCases[indexPath.item]
            if searchParams.color == selectedColor {
                collectionView.deselectItem(at: indexPath, animated: false)
                searchParams.color = nil
            } else {
                searchParams.color = selectedColor
            }
            resetFetchState()
            fetchPhotoData()
        } else {
            // Photo
            let vc = StatisticMainViewController()
            vc.photo = photoData[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.item == photoData.count - 5 {
                searchParams.page += 1
                if searchParams.page <= totalPage {
                    fetchPhotoData()
                }
            }
        }
    }
}
