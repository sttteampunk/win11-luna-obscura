Invoke-Expression (&starship init powershell)
Import-Module -Name Terminal-Icons
function y {
    $tmp = (New-TemporaryFile).FullName
    yazi.exe $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if ($cwd -and $cwd -ne $PWD.Path -and (Test-Path -LiteralPath $cwd -PathType Container)) {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}
function niv {
    # 1. Load Windows API signatures for window management and rounding
    $api = @'
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();
    [DllImport("dwmapi.dll")] public static extern int DwmSetWindowAttribute(IntPtr hwnd, int attr, ref int pref, int size);
'@
    if (!("Win32.Utils" -as [type])) { Add-Type -MemberDefinition $api -Name "Utils" -Namespace "Win32" }
    
    # 2. Get your active WezTerm window handle and hide it
    $termHandle = [Win32.Utils]::GetForegroundWindow()
    [Win32.Utils]::ShowWindow($termHandle, 0) # 0 = SW_HIDE
    
    # 3. Launch Neovide as a background process object
    $proc = Start-Process neovide -PassThru
    
    # 4. Wait for Neovide's GUI frame to initialize
    $timeout = 0
    while ($proc.MainWindowHandle -eq 0 -and $timeout -lt 40) { 
        Start-Sleep -Milliseconds 50
        $timeout++
    }
    # 6. Halt the script here until you close Neovide, then restore WezTerm
    $proc | Wait-Process
    [Win32.Utils]::ShowWindow($termHandle, 5) # 5 = SW_SHOW
}
