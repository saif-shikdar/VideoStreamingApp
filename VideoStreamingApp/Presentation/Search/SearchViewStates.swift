//
//  ViewStates.swift
//  PhotoSearch
//
//  Created by Saif on 07/07/22
//

import Foundation

enum SearchViewStates: Equatable {
    case showActivityIndicator
    case showVideosList
    case showError(String)
    case showVideoGallery(URL)
    case none
}
