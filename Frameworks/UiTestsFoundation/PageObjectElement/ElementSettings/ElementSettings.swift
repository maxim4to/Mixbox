public final class ElementSettings {
    public let name: String
    public let matcher: ElementMatcher
    public let searchMode: SearchMode
    public let searchTimeout: TimeInterval?
    public let interactionMode: InteractionMode
    public let visibilityCheckSettingsCustomization: VisibilityCheckSettingsCustomization
    
    public init(
        name: String,
        matcher: ElementMatcher,
        searchMode: SearchMode,
        searchTimeout: TimeInterval?, // nil == default
        interactionMode: InteractionMode,
        visibilityCheckSettingsCustomization: VisibilityCheckSettingsCustomization)
    {
        self.name = name
        self.matcher = matcher
        self.searchMode = searchMode
        self.searchTimeout = searchTimeout
        self.interactionMode = interactionMode
        self.visibilityCheckSettingsCustomization = visibilityCheckSettingsCustomization
    }
    
    func with(name: String) -> ElementSettings {
        return ElementSettings(
            name: name,
            matcher: matcher,
            searchMode: searchMode,
            searchTimeout: searchTimeout,
            interactionMode: interactionMode,
            visibilityCheckSettingsCustomization: visibilityCheckSettingsCustomization

        )
    }
    
    func with(matcher: ElementMatcher) -> ElementSettings {
        return ElementSettings(
            name: name,
            matcher: matcher,
            searchMode: searchMode,
            searchTimeout: searchTimeout,
            interactionMode: interactionMode,
            visibilityCheckSettingsCustomization: visibilityCheckSettingsCustomization

        )
    }
    
    func with(searchMode: SearchMode) -> ElementSettings {
        return ElementSettings(
            name: name,
            matcher: matcher,
            searchMode: searchMode,
            searchTimeout: searchTimeout,
            interactionMode: interactionMode,
            visibilityCheckSettingsCustomization: visibilityCheckSettingsCustomization

        )
    }
    
    func with(searchTimeout: TimeInterval?) -> ElementSettings {
        return ElementSettings(
            name: name,
            matcher: matcher,
            searchMode: searchMode,
            searchTimeout: searchTimeout,
            interactionMode: interactionMode,
            visibilityCheckSettingsCustomization: visibilityCheckSettingsCustomization

        )
    }
    
    func with(interactionMode: InteractionMode) -> ElementSettings {
        return ElementSettings(
            name: name,
            matcher: matcher,
            searchMode: searchMode,
            searchTimeout: searchTimeout,
            interactionMode: interactionMode,
            visibilityCheckSettingsCustomization: visibilityCheckSettingsCustomization
        )
    }
    
    func with(visibilityCheckSettingsCustomization: VisibilityCheckSettingsCustomization) -> ElementSettings {
        return ElementSettings(
            name: name,
            matcher: matcher,
            searchMode: searchMode,
            searchTimeout: searchTimeout,
            interactionMode: interactionMode,
            visibilityCheckSettingsCustomization: visibilityCheckSettingsCustomization
        )
    }
    
    func with(minimalPercentageOfVisibleArea: CGFloat?) -> ElementSettings {
        return with(
            visibilityCheckSettingsCustomization: VisibilityCheckSettingsCustomization(
                minimalPercentageOfVisibleArea: minimalPercentageOfVisibleArea,
                blendingThreshold: visibilityCheckSettingsCustomization.blendingThreshold
            )
        )
    }
    
    func with(blendingThresholdForVisibilityCheck: CGFloat?) -> ElementSettings {
        return with(
            visibilityCheckSettingsCustomization: VisibilityCheckSettingsCustomization(
                minimalPercentageOfVisibleArea: visibilityCheckSettingsCustomization.minimalPercentageOfVisibleArea,
                blendingThreshold: blendingThresholdForVisibilityCheck
            )
        )
    }
}
