public enum SearchMode {
    // Do not scroll
    case useCurrentlyVisible
    // Scroll
    case scrollUntilFound
    
    // Temporary (UPD: more than 1 year now) case to scroll "blindly" without knowledge where the element is.
    // For example, might be useful when element doesn't appear until scroll view is scrolled to it and it can
    // not be faked out (as in UICollectionView).
    case scrollBlindly
    
    public static let `default`: SearchMode = .scrollUntilFound
}
