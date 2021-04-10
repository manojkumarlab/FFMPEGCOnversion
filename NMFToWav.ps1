$inProcessPath = "E:\Random Videos\In Process\"

$oldVideos = Get-ChildItem -Include @("*.nmf") -Path $inProcessPath -Recurse;

Set-Location -Path 'E:\FFMPEG\bin\';

foreach ($oldVideo in $oldVideos) {
    $newVideo = [io.path]::ChangeExtension($oldVideo.FullName, '.wav')

    $ArgumentList = '-i "{0}" -y -async 1 -b 2000k -ar 44100 -ac 2 -v 0 -f flv -vcodec libx264 -preset superfast "{1}"' -f $oldVideo, $newVideo;

    Write-Host -ForegroundColor Green -Object $ArgumentList;
    $null = Read-Host -Prompt 'Press enter to continue, after verifying command line arguments.';

    Start-Process -FilePath c:\path\to\ffmpeg.exe -ArgumentList $ArgumentList -Wait -NoNewWindow;
}

Get-ChildItem .\video_old -Filter *.mkv | ForEach-Object {
  ffmpeg -i $_.FullName -c:v libx265 -x265-params lossless=1 ".\video_new\$($_.Name)"
}
