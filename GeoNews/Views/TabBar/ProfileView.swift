//
//  ProfileView.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import UIKit

class CenterScaleFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        let center = collectionView!.bounds.size.width / 2 + collectionView!.contentOffset.x
        
        for attribute in attributes {
            let distance = abs(attribute.center.x - center)
            let scale = max(1 - distance / center, 0.7)
            attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}


class ProfileView: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var viewModel: ProfileViewModel
    
    private var scrollView = UIScrollView()
    
    private var contentView = UIView()
    
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "person.crop.circle")
        return imageView
    }()
    
    private var userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "FiraGO-Regular", size: 20)
        label.text = "Loading..."
        label.numberOfLines = 0
        return label
    }()
    
    private var favoritesTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Regular", size: 20)
        label.text = "Favorites 💌"
        label.numberOfLines = 0
        return label
    }()
    
    private var favoritesCollectionView: UICollectionView = {
        let collectionViewLayout = CenterScaleFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.itemSize = CGSize(width: 130, height: 140)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var readLaterTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "FiraGO-Regular", size: 20)
        label.text = "Read Later ⏰"
        label.numberOfLines = 0
        return label
    }()
    
    private var readLaterCollectionView: UICollectionView = {
        let collectionViewLayout = CenterScaleFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.itemSize = CGSize(width: 130, height: 140)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private var pickerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "FiraGO-Regular", size: 20)
        label.text = "You Can Change News Design ↓"
        label.numberOfLines = 0
        return label
    }()
    
    private var cellPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.backgroundColor = .clear
        pickerView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        return pickerView
    }()
    
    private var emptyFavoritesImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "emptyFavorites"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white.withAlphaComponent(0.4)
        return imageView
    }()
    
    private var emptyReadLaterImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "emptyReadLater"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white.withAlphaComponent(0.4)
        return imageView
    }()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchFavoriteNews()
        viewModel.fetchReadLaterNews()
    }
    
    private func setupUI() {
        let gradientLayer = GradientLayer(bounds: view.bounds)
        view.layer.insertSublayer(gradientLayer, at: 0)
        setupScrollView()
        setupProfileImage()
        setupUserLabel()
        setupFavoritesTitle()
        setupFavoritesCollectionView()
        setupEmptyFavoritesImageView()
        setupReadLaterTitle()
        setupReadLaterCollectionView()
        setupEmptyReadLaterImageView()
        setupPickerTitle()
        setupPicker()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupProfileImage() {
        contentView.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        profileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setupUserLabel() {
        contentView.addSubview(userLabel)
        
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5),
            userLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            userLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupFavoritesTitle() {
        contentView.addSubview(favoritesTitle)
        
        NSLayoutConstraint.activate([
            favoritesTitle.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 15),
            favoritesTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
    }
    
    private func setupFavoritesCollectionView() {
        contentView.addSubview(favoritesCollectionView)

        NSLayoutConstraint.activate([
            favoritesCollectionView.topAnchor.constraint(equalTo: favoritesTitle.bottomAnchor, constant: 10),
            favoritesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            favoritesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favoritesCollectionView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.delegate = self
        favoritesCollectionView.register(SavedNewsCell.self, forCellWithReuseIdentifier: SavedNewsCell.identifier)
    }
    
    private func setupEmptyFavoritesImageView() {
        contentView.addSubview(emptyFavoritesImageView)
        
        NSLayoutConstraint.activate([
            emptyFavoritesImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emptyFavoritesImageView.centerYAnchor.constraint(equalTo: favoritesCollectionView.centerYAnchor),
            emptyFavoritesImageView.widthAnchor.constraint(equalToConstant: 100),
            emptyFavoritesImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        emptyFavoritesImageView.isHidden = !viewModel.favoriteNews.isEmpty
    }
    
    private func setupReadLaterTitle() {
        contentView.addSubview(readLaterTitle)
        
        NSLayoutConstraint.activate([
            readLaterTitle.topAnchor.constraint(equalTo: favoritesCollectionView.bottomAnchor, constant: 15),
            readLaterTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
    }
    
    private func setupEmptyReadLaterImageView() {
        contentView.addSubview(emptyReadLaterImageView)
        
        NSLayoutConstraint.activate([
            emptyReadLaterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emptyReadLaterImageView.centerYAnchor.constraint(equalTo: readLaterCollectionView.centerYAnchor),
            emptyReadLaterImageView.widthAnchor.constraint(equalToConstant: 100),
            emptyReadLaterImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        emptyReadLaterImageView.isHidden = !viewModel.readLaterNews.isEmpty
    }
    
    private func setupReadLaterCollectionView() {
        contentView.addSubview(readLaterCollectionView)
        
        NSLayoutConstraint.activate([
            readLaterCollectionView.topAnchor.constraint(equalTo: readLaterTitle.bottomAnchor, constant: 10),
            readLaterCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            readLaterCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            readLaterCollectionView.heightAnchor.constraint(equalToConstant: 140)
        ])
        
        readLaterCollectionView.dataSource = self
        readLaterCollectionView.delegate = self
        readLaterCollectionView.register(SavedNewsCell.self, forCellWithReuseIdentifier: SavedNewsCell.identifier)
    }
    
    private func setupPickerTitle() {
        contentView.addSubview(pickerTitle)
        
        NSLayoutConstraint.activate([
            pickerTitle.topAnchor.constraint(equalTo: readLaterCollectionView.bottomAnchor, constant: 20),
            pickerTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15)
        ])
    }

    private func setupPicker() {
        contentView.addSubview(cellPicker)
        
        NSLayoutConstraint.activate([
            cellPicker.topAnchor.constraint(equalTo: pickerTitle.bottomAnchor),
            cellPicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            cellPicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            cellPicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        cellPicker.dataSource = self
        cellPicker.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.onProfileImageUpdated = { [weak self] in
            DispatchQueue.main.async {
                if let image = self?.viewModel.loadProfileImage() {
                    self?.profileImageView.image = image
                } else {
                    self?.profileImageView.image = UIImage(systemName: "person.crop.circle")
                }
            }
        }
        
        viewModel.onProfileImageUpdated?()
        
        viewModel.onFavoritesUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.favoritesCollectionView.reloadData()
            }
        }
        
        viewModel.onReadLaterUpdated = { [weak self] in
            self?.readLaterCollectionView.reloadData()
        }
        
        viewModel.fetchFavoriteNews()
        
        viewModel.fetchUserData()
        
        viewModel.updateUserLabel = { [weak self] text in
            self?.userLabel.text = text
        }
    }
    
    @objc private func profileImageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            viewModel.saveProfileImage(image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CellStyleManager.shared.cellStyles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CellStyleManager.shared.cellStyles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CellStyleManager.shared.selectCellStyle(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "FiraGO-Regular", size: 20)
        
        label.backgroundColor = UIColor(red: 0/255, green: 64/255, blue: 99/255, alpha: 0.6)
        label.layer.cornerRadius = 15
        
        label.text = CellStyleManager.shared.cellStyles[row]
        return label
    }
}

extension ProfileView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == favoritesCollectionView {
            return viewModel.favoriteNews.count
        } else if collectionView == readLaterCollectionView {
            return viewModel.readLaterNews.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedNewsCell.identifier, for: indexPath)
        let newsItem = collectionView == favoritesCollectionView ? viewModel.favoriteNews(at: indexPath.row) : viewModel.readLaterNews(at: indexPath.row)
        
        if let configurableCell = cell as? ConfigurableNewsCell {
            configurableCell.configure(with: newsItem)
        }
        return cell
    }
    
    
}

extension ProfileView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedNews = collectionView == favoritesCollectionView ? viewModel.favoriteNews[indexPath.item] : viewModel.readLaterNews(at: indexPath.row)
        let newsDetailedViewModel = NewsDetailedViewModel()
        newsDetailedViewModel.selectedNews = selectedNews
        let detailView = NewsDetailedView(viewModel: newsDetailedViewModel)
        
        navigationController?.pushViewController(detailView, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
