import MixboxTestsFoundation
import Photos
import XCTest

final class PhotoStubberTests: TestCase {
    // TODO: Fix running on CI
    func disabled_test() {
        setUpPhotosPermissions()
        
        removeAllImagesFromSimulator()
        
        // count == 0: Check if previous code drops the state
        // count == 10, 20, 30: Actual test
        for count in [0, 10, 20, 30] {
            stubPhotos(minimalCount: count)
            XCTAssertEqual(photosCount(), count)
        }
        
        // If we require minimalCount of photos we don't want to delete exisitng photos
        stubPhotos(minimalCount: 20)
        XCTAssertEqual(photosCount(), 30)
        
        // Check again if this test drops state correctly.
        // There was a situation when I was running test twice. The following lines are to not run test twice.
        removeAllImagesFromSimulator()
        XCTAssertEqual(photosCount(), 0)
        
        stubPhotos(minimalCount: 20)
        XCTAssertEqual(photosCount(), 20)
    }
    
    private func stubPhotos(minimalCount: Int) {
        do {
            try photoStubber.stubPhotos(minimalCount: minimalCount)
        } catch {
            XCTFail("Failed to stub photos: \(error)")
        }
    }
    
    private func setUpPhotosPermissions() {
        // TODO: Move optimization to PermissionSetter?
        // Note that it is only valid for current process, so it is not generic.
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            testRunnerPermissions.photos.set(.allowed)
        }
    }
    
    private func photosCount() -> Int {
        return PHAsset.fetchAssets(with: .image, options: PHFetchOptions()).count
    }
    
    private func removeAllImagesFromSimulator() {
        var thereArePhotosToDelete: Bool?
        PHPhotoLibrary.shared().performChanges(
            {
                let allPhotos = PHAsset.fetchAssets(with: .image, options: PHFetchOptions())
                // swiftlint:disable:next empty_count
                thereArePhotosToDelete = allPhotos.count > 0
                PHAssetChangeRequest.deleteAssets(allPhotos)
            }, completionHandler: { _, error in
                if let error = error {
                    XCTFail("Error while deleting photos: \(error)")
                }
            }
        )
        
        while thereArePhotosToDelete == nil {
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 1))
        }
        
        if let thereArePhotosToDelete = thereArePhotosToDelete {
            if thereArePhotosToDelete {
                allowDeletingPhotos()
            }
        }
    }
    
    private func allowDeletingPhotos() {
        guard let springboard = XCUIApplication(privateWithPath: nil, bundleID: "com.apple.springboard") else {
            XCTFail("Couldn't find springboard app")
            return
        }
        
        let deleteButton = springboard.buttons.element(
            matching: NSPredicate(
                format: "label = 'Удалить' or label = 'Delete'",
                argumentArray: []
            )
        )
        
        if deleteButton.waitForExistence(timeout: 15) {
            deleteButton.tap()
            
            spinner.spin(
                timeout: 5,
                interval: 1,
                until: { [weak self] in
                    if deleteButton.exists {
                        return false
                    } else if let strongSelf = self {
                        return strongSelf.photosCount() == 0
                    } else {
                        return true
                    }
                }
            )
        } else {
            XCTFail("Delete button did not appear")
        }
    }
}
