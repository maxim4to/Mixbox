import UIKit

enum ZeroMiddleOneValue: Int {
    case zero = 0
    case middle
    case one
    
    // 0, 1 are boundaries
    // 0.5 is not enough for finding bugs with a sign.
    var alpha: CGFloat {
        return [0, 0.35, 1][index]
    }
    var overlapping: CGFloat {
        return [0, 0.35, 1][index]
    }
    var overlappedAreaRange: ClosedRange<CGFloat> {
        return [0...0, 0.2...0.5, 1...1][index]
    }
    var blendingThresholdRange: ClosedRange<CGFloat> {
        return [0...0, 0.1...0.4, 1...1][index]
    }
    
    private var index: Int {
        return self.rawValue
    }
}

final class VisibilityCheckTestDataProvider {
    // testDataToPreciselyCheckValues
    func testDataToCheckOverlapping() -> [VisibilityCheckTestsViewSettings] {
        return (0..<100).map { value in
            VisibilityCheckTestsViewSettings(
                overlappedColor: Color(
                    red: 0.5,
                    green: 0.5,
                    blue: 0,
                    alpha: 1
                ),
                overlappingColor: Color(
                    red: 0,
                    green: 1,
                    blue: 1,
                    alpha: CGFloat(value) / 100.0
                ),
                superviewColor: Color(
                    red: 1,
                    green: 1,
                    blue: 1,
                    alpha: 1
                ),
                overlapping: 1,
                id: "testDataToPreciselyCheckValues_\(value)",
                blendingThresholdRange: 0...1,
                overlappedAreaRange: 0...1
            )
        }
    }
//    func testDataToPreciselyCheckValues() -> [VisibilityCheckTestsViewSettings] {
//        return (0..<100).map { value in
//            VisibilityCheckTestsViewSettings(
//                overlappedColor: Color(
//                    red: 1,
//                    green: 0,
//                    blue: 0,
//                    alpha: 1
//                ),
//                overlappingColor: Color(
//                    red: 0,
//                    green: 1,
//                    blue: 0,
//                    alpha: CGFloat(value) / 100.0
//                ),
//                superviewColor: Color(
//                    red: 1,
//                    green: 1,
//                    blue: 1,
//                    alpha: 1
//                ),
//                overlapping: 1,
//                id: "testDataToPreciselyCheckValues_\(value)",
//                blendingThresholdRange: 0...1,
//                overlappedAreaRange: 0...1
//            )
//        }
//    }
    
//    func testDataToCheckOverlapping() -> [VisibilityCheckTestsViewSettings] {
//        var testData = [VisibilityCheckTestsViewSettings]()
//
//        let values: [ZeroMiddleOneValue] = [.zero, .middle, .one]
//
//        // With constant RGB.
//        iterate([values, values, values, values]) { _, values in
//            let overlappedColor = values[0]
//            let overlappingColor = values[1]
//            let superviewColor = values[2]
//            let overlapping = values[3]
//            
//            let settings = VisibilityCheckTestsViewSettings(
//                overlappedColor: Color(
//                    red: 1,
//                    green: 0,
//                    blue: 0,
//                    alpha: overlappedColor.alpha
//                ),
//                overlappingColor: Color(
//                    red: 0,
//                    green: 1,
//                    blue: 0,
//                    alpha: overlappingColor.alpha
//                ),
//                superviewColor: Color(
//                    red: 1,
//                    green: 1,
//                    blue: 1,
//                    alpha: superviewColor.alpha
//                ),
//                overlapping: overlapping.overlapping,
//                id: "overlappedColorAlpha=\(overlappedColor.alpha)"
//                    + ",overlappingColorAlpha=\(overlappingColor.alpha)"
//                    + ",superviewColorAlpha=\(superviewColor.alpha)"
//                    + ",overlapping=\(overlapping.overlapping)",
//                blendingThresholdRange: overlappingColor.blendingThresholdRange,
//                overlappedAreaRange: overlapping.overlappedAreaRange
//            )
//            testData.append(settings)
//        }
//        
//        return testData
//    }
    
//    func testDataToCheckOVerlapping() -> [VisibilityCheckTestsViewSettings] {
//        // To check that RGB doesn't matter
//        iterate([
//            colorTestData, colorTestData, colorTestData,
//            colorTestData, colorTestData, colorTestData,
//            ])
//        { index, values in
//            let settings = VisibilityCheckTestsViewSettings(
//                overlappedColor: Color(
//                    red: values[0],
//                    green: values[1],
//                    blue: values[2],
//                    alpha: 0.35
//                ),
//                overlappingColor: Color(
//                    red: values[3],
//                    green: values[4],
//                    blue: values[5],
//                    alpha: 0.35
//                ),
//                superviewColor: Color(
//                    red: 1,
//                    green: 1,
//                    blue: 1,
//                    alpha: 1
//                ),
//                overlapping: 0.35,
//                higherThanBlendingThreshold: 0, // FIXME
//                lowerThanBlendingThreshold: 0, // FIXME
//                id: "rgb#\(index)"
//            )
//            testData.append(settings)
//        }
//
//        return testData
//    }
    
    
//    func testDataForOverlappingTests() -> [VisibilityCheckTestsViewSettings] {
//        let single = VisibilityCheckTestsViewSettings(
//            overlappedColor: Color(red: 0, green: 1, blue: 0, alpha: 1),
//            overlappingColor: Color(red: 0, green: 0, blue: 0, alpha: 0.5),
//            superviewColor: Color(red: 1, green: 1, blue: 1, alpha: 1),
//            overlapping: 1,
//            id: "",
//            blendingThresholdRange: 0.4...0.6,
//            overlappedAreaRange: 1...1
//        )
//
//        return [single]
//    }

    // Examples (todo: make tests? do we need this utility at all?)
    //test(
    //    [
    //        [1, 2], [3, 4]
    //    ],
    //    [
    //        [1, 3],
    //        [1, 4],
    //        [2, 3],
    //        [2, 4]
    //    ]
    //)
    //test(
    //    [
    //        [1, 2]
    //    ],
    //    [
    //        [1],
    //        [2]
    //    ]
    //)
    //test(
    //    [
    //        [Int]()
    //    ],
    //    [
    //    ]
    //)
    //test(
    //    [
    //        [1],
    //        [2, 3]
    //    ],
    //    [
    //        [1, 2],
    //        [1, 3],
    //    ]
    //)
    private func iterate<T>(_ sets: [[T]], closure: (Int, [T]) -> ()) {
        var index = 0
        iterate(sets, startingSet: 0) { values in
            closure(index, values)
            index += 1
        }
    }
    private func iterate<T>(_ sets: [[T]], startingSet: Int, closure: ([T]) -> ()) {
        guard startingSet < sets.count else {
            return
        }
        
        let set = sets[startingSet]
        for value in set {
            if startingSet == sets.count - 1 {
                closure([value])
            } else {
                iterate(sets, startingSet: startingSet + 1) { (values: [T]) in
                    closure([value] + values)
                }
            }
        }
    }
}
