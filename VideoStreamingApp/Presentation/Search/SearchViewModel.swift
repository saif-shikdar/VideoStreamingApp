//
//  SearchViewModel.swift
//  PhotoSearch
//
//  Created by Saif on 07/07/22
//

import Foundation
import Combine

protocol SearchViewModelAction {
    func navigateToGallery(for index:Int)
}

protocol SearchViewModelInput {
    func getGalleryVideos() async
}

protocol SearchViewModelOutput {
    var state: SearchViewStates {get}
    var videoRecordsCount: Int {get}
    func getVideoDetails(index: Int)-> VideoRecord
}

final class SearchViewModel {
   
    private var searchUseCase: SearchUseCase

    private var videoRecords: [VideoRecord] = []
 
    @Published  var state: SearchViewStates = .none
    
    private var cancellables:Set<AnyCancellable> = Set()
    
    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
    }
}

extension SearchViewModel: SearchViewModelOutput {
    var videoRecordsCount: Int {
        return videoRecords.count
    }
    func getVideoDetails(index: Int) -> VideoRecord {
        return videoRecords[index]
    }
}

extension SearchViewModel: SearchViewModelAction {
    func navigateToGallery(for index:Int) {
        
        guard let url = videoRecords[index].videoUrl else {
            state = .showError(APIError.invalidData.localizedDescription)
            return
        }
        state = .showVideoGallery(url)
    }
}

extension SearchViewModel: SearchViewModelInput {
    func getGalleryVideos() async {
        state = .showActivityIndicator
        do {
            videoRecords = try await  searchUseCase.execute()
            
            state = .showVideosList
        } catch {
            state = .showError((error as! APIError).localizedDescription)
        }
    }
}

