//
//  HomeViewController.swift
//  OnlySchool
//
//  Created by Ting on 2024/4/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = CourseHomeViewModel(courseLoader: DataLoaderManager())
    
    private var courses: [CoursesModel] = []
    private var categories: [CategoryModel] = []
    private var categoriesArray: [String] = []
    
    private let maxDisplayItemsFor_iPhone: Int = 3
    private let maxDisplayItemsFor_iPad: Int = 4
    
    private func setupView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = true
        
        
        collectionView.collectionViewLayout = createiPhoneLayout()
        switch currentDeviceModel {
        case .phone:
            collectionView.collectionViewLayout = createiPhoneLayout()
        case .pad:
            collectionView.collectionViewLayout = createiIPadRegularLayout()
        default:
            break
        }
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.reuseIdentifier)
        collectionView.register(UINib(nibName: "CourseHomeBigCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CourseHomeBigCollectionViewCell.reuseIdentifier)
        collectionView.register(UINib(nibName: "CourseHomeSmallCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CourseHomeSmallCollectionViewCell.reuseIdentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // 初始化 ViewModel 並設置委託
        viewModel.delegate = self
        viewModel.loadCourses()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

extension HomeViewController: CourseViewModelDelegate {
    
    func didUpdata(_ rootData: RootModel) {
        print("User Updated: \(rootData)")
        self.categories = rootData.data ?? []
        
        rootData.data?.forEach({ res in
            self.categoriesArray.append(res.category ?? "")
            self.courses = res.courses ?? []
        })
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithError(_ error: DataServieError) {
        print("API Error: \(error)")
    }
}



extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as! HeaderView
        
        headerView.titleLb.text = categories[indexPath.section].category
        
        return headerView
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayItemCount(for: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let categoryData = categories[indexPath.section]
        
        let cellType = getCellType(for: indexPath)
        
        switch cellType {
        case .bigCell:
            guard let bigCell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseHomeBigCollectionViewCell.reuseIdentifier,for: indexPath) as? CourseHomeBigCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            bigCell.configure(model: categoryData.courses?[indexPath.row])
            
            return bigCell
            
        case .smallCell:
            guard let smallCell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseHomeSmallCollectionViewCell.reuseIdentifier,for: indexPath) as? CourseHomeSmallCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            smallCell.configure(model: categoryData.courses?[indexPath.row])
            
            return smallCell
        }
        
    }
}


//MARK: - GetCellType
extension HomeViewController {
    
    // 取得裝置資訊
    var currentDeviceModel: UIUserInterfaceIdiom {
        UIDevice.current.userInterfaceIdiom
    }
    
    // 根據裝置型號和 indexPath 返回 CellType
    func getCellType(for indexPath: IndexPath) -> CellType {
        var cellType: CellType = .smallCell
        
        switch currentDeviceModel {
        case .phone:
            if indexPath.item == 0 {
                return .bigCell
            } else {
                return .smallCell
            }
        case .pad:
            cellType = .smallCell
        default:
            break
        }
        
        return cellType
    }
    
    
    // 根據裝置型號返回每行顯示的課程數量
    func displayItemCount(for section: Int) -> Int {
        
        var count = 0
        let courses = categories[section].courses ?? []
        
        switch currentDeviceModel {
        case .phone:
            count = (courses.count >= maxDisplayItemsFor_iPhone) ? maxDisplayItemsFor_iPhone : courses.count
        case .pad:
            count = (courses.count >= maxDisplayItemsFor_iPad) ? maxDisplayItemsFor_iPad : courses.count
        default :
            break
        }
        
        return count
    }
}

//MARK: - createiLayout
extension HomeViewController {
    
    func createiPhoneLayout() -> UICollectionViewLayout {
        let bigItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(370))
        let bigItem = NSCollectionLayoutItem(layoutSize: bigItemSize)
        
        let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90))
        let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [bigItem, smallItem, smallItem])
        
        group.interItemSpacing = .fixed(12)
        
        let section = NSCollectionLayoutSection(group: group)
        
        // 設定 header 的大小
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        
        // 負責描述 supplementary item 的物件
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        // 指定 supplementary item 給 section
        section.boundarySupplementaryItems = [headerItem]
        
        // 增加 section 邊緣的空間
        section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func createiIPadRegularLayout() -> UICollectionViewLayout {
        let viewWidth: CGFloat = view.bounds.width
        let itemWidth: CGFloat = viewWidth / 2 - 16
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(itemWidth), heightDimension: .absolute(90.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(viewWidth), heightDimension: .estimated(180.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item, item, item])
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: NSCollectionLayoutSpacing.fixed(0.0), top: NSCollectionLayoutSpacing.fixed(0.0), trailing: NSCollectionLayoutSpacing.fixed(0.0), bottom: NSCollectionLayoutSpacing.fixed(10))

        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

//MARK: - Alert
extension HomeViewController {
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
    
}
