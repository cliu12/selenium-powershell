using namespace system.Collections
using namespace System.Collections.Generic
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

using module ".\SeleniumSelection.psm1"

Add-Type -AssemblyName Microsoft.PowerShell.Commands.Utility


if ('ValidateURIAttribute' -as [type]) {
    class ValidateURIAttribute :  System.Management.Automation.ValidateArgumentsAttribute {
        [void] Validate([object] $arguments , [System.Management.Automation.EngineIntrinsics]$EngineIntrinsics) {
            $Out = $null
            if ([uri]::TryCreate($arguments, [System.UriKind]::Absolute, [ref]$Out)) { return }
            else { throw  [System.Management.Automation.ValidationMetadataException]::new('Incorrect StartURL please make sure the URL starts with http:// or https://') }
            return
        }
    }    
    class ValidateURI : ValidateURIAttribute {}
}


if ('ValidateIsWebDriverAttribute' -as [type]) {
    class ValidateIsWebDriverAttribute :  System.Management.Automation.ValidateArgumentsAttribute {
        [void] Validate([object] $arguments , [System.Management.Automation.EngineIntrinsics]$EngineIntrinsics) {
            if ($arguments -isnot [OpenQA.Selenium.Remote.RemoteWebDriver]) {
                throw  [System.Management.Automation.ValidationMetadataException]::new('Target was not a valid web driver')
            }
            return
        }
    }
    class ValidateIsWebDriver : ValidateIsWebDriverAttribute {}
}



if ('OperatorTransformAttribute' -as [type]) {
    #Allow operator to use containing, matching, matches, equals etc.
    class OperatorTransformAttribute : System.Management.Automation.ArgumentTransformationAttribute {
        [object] Transform([System.Management.Automation.EngineIntrinsics]$EngineIntrinsics, [object] $InputData) {
            if ($inputData -match '^(contains|like|notlike|match|notmatch|eq|ne|gt|lt)$') {
                return $InputData
            }
            switch -regex ($InputData) {
                "^contain" { return 'contains' ; break }
                "^match" { return 'match'    ; break }
                "^n\w*match" { return 'notmatch' ; break }
                "^eq" { return 'eq'       ; break }
                "^n\w*eq" { return 'ne'       ; break }
                "^n\w*like" { return 'like'       ; break }
            }
            return $InputData
        }
    }

    class OperatorTransform : OperatorTransformAttribute {}
}

enum SeBrowsers {
    Chrome
    Edge 
    Firefox
    InternetExplorer
    MSEdge
}

enum SeWindowState {
    Headless
    Default
    Minimized
    Maximized
    Fullscreen
}

enum SeBySelector {
    ClassName
    CssSelector
    Id
    LinkText
    PartialLinkText
    Name
    TagName
    XPath
}

enum SeBySelect {
    Index
    Text
    Value    
}