function New-SeDriverOptions {
    [cmdletbinding()]
    [OutputType(
        [OpenQA.Selenium.Chrome.ChromeOptions],
        [OpenQA.Selenium.Edge.EdgeOptions],
        [OpenQA.Selenium.Firefox.FirefoxOptions],
        [OpenQA.Selenium.IE.InternetExplorerOptions]
    )]
    param(
        [ArgumentCompleter( { [Enum]::GetNames([SeBrowsers]) })]
        [ValidateScript( { $_ -in [Enum]::GetNames([SeBrowsers]) })]
        [Parameter(ParameterSetName = 'Default')]
        $Browser,
        [StringUrlTransformAttribute()]
        [ValidateURIAttribute()]
        [Parameter(Position = 1)]
        [string]$StartURL,
        [ArgumentCompleter( { [Enum]::GetNames([SeWindowState]) })]
        [ValidateScript( { $_ -in [Enum]::GetNames([SeWindowState]) })]
        $State,
        [System.IO.FileInfo]$DefaultDownloadPath,
        [switch]$PrivateBrowsing,
        [Double]$ImplicitWait = 0.3,
        [System.Drawing.Size][SizeTransformAttribute()]$Size,
        [System.Drawing.Point][PointTransformAttribute()]$Position,
        $WebDriverPath,
        $BinaryPath,
        [String[]]$Switches,
        [String[]]$Arguments,
        $ProfilePath,
        [OpenQA.Selenium.LogLevel]$LogLevel,
        [SeDriverUserAgentTransformAttribute()]
        [ValidateNotNull()]
        [ArgumentCompleter( [SeDriverUserAgentCompleter])]
        [String]$UserAgent,
        [Switch]$AcceptInsecureCertificates
    )
    if ($PSBoundParameters.ContainsKey('UserAgent')) { Test-SeDriverUserAgent -Browser $Browser -ErrorAction Stop }
    if ($PSBoundParameters.ContainsKey('AcceptInsecureCertificates')) { Test-SeDriverAcceptInsecureCertificates -Browser $Browser -ErrorAction Stop }
    
    #  [Enum]::GetNames([sebrowsers])
    $output = $null
    switch ($Browser) {
        Chrome { $Output = [OpenQA.Selenium.Chrome.ChromeOptions]::new() }
        #Edge { $Output = New-Object -TypeName OpenQA.Selenium.Chrome.ChromeOptions -Property @{ browserName = '' } }
        Edge { $Output = [OpenQA.Selenium.Edge.EdgeOptions]::new() }
        Firefox { $Output = [OpenQA.Selenium.Firefox.FirefoxOptions]::new() }
        InternetExplorer {
            $Output = [OpenQA.Selenium.IE.InternetExplorerOptions]::new()
            $Output.IgnoreZoomLevel = $true
        }
        MSEdge { $Output = [OpenQA.Selenium.Edge.EdgeOptions]::new() }
    }

    #Add members to be treated by Internal Start cmdlet since Start-SeDriver won't allow their use with Options parameter set.
    Add-Member -InputObject $output -MemberType NoteProperty -Name 'SeParams' -Value $PSBoundParameters
    

    return $output
}