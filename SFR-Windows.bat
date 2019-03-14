:
: File SFR-Windows.bat
: 
@echo off
set OCTAVE_CLI="C:\Programs\Octave\Octave-5.1.0.0\mingw64\bin\octave-cli.exe"

if [%1]==[test] goto TEST
if [%5]==[]     goto USAGE
if not exist %1 goto USAGE

echo pic_name="%1"; roi_x=%2; roi_y=%3; roi_w=%4; roi_h=%5; sfr | %OCTAVE_CLI%
goto EOF

:USAGE
echo Usage: %0 pic-name.jpg ROI_X ROI_Y ROI_Width ROI_Height
echo Example:
echo %0 200-1.jpg 630 510 70 25
goto EOF

:TEST
echo pic_name="200-1.jpg"; roi_x=630; roi_y=510; roi_w=70; roi_h=25; sfr | %OCTAVE_CLI%
echo pic_name="200-2.jpg"; roi_x=624; roi_y=475; roi_w=70; roi_h=25; sfr | %OCTAVE_CLI%
echo pic_name="200-3.jpg"; roi_x=624; roi_y=519; roi_w=70; roi_h=25; sfr | %OCTAVE_CLI%
echo pic_name="200-4.jpg"; roi_x=625; roi_y=500; roi_w=70; roi_h=25; sfr | %OCTAVE_CLI%

:EOF