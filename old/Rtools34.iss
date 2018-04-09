[Setup]
AppName=Rtools
AppVerName=Rtools 3.4
VersionInfoVersion=3.4.0.1964
AppPublisher=The R Foundation
AppPublisherURL=http://cran.r-project.org/bin/windows/Rtools
AppSupportURL=http://cran.r-project.org/bin/windows/Rtools
AppUpdatesURL=http://cran.r-project.org/bin/windows/Rtools
DefaultDirName=c:\Rtools
DefaultGroupName=Rtools
InfoBeforeFile=web\Rtools.txt
OutputBaseFilename=Rtools34
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
Name: "packages"; Description: "Package authoring installation"
Name: "full"; Description: "Full installation to build 32 or 64 bit R 3.2.x+"
Name: "compact"; Description: "Compact installation"
Name: "custom"; Description: "Custom installation"; Flags: iscustom

[Components]
Name: "Rtools"; Description: "R toolset"; Types: full compact packages
Name: "Cygwin"; Description: "Cygwin DLLs"; Types: full packages
Name: "mingw_32"; Description: "R 3.3.x+ 32 bit toolchain"; Types: full packages
Name: "mingw_64"; Description: "R 3.3.x+ 64 bit toolchain"; Types: full packages
Name: "Extras"; Description: "Extras to build 32 bit R:  TCL/TK"; Types: full
Name: "Extras64"; Description: "Extras to build 64 bit R:  TCL/TK"; Types: full

[Files]
Source: "web\Rtools.txt"; DestDir: "{app}"; DestName: "Rtools.txt"; Flags: ignoreversion; 
Source: "web\VERSION.txt"; DestDir: "{app}"; 

Source: "bin\*"; DestDir: "{app}\bin"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: Rtools; Excludes: ".svn"
Source: "texinfo5\*"; DestDir: "{app}\texinfo5"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: Rtools; Excludes: ".svn"
Source: "COPYING"; DestDir: "{app}"; Flags: ignoreversion
Source: "web\README.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "Cygwin\*"; DestDir: "{app}\bin"; Components: Cygwin; Excludes: ".svn"
Source: "mingw32-2015-09-22\*"; DestDir: "{app}\mingw_32"; Flags: ignoreversion recursesubdirs; Components: mingw_32; Excludes: ".svn"
Source: "mingw64-2015-09-22\*"; DestDir: "{app}\mingw_64"; Flags: ignoreversion recursesubdirs; Components: mingw_64; Excludes: ".svn"
Source: "Tcl32_8-6-4\*"; DestDir: "{code:rhome}\Tcl"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: Extras; Excludes: ".svn"
Source: "Tcl64_8-6-4\*"; DestDir: "{code:rhome64}\Tcl"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: Extras64; Excludes: ".svn"
Source: "libicu55\*"; DestDir: "{app}\mingw_libs"; Flags: ignoreversion recursesubdirs createallsubdirs; Components: mingw_32 mingw_64; Excludes: ".svn"
 
[Tasks]
Name: setPath; Description: "{code:setPathDescription}"; Flags:  unchecked;
Name: fixCygwin; Description: "{code:badCygwinDescription}"; Check: BadCygwin; Components: Rtools;
Name: recordversion; Description: "Save version information to registry"

