{********************************************************************}
{                                                                    }
{    TEditorProp                                                     }
{                                                                    }
{    start  1999/07/10                                               }
{                                                                    }
{    update 2000/11/24                                               }
{                                                                    }
{    Copyright (c) 1999,2000 本田勝彦 <katsuhiko.honda@nifty.ne.jp>  }
{                                                                    }
{********************************************************************}

unit HEdtProp;

interface

uses
  Windows, Classes, Graphics, StdCtrls, Registry, HEditor;

type
  TEditorProp = class(TComponent)
  private
    FColor: TColor;
    FCaret: TEditorCaret;
    FFont: TFont;
    FMargin: TEditorMargin;
    FMarks: TEditorMarks;
    FReserveWordList: TStringList;
    FScrollBars: TScrollStyle;
    FView: TEditorViewInfo;
    FWordWrap: Boolean;
    FWrapOption: TEditorWrapOption;
    FOnColorChange: TNotifyEvent;
    FOnScrollBarsChange: TNotifyEvent;
    FOnWordWrapChange: TNotifyEvent;
    procedure SetCaret(Value: TEditorCaret);
    procedure SetColor(Value: TColor);
    procedure SetFont(Value: TFont);
    procedure SetMargin(Value: TEditorMargin);
    procedure SetMarks(Value: TEditorMarks);
    procedure SetScrollBars(Value: TScrollStyle);
    procedure SetReserveWordList(Value: TStringList);
    procedure SetWordWrap(Value: Boolean);
    procedure SetView(Value: TEditorViewInfo);
    procedure SetWrapOption(Value: TEditorWrapOption);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure ReadReg(Root, Ident: String);
    procedure WriteReg(Root, Ident: String);
    property OnColorChange: TNotifyEvent read FOnColorChange write FOnColorChange;
    property OnScrollBarsChange: TNotifyEvent read FOnScrollBarsChange write FOnScrollBarsChange;
    property OnWordWrapChange: TNotifyEvent read FOnWordWrapChange write FOnWordWrapChange;
  published
    property Color: TColor read FColor write SetColor;
    property Caret: TEditorCaret read FCaret write SetCaret;
    property Font: TFont read FFont write SetFont;
    property Margin: TEditorMargin read FMargin write SetMargin;
    property Marks: TEditorMarks read FMarks write SetMarks;
    property ReserveWordList: TStringList read FReserveWordList write SetReserveWordList;
    property ScrollBars: TScrollStyle read FScrollBars write SetScrollBars;
    property View: TEditorViewInfo read FView write SetView;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;
    property WrapOption: TEditorWrapOption read FWrapOption write SetWrapOption;
  end;

implementation

// TEditorViewInfo.FComponent に手を伸ばすための型宣言
type
  TPropEditorViewInfo = class(TEditorViewInfo);


{ TEditorProp }

constructor TEditorProp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCaret := TEditorCaret.Create;
  FFont := TFont.Create;
  FMargin := TEditorMargin.Create;
  FMarks := TEditorMarks.Create;
  FReserveWordList := TStringList.Create;
  FReserveWordList.Sorted := True;
  FReserveWordList.Duplicates := dupIgnore;
  FView := TEditorViewInfo.Create;
  TPropEditorViewInfo(FView).FComponent := Self; // for PropertyEditor
  FWrapOption := TEditorWrapOption.Create;
  FColor := clWindow;
  Font.Color := clWindowText;
  Font.Name := 'FixedSys';
end;

destructor TEditorProp.Destroy;
begin
  FCaret.Free;
  FFont.Free;
  FMargin.Free;
  FMarks.Free;
  FReserveWordList.Free;
  FView.Free;
  FWrapOption.Free;
  inherited Destroy;
end;

procedure TEditorProp.Assign(Source: TPersistent);
begin
  if Source is TEditor then
  begin
    try
      Color := TEditor(Source).Color;
      FCaret.Assign(TEditor(Source).Caret);
      FFont.Assign(TEditor(Source).Font);
      FMargin.Assign(TEditor(Source).Margin);
      FMarks.Assign(TEditor(Source).Marks);
      FReserveWordList.Assign(TEditor(Source).ReserveWordList);
      ScrollBars := TEditor(Source).ScrollBars;
      FView.Assign(TEditor(Source).View);
      WordWrap := TEditor(Source).WordWrap;
      FWrapOption.Assign(TEditor(Source).WrapOption);
    except
    end;
  end
  else
    if Source is TEditorProp then
    begin
      try
        Color := TEditorProp(Source).Color;
        FCaret.Assign(TEditorProp(Source).Caret);
        FFont.Assign(TEditorProp(Source).Font);
        FMargin.Assign(TEditorProp(Source).Margin);
        FMarks.Assign(TEditorProp(Source).Marks);
        FReserveWordList.Assign(TEditorProp(Source).ReserveWordList);
        ScrollBars := TEditorProp(Source).ScrollBars;
        FView.Assign(TEditorProp(Source).View);
        WordWrap := TEditorProp(Source).WordWrap;
        FWrapOption.Assign(TEditorProp(Source).WrapOption);
      except
      end;
    end
    else
      inherited Assign(Source);
