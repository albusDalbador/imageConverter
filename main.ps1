

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

function Change-Image-Size {
param (
    [System.Drawing.Bitmap]$Bitmap
)

    #$screenWidth = $Host.UI.RawUI.WindowSize.Width
    $consolenWidth = 211
     
    [int]$imageWidth = [int]$Bitmap.Size.Width

    [int]$consoleHeight = 50
    if ($imageWidth -gt $consolenWidth) {
        $consoleHeight = [math]::Round(($consolenWidth  / $Bitmap.Size.Width) * $Bitmap.Size.Height)
         
    }

    $imageWidth
    $consolenWidth

    $imageHeight
    $consoleHeight

    if ($screenWidth -lt $imageWidth) {
        $newBitMap = New-Object System.Drawing.Bitmap($consoleWidth,$consoleHeight)

        $widthStep = [math]::Round($imageWidth / $consolenWidth)
        $heightStep = [math]::Round($imageHeight / $consoleHeight)
        
        foreach ($i in (1..($consolenWidth ))) {
            
        }
    
        write-host "to do"
    } else {
        $Bitmap
    }
}


function Draw-Result {
param (
    [System.Drawing.Bitmap]$baseBitmap
)

    $newBitmap = Change-Image-Size -Bitmap $baseBitmap
    #[char]([int][math]::Round( (Get-Average-Value-Of-Pixel $newBitmap.GetPixel(1,1)) / 255 * 17 + 32 ))

    [string]$resultImage
    
    for ($x = 1; $x -lt $newBitmap.Height; $x++) {
        foreach ($y in (1..($newBitmap.Width -1))) {

            #Write-Host ([math]::Round((Get-Average-Value-Of-Pixel  $newBitmap.GetPixel($y,$x)))) -NoNewline
            
            $resultImage += " " + ([char]([int][math]::Round( (Get-Average-Value-Of-Pixel $newBitmap.GetPixel($y,$x)) / 255 * 17 + 32 ))) 

        }
        $resultImage += "`n"
    }

    $resultImage > marika.txt

}








#"main"

#$filePath = Read-Host "enter the path to the file from this location: $pwd"

#$image = New-Object -ComObject Wia.ImageFile
#$image.loadfile("$pwd\$filePath")


$BitMap = [System.Drawing.Bitmap]::FromFile((Get-Item "$pwd\obama.png").FullName)

$BitMap.Size.Width

Change-Image-Size -Bitmap $BitMap

#(Get-Item "$pwd\$filePath").FullName

#$image.width

#$pixel = $BitMap.GetPixel(300,1)

#$pixel.GetType()


#Get-Average-Value-Of-Pixel -pixel $pixel


#Draw-Result -baseBitmap $BitMap
 