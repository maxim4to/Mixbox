import MixboxTestsFoundation
import MixboxFoundation

// Настройки взаимодействия (действия, проверки) с примененными настройками элемента.
// Настройки элемента менее приоритетны. На 27.02.2018 они не пересекались, но могут пересекаться в будущем.
public final class ResolvedInteractionSettings {
    public let interactionSettings: InteractionSettings // TODO: Private.
    public let elementSettings: ElementSettings // TODO: Private.
    public let pollingConfiguration: PollingConfiguration
    public let visibilityCheckSettings: VisibilityCheckSettings
    
    public var elementName: String {
        return elementSettings.name
    }
    
    public var shouldAutoScroll: Bool {
        return elementSettings.searchMode == .scrollUntilFound
    }
    
    public var fileLineWhereExecuted: FileLine {
        return interactionSettings.fileLineWhereExecuted
    }
    
    public var interactionName: String {
        return interactionSettings.descriptionBuilder.buildFunction(
            HumanReadableInteractionDescriptionBuilderSource(
                elementName: elementSettings.name
            )
        )
    }
    
    public init(
        interactionSettings: InteractionSettings,
        elementSettings: ElementSettings,
        pollingConfiguration: PollingConfiguration,
        defaultVisibilityCheckSettings: VisibilityCheckSettings)
    {
        self.interactionSettings = interactionSettings
        self.elementSettings = elementSettings
        self.pollingConfiguration = pollingConfiguration
        self.visibilityCheckSettings = defaultVisibilityCheckSettings.customized(
            customization: elementSettings.visibilityCheckSettingsCustomization
        )
    }
}
