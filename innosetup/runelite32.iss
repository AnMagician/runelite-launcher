[Setup]
AppName=Project-PK Launcher
AppPublisher=Project-PK
UninstallDisplayName=Project-PK
AppVersion=${project.version}
AppSupportURL=https://project-pk.com
DefaultDirName={localappdata}\Project-PK

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x86 x64
PrivilegesRequired=lowest

WizardSmallImageFile=${project.projectDir}/innosetup/icon_128.bmp
SetupIconFile=${project.projectDir}/innosetup/favicon.ico
UninstallDisplayIcon={app}\Project PK.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${project.projectDir}
OutputBaseFilename=Project-PKSetup32

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${project.projectDir}\build\win-x86\Project PK.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x86\Project PK.jar"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x86\launcher_x86.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "${project.projectDir}\build\win-x86\config.json"; DestDir: "{app}"
Source: "${project.projectDir}\build\win-x86\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Project-PK\Project-PK"; Filename: "{app}\Project PK.exe"
Name: "{userprograms}\Project-PK\Project-PK (configure)"; Filename: "{app}\Project PK.exe"; Parameters: "--configure"
Name: "{userprograms}\Project-PK\Project-PK (safe mode)"; Filename: "{app}\Project PK.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Project-PK"; Filename: "{app}\Project PK.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Project PK.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Project PK.exe"; Description: "&Open Project PK"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Project-PK.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.project-pk\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Registry]
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: ""; ValueData: "URL:runelite-jav Protocol"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav"; ValueType: string; ValueName: "URL Protocol"; ValueData: ""; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open"; Flags: uninsdeletekey
Root: HKCU; Subkey: "Software\Classes\runelite-jav\shell\open\command"; ValueType: string; ValueName: ""; ValueData: """{app}\Project PK.exe"" ""%1"""; Flags: uninsdeletekey

[Code]
#include "upgrade.pas"
#include "usernamecheck.pas"
#include "dircheck.pas"