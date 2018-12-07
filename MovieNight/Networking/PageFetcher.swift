//
//  PageFetcher.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/6/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Fetches pages and caches the results in the entities property.
class PageFetcher<T: Codable> {
    /// A closure that has parameters for page number, and a completion handler.
    typealias ApiRequest = (Int, @escaping (ApiResult<Page<T>>) -> Void) -> Void
    /// The closure that is called to request more entities.
    /// This should only be assigned once.
    var apiRequest: ApiRequest?
    /// A list of all fetched entities
    private(set) var entities = [T]()
    /// The latest fetch result page
    private(set) var currentPage: Page<T>?
    /// The total number of results that can be fetched.
    private(set) var totalResults = 0
    /// Is a fetch currently in progress.
    private(set) var isFetchInProgress = false
    
    /// Fetch entities and cache them.
    /// Keeps track of which pages have been loaded and will load the next page that hasn't been fetch yet.
    ///
    /// - Parameter completionHandler: Called when fetch has completed.
    func fetch(completionHandler: @escaping (ApiResult<Page<T>>) -> Void) {
        guard let apiRequest = apiRequest else {
            print("Error: PageFetcher.apiRequest is nil.")
            return
        }
        
        // Check to make sure the last page hasn't been loaded
        if let page = currentPage {
            guard page.page < page.totalPages && page.page < TmdbClient.maxPage else {
                return
            }
        }
        // Only allow one fetch at a time
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        // Fetch the next page
        let pageNumber = currentPage?.page ?? 0
        
        apiRequest(pageNumber + 1) { [weak self] (apiResult) in
            guard let s = self else {
                return
            }
            
            switch apiResult {
            case .success(let result):
                // Append results to stored property
                s.currentPage = result
                s.entities += result.results
                
                // Storing totalResults from first page instead of updating for every new result
                // because UITableView will crash if total results changes in UITableViewDataSource.
                // See comments at the bottom for a detailed example crash log.
                if result.page == 1 {
                    s.totalResults = result.totalResults
                }
            case .failure:
                // completionHandler will pass along the failure
                break
            }
            
            s.isFetchInProgress = false
            
            completionHandler(apiResult)
        }
    }
}

/**
 https://api.themoviedb.org/3/person/popular?api_key=021688f88c70406f5ba54448449a301d&page=6
 totalResults: 18078
 https://api.themoviedb.org/3/person/popular?api_key=021688f88c70406f5ba54448449a301d&page=7
 totalResults: 18077
 2018-12-06 16:49:51.819387-0800 MovieNight[39791:3701586] *** Assertion failure in -[UITableView _endCellAnimationsWithContext:], /BuildRoot/Library/Caches/com.apple.xbs/Sources/UIKitCore_Sim/UIKit-3698.93.8/UITableView.m:2062
 2018-12-06 16:49:51.829639-0800 MovieNight[39791:3701586] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Invalid update: invalid number of rows in section 0.  The number of rows contained in an existing section after the update (18077) must be equal to the number of rows contained in that section before the update (18078), plus or minus the number of rows inserted or deleted from that section (0 inserted, 0 deleted) and plus or minus the number of rows moved into or out of that section (0 moved in, 0 moved out).'
 *** First throw call stack:
 (
 0   CoreFoundation                      0x000000010f3271bb __exceptionPreprocess + 331
 1   libobjc.A.dylib                     0x000000010d905735 objc_exception_throw + 48
 2   CoreFoundation                      0x000000010f326f42 +[NSException raise:format:arguments:] + 98
 3   Foundation                          0x000000010d308877 -[NSAssertionHandler handleFailureInMethod:object:file:lineNumber:description:] + 194
 4   UIKitCore                           0x0000000111f9de2d -[UITableView _endCellAnimationsWithContext:] + 18990
 5   UIKitCore                           0x0000000111fb8cb0 -[UITableView _updateRowsAtIndexPaths:withUpdateAction:rowAnimation:usingPresentationValues:] + 1384
 6   UIKitCore                           0x0000000111fb9041 -[UITableView reloadRowsAtIndexPaths:withRowAnimation:] + 133
 7   MovieNight                          0x000000010cf4fea5 $S10MovieNight16PeopleDataSourceC5fetchyyFyAA9ApiResultOyAA4PageVyAA6PersonVGGcfU_ + 517
 8   MovieNight                          0x000000010cf5000c $S10MovieNight16PeopleDataSourceC5fetchyyFyAA9ApiResultOyAA4PageVyAA6PersonVGGcfU_TA + 12
 9   MovieNight                          0x000000010cf36631 $S10MovieNight11PageFetcherC5fetch17completionHandleryyAA9ApiResultOyAA0C0VyxGGc_tFyAKcfU_ + 1313
 10  MovieNight                          0x000000010cf366e7 $S10MovieNight11PageFetcherC5fetch17completionHandleryyAA9ApiResultOyAA0C0VyxGGc_tFyAKcfU_TA + 55
 11  MovieNight                          0x000000010cf49534 $S10MovieNight9ApiResultOyAA4PageVyAA6PersonVGGIegg_AIIegn_TR + 52
 12  MovieNight                          0x000000010cf49591 $S10MovieNight9ApiResultOyAA4PageVyAA6PersonVGGIegg_AIIegn_TRTA + 17
 13  MovieNight                          0x000000010cf60c26 $S10MovieNight9ApiClientPAAE5fetch4with17completionHandlery10Foundation10URLRequestV_yAA0C6ResultOyqd__GctSeRd__lFyAG4DataVSg_So13NSURLResponseCSgs5Error_pSgtcfU_yycfU_ + 1462
 14  MovieNight                          0x000000010cf61fa5 $S10MovieNight9ApiClientPAAE5fetch4with17completionHandlery10Foundation10URLRequestV_yAA0C6ResultOyqd__GctSeRd__lFyAG4DataVSg_So13NSURLResponseCSgs5Error_pSgtcfU_yycfU_TA + 117
 15  MovieNight                          0x000000010cf44b8d $SIeg_IeyB_TR + 45
 16  libdispatch.dylib                   0x0000000110833595 _dispatch_call_block_and_release + 12
 17  libdispatch.dylib                   0x0000000110834602 _dispatch_client_callout + 8
 18  libdispatch.dylib                   0x000000011084199a _dispatch_main_queue_callback_4CF + 1541
 19  CoreFoundation                      0x000000010f28c3e9 __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__ + 9
 20  CoreFoundation                      0x000000010f286a76 __CFRunLoopRun + 2342
 21  CoreFoundation                      0x000000010f285e11 CFRunLoopRunSpecific + 625
 22  GraphicsServices                    0x00000001175261dd GSEventRunModal + 62
 23  UIKitCore                           0x0000000111d9581d UIApplicationMain + 140
 24  MovieNight                          0x000000010cf5f507 main + 71
 25  libdyld.dylib                       0x00000001108aa575 start + 1
 )
 libc++abi.dylib: terminating with uncaught exception of type NSException
*/
