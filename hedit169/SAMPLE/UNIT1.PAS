unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Menus, HEditor, HtSearch, ExtCtrls,
  HEdtProp;

type
  TOpenMenuList = class(TStringList)
  public
    FOnClickProc: TNotifyEvent;
    FMenuItem: TMenuItem;
    constructor Create(OnClickProc: TNotifyEvent; MenuItem: TMenuItem);
    destructor Destroy; override;
    procedure BringToTop(const S: String);
    procedure ReadIni;
    procedure WriteIni;
    procedure RecreateMenu;
  end;

  TLineNumberMode = (lmRow, lmLine);

  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    PopupMenu1: TPopupMenu;
    EditorProp2: TEditorProp;
    mnuLoadFromFile: TMenuItem;
    mnuFileList: TMenuItem;
    mnuNew: TMenuItem;
    mnuSave: TMenuItem;
    mnuSaveAs: TMenuItem;
    mnuClear: TMenuItem;
    mnuPageClose: TMenuItem;
    N1: TMenuItem;
    mnuEdit: TMenuItem;
    mnuSearch: TMenuItem;
    mnuReplace: TMenuItem;
    mnuCut: TMenuItem;
    mnuCopy: TMenuItem;
    mnuPaste: TMenuItem;
    mnuSelectAll: TMenuItem;
    mnuDeleteLine: TMenuItem;
    N2: TMenuItem;
    mnuUndo: TMenuItem;
    mnuRedo: TMenuItem;
    mnuFind: TMenuItem;
    mnuFindForward: TMenuItem;
    mnuFindBackward: TMenuItem;
    mnuOverWrite: TMenuItem;
    mnuReadOnly: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    mnuLineNumberMode: TMenuItem;
    mnuRowCol: TMenuItem;
    mnuLinesChar: TMenuItem;
    N6: TMenuItem;
    mnuEditorProperty: TMenuItem;
    N7: TMenuItem;
    mnuIndent: TMenuItem;
    mnuUnIndent: TMenuItem;
    N8: TMenuItem;
    mnuBoxSel: TMenuItem;
    mnuBoxPaste: TMenuItem;
    mnuWindow: TMenuItem;
    N9: TMenuItem;
    mnuSplit: TMenuItem;
    mnuOtherWindow: TMenuItem;
    EditorProp3: TEditorProp;
    EditorProp4: TEditorProp;
    EditorProp1: TEditorProp;
    PageControl1: TPageControl;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure mnuLoadFromFileClick(Sender: TObject);
    procedure mnuNewClick(Sender: TObject);
    procedure mnuSaveClick(Sender: TObject);
    procedure mnuSaveAsClick(Sender: TObject);
    procedure mnuClearClick(Sender: TObject);
    procedure mnuPageCloseClick(Sender: TObject);
    procedure mnuReplaceClick(Sender: TObject);
    procedure mnuCutClick(Sender: TObject);
    procedure mnuCopyClick(Sender: TObject);
    procedure mnuPasteClick(Sender: TObject);
    procedure mnuSelectAllClick(Sender: TObject);
    procedure mnuDeleteLineClick(Sender: TObject);
    procedure mnuUndoClick(Sender: TObject);
    procedure mnuRedoClick(Sender: TObject);
    procedure mnuFindClick(Sender: TObject);
    procedure mnuFindForwardClick(Sender: TObject);
    procedure mnuFindBackwardClick(Sender: TObject);
    procedure mnuOverWriteClick(Sender: TObject);
    procedure mnuReadOnlyClick(Sender: TObject);
    procedure CaretMoved(Sender: TObject);
    procedure EditorChange(Sender: TObject);
    procedure SelectionModeChange(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure RowColClick(Sender: TObject);
    procedure mnuEditorPropertyClick(Sender: TObject);
    procedure mnuIndentClick(Sender: TObject);
    procedure mnuUnIndentClick(Sender: TObject);
    procedure mnuBoxSelClick(Sender: TObject);
    procedure mnuBoxPasteClick(Sender: TObject);
    procedure mnuOtherWindowClick(Sender: TObject);
    procedure mnuSplitClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure EditorEnter(Sender: TObject);
  private
    FDelphiExtList: TStringList;
    FFileList: TStringList;
    FHtmlExtList: TStringList;
    FLineNumberMode: TLineNumberMode;
    FOpenMenuList: TOpenMenuList;
    FReplaceValue: String;
    FSearchOptions: TSearchOptions;
    FSearchValue: String;
    procedure EditorExchanged(NewEditor: TEditor);
    function GetActiveFileName: String;
    procedure OpenMenuListSelected(Sender: TObject);
    function SecondEditor: TEditor;
    procedure SetActiveFileName(Value: String);
    procedure SetLineNumberMode(Value: TLineNumberMode);
    procedure UpdateCaption;
    procedure UpdateLineNumber(Editor: TEditor);
    procedure UpdateModified(Editor: TEditor);
    procedure UpdateOverWrite(Editor: TEditor);
    procedure UpdateSelectionMode(Editor: TEditor);
    {$IFNDEF VER90}
    function ActiveSplitter: TSplitter;
    procedure SplitterMoved(Sender: TObject);
    {$ENDIF}
  public
    function ActiveEditor: TEditor;
    procedure BeginSplit;
    procedure CreateNewSheet(FileName: String);
    procedure EndSplit;
    function IsSplit: Boolean;
    procedure MoveEditorsFromTForm2;
    function Search: Boolean;
    property ActiveFileName: String read GetActiveFileName write SetActiveFileName;
    property LineNumberMode: TLineNumberMode read FLineNumberMode write SetLineNumberMode;
  end;

var
  Form1: TForm1;

implementation

uses
  Clipbrd, Registry, IniFiles, HSchfm, HReplfm,
  HViewEdt, TypInfo, Unit2;

{$R *.DFM}

{  TOpenMenuList  }

constructor TOpenMenuList.Create(OnClickProc: TNotifyEvent;
    MenuItem: TMenuItem);
begin
  FOnClickProc := OnClickProc;
  FMenuItem := MenuItem;
  ReadIni;
  RecreateMenu;
end;

destructor TOpenMenuList.Destroy;
var
  I: Integer;
begin
  WriteIni;
  for I := FMenuItem.Count - 1 downto 0 do
    FMenuItem.Items[I].Free;
  inherited Destroy;
end;

procedure TOpenMenuList.BringToTop(const S: String);
begin
  if IndexOf(S) <> -1 then
    Delete(IndexOf(S));
  Insert(0, S);
  if Count > 8 then
    Delete(Count - 1);
  RecreateMenu;
end;

procedure TOpenMenuList.ReadIni;
var
  Ini: TIniFile;
  I, Cnt: Integer;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    Cnt := Ini.ReadInteger('OpenMenuItems', 'Count', 0);
    for I := 0 to Cnt - 1 do
      Add(Ini.ReadString('OpenMenuItems', 'Item' + IntToStr(I), ''));
  finally
    Ini.Free;
  end;
end;

procedure TOpenMenuList.WriteIni;
var
  Ini: TIniFile;
  I: Integer;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    Ini.WriteInteger('OpenMenuItems', 'Count', Count);
    for I := 0 to Count - 1 do
      Ini.WriteString('OpenMenuItems', 'Item' + IntToStr(I), Strings[I]);
  finally
    Ini.Free;
  end;
end;

procedure TOpenMenuList.RecreateMenu;
var
  I: Integer;
  Item: TMenuItem;
begin
  for I := FMenuItem.Count - 1 downto 0 do
    FMenuItem.Items[I].Free;
  for I := 0 to Count - 1 do
  begin
    Item := TMenuItem.Create(FMenuItem);
    Item.Caption := Strings[I];
    Item.OnClick := FOnClickProc;
    FMenuItem.Add(Item);
  end;
end;


{  TForm1  }

procedure TForm1.MoveEditorsFromTForm2;
var
  I: Integer;
  Form: TForm2;
begin
  // TForm2 を生成し、TForm2.TabSheet1..TabSheet5 を TForm1.PageControl1 へ
  // 移動し Editor1..Editor5 のイベントハンドラを TForm1 のものに設定する
  Form := TForm2.Create(Application);
  for I := 0 to Form.ComponentCount - 1 do
    if Form.Components[I] is TTabSheet then
      TTabSheet(Form.Components[I]).PageControl := PageControl1
    else
      if Form.Components[I] is TEditor then
      with TEditor(Form.Components[I]) do
      begin
        OnCaretMoved := CaretMoved;
        OnChange := EditorChange;
        OnEnter := EditorEnter;
        OnSelectionModeChange := SelectionModeChange;
        PopupMenu := PopupMenu1;
      end;
  for I := 0 to Form.FFileList.Count - 1 do
    FFileList.Add(Form.FFileList[I]);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Memo1.Free; // 効能書きの消去
  FFileList := TStringList.Create;
  FOpenMenuList := TOpenMenuList.Create(OpenMenuListSelected, mnuFileList);
  FDelphiExtList := TStringList.Create;
  with FDelphiExtList do
  begin
    Sorted := True;
    Duplicates := dupIgnore;
    Add('.pas');
    Add('.dpr');
    Add('.inc');
  end;
  FHtmlExtList := TStringList.Create;
  with FHtmlExtList do
  begin
    Sorted := True;
    Duplicates := dupIgnore;
    Add('.htm');
    Add('.html');
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FHtmlExtList.Free;
  FDelphiExtList.Free;
  FOpenMenuList.Free;
  FFileList.Free;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  PageControl1Change(Self);
end;

// TOpenMenuList.Create コンストラクタに渡すためのイベントハンドラ
procedure TForm1.OpenMenuListSelected(Sender: TObject);
var
  S: String;
begin
  if Sender is TMenuItem then
  begin
    S := TMenuItem(Sender).Caption;
    if FileExists(S) then
    begin
      FOpenMenuList.BringToTop(S);
      CreateNewSheet(S);
      with PageControl1 do
        ActivePage := Pages[PageCount - 1];
      ActiveEditor.Lines.LoadFromFile(S);
      ActiveEditor.Modified := False;
      EditorExchanged(ActiveEditor);
    end;
  end;
end;

function TForm1.ActiveEditor: TEditor;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to PageControl1.ActivePage.ControlCount - 1 do
    if PageControl1.ActivePage.Controls[I] is TEditor then
    begin
      Result := TEditor(PageControl1.ActivePage.Controls[I]);
      if Result.Focused then
        Exit;
    end;
end;

function TForm1.GetActiveFileName: String;
begin
  Result := FFileList[PageControl1.ActivePage.PageIndex];
end;

procedure TForm1.SetActiveFileName(Value: String);
begin
  FFileList[PageControl1.ActivePage.PageIndex] := Value;
end;

procedure TForm1.UpdateCaption;
begin
  Caption := ActiveFileName;
end;

procedure TForm1.UpdateModified(Editor: TEditor);
begin
  if Editor.Modified then
    StatusBar1.Panels[1].Text := '変更'
  else
    StatusBar1.Panels[1].Text := '';
end;

procedure TForm1.UpdateOverWrite(Editor: TEditor);
begin
  if Editor.OverWrite then
    StatusBar1.Panels[2].Text := '上書'
  else
    StatusBar1.Panels[2].Text := '挿入';
end;

procedure TForm1.UpdateSelectionMode(Editor: TEditor);
begin
  if Editor.SelectionMode = smBox then
    StatusBar1.Panels[3].Text := '矩形選択'
  else
    StatusBar1.Panels[3].Text := ''
end;

procedure TForm1.UpdateLineNumber(Editor: TEditor);
begin
  with Editor do
    if FLineNumberMode = lmLine then
      StatusBar1.Panels[0].Text :=
        Format('%5d 行:%4d 桁', [RowToLines(Row) + 1, ColToChar(Row, Col) + 1])
    else
      StatusBar1.Panels[0].Text :=
        Format('%5d 行:%4d 桁', [Row + 1, Col + 1]);
end;

procedure TForm1.EditorExchanged(NewEditor: TEditor);
begin
  UpdateCaption;
  UpdateModified(NewEditor);
  UpdateOverWrite(NewEditor);
  UpdateSelectionMode(NewEditor);
  UpdateLineNumber(NewEditor);
end;

procedure TForm1.SetLineNumberMode(Value: TLineNumberMode);
begin
  if FLineNumberMode <> Value then
  begin
    FLineNumberMode := Value;
    mnuRowCol.Checked := Value = lmRow;
    mnuLinesChar.Checked := Value = lmLine;
    UpdateLineNumber(ActiveEditor);
  end;
end;

procedure TForm1.CaretMoved(Sender: TObject);
begin
  if Sender is TEditor then
    UpdateLineNumber(TEditor(Sender));
end;

procedure TForm1.EditorChange(Sender: TObject);
begin
  if Sender is TEditor then
    UpdateModified(TEditor(Sender));
end;

procedure TForm1.SelectionModeChange(Sender: TObject);
begin
  if Sender is TEditor then
    UpdateSelectionMode(TEditor(Sender));
end;

procedure TForm1.EditorEnter(Sender: TObject);
begin
  if Sender is TEditor then
    UpdateSelectionMode(TEditor(Sender));
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
  ActiveEditor.SetFocus;
  EditorExchanged(ActiveEditor);
end;

procedure TForm1.CreateNewSheet(FileName: String);
var
  Sheet: TTabSheet;
  NewEditor: TEditor;
  S: String;
  I: Integer;
begin
  FFileList.Add(FileName);
  Sheet := TTabSheet.Create(Self);
  Sheet.Caption := ChangeFileExt(ExtractFileName(FileName), '');
  Sheet.PageControl := PageControl1;
  NewEditor := TEditor.Create(Self);
  NewEditor.Parent := Sheet;
  // SetEditorProperties
  NewEditor.Width := Sheet.Width;
  NewEditor.Height := Sheet.Height;
  NewEditor.Align := alClient;
  NewEditor.PopupMenu := PopupMenu1;
  NewEditor.OnCaretMoved := CaretMoved;
  NewEditor.OnChange := EditorChange;
  NewEditor.OnEnter := EditorEnter;
  NewEditor.OnSelectionModeChange := SelectionModeChange;
  // ファイルの拡張子に応じてプロパティを設定する
  S := ExtractFileExt(FileName);
  if FDelphiExtList.Find(S, I) then
    EditorProp2.AssignTo(NewEditor)
  else
    if FHtmlExtList.Find(S, I) then
      EditorProp3.AssignTo(NewEditor)
    else
      EditorProp4.AssignTo(NewEditor);
end;

// menu
procedure TForm1.PopupMenu1Popup(Sender: TObject);
var
  Sel, CanPaste: Boolean;
begin
  with ActiveEditor do
  begin
    mnuOverWrite.Checked := OverWrite;
    mnuReadOnly.Checked := ReadOnly;
    Sel := SelLength > 0;
    mnuCopy.Enabled := Sel;
    mnuCut.Enabled := Sel;
    mnuIndent.Enabled := Sel;
    mnuUnIndent.Enabled := Sel;
    CanPaste := Clipboard.HasFormat(CF_TEXT);
    mnuPaste.Enabled := CanPaste;
    mnuBoxPaste.Enabled := CanPaste;
    mnuRedo.Enabled := CanRedo;
    mnuUndo.Enabled := CanUndo;
    mnuBoxSel.Checked := SelectionMode = smBox;
    mnuSave.Enabled := PageControl1.ActivePage.Caption <> 'new file';
    mnuSplit.Checked := IsSplit;
  end;
end;

procedure TForm1.mnuLoadFromFileClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    CreateNewSheet(OpenDialog1.FileName);
    with PageControl1 do
      ActivePage := Pages[PageCount - 1];
    ActiveEditor.Lines.LoadFromFile(OpenDialog1.FileName);
    ActiveEditor.Modified := False;
    FOpenMenuList.BringToTop(OpenDialog1.FileName);
    EditorExchanged(ActiveEditor);
  end;
end;

procedure TForm1.mnuNewClick(Sender: TObject);
begin
  CreateNewSheet('new file');
  with PageControl1 do
    ActivePage := Pages[PageCount - 1];
  EditorExchanged(ActiveEditor);
end;

procedure TForm1.mnuClearClick(Sender: TObject);
begin
  ActiveEditor.Lines.Clear;
end;

procedure TForm1.mnuPageCloseClick(Sender: TObject);
var
  Index: Integer;
begin
  if PageControl1.PageCount = 1 then
  begin
    Close;
    Exit;
  end;
  Index := PageControl1.ActivePage.PageIndex;
  with PageControl1 do
  begin
    if IsSplit then
      EndSplit;
    FFileList.Delete(Index);
    ActiveEditor.Free;
    ActivePage.Free;
    if Index > 0 then
      ActivePage := Pages[Index - 1]
    else
      ActivePage := Pages[0];
  end;
  PageControl1Change(Self);
end;

procedure TForm1.mnuOverWriteClick(Sender: TObject);
begin
  ActiveEditor.OverWrite := not ActiveEditor.OverWrite;
  UpdateOverWrite(ActiveEditor);
end;

procedure TForm1.mnuCutClick(Sender: TObject);
begin
  ActiveEditor.CutToClipboard;
end;

procedure TForm1.mnuCopyClick(Sender: TObject);
begin
  ActiveEditor.CopyToClipboard;
end;

procedure TForm1.mnuPasteClick(Sender: TObject);
begin
  ActiveEditor.PasteFromClipboard;
end;

procedure TForm1.mnuSelectAllClick(Sender: TObject);
begin
  ActiveEditor.SelectAll;
end;

procedure TForm1.mnuDeleteLineClick(Sender: TObject);
begin
  ActiveEditor.DeleteRow(ActiveEditor.Row);
end;

procedure TForm1.mnuReadOnlyClick(Sender: TObject);
begin
  ActiveEditor.ReadOnly := not ActiveEditor.ReadOnly;
end;

procedure TForm1.mnuUndoClick(Sender: TObject);
begin
  ActiveEditor.Undo;
end;

procedure TForm1.mnuRedoClick(Sender: TObject);
begin
  ActiveEditor.Redo;
end;

procedure TForm1.mnuSaveClick(Sender: TObject);
begin
  ActiveEditor.Lines.SaveToFile(ActiveFileName);
  ActiveEditor.Modified := False;
  UpdateModified(ActiveEditor);
end;

procedure TForm1.mnuSaveAsClick(Sender: TObject);
begin
  if SaveDialog1.Execute then
  begin
    ActiveEditor.Lines.SaveToFile(SaveDialog1.FileName);
    ActiveFileName := SaveDialog1.FileName;
    PageControl1.ActivePage.Caption :=
      ChangeFileExt(ExtractFileName(SaveDialog1.FileName), '');
    ActiveEditor.Modified := False;
    EditorExchanged(ActiveEditor);
  end;
end;

procedure TForm1.RowColClick(Sender: TObject);
begin
  if Sender = mnuRowCol then
    LineNumberMode := lmRow
  else
    LineNumberMode := lmLine;
end;

procedure TForm1.mnuEditorPropertyClick(Sender: TObject);
begin
  EditEditor(ActiveEditor, nil);
end;

procedure TForm1.mnuIndentClick(Sender: TObject);
begin
  if ActiveEditor.Selected then
    ActiveEditor.SelIndent;
end;

procedure TForm1.mnuUnIndentClick(Sender: TObject);
begin
  if ActiveEditor.Selected then
    ActiveEditor.SelUnIndent;
end;

procedure TForm1.mnuBoxSelClick(Sender: TObject);
begin
  if ActiveEditor.SelectionMode = smLine then
    ActiveEditor.SelectionMode := smBox
  else
    ActiveEditor.SelectionMode := smLine;
end;

procedure TForm1.mnuBoxPasteClick(Sender: TObject);
begin
  if Clipboard.HasFormat(CF_TEXT) then
    ActiveEditor.SetSelTextBox(PChar(Clipboard.AsText));
end;

// 検索・置き換え

function TForm1.Search: Boolean;
var
  Info: TSearchInfo;
begin
  Result := False;
  with ActiveEditor do
  begin
    Info.Start := SelStart;
    Info.Length := SelLength;
    // cf HTSearch.pas
    if SearchText(PChar(Lines.Text),
                  Info, FSearchValue, FSearchOptions) then
    begin
      SelStart := Info.Start;
      SelLength := Info.Length;
      SendMessage(ActiveEditor.Handle, EM_SCROLLCARET, 0, 0);
      Result := True;
    end
    else
      ShowMessage('検索文字列  '' ' + FSearchValue + ' ''' + #13#10 +
                  'は見つかりませんでした。');
  end;
end;

procedure TForm1.mnuFindClick(Sender: TObject);
begin
  if TFormSearch.Execute(FSearchValue, FSearchOptions) then
    Search;
end;

procedure TForm1.mnuFindForwardClick(Sender: TObject);
begin
  if FSearchValue <> '' then
  begin
    Include(FSearchOptions, sfrDown);
    Search;
  end;
end;

procedure TForm1.mnuFindBackwardClick(Sender: TObject);
begin
  if FSearchValue <> '' then
  begin
    Exclude(FSearchOptions, sfrDown);
    Search;
  end;
end;

procedure TForm1.mnuReplaceClick(Sender: TObject);
var
  Editor: TEditor;
  CaretPoint: TPoint;
  MsgForm: TForm;
  Choice: Word;

  procedure ReplaceEditor;
  begin
    Editor.SelText := FReplaceValue;
    // 後方検索で Delphi を Delphi is Great に置き換えた場合
    // 無限ループになるのを防ぐための処理
    if not (sfrDown in FSearchOptions) then
      Editor.SelStart := Editor.SelStart - Length(FReplaceValue);
  end;

begin
  if TFormReplace.Execute(
       FSearchValue, FReplaceValue, FSearchOptions) then
  begin
    Editor := ActiveEditor;
    while Search do
    begin
      if sfrReplaceConfirm in FSearchOptions then
      begin
        // get screen position
        GetCaretPos(CaretPoint);
        CaretPoint := Editor.ClientToScreen(CaretPoint);
        // TMessageForm.Create fc Dialogs.pas
        MsgForm :=
          CreateMessageDialog(
            '' + ' ' + FSearchValue + ' ' + '' + '  を' + #13#10+
            '' + ' ' + FReplaceValue + ' ' + '' + '  に 置き換えますか？',
            mtConfirmation, [mbYes, mbNo, mbCancel, mbAll]);
        try
          // positioning
          MsgForm.Top := CaretPoint.Y - MsgForm.Height - Editor.RowHeight;
          if MsgForm.Top < 0 then
            MsgForm.Top := CaretPoint.Y + Editor.RowHeight;
          MsgForm.Left := CaretPoint.X + 2;
          if (MsgForm.Left + MsgForm.Width) > Screen.Width then
            MsgForm.Left := Screen.Width - MsgForm.Width - 4;
          // display
          Choice := MsgForm.ShowModal;
        finally
          MsgForm.Free;
        end;

        case Choice of
          mrYes: ReplaceEditor;
          mrNo: ;
          mrCancel: Exit;
          mrAll:
            begin
              ReplaceEditor;
              Include(FSearchOptions, sfrReplaceAll);
              Exclude(FSearchOptions, sfrReplaceConfirm);
            end;
        end;
      end
      else
        ReplaceEditor;
      if not(sfrReplaceAll in FSearchOptions) then
        Exit;
    end;
  end;
end;

// 分割

procedure SetProperties(Source, Dest: TPersistent; TypeKinds: TTypeKinds);
var
  PropList: PPropList;
  I, Count: Integer;
begin
  Count := GetPropList(Source.ClassInfo, TypeKinds, nil);
  GetMem(PropList, Count * SizeOf(PPropInfo));
  try
    GetPropList(Source.ClassInfo, TypeKinds, PropList);
    for I := 0 to Count - 1 do
      {$IFDEF VER90}
      case PropList[I].PropType.Kind of
      {$ELSE}
      case PropList[I].PropType^.Kind of
      {$ENDIF}
        tkFloat:
          SetFloatProp(
            Dest, PropList[I], GetFloatProp(Source, PropList[I]));
        tkInteger, tkChar, tkEnumeration, tkSet, tkClass:
          SetOrdProp(
            Dest, PropList[I], GetOrdProp(Source, PropList[I]));
        tkMethod:
          SetMethodProp(
            Dest, PropList[I], GetMethodProp(Source, PropList[I]));
        tkString:
          SetStrProp(
            Dest, PropList[I], GetStrProp(Source, PropList[I]));
        { ? tkArray, tkRecord, tkInterface, tkInt64, tkDynArray ? }
      end;
  finally
    FreeMem(PropList, Count * SizeOf(PPropInfo));
  end;
end;

function TForm1.IsSplit: Boolean;
var
  I, Count: Integer;
begin
  Result := False;
  Count := 0;
  for I := 0 to PageControl1.ActivePage.ControlCount - 1 do
    if PageControl1.ActivePage.Controls[I] is TEditor then
    begin
      Inc(Count);
      if Count > 1 then
      begin
        Result := True;
        Exit;
      end;
    end;
end;

function TForm1.SecondEditor: TEditor;
var
  I: Integer;
begin
  Result := nil;
  if IsSplit then
    for I := PageControl1.ActivePage.ControlCount - 1 downto 0 do
      if PageControl1.ActivePage.Controls[I] is TEditor then
        begin
          Result := TEditor(PageControl1.ActivePage.Controls[I]);
          Exit;
        end;
end;

{$IFNDEF VER90}
function TForm1.ActiveSplitter: TSplitter;
var
  I: Integer;
begin
  Result := nil;
  if IsSplit then
    for I := 0 to PageControl1.ActivePage.ControlCount - 1 do
      if PageControl1.ActivePage.Controls[I] is TSplitter then
      begin
        Result := TSplitter(PageControl1.ActivePage.Controls[I]);
        Exit;
      end;
end;

procedure TForm1.SplitterMoved(Sender: TObject);
begin
  if IsSplit then
    SecondEditor.Height := TSplitter(Sender).Top;
end;
{$ENDIF}

procedure TForm1.BeginSplit;
var
  Editor: TEditor;
  {$IFNDEF VER90}
  Splitter: TSplitter;
  {$ENDIF}
begin
  if not IsSplit then
  begin
    Editor := TEditor.Create(Self);
    // TEditorProp によるプロパティ設定
    EditorProp1.Assign(ActiveEditor);
    EditorProp1.AssignTo(Editor);
    // TForm2.Editor1..Editor4 が分割された時のためにイベントハンドラを
    // 受け継ぐ
    SetProperties(ActiveEditor, Editor, tkMethods);
    // PopupMenu, OnCaretMoved, OnChange, OnEnter, OnSelectionModeChange
    // は TForm1 のモノにする
    Editor.PopupMenu := PopupMenu1;
    Editor.OnCaretMoved := CaretMoved;
    Editor.OnChange := EditorChange;
    Editor.OnEnter := EditorEnter;
    Editor.OnSelectionModeChange := SelectionModeChange;
    // Parent 他
    Editor.Parent := PageControl1.ActivePage;
    Editor.Align := alTop;
    Editor.Top := 0;
    Editor.Height := PageControl1.ActivePage.Height div 2;
    // 文字列オブジェクトの共有
    Editor.ExchangeList(ActiveEditor);
    Editor.TopRow := ActiveEditor.TopRow;
    ActiveEditor.TopRow := Editor.TopRow + Editor.RowCount;
    {$IFNDEF VER90}
    Splitter := TSplitter.Create(Self);
    Splitter.Parent := PageControl1.ActivePage;
    Splitter.Align := alTop;
    Splitter.Top := Editor.Top + Editor.Height;
    Splitter.Cursor := crVSplit;
    Splitter.OnMoved := SplitterMoved;
    {$ENDIF}
  end;
end;

procedure TForm1.EndSplit;
begin
  if IsSplit then
  begin
    {$IFNDEF VER90}
    ActiveSplitter.Free;
    {$ENDIF}
    SecondEditor.Free;
    PageControl1Change(Self);
  end;
end;

procedure TForm1.mnuSplitClick(Sender: TObject);
begin
  if IsSplit then
    EndSplit
  else
    BeginSplit;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  {$IFDEF VER90}
  if IsSplit then
    SecondEditor.Height := PageControl1.ActivePage.Height div 2;
  {$ENDIF}
end;

// 別窓

procedure TForm1.mnuOtherWindowClick(Sender: TObject);
var
  Form: TForm1;
begin
  Form := TForm1.Create(Application);
  Form.CreateNewSheet(ActiveFileName);
  Form.Show;
  // TEditorProp によるプロパティ設定
  EditorProp1.Assign(ActiveEditor);
  EditorProp1.AssignTo(Form.ActiveEditor);
  // TForm2.Editor1..Editor4 の別窓を開いた時のためにイベントハンドラを
  // 受け継ぐ
  SetProperties(ActiveEditor, Form.ActiveEditor, tkMethods);
  // PopupMenu, OnCaretMoved, OnChange, OnSelectionModeChange は
  // ここでこしらえた新しい Form のモノにする
  Form.ActiveEditor.PopupMenu := Form.PopupMenu1;
  Form.ActiveEditor.OnCaretMoved := Form.CaretMoved;
  Form.ActiveEditor.OnChange := Form.EditorChange;
  Form.ActiveEditor.OnEnter := Form.EditorEnter;
  Form.ActiveEditor.OnSelectionModeChange := Form.SelectionModeChange;
  // 文字列オブジェクトの共有
  Form.ActiveEditor.ExchangeList(ActiveEditor);
end;

end.

