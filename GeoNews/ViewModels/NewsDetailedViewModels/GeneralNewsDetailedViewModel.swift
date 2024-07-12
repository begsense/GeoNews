//
//  GeneralNewsDetailedViewModel.swift
//  GeoNews
//
//  Created by M1 on 11.07.2024.
//

import Foundation

class GeneralNewsDetailedViewModel: NewsDetailedViewModelProtocol {
    var selectedNews: News?
}

protocol NewsDetailedViewModelProtocol {
    var selectedNews: News? { get }
}
