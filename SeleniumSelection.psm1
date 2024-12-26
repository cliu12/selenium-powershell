class Option {
    static [bool] IsMultiSelect([OpenQA.Selenium.IWebElement] $element) {
        $selection = [OpenQA.Selenium.Support.UI.SelectElement]::New($element);
        return $selection.IsMultiple;
    }
    static [System.Collections.ArrayList] GetOptions([OpenQA.Selenium.IWebElement] $element) {
        $selection = [OpenQA.Selenium.Support.UI.SelectElement]::New($element);
        return $selection.Options;
    }
    static [void] SelectByValue([OpenQA.Selenium.IWebElement] $element, [string] $value) {
        $selection = [OpenQA.Selenium.Support.UI.SelectElement]::New($element);
        $selection.SelectByValue($value);
    }
    static [void] DeselectByValue([OpenQA.Selenium.IWebElement] $element, [string] $value) {
        $selection = [OpenQA.Selenium.Support.UI.SelectElement]::New($element);
        $selection.DeselectByValue($value);
    }
    static [void] SelectByText([OpenQA.Selenium.IWebElement] $element, [string] $text, [bool] $partialMatch = $false) {
        $selection = [OpenQA.Selenium.Support.UI.SelectElement]::New($element);
        $selection.SelectByText($text,$partialMatch);
    }
    static [void] DeselectByText([OpenQA.Selenium.IWebElement] $element, [string] $text) {
        $selection = [OpenQA.Selenium.Support.UI.SelectElement]::New($element);
        $selection.DeselectByText($text);
    }
    static [void] SelectByIndex([OpenQA.Selenium.IWebElement] $element, [int] $index) {
        $selection = [OpenQA.Selenium.Support.UI.SelectElement]::New($element);
        $selection.SelectByIndex($index);
    }
    static [void] DeselectByIndex([OpenQA.Selenium.IWebElement] $element, [int] $index) {
        $selection = [OpenQA.Selenium.Support.UI.SelectElement]::New($element);
        $selection.DeselectByIndex($index);
    }
    static [void] DeselectAll([OpenQA.Selenium.IWebElement] $element) {
        $selection = [OpenQA.Selenium.Support.UI.SelectElement]::New($element);
        $selection.DeselectAll();
    }
    static [OpenQA.Selenium.IWebElement] GetSelectedOption([OpenQA.Selenium.IWebElement] $element) {
        $selection = [OpenQA.Selenium.Support.UI.SelectElement]::New($element);
        return $selection.SelectedOption;
    }
    static [System.Collections.ArrayList] GetAllSelectedOptions([OpenQA.Selenium.IWebElement] $element) {
        $selection = [OpenQA.Selenium.Support.UI.SelectElement]::New($element);
        return $selection.AllSelectedOptions;
    }
}