[Registry]
Root: HKLM; Subkey: SYSTEM\CurrentControlSet\Control\Session Manager\Environment; ValueType: expandsz; ValueName: PATH; ValueData: "{code:getNewPath}"; Tasks: setPath
Root: HKCU; Subkey: SOFTWARE\Cygnus Solutions\Cygwin\mounts v2; Flags: deletekey; Tasks: fixCygwin; Check: CygwinHKCU;
Root: HKLM; Subkey: SOFTWARE\Cygnus Solutions\Cygwin\mounts v2; Flags: deletekey; Tasks: fixCygwin; Check: not CygwinHKCU;

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
  RPage: TInputDirWizardPage;
  RPage64: TInputDirWizardPage;
  PathPage : TWizardPage;
  PathMemo : TMemo;
  oldpath, newpath : string;
  version : string;

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
  begin
    if isComponentSelected('mingw_32') then
      path := AddPrefix(ExpandConstant('{app}\bin;{app}\mingw_32\bin;'), oldpath)
    else if isComponentSelected('mingw_64') then
      path := AddPrefix(ExpandConstant('{app}\bin;{app}\mingw_64\bin;'), oldpath);
  end
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
  if not GetVersionNumbersString(ExpandConstant('{srcexe}'), version) then
    version := '';

  // Do this one first so it appears second.  We could refer to the ID of the other, but that
  // seems to cause problems...

  RPage64 := CreateInputDirPage(wpSelectComponents,
    'Select R64 Source Home Directory', 'Where have you installed the R source code for 64 bit builds?',
    'The "Extras64" files will be stored in subdirectories of the R source home directory.  ' +
    'These files are not needed to build packages, only to build R itself.'#13#10#13#10 +
    'To continue, click Next. If you would like to select a different folder, click Browse.',
    False, '');

  // Add item
  RPage64.Add('R 64 bit source home');

  // Set initial value
  RPage64.Values[0] := 'C:\R64';

  // Create the R page
  RPage := CreateInputDirPage(wpSelectComponents,
    'Select R Source Home Directory', 'Where have you installed the R source code for 32 bit builds?',
    'The "Extras" files will be stored in subdirectories of the R source home directory.  ' +
    'These files are not needed to build packages, only to build R itself.'#13#10#13#10 +
    'To continue, click Next. If you would like to select a different folder, click Browse.',
    False, '');

  // Add item
  RPage.Add('R 32 bit source home');

  // Set initial value
  RPage.Values[0] := 'C:\R';

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

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  { Skip source selection if no Extras }
  Result := false;
  if PageID = PathPage.ID then
    Result := not IsTaskSelected('setPath');
end;

function rhome(Param: String): String;
begin
  result := RPage.Values[0];
end;

function rhome64(Param: String): String;
begin
  result := RPage64.Values[0];
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

var
  root : integer;
  cygwinroot : string;
const
  subkey = 'SOFTWARE\Cygnus Solutions\Cygwin\mounts v2\/';
  valuename = 'native';
  
function BadCygwin(): Boolean;
begin
  // Assume we don't have the key, and there is no problem.
  result := false;
  root := HKEY_CURRENT_USER;

  if not RegKeyExists(root, subkey) then
  begin
    root := HKEY_LOCAL_MACHINE;
    if not RegKeyExists(root, subkey) then
      exit;
  end;
  
  // We do have the subkey; assume it is bad.
  result := true;
  cygwinroot := '';
  if not RegQueryStringValue(root, subkey, valuename, cygwinroot) then
    exit;
  if DirExists(cygwinroot) then
    result := false
end;

function CygwinHKCU(): boolean;
begin
  result := root = HKEY_CURRENT_USER;
end;

function badCygwinDescription(Param: String): String;
begin
  result := 'Remove bad Cygwin mount information.' + CRLF
            + '(Probably left from an incomplete Cygwin uninstall.)';
  if cygwinroot <> '' then
    result := result + CRLF + ' Registry records / as the non-existent '+cygwinroot;
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
var
  i, p : integer;
begin
  if GetVersionNumbersString(ExpandConstant('{srcexe}'), result) then
  begin
    i := 0;
    p := 0;
    while p < length(result) do
    begin
      p := p + 1;
      if result[p] = '.' then
      begin
        i := i + 1;
        if i = 2 then
        begin
          p := p - 1;
          break;
        end;
      end;
    end;
    result := copy(result, 1, p);
  end
  else
    result := 'Unknown';
end;

function FullVersion(Param: String): String;
begin
  result := version;
end;

