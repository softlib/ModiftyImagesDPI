unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  jpeg,Winapi.GDIPOBJ, Winapi.GDIPAPI,Winapi.GDIPUTIL, Vcl.StdCtrls,Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    edtDPIValue: TEdit;
    cbOverWriteFiles: TCheckBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  DPI:integer;
implementation
uses MyIOUtils;

{$R *.dfm}

function GDIPlus_CropImage(imgfilename:string;cutRightSize:integer;bTest:boolean):string;
var
  fBitmap:   TGPBitmap;
  tmp:   TGpBitmap;
  g:   TGpGraphics;
  Clsid:   TGUID;
  sb: TGPSolidBrush;
  path: TGPGraphicsPath;
  path2: TGPGraphicsPath;
  region: TGPRegion;
  GRect: TGPRectF;
  rgn: TGPRegion;
  NewWidth: Cardinal;
  NewHeight: Cardinal;
  ImgMimeType:string;
  ImgFileExt: string;
begin
   if Not FileExists(imgfilename) then  Exit;
   fBitmap   :=   TGPBitmap.Create(imgfilename);

   NewWidth:=Round(fBitmap.GetWidth*(DPI/fBitmap.GetHorizontalResolution))-cutRightSize;
   NewHeight:=Round(fBitmap.GetHeight*(DPI/fBitmap.GetHorizontalResolution));

   //DPI:=fBitmap.GetHorizontalResolution;


   //图像裁剪后宽度发生改变，而高度不变，且图像不拉伸
   tmp := TGpBitmap.Create(NewWidth,NewHeight,fBitmap.GetPixelFormat);
   g  := TGpGraphics.Create(tmp);
   g.SetCompositingQuality(CompositingQuality.CompositingQualityHighQuality);
   GRect:=MakeRect(0,0,NewWidth,NewHeight);
   g.DrawImage(fBitmap,GRect,0,0,fBitmap.GetWidth,fBitmap.GetHeight,UnitPixel);


    //宽度固定为450 高度也不变，将图像裁剪后并拉伸
 {  tmp := TGpBitmap.Create(450,NewHeight,fBitmap.GetPixelFormat);
   g  := TGpGraphics.Create(tmp);
   GRect:=MakeRect(0,0,450,NewHeight);
   g.DrawImage(fBitmap,GRect,0,0,NewWidth,NewHeight,UnitPixel);
   }
    g.Free;
   fBitmap.Free;

   tmp.SetResolution(DPI,DPI);   // 修改dpi值       \

   ImgFileExt:=AnsiLowerCase(extractfileext(imgfilename));

   if '.jpg'=ImgFileExt then
      ImgMimeType:='image/jpeg'
   else
   if '.tif'=ImgFileExt then
     ImgMimeType:='image/tiff'
   else
   if '.bmp'=ImgFileExt then
     ImgMimeType:='image/bmp';


   if   Winapi.GDIPUTIL.GetEncoderClsid(ImgMimeType,   Clsid)   <>   -1   then
   begin
     if Not DirectoryExists(extractfilepath(paramstr(0))+'\bmp') then
     begin
       ForceDirectories(extractfilepath(paramstr(0))+'\bmp');
     end;
     try
       if bTest then
         tmp.Save(changefileExt(imgfilename,'_ext'+ImgFileExt),   Clsid)
       else
         tmp.Save(imgfilename,   Clsid);
     except

     end;
   end;
   tmp.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  imgfiles: TStrings;
  ExecError,bOverWrite:boolean;
begin
ExecError:=False;
Button1.Enabled:=false;Button1.Caption:='正在处理';
imgfiles:=TStringList.Create;

bOverWrite:=Form1.cbOverWriteFiles.Checked;

try

  DPI:=strtoint(edtDPIValue.Text);
  if DPI<=0 then
  begin
    showmessage('DPI值必须大于0');
    ExecError:=true;
    Exit;
  end;



  if Not DirectoryExists(Edit1.Text) then
  begin
     showmessage('图片路径无效！');
     ExecError:=true;
     Exit;
  end;


  MyIOUtils.FindFiles(Edit1.Text,imgfiles,'*.tif');

  TThread.CreateAnonymousThread(procedure()
  var
    i: Integer;
  begin
    try
     for i:= 0 to imgfiles.Count-1 do
      begin
        TThread.Synchronize(nil,procedure()
        begin
           Label2.Caption:='正在处理：'+imgFiles[i];
        end);
        if bOverWrite then
          GDIPlus_CropImage(imgFiles[i],0,False)
        else
           GDIPlus_CropImage(imgFiles[i],0,True);

      end;
      Label2.Caption:='处理完毕！';
    finally
      freeandnil(imgfiles);
      Button1.Enabled:=true;Button1.Caption:='开始处理';
    end;

  end).Start;

 finally
   if assigned(imgfiles) and (ExecError) then
   begin
     freeandnil(imgfiles);
     Button1.Enabled:=true;Button1.Caption:='开始处理';
   end;
 end;

end;

end.
