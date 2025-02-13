import XCTest

// TODO: Share with GrayBoxUiTests
final class NetworkRecordingTests: BaseNetworkMockingTestCase {
    func test_networkRecording_works() {
        legacyNetworking.recording.startRecording()
        
        openScreen(screen)
        
        screen.localhost.tap()
        
        XCTAssertEqual(
            legacyNetworking.recording.lastRequest(urlPattern: "localhost")?.responseString(),
            notStubbedText
        )
    }
}
