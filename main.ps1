[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing.Bitmap")

#functions 
function Get-Average-Value-Of-Pixel {
param(
    [System.ValueType]$pixel
)
    $red = $pixel | select -ExpandProperty R
    $green = $pixel | select -ExpandProperty G
    $blue = $pixel | select -ExpandProperty B
    $alpha = $pixel | select -ExpandProperty A

    ($red + $green + $blue) / 3
}


function Compress-Height {
param(
    [System.Drawing.Bitmap]$sourceBitmap
)

    [System.Drawing.Bitmap]$stepBitmap = [System.Drawing.Bitmap](New-Object System.Drawing.Bitmap($sourceBitmap.Size.Width ,[int]($sourceBitmap.Size.Height/2)))

    foreach ($y in (1..($sourceBitmap.Size.Height/2 -1 ))){
        foreach ($x in (1..($sourceBitmap.Size.Width - 1))){
            $stepBitmap.SetPixel($x,$y,$sourceBitmap.GetPixel($x,$y*2))
        }
    }

    $stepBitmap
}


function Draw-Result {
param (
    [System.Drawing.Bitmap]$newBitmap
)

    [string]$resultImage

    for ($x = 1; $x -lt $newBitmap.Size.Height; $x++) {
        foreach ($y in (1..($newBitmap.Size.Width -1))) {

            #$resultImage += " " + ([char]([int][math]::Round( (Get-Average-Value-Of-Pixel $newBitmap.GetPixel($y,$x)) / 255 * 17 + 32 ))) 
            Write-Host ([char]([int][math]::Round( (Get-Average-Value-Of-Pixel $newBitmap.GetPixel($y,$x)) / 255 * 17 + 32 )))  -NoNewline

        }
        Write-Host ""
        #$resultImage += "`n"
    }
    #$resultImage > obama.txt
}


function Change-Image-Size {
param (
    [System.Drawing.Bitmap]$Bitmap
)
    $consoleWidth = 211

    [System.Drawing.Bitmap]$stepBitmap = Compress-Height -sourceBitmap $Bitmap
     
    [int]$imageWidth = [int]$stepBitmap.Size.Width
    [int]$imageHeight = [int]$stepBitmap.Size.Height

    [int]$consoleHeight = $imageHeight

    if ($imageWidth -gt $consolenWidth) {
        $consoleHeight = [math]::Round(($consoleWidth  / $imageWidth) * $imageHeight)
        
        [System.Drawing.Bitmap]$newBitMap = [System.Drawing.Bitmap](New-Object System.Drawing.Bitmap($consoleWidth ,$consoleHeight))

        $widthStep = [math]::floor($imageWidth / $consoleWidth)
        $heightStep = [math]::floor($imageHeight / $consoleHeight)

        foreach ($i in (1..($consoleHeight - 1))) {
            foreach ($j in (1 ..($consoleWidth - 1))){ 
                $newBitMap.SetPixel($j,$i,$stepBitmap.GetPixel($j * $widthStep,$i * $heightStep))
            }
        }
        
        Draw-Result -newBitmap $newBitMap
    } else {
        Draw-Result -newBitmap $Bitmap
    }
}


#"main"

$BitMap = [System.Drawing.Bitmap]::FromFile((Get-Item "$pwd\obama.png").FullName)

Change-Image-Size -Bitmap $BitMap