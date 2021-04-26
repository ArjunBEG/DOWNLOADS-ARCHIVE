// Learn more about F# at http://fsharp.net
#light

open System
open System.Windows
open System.Windows.Media.Imaging
open Microsoft.Kinect

let sensor = KinectSensor.KinectSensors.[0]
let grid = new System.Windows.Controls.Grid()
let winImage = new System.Windows.Controls.Image()

let ds : int16 = Convert.ToInt16(1)
let pixelData : int16 array = Array.create 307200 ds

winImage.Height <- 480.0
winImage.Width <- 640.0

grid.Children.Add(winImage) |> ignore

//Video frame is ready to be processed.
let DepthFrameReady (sender : obj) (args: DepthImageFrameReadyEventArgs) = 
    let receivedData = ref false

    using (args.OpenDepthImageFrame()) (fun r -> 
        if (r <> null) then
            (
                //Array.Resize(ref pixelData, r.PixelDataLength)
                r.CopyPixelDataTo(pixelData)
                receivedData := true
        )
        
        if (receivedData <> ref false) then
            (
            let source = BitmapSource.Create(640, 480, 96.0, 96.0, Media.PixelFormats.Gray16, null, pixelData, 640 * 2)
            winImage.Source <- source 
        )
        )

        

let WindowLoaded (sender : obj) (args: RoutedEventArgs) = 
    sensor.Start()
    sensor.DepthStream.Enable()
    sensor.DepthFrameReady.AddHandler(new EventHandler<DepthImageFrameReadyEventArgs>(DepthFrameReady))
 
let WindowUnloaded (sender : obj) (args: RoutedEventArgs) = 
    sensor.Stop()  

let window = new Window()
window.Width <- 800.0
window.Height <- 600.0
window.Title <- "Kinect Depth Application"
window.Loaded.AddHandler(new RoutedEventHandler(WindowLoaded))
window.Unloaded.AddHandler(new RoutedEventHandler(WindowUnloaded))
window.Content <- grid

window.Show()

[<STAThread()>]
do 
    let app = new Application() in
    app.Run(window) |> ignore