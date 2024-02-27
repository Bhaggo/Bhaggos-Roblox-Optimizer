@echo off
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && ""%~s0"" %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
:: Give batch file administrative rights
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if %errorlevel% NEQ 0 (
    echo Requesting administrative privileges...
    goto UACPrompt
) else (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
:VBSDynamicBuild
SET TempVBSFile=%temp%\~tmpSendKeysTemp.vbs
IF EXIST "%TempVBSFile%" DEL /F /Q "%TempVBSFile%"
ECHO Set WshShell = WScript.CreateObject("WScript.Shell") >>"%TempVBSFile%"
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"
ECHO WshShell.SendKeys "{F11}"                            >>"%TempVBSFile%
ECHO Wscript.Sleep 900                                    >>"%TempVBSFile%"

CSCRIPT //nologo "%TempVBSFile%"
echo successfully given admin rights, now starting program..
cls
title Bhaggo's Roblox Optimizer
set "params=%*"
mode 117
:menu
cls
cls
echo. 
echo 	"**********************************************************************";
echo 	"* __             __   __   __  .  __      __   __   __        __     *";
echo 	"*|__) |__|  /\  / _` / _` /  \ ' /__`    |__) /  \ |__) |    /  \ \_/*";
echo 	"*|__) |  | /~~\ \__> \__> \__/   .__/    |  \ \__/ |__) |___ \__/ / \*";
echo 	"*                                                                    *";
echo 	"*                __   __  ___           __  ___  __                  *";
echo 	"*               /  \ |__)  |  |  |\/| |  / |__  |__)                 *";
echo 	"*               \__/ |     |  |  |  | | /_ |___ |  \                 *";
echo 	"*                                                                    *";
echo 	"*                     @BhaggoYT on YouTube                           *";
echo 	"*                                                                    *";
echo 	"**********************************************************************";
echo.
color 90
echo.
echo  		Enter [1] for max fps file with DirectX 10
echo.
echo  		Enter [2] for for max fps file with DirectX 11
echo.
echo  		Enter [3] for for max fps file with Vulkan
echo.
echo  		Enter [4] for for max fps file with OpenGL
echo.
echo  		Enter [5] for for max fps file with Metal
echo.
echo *********************************************************************************************************************
echo.
echo  		Enter [basic] for basic settings applied (fps unlocker and tweaks)(default is DirectX 11)
echo.
echo  		Enter [basic1] for basic settings with DirectX 10
echo.
echo  		Enter [basic3] for basic settings with Vulkan
echo.
echo  		Enter [basic4] for basic settings with OpenGL
echo.
echo *********************************************************************************************************************
echo.
echo  		Enter [6] for max graphics file with Vulkan
echo.
echo. 		Enter [7] for max graphics file with DirectX 10
echo.
echo  		Enter [8] for max graphics file with DirectX 11
echo.
echo *********************************************************************************************************************
echo.
echo  		Enter [9] for opening roblox directory folder
echo  		Enter [10] for deleting roblox ClientAppSettings folder
echo.
echo *********************************************************************************************************************
echo.
echo  		Enter [quit] to quit the program.
echo.
echo *********************************************************************************************************************

set /p ans="Enter Number: "

if "%ans%"=="1" goto Dx10
if "%ans%"=="2" goto Dx11
if "%ans%"=="3" goto Vulkan
if "%ans%"=="4" goto OpenGL
if "%ans%"=="5" goto Metal
if "%ans%"=="6" goto MaxV
if "%ans%"=="7" goto MaxDX10
if "%ans%"=="8" goto MaxDX11
if "%ans%"=="9" goto open
if "%ans%"=="10" goto delete
if "%ans%"=="basic" goto basic
if "%ans%"=="basic1" goto basic1
if "%ans%"=="basic3" goto basic3
if "%ans%"=="basic4" goto basic4
if "%ans%"=="quit" goto quit
echo Invalid answer
pause
goto menu

:Dx10
@echo off
echo starting
set "robloxDirectory=C:\Program Files (x86)\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation2
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation2
set "robloxDirectory=C:\Program Files\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation3
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation3
set "robloxDirectory=%USERPROFILE%\AppData\Local\Roblox\Versions"

if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:checkIfAvailable
set "folderFound=false"

for /d %%a in ("%robloxDirectory%\version-*") do (
    if exist "%%a\ClientSettings" (
        set "directory=%%a\ClientSettings"
        set "folderFound=true"
        goto importFile
    )
)

if "%folderFound%"=="false" (
    for /d %%a in ("%robloxDirectory%\version-*") do (
echo Creating ClientSettings folder..
        mkdir "%%a\ClientSettings"
        set "directory=%%a\ClientSettings"
        goto importFile
    )
)

pause
echo File imported into this directory: %robloxDirectory%
pause

:importFile
if exist "%directory%\ClientAppSettings.json" (
echo json file already exists. Overwriting the file..
	
    (
        echo { 
        echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://98732842556\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022plastic\u0022:{\u0022ids\u0022:[\u0022\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL23\u0022": "0",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagNewLightAttenuation": "True",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "FIntTerrainArraySliceSize": 8,
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFFlagDebugRenderForceTechnologyVoxel": "True",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FLogNetwork": "7",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL34\u0022": "0",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistance\u0022": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FIntLightingDefaultClearColorARGB": "True;255,255,255,255",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FIntRenderLocalLightFadeInMs_enabled": "99999",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL12\u0022": "0",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringPartTexturePackTablePre2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "FIntFontSizePadding": "3",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
		echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "DFFlagDebugPauseVoxelizer": true,
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagDebugGraphicsDisableDirect3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11FL10": "True",
        echo.      "FFlagGraphicsEnableD3D10Compute": "True",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.       "FFlagDebugSkyGray": true
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
) else (

    (
        echo {
		echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://98732842556\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022plastic\u0022:{\u0022ids\u0022:[\u0022\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL23\u0022": "0",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "DFFlagDebugPauseVoxelizer": true,
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFFlagDebugRenderForceTechnologyVoxel": "True",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FLogNetwork": "7",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL34\u0022": "0",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistance\u0022": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FIntLightingDefaultClearColorARGB": "True;255,255,255,255",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FIntRenderLocalLightFadeInMs_enabled": "99999",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL12\u0022": "0",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringPartTexturePackTablePre2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "FIntFontSizePadding": "3",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "FFlagDebugGraphicsDisableDirect3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11FL10": "True",
        echo.      "FFlagGraphicsEnableD3D10Compute": "True",
        echo.       "FFlagDebugSkyGray": true
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
)

pause
echo Found directory: %robloxDirectory%
timeout /t 3 /nobreak
pause
goto menu


:Dx11
@echo off
echo starting
set "robloxDirectory=C:\Program Files (x86)\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation2
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation2
set "robloxDirectory=C:\Program Files\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation3
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation3
set "robloxDirectory=%USERPROFILE%\AppData\Local\Roblox\Versions"

if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:checkIfAvailable
set "folderFound=false"

for /d %%a in ("%robloxDirectory%\version-*") do (
    if exist "%%a\ClientSettings" (
        set "directory=%%a\ClientSettings"
        set "folderFound=true"
        goto importFile
    )
)

if "%folderFound%"=="false" (
    for /d %%a in ("%robloxDirectory%\version-*") do (
echo Creating ClientSettings folder..
        mkdir "%%a\ClientSettings"
        set "directory=%%a\ClientSettings"
        goto importFile
    )
)

pause
echo File imported into this directory: %robloxDirectory%
pause

:importFile
if exist "%directory%\ClientAppSettings.json" (
echo json file already exists. Overwriting the file..
	
    (
        echo { 
        echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://98732842556\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022plastic\u0022:{\u0022ids\u0022:[\u0022\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL23\u0022": "0",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagNewLightAttenuation": "True",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "FIntTerrainArraySliceSize": 8,
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFFlagDebugRenderForceTechnologyVoxel": "True",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FLogNetwork": "7",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL34\u0022": "0",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistance\u0022": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FIntLightingDefaultClearColorARGB": "True;255,255,255,255",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FIntRenderLocalLightFadeInMs_enabled": "99999",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL12\u0022": "0",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringPartTexturePackTablePre2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "FIntFontSizePadding": "3",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
		echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "DFFlagDebugPauseVoxelizer": true,
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.       "FFlagDebugSkyGray": true
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
) else (

    (
        echo {
		echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://98732842556\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022plastic\u0022:{\u0022ids\u0022:[\u0022\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL23\u0022": "0",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "DFFlagDebugPauseVoxelizer": true,
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFFlagDebugRenderForceTechnologyVoxel": "True",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FLogNetwork": "7",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL34\u0022": "0",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistance\u0022": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FIntLightingDefaultClearColorARGB": "True;255,255,255,255",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FIntRenderLocalLightFadeInMs_enabled": "99999",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL12\u0022": "0",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringPartTexturePackTablePre2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "FIntFontSizePadding": "3",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "FFlagDebugGraphicsDisableDirect3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11FL10": "True",
        echo.      "FFlagGraphicsEnableD3D10Compute": "True",
        echo.       "FFlagDebugSkyGray": true
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
)

pause
echo Found directory: %robloxDirectory%
timeout /t 3 /nobreak
goto menu

:Vulkan
@echo off
echo starting
set "robloxDirectory=C:\Program Files (x86)\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation2
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation2
set "robloxDirectory=C:\Program Files\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation3
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation3
set "robloxDirectory=%USERPROFILE%\AppData\Local\Roblox\Versions"

if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:checkIfAvailable
set "folderFound=false"

for /d %%a in ("%robloxDirectory%\version-*") do (
    if exist "%%a\ClientSettings" (
        set "directory=%%a\ClientSettings"
        set "folderFound=true"
        goto importFile
    )
)

if "%folderFound%"=="false" (
    for /d %%a in ("%robloxDirectory%\version-*") do (
echo Creating ClientSettings folder..
        mkdir "%%a\ClientSettings"
        set "directory=%%a\ClientSettings"
        goto importFile
    )
)

pause
echo File imported into this directory: %robloxDirectory%
pause

:importFile
if exist "%directory%\ClientAppSettings.json" (
echo json file already exists. Overwriting the file..
	
    (
        echo { 
        echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://98732842556\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022plastic\u0022:{\u0022ids\u0022:[\u0022\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL23\u0022": "0",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagNewLightAttenuation": "True",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "FIntTerrainArraySliceSize": 8,
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFFlagDebugRenderForceTechnologyVoxel": "True",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FLogNetwork": "7",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL34\u0022": "0",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistance\u0022": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FIntLightingDefaultClearColorARGB": "True;255,255,255,255",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FIntRenderLocalLightFadeInMs_enabled": "99999",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL12\u0022": "0",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringPartTexturePackTablePre2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "FIntFontSizePadding": "3",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
		echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "DFFlagDebugPauseVoxelizer": true,
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagDebugGraphicsDisableVulkan": "True",
        echo.      "FFlagDebugGraphicsDisableVulkan11": "True",
        echo.      "FFlagDebugGraphicsPreferVulkan": "True",
        echo.      "FFlagRenderVulkanFixMinimizeWindow": "True",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.       "FFlagDebugSkyGray": true
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
) else (

    (
        echo {
		echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://98732842556\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022plastic\u0022:{\u0022ids\u0022:[\u0022\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL23\u0022": "0",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "DFFlagDebugPauseVoxelizer": true,
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFFlagDebugRenderForceTechnologyVoxel": "True",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FLogNetwork": "7",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL34\u0022": "0",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistance\u0022": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FIntLightingDefaultClearColorARGB": "True;255,255,255,255",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FIntRenderLocalLightFadeInMs_enabled": "99999",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL12\u0022": "0",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringPartTexturePackTablePre2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "FIntFontSizePadding": "3",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "FFlagDebugGraphicsDisableVulkan": "True",
        echo.      "FFlagDebugGraphicsDisableVulkan11": "True",
        echo.      "FFlagDebugGraphicsPreferVulkan": "True",
        echo.      "FFlagRenderVulkanFixMinimizeWindow": "True",
        echo.       "FFlagDebugSkyGray": true
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
)

pause
echo Found directory: %robloxDirectory%
timeout /t 3 /nobreak
goto menu

:MaxDX10
@echo off
echo starting
set "robloxDirectory=C:\Program Files (x86)\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation2
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation2
set "robloxDirectory=C:\Program Files\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation3
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation3
set "robloxDirectory=%USERPROFILE%\AppData\Local\Roblox\Versions"

if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:checkIfAvailable
set "folderFound=false"

for /d %%a in ("%robloxDirectory%\version-*") do (
    if exist "%%a\ClientSettings" (
        set "directory=%%a\ClientSettings"
        set "folderFound=true"
        goto importFile
    )
)

if "%folderFound%"=="false" (
    for /d %%a in ("%robloxDirectory%\version-*") do (
echo Creating ClientSettings folder..
        mkdir "%%a\ClientSettings"
        set "directory=%%a\ClientSettings"
        goto importFile
    )
)

pause
echo File imported into this directory: %robloxDirectory%
pause

:importFile
if exist "%directory%\ClientAppSettings.json" (
echo json file already exists. Overwriting the file..
    (
        echo { 
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
		echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "FLogNetwork": "7",
        echo.      "DFIntTaskSchedulerTargetFps": "360",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546645012\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255,255,255,255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546650097\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[204,201,200,232]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546652947\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[212,200,187,250]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546653951\u0022,\u0022rbxassetid://7546654144\u0022],\u0022color\u0022:[208,208,208,255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547162198\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[170,170,170,255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547101130\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[105,104,102,244]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[254,254,254,7]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547164710\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[113,113,113,255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547169285\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[165,165,159,255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547171356\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255,255,255,255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547177270\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[199,199,199,255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547288171\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[199,199,199,255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547291361\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[208,208,208,255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547184629\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[159,119,95,200]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547295153\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[220,220,220,255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547298114\u0022,\u0022rbxassetid://7547298323\u0022],\u0022color\u0022:[193,193,193,255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547303225\u0022,\u0022rbxassetid://7547298786\u0022],\u0022color\u0022:[227,227,227,255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547332968\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[212,209,203,255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873267379\u0022,\u0022rbxassetid://9438410548\u0022],\u0022color\u0022:[123,123,123,234]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873270487\u0022,\u0022rbxassetid://9438413638\u0022],\u0022color\u0022:[154,154,153,238]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9438582231\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[74,78,80,156]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9438851661\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[226,229,229,243]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439044431\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[114,114,112,240]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873288083\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[121,117,113,234]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873289812\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[235,234,230,250]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873319819\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[130,130,130,252]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873322398\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[142,142,144,236]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873515198\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[154,154,154,248]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439566986\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[220,220,221,255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873521380\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[174,171,169,246]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439632387\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[218,218,218,255]}}",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FFlagEnableInGameMenuChrome": "true",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFIntTextureQualityOverride": "3",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagVoiceBetaBadge": "False",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "FFlagNewLightAttenuation": "False",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "FFlagEnableInGameMenuChromeABTest": "True",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FFlagDebugGraphicsDisableDirect3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11FL10": "True",
        echo.      "FFlagGraphicsEnableD3D10Compute": "True",
		echo.      "FFlagGameBasicSettingsFramerateCap": "True"
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
) else (
    (
        echo { 
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FLogNetwork": "7",
        echo.      "DFIntTaskSchedulerTargetFps": "360",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546645012\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255,255,255,255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546650097\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[204,201,200,232]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546652947\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[212,200,187,250]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546653951\u0022,\u0022rbxassetid://7546654144\u0022],\u0022color\u0022:[208,208,208,255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547162198\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[170,170,170,255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547101130\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[105,104,102,244]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[254,254,254,7]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547164710\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[113,113,113,255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547169285\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[165,165,159,255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547171356\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255,255,255,255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547177270\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[199,199,199,255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547288171\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[199,199,199,255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547291361\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[208,208,208,255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547184629\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[159,119,95,200]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547295153\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[220,220,220,255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547298114\u0022,\u0022rbxassetid://7547298323\u0022],\u0022color\u0022:[193,193,193,255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547303225\u0022,\u0022rbxassetid://7547298786\u0022],\u0022color\u0022:[227,227,227,255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547332968\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[212,209,203,255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873267379\u0022,\u0022rbxassetid://9438410548\u0022],\u0022color\u0022:[123,123,123,234]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873270487\u0022,\u0022rbxassetid://9438413638\u0022],\u0022color\u0022:[154,154,153,238]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9438582231\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[74,78,80,156]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9438851661\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[226,229,229,243]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439044431\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[114,114,112,240]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873288083\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[121,117,113,234]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873289812\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[235,234,230,250]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873319819\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[130,130,130,252]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873322398\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[142,142,144,236]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873515198\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[154,154,154,248]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439566986\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[220,220,221,255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873521380\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[174,171,169,246]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439632387\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[218,218,218,255]}}",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FFlagEnableInGameMenuChrome": "true",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFIntTextureQualityOverride": "3",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FFlagVoiceBetaBadge": "False",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "FFlagNewLightAttenuation": "False",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "FFlagEnableInGameMenuChromeABTest": "True",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FFlagDebugGraphicsDisableDirect3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11FL10": "True",
        echo.      "FFlagGraphicsEnableD3D10Compute": "True",
		echo.      "FFlagGameBasicSettingsFramerateCap": "True"
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
)

pause
echo Found directory: %robloxDirectory%
timeout /t 3 /nobreak
goto menu

:MaxDX11
@echo off
echo starting
set "robloxDirectory=C:\Program Files (x86)\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation2
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation2
set "robloxDirectory=C:\Program Files\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation3
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation3
set "robloxDirectory=%USERPROFILE%\AppData\Local\Roblox\Versions"

if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:checkIfAvailable
set "folderFound=false"

for /d %%a in ("%robloxDirectory%\version-*") do (
    if exist "%%a\ClientSettings" (
        set "directory=%%a\ClientSettings"
        set "folderFound=true"
        goto importFile
    )
)

if "%folderFound%"=="false" (
    for /d %%a in ("%robloxDirectory%\version-*") do (
echo Creating ClientSettings folder..
        mkdir "%%a\ClientSettings"
        set "directory=%%a\ClientSettings"
        goto importFile
    )
)

pause
echo File imported into this directory: %robloxDirectory%
pause

:importFile
if exist "%directory%\ClientAppSettings.json" (
echo json file already exists. Overwriting the file..
    (
        echo { 
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
		echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "FLogNetwork": "7",
        echo.      "DFIntTaskSchedulerTargetFps": "360",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546645012\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255,255,255,255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546650097\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[204,201,200,232]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546652947\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[212,200,187,250]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546653951\u0022,\u0022rbxassetid://7546654144\u0022],\u0022color\u0022:[208,208,208,255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547162198\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[170,170,170,255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547101130\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[105,104,102,244]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[254,254,254,7]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547164710\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[113,113,113,255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547169285\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[165,165,159,255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547171356\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255,255,255,255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547177270\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[199,199,199,255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547288171\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[199,199,199,255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547291361\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[208,208,208,255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547184629\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[159,119,95,200]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547295153\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[220,220,220,255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547298114\u0022,\u0022rbxassetid://7547298323\u0022],\u0022color\u0022:[193,193,193,255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547303225\u0022,\u0022rbxassetid://7547298786\u0022],\u0022color\u0022:[227,227,227,255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547332968\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[212,209,203,255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873267379\u0022,\u0022rbxassetid://9438410548\u0022],\u0022color\u0022:[123,123,123,234]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873270487\u0022,\u0022rbxassetid://9438413638\u0022],\u0022color\u0022:[154,154,153,238]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9438582231\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[74,78,80,156]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9438851661\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[226,229,229,243]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439044431\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[114,114,112,240]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873288083\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[121,117,113,234]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873289812\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[235,234,230,250]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873319819\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[130,130,130,252]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873322398\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[142,142,144,236]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873515198\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[154,154,154,248]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439566986\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[220,220,221,255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873521380\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[174,171,169,246]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439632387\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[218,218,218,255]}}",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FFlagEnableInGameMenuChrome": "true",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFIntTextureQualityOverride": "3",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagVoiceBetaBadge": "False",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "FFlagNewLightAttenuation": "False",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "FFlagEnableInGameMenuChromeABTest": "True",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FFlagDebugGraphicsDisableDirect3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11": "True",
        echo.      "FFlagDebugGraphicsPreferD3D11FL10": "False",
		echo.      "FFlagGameBasicSettingsFramerateCap": "True"
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
) else (
    (
        echo { 
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FLogNetwork": "7",
        echo.      "DFIntTaskSchedulerTargetFps": "360",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546645012\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255,255,255,255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546650097\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[204,201,200,232]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546652947\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[212,200,187,250]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546653951\u0022,\u0022rbxassetid://7546654144\u0022],\u0022color\u0022:[208,208,208,255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547162198\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[170,170,170,255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547101130\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[105,104,102,244]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[254,254,254,7]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547164710\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[113,113,113,255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547169285\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[165,165,159,255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547171356\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255,255,255,255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547177270\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[199,199,199,255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547288171\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[199,199,199,255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547291361\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[208,208,208,255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547184629\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[159,119,95,200]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547295153\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[220,220,220,255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547298114\u0022,\u0022rbxassetid://7547298323\u0022],\u0022color\u0022:[193,193,193,255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547303225\u0022,\u0022rbxassetid://7547298786\u0022],\u0022color\u0022:[227,227,227,255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547332968\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[212,209,203,255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873267379\u0022,\u0022rbxassetid://9438410548\u0022],\u0022color\u0022:[123,123,123,234]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873270487\u0022,\u0022rbxassetid://9438413638\u0022],\u0022color\u0022:[154,154,153,238]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9438582231\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[74,78,80,156]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9438851661\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[226,229,229,243]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439044431\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[114,114,112,240]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873288083\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[121,117,113,234]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873289812\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[235,234,230,250]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873319819\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[130,130,130,252]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873322398\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[142,142,144,236]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873515198\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[154,154,154,248]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439566986\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[220,220,221,255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873521380\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[174,171,169,246]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439632387\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[218,218,218,255]}}",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FFlagEnableInGameMenuChrome": "true",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFIntTextureQualityOverride": "3",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagVoiceBetaBadge": "False",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "FFlagNewLightAttenuation": "False",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "FFlagEnableInGameMenuChromeABTest": "True",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FFlagDebugGraphicsDisableDirect3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11": "True",
        echo.      "FFlagDebugGraphicsPreferD3D11FL10": "False",
		echo.      "FFlagGameBasicSettingsFramerateCap": "True"
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
)

pause
echo Found directory: %robloxDirectory%
timeout /t 3 /nobreak
goto menu

:MaxV
@echo off
echo starting
set "robloxDirectory=C:\Program Files (x86)\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation2
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation2
set "robloxDirectory=C:\Program Files\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation3
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation3
set "robloxDirectory=%USERPROFILE%\AppData\Local\Roblox\Versions"

if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:checkIfAvailable
set "folderFound=false"

for /d %%a in ("%robloxDirectory%\version-*") do (
    if exist "%%a\ClientSettings" (
        set "directory=%%a\ClientSettings"
        set "folderFound=true"
        goto importFile
    )
)

if "%folderFound%"=="false" (
    for /d %%a in ("%robloxDirectory%\version-*") do (
echo Creating ClientSettings folder..
        mkdir "%%a\ClientSettings"
        set "directory=%%a\ClientSettings"
        goto importFile
    )
)

pause
echo File imported into this directory: %robloxDirectory%
pause

:importFile
if exist "%directory%\ClientAppSettings.json" (
echo json file already exists. Overwriting the file..
    (
        echo { 
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
		echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "FLogNetwork": "7",
        echo.      "DFIntTaskSchedulerTargetFps": "360",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546645012\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255,255,255,255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546650097\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[204,201,200,232]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546652947\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[212,200,187,250]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546653951\u0022,\u0022rbxassetid://7546654144\u0022],\u0022color\u0022:[208,208,208,255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547162198\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[170,170,170,255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547101130\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[105,104,102,244]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[254,254,254,7]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547164710\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[113,113,113,255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547169285\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[165,165,159,255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547171356\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255,255,255,255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547177270\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[199,199,199,255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547288171\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[199,199,199,255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547291361\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[208,208,208,255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547184629\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[159,119,95,200]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547295153\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[220,220,220,255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547298114\u0022,\u0022rbxassetid://7547298323\u0022],\u0022color\u0022:[193,193,193,255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547303225\u0022,\u0022rbxassetid://7547298786\u0022],\u0022color\u0022:[227,227,227,255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547332968\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[212,209,203,255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873267379\u0022,\u0022rbxassetid://9438410548\u0022],\u0022color\u0022:[123,123,123,234]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873270487\u0022,\u0022rbxassetid://9438413638\u0022],\u0022color\u0022:[154,154,153,238]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9438582231\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[74,78,80,156]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9438851661\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[226,229,229,243]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439044431\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[114,114,112,240]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873288083\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[121,117,113,234]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873289812\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[235,234,230,250]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873319819\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[130,130,130,252]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873322398\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[142,142,144,236]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873515198\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[154,154,154,248]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439566986\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[220,220,221,255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873521380\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[174,171,169,246]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439632387\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[218,218,218,255]}}",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FFlagEnableInGameMenuChrome": "true",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFIntTextureQualityOverride": "3",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagVoiceBetaBadge": "False",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "FFlagNewLightAttenuation": "False",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "FFlagEnableInGameMenuChromeABTest": "True",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FFlagDebugGraphicsDisableVulkan": "True",
        echo.      "FFlagDebugGraphicsDisableVulkan11": "True",
        echo.      "FFlagDebugGraphicsPreferVulkan": "True",
        echo.      "FFlagRenderVulkanFixMinimizeWindow": "True",
		echo.      "FFlagGameBasicSettingsFramerateCap": "True"
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
) else (
    (
        echo { 
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FLogNetwork": "7",
        echo.      "DFIntTaskSchedulerTargetFps": "360",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546645012\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255,255,255,255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546650097\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[204,201,200,232]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546652947\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[212,200,187,250]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7546653951\u0022,\u0022rbxassetid://7546654144\u0022],\u0022color\u0022:[208,208,208,255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547162198\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[170,170,170,255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547101130\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[105,104,102,244]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[254,254,254,7]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547164710\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[113,113,113,255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547169285\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[165,165,159,255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547171356\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255,255,255,255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547177270\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[199,199,199,255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547288171\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[199,199,199,255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547291361\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[208,208,208,255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547184629\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[159,119,95,200]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547295153\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[220,220,220,255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547298114\u0022,\u0022rbxassetid://7547298323\u0022],\u0022color\u0022:[193,193,193,255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547303225\u0022,\u0022rbxassetid://7547298786\u0022],\u0022color\u0022:[227,227,227,255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547332968\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[212,209,203,255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873267379\u0022,\u0022rbxassetid://9438410548\u0022],\u0022color\u0022:[123,123,123,234]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873270487\u0022,\u0022rbxassetid://9438413638\u0022],\u0022color\u0022:[154,154,153,238]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9438582231\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[74,78,80,156]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9438851661\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[226,229,229,243]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439044431\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[114,114,112,240]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873288083\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[121,117,113,234]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873289812\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[235,234,230,250]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873319819\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[130,130,130,252]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873322398\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[142,142,144,236]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873515198\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[154,154,154,248]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439566986\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[220,220,221,255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9873521380\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[174,171,169,246]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://9439632387\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[218,218,218,255]}}",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FFlagEnableInGameMenuChrome": "true",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFIntTextureQualityOverride": "3",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagVoiceBetaBadge": "False",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "FFlagNewLightAttenuation": "False",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "FFlagEnableInGameMenuChromeABTest": "True",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FFlagDebugGraphicsDisableVulkan": "True",
        echo.      "FFlagDebugGraphicsDisableVulkan11": "True",
        echo.      "FFlagDebugGraphicsPreferVulkan": "True",
        echo.      "FFlagRenderVulkanFixMinimizeWindow": "True",
		echo.      "FFlagGameBasicSettingsFramerateCap": "True"
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
)

pause
echo Found directory: %robloxDirectory%
timeout /t 3 /nobreak
goto menu

:open
@echo off
start "" "%LOCALAPPDATA%\Roblox\Versions\" 2>nul
start "" "C:\Program Files\Roblox\Versions\" 2>nul
start "" "C:\Program Files (x86)\Roblox\Versions\" 2>nul
timeout /t 3 /nobreak
goto menu

:delete
@echo off
goto deleteRobloxFolder1

:deleteRobloxFolder1
for /d %%a in ("C:\Program Files (x86)\Roblox\Versions\version-*") do (
    if exist "%%a\ClientSettings" (
        del /q "%%a\ClientSettings\ClientAppSettings.json" > nul 2>&1
        rd /s /q "%%a\ClientSettings" > nul 2>&1
    )
)
goto deleteRobloxFolder2

:deleteRobloxFolder2
for /d %%a in ("C:\Program Files\Roblox\Versions\version-*") do (
    if exist "%%a\ClientSettings" (
        del /q "%%a\ClientSettings\ClientAppSettings.json" > nul 2>&1
        rd /s /q "%%a\ClientSettings" > nul 2>&1
    )
)
goto deleteRobloxFolder3

:deleteRobloxFolder3
for /d %%a in ("%USERPROFILE%\AppData\Local\Roblox\Versions\version-*") do (
    if exist "%%a\ClientSettings" (
        del /q "%%a\ClientSettings\ClientAppSettings.json" > nul 2>&1
        rd /s /q "%%a\ClientSettings" > nul 2>&1
    )
)

timeout /t 3 /nobreak
goto menu

:Metal
@echo off
echo starting
set "robloxDirectory=C:\Program Files (x86)\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation2
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation2
set "robloxDirectory=C:\Program Files\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation3
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation3
set "robloxDirectory=%USERPROFILE%\AppData\Local\Roblox\Versions"

if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:checkIfAvailable
set "folderFound=false"

for /d %%a in ("%robloxDirectory%\version-*") do (
    if exist "%%a\ClientSettings" (
        set "directory=%%a\ClientSettings"
        set "folderFound=true"
        goto importFile
    )
)

if "%folderFound%"=="false" (
    for /d %%a in ("%robloxDirectory%\version-*") do (
echo Creating ClientSettings folder..
        mkdir "%%a\ClientSettings"
        set "directory=%%a\ClientSettings"
        goto importFile
    )
)

pause
echo File imported into this directory: %robloxDirectory%
pause

:importFile
if exist "%directory%\ClientAppSettings.json" (
    echo "'ClientAppSettings.json' already exists in ClientSettings folder. Replacing the file..."
	
    (
        echo { 
        echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://98732842556\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022plastic\u0022:{\u0022ids\u0022:[\u0022\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL23\u0022": "0",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagNewLightAttenuation": "True",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "FIntTerrainArraySliceSize": 8,
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFFlagDebugRenderForceTechnologyVoxel": "True",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FLogNetwork": "7",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL34\u0022": "0",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistance\u0022": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FIntLightingDefaultClearColorARGB": "True;255,255,255,255",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FIntRenderLocalLightFadeInMs_enabled": "99999",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL12\u0022": "0",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringPartTexturePackTablePre2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "FIntFontSizePadding": "3",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
		echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "DFFlagDebugPauseVoxelizer": true,
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.       "FFlagDebugSkyGray": true
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
) else (

    (
        echo {
		echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://98732842556\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022plastic\u0022:{\u0022ids\u0022:[\u0022\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL23\u0022": "0",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "DFFlagDebugPauseVoxelizer": true,
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFFlagDebugRenderForceTechnologyVoxel": "True",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FLogNetwork": "7",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL34\u0022": "0",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistance\u0022": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FIntLightingDefaultClearColorARGB": "True;255,255,255,255",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FIntRenderLocalLightFadeInMs_enabled": "99999",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL12\u0022": "0",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringPartTexturePackTablePre2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "FIntFontSizePadding": "3",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "FFlagDebugGraphicsPreferMetal": "True",
        echo.       "FFlagDebugSkyGray": true
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
)

pause
echo Found directory: %robloxDirectory%
timeout /t 3 /nobreak
goto menu

:OpenGL
@echo off
echo starting
set "robloxDirectory=C:\Program Files (x86)\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation2
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation2
set "robloxDirectory=C:\Program Files\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation3
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation3
set "robloxDirectory=%USERPROFILE%\AppData\Local\Roblox\Versions"

if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:checkIfAvailable
set "folderFound=false"

for /d %%a in ("%robloxDirectory%\version-*") do (
    if exist "%%a\ClientSettings" (
        set "directory=%%a\ClientSettings"
        set "folderFound=true"
        goto importFile
    )
)

if "%folderFound%"=="false" (
    for /d %%a in ("%robloxDirectory%\version-*") do (
echo Creating ClientSettings folder..
        mkdir "%%a\ClientSettings"
        set "directory=%%a\ClientSettings"
        goto importFile
    )
)

pause
echo File imported into this directory: %robloxDirectory%
pause

:importFile
if exist "%directory%\ClientAppSettings.json" (
    echo "'ClientAppSettings.json' already exists in ClientSettings folder. Replacing the file..."
	
    (
        echo { 
        echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://98732842556\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022plastic\u0022:{\u0022ids\u0022:[\u0022\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL23\u0022": "0",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagNewLightAttenuation": "True",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "FIntTerrainArraySliceSize": 8,
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFFlagDebugRenderForceTechnologyVoxel": "True",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FLogNetwork": "7",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL34\u0022": "0",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistance\u0022": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FIntLightingDefaultClearColorARGB": "True;255,255,255,255",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FIntRenderLocalLightFadeInMs_enabled": "99999",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL12\u0022": "0",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringPartTexturePackTablePre2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "FIntFontSizePadding": "3",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
		echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "DFFlagDebugPauseVoxelizer": true,
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "FFlagDebugSkyGray": "True",
        echo.      "FFlagDebugGraphicsDisableDirect3D11": "True",
        echo.      "FFlagDebugGraphicsPreferOpenGL": "True"
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
) else (

    (
        echo {
		echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FStringPartTexturePackTable2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://98732842556\u0022,\u0022rbxassetid://9438453972\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022plastic\u0022:{\u0022ids\u0022:[\u0022\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL23\u0022": "0",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "DFFlagDebugPauseVoxelizer": true,
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FFlagFastGPULightCulling3": "True",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFFlagDebugRenderForceTechnologyVoxel": "True",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FLogNetwork": "7",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFIntClientLightingTechnologyChangedTelemetryHundredthsPercent": "0",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL34\u0022": "0",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "DFIntCanHideGuiGroupId": "32380007",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistance\u0022": "0",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FIntLightingDefaultClearColorARGB": "True;255,255,255,255",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FIntRenderLocalLightFadeInMs_enabled": "99999",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "\u0022DFIntCSGLevelOfDetailSwitchingDistanceL12\u0022": "0",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringPartTexturePackTablePre2022": "{\u0022foil\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022brick\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022cobblestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022concrete\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022diamondplate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022fabric\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://7547304948\u0022,\u0022rbxassetid://7546645118\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022granite\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022grass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ice\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022marble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022metal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pebble\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022corrodedmetal\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sand\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022slate\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022wood\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022woodplanks\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022asphalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022basalt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022crackedlava\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022glacier\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022ground\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022leafygrass\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022limestone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022mud\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022pavement\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022rock\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022salt\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022sandstone\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]},\u0022snow\u0022:{\u0022ids\u0022:[\u0022rbxassetid://0\u0022,\u0022rbxassetid://0\u0022],\u0022color\u0022:[255, 255, 255, 255]}}",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FFlagDebugForceFutureIsBrightPhase3": "True",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "FIntFontSizePadding": "3",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "FFlagDebugSkyGray": "True",
        echo.      "FFlagDebugGraphicsDisableDirect3D11": "True",
        echo.      "FFlagDebugGraphicsPreferOpenGL": "True"
        echo }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
)

pause
echo Found directory: %directory%
timeout /t 3 /nobreak
pause
goto menu

:basic
@echo off
echo starting
set "robloxDirectory=C:\Program Files (x86)\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation2
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation2
set "robloxDirectory=C:\Program Files\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation3
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation3
set "robloxDirectory=%USERPROFILE%\AppData\Local\Roblox\Versions"

if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:checkIfAvailable
set "folderFound=false"

for /d %%a in ("%robloxDirectory%\version-*") do (
    if exist "%%a\ClientSettings" (
        set "directory=%%a\ClientSettings"
        set "folderFound=true"
        goto importFile
    )
)

if "%folderFound%"=="false" (
    for /d %%a in ("%robloxDirectory%\version-*") do (
echo Creating ClientSettings folder..
        mkdir "%%a\ClientSettings"
        set "directory=%%a\ClientSettings"
        goto importFile
    )
)

pause
echo File imported into this directory: %robloxDirectory%
pause

:importFile
if exist "%directory%\ClientAppSettings.json" (
    echo "'ClientAppSettings.json' already exists in ClientSettings folder. Replacing the file..."
	
    (
        echo.    {
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FLogNetwork": "7",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "DFFlagDisableDPIScale": "False",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "FFlagVoiceBetaBadge": "False",
        echo.      "FFlagTopBarUseNewBadge": "False",
        echo.      "FFlagEnableBetaBadgeLearnMore": "False",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "False",
        echo.      "FFlagControlBetaBadgeWithGuac": "False",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "",
        echo.      "FFlagFixDupeBetaBadge": "True",
        echo.      "FIntFullscreenTitleBarTriggerDelayMillis": "3600000",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FIntRenderLocalLightUpdatesMax": "1",
        echo.      "FIntRenderLocalLightUpdatesMin": "1",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False,",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True",
        echo.    }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
) else (

    (
        echo.    {
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FLogNetwork": "7",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "DFFlagDisableDPIScale": "False",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "FFlagVoiceBetaBadge": "False",
        echo.      "FFlagTopBarUseNewBadge": "False",
        echo.      "FFlagEnableBetaBadgeLearnMore": "False",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "False",
        echo.      "FFlagControlBetaBadgeWithGuac": "False",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "",
        echo.      "FFlagFixDupeBetaBadge": "True",
        echo.      "FIntFullscreenTitleBarTriggerDelayMillis": "3600000",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FIntRenderLocalLightUpdatesMax": "1",
        echo.      "FIntRenderLocalLightUpdatesMin": "1",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False,",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True",
        echo.    }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
)

pause
echo Found directory: %robloxDirectory%
timeout /t 3 /nobreak
goto menu

:basic1
@echo off
echo starting
set "robloxDirectory=C:\Program Files (x86)\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation2
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation2
set "robloxDirectory=C:\Program Files\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation3
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation3
set "robloxDirectory=%USERPROFILE%\AppData\Local\Roblox\Versions"

if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:checkIfAvailable
set "folderFound=false"

for /d %%a in ("%robloxDirectory%\version-*") do (
    if exist "%%a\ClientSettings" (
        set "directory=%%a\ClientSettings"
        set "folderFound=true"
        goto importFile
    )
)

if "%folderFound%"=="false" (
    for /d %%a in ("%robloxDirectory%\version-*") do (
echo Creating ClientSettings folder..
        mkdir "%%a\ClientSettings"
        set "directory=%%a\ClientSettings"
        goto importFile
    )
)

pause
echo File imported into this directory: %robloxDirectory%
pause

:importFile
if exist "%directory%\ClientAppSettings.json" (
    echo "'ClientAppSettings.json' already exists in ClientSettings folder. Replacing the file..."
	
    (
        echo.    {
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FLogNetwork": "7",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "FIntTerrainArraySliceSize": "8",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FIntFontSizePadding": "3",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagDebugGraphicsDisableDirect3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11FL10": "True",
        echo.      "FFlagGraphicsEnableD3D10Compute": "True",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True"
        echo.    }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
) else (

    (
        echo.    {
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FLogNetwork": "7",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "FIntTerrainArraySliceSize": "8",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FIntFontSizePadding": "3",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagDebugGraphicsDisableDirect3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11": "False",
        echo.      "FFlagDebugGraphicsPreferD3D11FL10": "True",
        echo.      "FFlagGraphicsEnableD3D10Compute": "True",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True"
        echo.    }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
)

pause
echo Found directory: %robloxDirectory%
timeout /t 3 /nobreak
goto menu

:basic3
@echo off
echo starting
set "robloxDirectory=C:\Program Files (x86)\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation2
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation2
set "robloxDirectory=C:\Program Files\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation3
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation3
set "robloxDirectory=%USERPROFILE%\AppData\Local\Roblox\Versions"

if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:checkIfAvailable
set "folderFound=false"

for /d %%a in ("%robloxDirectory%\version-*") do (
    if exist "%%a\ClientSettings" (
        set "directory=%%a\ClientSettings"
        set "folderFound=true"
        goto importFile
    )
)

if "%folderFound%"=="false" (
    for /d %%a in ("%robloxDirectory%\version-*") do (
echo Creating ClientSettings folder..
        mkdir "%%a\ClientSettings"
        set "directory=%%a\ClientSettings"
        goto importFile
    )
)

pause
echo File imported into this directory: %robloxDirectory%
pause

:importFile
if exist "%directory%\ClientAppSettings.json" (
    echo "'ClientAppSettings.json' already exists in ClientSettings folder. Replacing the file..."
	
    (
        echo.    {
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FLogNetwork": "7",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "FIntTerrainArraySliceSize": "8",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FIntFontSizePadding": "3",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagDebugGraphicsDisableVulkan": "True",
        echo.      "FFlagDebugGraphicsDisableVulkan11": "True",
        echo.      "FFlagDebugGraphicsPreferVulkan": "True",
        echo.      "FFlagRenderVulkanFixMinimizeWindow": "True",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True"
        echo.    }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
) else (

    (
        echo.    {
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FLogNetwork": "7",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "FIntTerrainArraySliceSize": "8",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FIntFontSizePadding": "3",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagDebugGraphicsDisableVulkan": "True",
        echo.      "FFlagDebugGraphicsDisableVulkan11": "True",
        echo.      "FFlagDebugGraphicsPreferVulkan": "True",
        echo.      "FFlagRenderVulkanFixMinimizeWindow": "True",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True"
        echo.    }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
)

pause
echo Found directory: %robloxDirectory%
timeout /t 3 /nobreak
goto menu

:basic4
@echo off
echo starting
set "robloxDirectory=C:\Program Files (x86)\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation2
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation2
set "robloxDirectory=C:\Program Files\Roblox\Versions"

if not exist "%robloxDirectory%" goto robloxLocation3
if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:robloxLocation3
set "robloxDirectory=%USERPROFILE%\AppData\Local\Roblox\Versions"

if exist "%robloxDirectory%" (
    goto checkIfAvailable
)

:checkIfAvailable
set "folderFound=false"

for /d %%a in ("%robloxDirectory%\version-*") do (
    if exist "%%a\ClientSettings" (
        set "directory=%%a\ClientSettings"
        set "folderFound=true"
        goto importFile
    )
)

if "%folderFound%"=="false" (
    for /d %%a in ("%robloxDirectory%\version-*") do (
echo Creating ClientSettings folder..
        mkdir "%%a\ClientSettings"
        set "directory=%%a\ClientSettings"
        goto importFile
    )
)

pause
echo File imported into this directory: %robloxDirectory%
pause

:importFile
if exist "%directory%\ClientAppSettings.json" (
    echo "'ClientAppSettings.json' already exists in ClientSettings folder. Replacing the file..."
	
    (
        echo.    {
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FLogNetwork": "7",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "FIntTerrainArraySliceSize": "8",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FIntFontSizePadding": "3",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagDebugGraphicsDisableDirect3D11": "True",
        echo.      "FFlagDebugGraphicsPreferOpenGL": "True",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True"
        echo.    }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
) else (

    (
        echo.    {
        echo.      "FFlagHandleAltEnterFullscreenManually": "False",
        echo.      "FLogNetwork": "7",
        echo.      "DFLogHttpTraceLight": "0",
        echo.      "FFlagFixGraphicsQuality": "True",
        echo.      "DFIntTaskSchedulerTargetFps": "0",
        echo.      "DFFlagDisableDPIScale": "True",
        echo.      "FFlagNullCheckCloudsRendering": "True",
        echo.      "FFlagGlobalWindRendering": "false",
        echo.      "DFFlagEnableHardwareTelemetry": "false",
        echo.      "FFlagControlBetaBadgeWithGuac": "false",
        echo.      "DFIntBrowserTrackerApiDeviceInitializeRolloutPercentage": "0",
        echo.      "FFlagDebugDisableTelemetryEventIngest": "True",
        echo.      "FFlagAdServiceEnabled": "False",
        echo.      "FFlagRenderCheckThreading": "True",
        echo.      "FFlagDebugForceChatDisabled": "False",
        echo.      "FFlagAudioDeviceTelemetry": "false",
        echo.      "DFIntLightstepHTTPTransportHundredthsPercent2": "0",
        echo.      "DFFlagQueueDataPingFromSendData": "True",
        echo.      "FFlagDisableNewIGMinDUA": "True",
        echo.      "FFlagEnableBatteryStateLogger": "False",
        echo.      "FStringVoiceBetaBadgeLearnMoreLink": "null",
        echo.      "FFlagEnableCameraByDefault": "False",
        echo.      "FFlagCommitToGraphicsQualityFix": "True",
        echo.      "FIntFlagUpdateVersion": "132",
        echo.      "DFStringCrashUploadToBacktraceBaseUrl": "null",
        echo.      "FFlagInGameMenuV1FullScreenTitleBar": "False",
        echo.      "DFFlagEnableGCapsHardwareTelemetry": "False",
        echo.      "FFlagAvatarChatServiceExposeClientFeaturesForVoiceChat": "False",
        echo.      "FIntCameraMaxZoomDistance": "99999",
        echo.      "FFlagEnableV3MenuABTest3": "False",
        echo.      "FFlagMSRefactor5": "False",
        echo.      "FFlagEnableInGameMenuControls": "False",
        echo.      "DFIntWriteFullDmpPercent": "0",
        echo.      "FIntFRMMinGrassDistance": "0",
        echo.      "DFIntLoginTelemetryHundredthsPercent": "0",
        echo.      "FIntDebugForceMSAASamples": "0",
        echo.      "FIntRenderGrassDetailStrands": "0",
        echo.      "FFlagBatchAssetApi": "True",
        echo.      "FFlagEnableBetaBadgeLearnMore": "false",
        echo.      "FFlagEnableMenuModernizationABTest2": "False",
        echo.      "DFFlagTextureQualityOverrideEnabled": "True",
        echo.      "FFlagReportFpsAndGfxQualityPercentiles": "False",
        echo.      "FIntEmotesAnimationsPerPlayerCacheSize": "16777216",
        echo.      "FFlagVoiceBetaBadge": "false",
        echo.      "FFlagLuaAppSystemBar": "False",
        echo.      "FFlagGpuGeometryManager7": "True",
        echo.      "FIntFRMMaxGrassDistance": "0",
        echo.      "FFlagDebugDisableTelemetryV2Stat": "True",
        echo.      "FFlagEnableAccessibilitySettingsInExperienceMenu2": "True",
        echo.      "FIntV1MenuLanguageSelectionFeaturePerMillageRollout": "0",
        echo.      "DFStringCrashUploadToBacktraceMacPlayerToken": "null",
        echo.      "DFFlagDebugPerfMode": "True",
        echo.      "FFlagEnableAudioOutputDevice": "false",
        echo.      "FFlagCoreGuiTypeSelfViewPresent": "False",
        echo.      "DFStringLightstepHTTPTransportUrlPath": "null",
        echo.      "DFFlagClientBaseNetworkMetrics": "False",
        echo.      "FIntDefaultMeshCacheSizeMB": "256",
        echo.      "FFlagDebugGraphicsCrashOnLeaks": "False",
        echo.      "FIntUITextureMaxRenderTextureSize": "1024",
        echo.      "FFlagEnableQuickGameLaunch": "False",
        echo.      "FIntTerrainOTAMaxTextureSize": "1024",
        echo.      "FIntBootstrapperTelemetryReportingHundredthsPercentage": "0",
        echo.      "FFlagRenderPerformanceTelemetry": "False",
        echo.      "DFFlagEnableMemProfilingOutsideClient": "False",
        echo.      "FStringPerformanceSendMeasurementAPISubdomain": "opt-out",
        echo.      "DFFlagDebugAnalyticsSendUserId": "False",
        echo.      "FIntLmsClientRollout2": "0",
        echo.      "DFFlagAddPublicGettersForGfxQualityAndFpsForTelemCounters2": "False",
        echo.      "FFlagDebugDisableTelemetryV2Event": "True",
        echo.      "DFFlagEnableFmodErrorsTelemetry": "False",
        echo.      "FFlagEnableMenuControlsABTest": "False",
        echo.      "DFStringLightstepHTTPTransportUrlHost": "null",
        echo.      "FFlagDontCreatePingJob": "True",
        echo.      "FFlagBetaBadgeLearnMoreLinkFormview": "false",
        echo.      "FIntReportDeviceInfoRollout": "0",
        echo.      "DFStringAltHttpPointsReporterUrl": "null",
        echo.      "FFlagRenderGpuTextureCompressor": "True",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioEligible": "False",
        echo.      "DFStringAnalyticsNS1BeaconConfig": "https://opt-out.roblox.com",
        echo.      "FFlagEnableMenuModernizationABTest": "False",
        echo.      "FFlagTrackMacWebLaunchFlow": "False",
        echo.      "FIntStartupInfluxHundredthsPercentage": "0",
        echo.      "DFIntTextureQualityOverride": "6",
        echo.      "DFStringRobloxAnalyticsURL": "null",
        echo.      "DFIntRunningBaseOrientationP": "450",
        echo.      "DFIntDetectCrashEarlyPercentage": "0",
        echo.      "DFFlagPredictedOOM": "False",
        echo.      "DFStringTelemetryV2Url": "null",
        echo.      "FFlagGraphicsCheckComputeSupport": "True",
        echo.      "FStringErrorUploadToBacktraceBaseUrl": "https://opt-out.roblox.com",
        echo.      "FintRenderGrassHeightScaler": "0",
        echo.      "FIntTerrainArraySliceSize": "8",
        echo.      "DFIntUserIdPlayerNameLifetimeSeconds": "86400",
        echo.      "DFStringAnalyticsEventStreamUrlEndpoint": "opt-out",
        echo.      "FFlagPreloadMinimalFonts": "True",
        echo.      "FFlagDebugDisplayFPS": "False",
        echo.      "GoogleAnalyticsAccountPropertyIDPlayer": "null",
        echo.      "DFFlagESGamePerfMonitorEnabled": "False",
        echo.      "FFlagGraphicsGLEnableHQShadersExclusion": "False",
        echo.      "DFIntGoogleAnalyticsLoadPlayerHundredth": "0",
        echo.      "FFlagImmersiveAdsWhitelistDisabled": "False",
        echo.      "FIntFontSizePadding": "3",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInCoreScripts2": "True",
        echo.      "DFLogHttpTraceError": "0",
        echo.      "DFLogHttpTrace": "0",
        echo.      "FFlagDebugRenderingSetDeterministic": "True",
        echo.      "DFFlagAudioDeviceTelemetry": "False",
        echo.      "FFlagDebugDisableTelemetryPoint": "True",
        echo.      "FFlagDebugDisableTelemetryV2Counter": "True",
        echo.      "DFFlagEnableMemProfilingStorePlaceId": "False",
        echo.      "DFIntNewRunningBaseAltitudeD": "50",
        echo.      "FFlagEnableSoundTelemetry": "False",
        echo.      "DFStringHttpPointsReporterUrl": "null",
        echo.      "DFLogBatchAssetApiLog": "3",
        echo.      "FFlagTrackWinWebLaunchFlow": "False",
        echo.      "FIntHSRClusterSymmetryDistancePercent": "10000",
        echo.      "FIntLinkBrowserTrackerToDeviceRollout": "0",
        echo.      "FIntMeshContentProviderForceCacheSize": "268435456",
        echo.      "DFStringAnalyticsNS1ApplicationId": "opt-out",
        echo.      "DFIntDebugFRMQualityLevelOverride": "1",
        echo.      "FIntRenderShadowIntensity": "0",
        echo.      "FFlagTopBarUseNewBadge": "false",
        echo.      "FFlagGraphicsSettingsOnlyShowValidModes": "True",
        echo.      "FFlagWindowsLaunchAnalytics": "False",
        echo.      "FFlagEnableAccessibilitySettingsAPIV2": "True",
        echo.      "FStringTerrainMaterialTablePre2022": "",
        echo.      "FFlagDebugDisableOTAMaterialTexture": "true",
        echo.      "FFlagAnimationClipMemCacheEnabled": "True",
        echo.      "DFFlagAddUserIdToSessionTracking": "False",
        echo.      "FFlagPreloadTextureItemsOption4": "True",
        echo.      "FFlagEnableInGameMenuModernization": "False",
        echo.      "FIntAbuseReportScreenshotMaxSize": "0",
        echo.      "FFlagPreloadAllFonts": "True",
        echo.      "DFStringAltTelegrafHTTPTransportUrl": "null",
        echo.      "FFlagEnableAccessibilitySettingsEffectsInExperienceChat": "True",
        echo.      "DFFlagGpuVsCpuBoundTelemetry": "False",
        echo.      "FFlagDebugGraphics": "False",
        echo.      "FStringGamesUrlPath": "/games/",
        echo.      "FStringTerrainMaterialTable2022": "",
        echo.      "FFlagGraphicsGLEnableSuperHQShadersExclusion": "False",
        echo.      "FFlagEnableAdsAPI": "False",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableAudio": "False",
        echo.      "FFlagCloudsReflectOnWater": "True",
        echo.      "FFlagAvatarChatSettingsEnabled2": "False",
        echo.      "DFIntPredictedOOMPercent": "0",
        echo.      "DFFlagEphemeralCounterInfluxReportingEnabled": "False",
        echo.      "\u0022FIntCameraMaxZoomDistance\u0022: \u002299999\u0022": "99999",
        echo.      "FFlagDisablePostFx": "True",
        echo.      "FIntPGSAngularDampingPermillPersecond": "9999999999",
        echo.      "DFFlagCrashUploadFullDumps": "False",
        echo.      "FFlagFacialAnimationStreamingServiceUniverseSettingsEnableVideo": "False",
        echo.      "DFIntCrashReportingHundredthsPercentage": "0",
        echo.      "FStringCoreScriptBacktraceErrorUploadToken": "null",
        echo.      "DFFlagAvatarChatServiceUserPermissionsAudioOptIn": "False",
        echo.      "GoogleAnalyticsAccountPropertyID": "null",
        echo.      "FFlagVoiceChatServiceManagerUseAvatarChat": "False",
        echo.      "FFlagEnableInGameMenuV3": "False",
        echo.      "DFFlagHttpCacheCleanBasedOnMemory": "True",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInAudio": "False",
        echo.      "DFStringCrashUploadToBacktraceWindowsPlayerToken": "null",
        echo.      "DFIntUserIdPlayerNameCacheSize": "33554432",
        echo.      "DFStringLightstepToken": "null",
        echo.      "DFIntStartupTracingInfluxRollout": "0",
        echo.      "DFFlagEnableLightstepReporting2": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralCounter": "True",
        echo.      "DFIntHttpCurlConnectionCacheSize": "134217728",
        echo.      "DFFlagVideoCaptureServiceEnabled": "False",
        echo.      "DFStringRobloxAnalyticsSubDomain": "opt-out",
        echo.      "FFlagFacialAnimationStreamingServiceUserSettingsOptInVideo": "False",
        echo.      "FIntTaskSchedulerAutoThreadLimit": "8",
        echo.      "DFFlagBrowserTrackerIdTelemetryEnabled": "False",
        echo.      "FFlagDebugDisableTelemetryEphemeralStat": "True",
        echo.      "DFFlagBaseNetworkMetrics": "False",
        echo.      "DFIntS2PhysicsSenderRate": "250",
        echo.      "FFlagLocServicePerformanceAnalyticsEnabled": "False",
        echo.      "DFStringTelegrafHTTPTransportUrl": "null",
        echo.      "FStringImmersiveAdsUniverseWhitelist": "0",
        echo.      "FFlagAddGameInstanceIdToSessionTracking": "False",
        echo.      "FFlagTrackPlaceIdForCrashEnabled": "False",
        echo.      "FFlagDebugGraphicsDisableDirect3D11": "True",
        echo.      "FFlagDebugGraphicsPreferOpenGL": "True",
        echo.      "FFlagGameBasicSettingsFramerateCap": "True"
        echo.    }
    ) > "%directory%\ClientAppSettings.json"
echo json successfully replaced in ClientSettings folder.
)

pause
echo Found directory: %robloxDirectory%
timeout /t 3 /nobreak
goto menu

:quit
exit