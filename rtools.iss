[Setup]
AppName=Rtools
AppVersion=3.5
VersionInfoVersion=3.5.0.0
AppPublisher=The R Foundation
AppPublisherURL=https://cran.r-project.org/bin/windows/Rtools
AppSupportURL=https://cran.r-project.org/bin/windows/Rtools
AppUpdatesURL=https://cran.r-project.org/bin/windows/Rtools
DefaultDirName=c:\Rtools
DefaultGroupName=Rtools
InfoBeforeFile=Rtools.txt
OutputBaseFilename=Rtools35
Compression=lzma/ultra
SolidCompression=yes
PrivilegesRequired=none
ChangesEnvironment=yes

[Code]
function MinRVersion(Param: String): String;
begin
  result := '3.3.0';
end;
  
[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "greek"; MessagesFile: "compiler:Languages\Greek.isl"
Name: "hebrew"; MessagesFile: "compiler:Languages\Hebrew.isl" 
Name: "hungarian"; MessagesFile: "compiler:Languages\Hungarian.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "serbian_cyrillic"; MessagesFile: "compiler:Languages\SerbianCyrillic.isl"
Name: "serbian_latin"; MessagesFile: "compiler:Languages\SerbianLatin.isl"
Name: "slovenian"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Types]
Name: "packages"; Description: "Tools for building R packages from source (recommended)"
Name: "full"; Description: "Full installation to build 32 and 64 bit R 3.5.x"
Name: "compact"; Description: "Compact installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "Rtools"; Description: "Build utilities (make, sh, tar, etc)"; Types: full compact packages
Name: "mingw_32"; Description: "R 3.5.x+ 32 bit toolchain"; Types: full packages
Name: "mingw_64"; Description: "R 3.5.x+ 64 bit toolchain"; Types: full packages
Name: "Extras"; Description: "Extras to build R itself: ICU, TexInfo, TclTk"; Types: full

[Files]
Source: "Rtools.txt"; DestDir: "{app}"; Flags: ignoreversion; 
Source: "VERSION.txt"; DestDir: "{app}";
Source: "utils\*"; DestDir: "{app}\bin"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: Rtools; Excludes: ".svn"
Source: "texinfo5\*"; DestDir: "{app}\texinfo5"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: Extras; Excludes: ".svn"
Source: "COPYING"; DestDir: "{app}"; Flags: ignoreversion
Source: "README.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "mingw32-2015-09-22\*"; DestDir: "{app}\mingw_32"; Flags: ignoreversion recursesubdirs; Components: mingw_32; Excludes: ".svn"
Source: "mingw64-2015-09-22\*"; DestDir: "{app}\mingw_64"; Flags: ignoreversion recursesubdirs; Components: mingw_64; Excludes: ".svn"
Source: "tcltk\*"; DestDir: "{app}\"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: Extras; Excludes: ".svn"
Source: "icu\*"; DestDir: "{app}\mingw_libs"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: Extras; Excludes: ".svn"
 
[Tasks]
Name: setPath; Description: "{code:setPathDescription}"; Flags:  unchecked;
Name: recordversion; Description: "Save version information to registry"

[Registry]
Root: HKLM; Subkey: SYSTEM\CurrentControlSet\Control\Session Manager\Environment; ValueType: expandsz; ValueName: PATH; ValueData: "{code:getNewPath}"; Tasks: setPath

Root: HKLM; Subkey: "Software\R-core"; Flags: uninsdeletekeyifempty; Tasks: recordversion; Check: IsAdmin
Root: HKLM; Subkey: "Software\R-core\Rtools"; Flags: uninsdeletekeyifempty; Tasks: recordversion; Check: IsAdmin
Root: HKLM; Subkey: "Software\R-core\Rtools"; Flags: uninsdeletevalue; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Tasks: recordversion; Check: IsAdmin
Root: HKLM; Subkey: "Software\R-core\Rtools"; Flags: uninsdeletevalue; ValueType: string; ValueName: "Current Version"; ValueData: "{code:SetupVer}"; Tasks: recordversion; Check: IsAdmin

Root: HKLM; Subkey: "Software\R-core\Rtools\{code:SetupVer}"; Flags: uninsdeletekey; Tasks: recordversion; Check: IsAdmin
Root: HKLM; Subkey: "Software\R-core\Rtools\{code:SetupVer}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Tasks: recordversion; Check: IsAdmin
Root: HKLM; Subkey: "Software\R-core\Rtools\{code:SetupVer}"; Flags: uninsdeletevalue; ValueType: string; ValueName: "FullVersion"; ValueData: "{code:FullVersion}"; Tasks: recordversion; Check: IsAdmin
Root: HKLM; Subkey: "Software\R-core\Rtools\{code:SetupVer}"; Flags: uninsdeletevalue; ValueType: string; ValueName: "MinRVersion"; ValueData: "{code:MinRVersion}"; Tasks: recordversion; Check: IsAdmin