end;

procedure TEditorProp.AssignTo(Dest: TPersistent);
begin
  if Dest is TEditor then
  begin
    try
      TEditor(Dest).Color := FColor;
      TEditor(Dest).Caret.Assign(FCaret);
      TEditor(Dest).Font.Assign(FFont);
      TEditor(Dest).Margin.Assign(FMargin);
      TEditor(Dest).Marks.Assign(FMarks);
      TEditor(Dest).ReserveWordList.Assign(FReserveWordList);
      TEditor(Dest).ScrollBars := FScrollBars;
      TEditor(Dest).View.Assign(FView);
      if FWordWrap then
      begin
        TEditor(Dest).WrapOption.Assign(FWrapOption);
        TEditor(Dest).WordWrap := FWordWrap;
      end
      else
      begin
        TEditor(Dest).WordWrap := FWordWrap;
        TEditor(Dest).WrapOption.Assign(FWrapOption);
      end;
    except
    end;
  end
  else
    if Dest is TEditorProp then
    begin
      try
        TEditorProp(Dest).Color := FColor;
        TEditorProp(Dest).Caret.Assign(FCaret);
        TEditorProp(Dest).Font.Assign(FFont);
        TEditorProp(Dest).Margin.Assign(FMargin);
        TEditorProp(Dest).Marks.Assign(FMarks);
        TEditorProp(Dest).ReserveWordList.Assign(FReserveWordList);
        TEditorProp(Dest).ScrollBars := FScrollBars;
        TEditorProp(Dest).View.Assign(FView);
        TEditorProp(Dest).WordWrap := FWordWrap;
        TEditorProp(Dest).WrapOption.Assign(FWrapOption);
      except
      end;
    end
    else
      inherited AssignTo(Dest);
end;

procedure TEditorProp.SetCaret(Value: TEditorCaret);
begin
  FCaret.Assign(Value);
end;

procedure TEditorProp.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    if Assigned(FOnColorChange) then FOnColorChange(Self);
  end;
end;

procedure TEditorProp.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TEditorProp.SetMargin(Value: TEditorMargin);
begin
  FMargin.Assign(Value);
end;

procedure TEditorProp.SetMarks(Value: TEditorMarks);
begin
  FMarks.Assign(Value);
end;

procedure TEditorProp.SetScrollBars(Value: TScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    if Assigned(FOnScrollBarsChange) then FOnScrollBarsChange(Self);
  end;
end;

procedure TEditorProp.SetReserveWordList(Value: TStringList);
begin
  FReserveWordList.Assign(Value);
end;

procedure TEditorProp.SetView(Value: TEditorViewInfo);
begin
  FView.Assign(Value);
end;

procedure TEditorProp.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    if Assigned(FOnWordWrapChange) then FOnWordWrapChange(Self);
  end;
end;

procedure TEditorProp.SetWrapOption(Value: TEditorWrapOption);
begin
  FWrapOption.Assign(Value);
end;

// TRegistry の protected な GetKey メソッドにアクセスするための宣言
type
  TStreamReg = class(TRegIniFile);

procedure TEditorProp.ReadReg(Root, Ident: String);
var
  Reg: TStreamReg;
  Info: TRegDataInfo;
  Key, OldKey: HKEY;
  Ms: TMemoryStream;
begin
  Reg := TStreamReg(TRegIniFile.Create(Root));
  try
    Key := Reg.GetKey(Ident);
    if Key <> 0 then
    try
      OldKey := Reg.CurrentKey;
      Reg.SetCurrentKey(Key);
      try
        if Reg.GetDataInfo(Ident, Info) then
        begin
          Ms := TMemoryStream.Create;
          try
            Ms.SetSize(Info.DataSize);
            Reg.ReadBinaryData(Ident, Ms.Memory^, Info.DataSize);
            Ms.Position := 0;
            if Ms.Size > 0 then
              Ms.ReadComponent(Self);
          finally
            Ms.Free;
          end;
        end;
      finally
        Reg.SetCurrentKey(OldKey);
      end;
    finally
      RegCloseKey(Key);
    end;
  finally
    Reg.Free;
  end;
end;

procedure TEditorProp.WriteReg(Root, Ident: String);
var
  Reg: TStreamReg;
  Key, OldKey: HKEY;
  Ms: TMemoryStream;
begin
  Reg := TStreamReg(TRegIniFile.Create(Root));
  try
    Reg.CreateKey(Ident);
    Key := Reg.GetKey(Ident);
    if Key <> 0 then
    try
      OldKey := Reg.CurrentKey;
      Reg.SetCurrentKey(Key);
      try
        Ms := TMemoryStream.Create;
        try
          Ms.WriteComponent(Self);
          Ms.Position := 0;
          Reg.WriteBinaryData(Ident, Ms.Memory^, Ms.Size);
        finally
          Ms.Free;
        end;
      finally
        Reg.SetCurrentKey(OldKey);
      end;
    finally
      RegCloseKey(Key);
    end;
  finally
    Reg.Free;
  end;
end;

end.