Root: HKCU; Subkey: "Software\R-core"; Flags: uninsdeletekeyifempty; Tasks: recordversion; Check: NonAdmin
Root: HKCU; Subkey: "Software\R-core\Rtools"; Flags: uninsdeletekeyifempty; Tasks: recordversion; Check: NonAdmin
Root: HKCU; Subkey: "Software\R-core\Rtools"; Flags: uninsdeletevalue; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Tasks: recordversion; Check: NonAdmin
Root: HKCU; Subkey: "Software\R-core\Rtools"; Flags: uninsdeletevalue; ValueType: string; ValueName: "Current Version"; ValueData: "{code:SetupVer}"; Tasks: recordversion; Check: NonAdmin

Root: HKCU; Subkey: "Software\R-core\Rtools\{code:SetupVer}"; Flags: uninsdeletekey; Tasks: recordversion; Check: NonAdmin
Root: HKCU; Subkey: "Software\R-core\Rtools\{code:SetupVer}"; ValueType: string; ValueName: "InstallPath"; ValueData: "{app}"; Tasks: recordversion; Check: NonAdmin
Root: HKCU; Subkey: "Software\R-core\Rtools\{code:SetupVer}"; Flags: uninsdeletevalue; ValueType: string; ValueName: "FullVersion"; ValueData: "{code:FullVersion}"; Tasks: recordversion; Check: NonAdmin
Root: HKCU; Subkey: "Software\R-core\Rtools\{code:SetupVer}"; Flags: uninsdeletevalue; ValueType: string; ValueName: "MinRVersion"; ValueData: "{code:MinRVersion}"; Tasks: recordversion; Check: NonAdmin

[Code]
const
  CRLF = #13#10;
  MAXPATHLINES = 5;
var
  PathPage : TWizardPage;
  PathMemo : TMemo;
  oldpath, newpath : string;

function AddPrefix(prefix: string; oldpath: string): string;
begin
  if pos(prefix, oldpath) = 1 then
    result := oldpath
  else
    result := prefix + oldpath;
end;
  
procedure PathPageActivate(Sender: TWizardPage);
var
  path : string;
  pathstart : string;
  semi : integer;
begin
  if newpath = '' then
    path := AddPrefix(ExpandConstant('{app}\bin;'), oldpath)
  else
    path := newpath;
  // Wrap at semicolons
  pathstart := '';
  repeat
    semi := pos(';', path);
    if semi > 0 then
    begin
      pathstart := pathstart + CRLF + copy(path, 1, semi);
      path := copy(path, semi + 1, length(path));
    end;
  until semi = 0;
  if copy(pathstart, 1, 2) = CRLF then
    pathstart := copy(pathstart, 3, length(pathstart)-2);
  PathMemo.text := pathstart + CRLF + path;
end;

procedure InitializeWizard;
begin

  PathPage := CreateCustomPage(wpSelectTasks, 'System Path', 'Edit the PATH (leaving Rtools\bin first).');
  PathPage.OnActivate := @PathPageActivate;
  
  PathMemo := TMemo.Create(PathPage);
  PathMemo.Top := ScaleY(8);
  PathMemo.Width := PathPage.SurfaceWidth;
  PathMemo.Height := PathPage.SurfaceHeight - PathMemo.Top;
  PathMemo.ScrollBars := ssVertical;
  PathMemo.Parent := PathPage.Surface;

  newpath := '';
  oldpath := '';
  RegQueryStringValue(HKEY_LOCAL_MACHINE, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment',
     'PATH', oldpath);
end;

function NextButtonClick(PageID: Integer): Boolean;
begin
  if PageId = PathPage.ID then
  begin
    newpath := PathMemo.text;
    while StringChangeEx(newpath, CRLF, '', true) > 0 do;
  end;
  Result := True;
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := false;
  if PageID = PathPage.ID then
    Result := not IsTaskSelected('setPath');
end;

function setPathDescription(Param: String): String;
var
  path, pathstart : string;
  semi, col : integer;
  linecount : integer;
begin
  if newpath = '' then
  begin
    result := 'Edit the system PATH.' + CRLF + CRLF + 'Current value:'
              + CRLF + 'PATH=';
    path := oldpath;
  end
  else
  begin
    result := 'Change system PATH to:' + CRLF + 'PATH=';
    path := newpath;
  end;
  // Wrap a long path
  pathstart := '';
  col := 0;
  linecount := 0;
  repeat
    semi := pos(';', path);
    if semi + col > 80 then
    begin
      pathstart := pathstart + CRLF + '     ';
      col := 0;
      linecount := linecount + 1;
    end;
    pathstart := pathstart + copy(path, 1, semi);
    col := col + semi;
    path := copy(path, semi + 1, length(path));
  until (semi = 0) or (linecount + 1 = MAXPATHLINES);
  if semi <> 0 then
    path := CRLF + '[truncated]';
  result := result + pathstart + path;
end;

function getNewPath(Param : string): string;
begin
  if newpath = '' then
    result := oldpath
  else
    result := newpath;
end;

function IsAdmin: boolean;
begin
  Result := IsAdminLoggedOn or IsPowerUserLoggedOn;
end;

function NonAdmin: boolean;
begin
  Result := not IsAdmin;
end;

function SetupVer(Param: String): String;
begin
  result := '{#SetupSetting("AppVersion")}';
end;

function FullVersion(Param: String): String;
begin
  result := '{#SetupSetting("VersionInfoVersion")}';
end;

