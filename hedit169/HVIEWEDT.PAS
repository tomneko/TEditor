
{********************************************************************}
{                                                                    }
{    Property Editor & Component Editor for TEditor & TEditorProp    }
{                                                                    }
{    start  1999/06/20                                               }
{                                                                    }
{    update 2000/03/23                                               }
{                                                                    }
{    Copyright (c) 1999, 2000 本田勝彦 <katsuhiko.honda@nifty.ne.jp> }
{                                                                    }
{********************************************************************}

unit HViewEdt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ColorGrd, StdCtrls, ExtCtrls, ComCtrls, Buttons, HEditor,
  Spin, Menus, Clipbrd, HEdtProp;

type
  TFormViewEditor = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Editor1: TEditor;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label11: TLabel;
    Label12: TLabel;
    Button4: TButton;
    Button5: TButton;
    CheckBox12: TCheckBox;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Edit1: TEdit;
    TabSheet4: TTabSheet;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    PopupMenu1: TPopupMenu;
    Paste1: TMenuItem;
    Copy1: TMenuItem;
    Cut1: TMenuItem;
    Redo1: TMenuItem;
    Undo1: TMenuItem;
    DeleteRow1: TMenuItem;
    TabSheet5: TTabSheet;
    EditorProp1: TEditorProp;
    Button6: TButton;
    TabSheet6: TTabSheet;
    CheckBox20: TCheckBox;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    SpinEdit6: TSpinEdit;
    Editor4: TEditor;
    Button7: TButton;
    Button8: TButton;
    ListBox4: TListBox;
    ColorGrid2: TColorGrid;
    GroupBox1: TGroupBox;
    CheckBox17: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox18: TCheckBox;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button3: TButton;
    Edit6: TEdit;
    Label9: TLabel;
    Label8: TLabel;
    Edit5: TEdit;
    Button2: TButton;
    Button1: TButton;
    Editor3: TEditor;
    ListBox3: TListBox;
    ColorGrid1: TColorGrid;
    GroupBox7: TGroupBox;
    CheckBox13: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox14: TCheckBox;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    GroupBox4: TGroupBox;
    CheckBox11: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox27: TCheckBox;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpinEdit3: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    Editor2: TEditor;
    GroupBox2: TGroupBox;
    Label10: TLabel;
    CheckBox2: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    RadioGroup1: TRadioGroup;
    CheckBox6: TCheckBox;
    CheckBox8: TCheckBox;
    SpinEdit1: TSpinEdit;
    CheckBox26: TCheckBox;
    CheckBox28: TCheckBox;
    RadioGroup2: TRadioGroup;
    GroupBox6: TGroupBox;
    CheckBox29: TCheckBox;
    CheckBox30: TCheckBox;
    RadioGroup3: TRadioGroup;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    ComboBox5: TComboBox;
    Editor5: TEditor;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure CheckBox16Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure SpinEdit5Change(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure ColorGrid1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox4Click(Sender: TObject);
    procedure ColorGrid2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CheckBox17Click(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Undo1Click(Sender: TObject);
    procedure Redo1Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure DeleteRow1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure CheckBox21Click(Sender: TObject);
    procedure CheckBox22Click(Sender: TObject);
    procedure CheckBox23Click(Sender: TObject);
    procedure CheckBox24Click(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit8Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure SpinEdit6Change(Sender: TObject);
    procedure CheckBox25Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure CheckBox20Click(Sender: TObject);
    procedure Edit5Change(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure CheckBox26Click(Sender: TObject);
    procedure CheckBox27Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure CheckBox28Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox29Click(Sender: TObject);
    procedure RadioGroup3Click(Sender: TObject);
    procedure CheckBox30Click(Sender: TObject);
  private
    FColorList: TList;
    FEditorProp: TEditorProp;
    FOption: TPersistent;
    FShowTrueType: Boolean;
    procedure BuildFontList;
    procedure GetColorList(const S: String);
    procedure GetCursors(const S: string);
    procedure UpdateFontColor(Sender: TObject);
    procedure UpdateView(Sender: TObject);
    procedure UpdateMargin(Sender: TObject);
    procedure UpdateMarks(Sender: TObject);
    procedure UpdateScrollBars(Sender: TObject);
    function EditEditorProp(EditorProp: TEditorProp;
      Option: TPersistent): Boolean;
    procedure WMHelp(var Message: TMessage); message WM_HELP;
  public
    class function Execute(EditorProp: TEditorProp;
      Option: TPersistent): Boolean;
  end;

function EditEditor(Editor: TEditor; Option: TPersistent): Boolean;
function EditEditorProp(EditorProp: TEditorProp; Option: TPersistent): Boolean;

implementation

{$R *.DFM}

function EditEditor(Editor: TEditor; Option: TPersistent): Boolean;
var
  EditorProp: TEditorProp;
begin
  Result := False;
  EditorProp := TEditorProp.Create(nil);
  try
    EditorProp.Assign(Editor);
    if EditEditorProp(EditorProp, Option) then
    begin
      EditorProp.AssignTo(Editor);
      Result := True;
    end;
  finally
    EditorProp.Free;
  end;
end;

function EditEditorProp(EditorProp: TEditorProp;
  Option: TPersistent): Boolean;
begin
  Result := TFormViewEditor.Execute(EditorProp, Option);
end;


{ TFormViewEditor }

class function TFormViewEditor.Execute(EditorProp: TEditorProp;
  Option: TPersistent): Boolean;
var
  Form: TFormViewEditor;
begin
  Form := TFormViewEditor.Create(Application);
  try
    Result := Form.EditEditorProp(EditorProp, Option);
  finally
    Form.Free;
  end;
end;

function TFormViewEditor.EditEditorProp(EditorProp: TEditorProp;
  Option: TPersistent): Boolean;
begin
  Result := False;
  if EditorProp = nil then Exit;
  // EditorProp, Option への参照を保持する
  FEditorProp := EditorProp;
  FOption := Option;
  // EditorProp のプロパティを受け取る
  EditorProp1.Assign(EditorProp);
  // 各コントロールの初期化
  // color & font
  Editor1.Font.Name := EditorProp1.Font.Name;
  Editor1.Font.Size := EditorProp1.Font.Size;
  // TEditorViewInfo
  Edit2.Text := EditorProp1.View.HexPrefix;
  Edit3.Text := EditorProp1.View.Quotation;
  Edit4.Text := EditorProp1.View.Commenter;
  CheckBox16.Checked := EditorProp1.View.ControlCode;
  CheckBox27.Checked := EditorProp1.View.Mail;
  CheckBox25.Checked := EditorProp1.View.Url;
  // TEditorCaret
  CheckBox1.Checked := EditorProp1.Caret.FreeCaret;
  CheckBox2.Checked := EditorProp1.Caret.AutoIndent;
  CheckBox3.Checked := EditorProp1.Caret.InTab;
  CheckBox26.Checked := EditorProp1.Caret.KeepCaret;
  CheckBox4.Checked := EditorProp1.Caret.LockScroll;
  CheckBox5.Checked := EditorProp1.Caret.NextLine;
  CheckBox6.Checked := EditorProp1.Caret.TabIndent;
  CheckBox7.Checked := EditorProp1.Caret.PrevSpaceIndent;
  CheckBox28.Checked := EditorProp1.Caret.SelMove;
  CheckBox8.Checked := EditorProp1.Caret.SoftTab;
  CheckBox29.Checked := EditorProp1.Caret.RowSelect;
  CheckBox30.Checked := EditorProp1.Caret.AutoCursor;
  SpinEdit1.Value := EditorProp1.Caret.TabSpaceCount;
  RadioGroup1.ItemIndex := Ord(EditorProp1.Caret.Style);
  RadioGroup3.ItemIndex := Ord(EditorProp1.Caret.SelDragMode);
  // ScrollBars
  Editor1.ScrollBars := EditorProp1.ScrollBars;
  RadioGroup2.ItemIndex := Ord(EditorProp1.ScrollBars);
  // TEditorMarks
  CheckBox9.Checked := EditorProp1.Marks.RetMark.Visible;
  CheckBox10.Checked := EditorProp1.Marks.EofMark.Visible;
  CheckBox11.Checked := EditorProp1.Marks.Underline.Visible;
  // TEditorMargin
  SpinEdit2.Value := EditorProp1.Margin.Top;
  SpinEdit3.Value := EditorProp1.Margin.Left;
  SpinEdit4.Value := EditorProp1.Margin.Line;
  SpinEdit5.Value := EditorProp1.Margin.Character;
  // draw
  UpdateView(Self);
  UpdateMarks(Self);
  UpdateMargin(Self);
  UpdateFontColor(Self);
  // ReserveWordList
  Editor4.Lines.Assign(EditorProp1.ReserveWordList);
  Editor4.Row := 0;
  // WordWrap
  CheckBox20.Checked := EditorProp1.WordWrap;
  CheckBox21.Checked := EditorProp1.WrapOption.FollowPunctuation;
  CheckBox22.Checked := EditorProp1.WrapOption.FollowRetMark;
  CheckBox23.Checked := EditorProp1.WrapOption.Leading;
  CheckBox24.Checked := EditorProp1.WrapOption.WordBreak;
  Edit7.Text := EditorProp1.WrapOption.FollowStr;
  Edit8.Text := EditorProp1.WrapOption.LeadStr;
  Edit9.Text := EditorProp1.WrapOption.PunctuationStr;
  SpinEdit6.Value := EditorProp1.WrapOption.WrapByte;
  // イベントハンドラをアタッチする
  EditorProp1.OnColorChange := UpdateFontColor;
  EditorProp1.Font.OnChange := UpdateFontColor;
  EditorProp1.Margin.OnChange := UpdateMargin;
  EditorProp1.Marks.OnChange := UpdateMarks;
  EditorProp1.OnScrollBarsChange := UpdateScrollBars;
  EditorProp1.View.OnChange := UpdateView;
  // show modal
  Result := ShowModal = mrOk;
end;

// GetColorValues に渡すメソッド cf. Graphics.pas

procedure TFormViewEditor.GetColorList(const S: String);
begin
  if FColorList.Count < 16 then
    FColorList.Add(Pointer(StringToColor(S)));
end;

//   HGetCursorValues に渡すメソッド cf. Controls.pas

procedure TFormViewEditor.GetCursors(const S: string);
begin
  ComboBox1.Items.Add(S);
  ComboBox2.Items.Add(S);
  ComboBox3.Items.Add(S);
  ComboBox4.Items.Add(S);
  ComboBox5.Items.Add(S);
end;

procedure TFormViewEditor.FormCreate(Sender: TObject);
begin
  FColorList := TList.Create;
  GetColorValues(GetColorList);
  FColorList.Exchange(7, 8); // exchange clSilver, clGray
end;

procedure TFormViewEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FColorList.Free;
end;

procedure TFormViewEditor.FormShow(Sender: TObject);
var
  I: Integer;
begin
  BuildFontList;
  I := ListBox1.Items.IndexOf(EditorProp1.Font.Name);
  if I >= 0 then
    ListBox1.ItemIndex := I
  else
  begin
    ListBox1.ItemIndex := 0;
    EditorProp1.Font.Name := ListBox1.Items[0];
  end;
  for I := 8 to 50 do
    ListBox2.Items.Add(IntToStr(I));
  I := ListBox2.Items.IndexOf(IntToStr(EditorProp1.Font.Size));
  if I >= 0 then
    ListBox2.ItemIndex := I
  else
  begin
    ListBox2.ItemIndex := 0;
    EditorProp1.Font.Size := StrToIntDef(ListBox2.Items[0], 10);
  end;
  Edit1.Text := IntToStr(EditorProp1.Font.Size);
  ListBox3.ItemIndex := 0;
  ListBox3Click(Self);
  ListBox4.ItemIndex := 0;
  ListBox4Click(Self);
  HGetCursorValues(GetCursors);
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(HCursorToString(EditorProp1.Caret.Cursors.DefaultCursor));
  ComboBox2.ItemIndex := ComboBox2.Items.IndexOf(HCursorToString(EditorProp1.Caret.Cursors.DragSelCursor));
  ComboBox3.ItemIndex := ComboBox3.Items.IndexOf(HCursorToString(EditorProp1.Caret.Cursors.DragSelCopyCursor));
  ComboBox4.ItemIndex := ComboBox4.Items.IndexOf(HCursorToString(EditorProp1.Caret.Cursors.InSelCursor));
  ComboBox5.ItemIndex := ComboBox5.Items.IndexOf(HCursorToString(EditorProp1.Caret.Cursors.LeftMarginCursor));
  Editor5.Caret.Cursors.Assign(EditorProp1.Caret.Cursors);
  Editor5.SelStart := 12;
  Editor5.SelLength := 22;
  if FOption is TEditorBracketCollection then
    PageControl1.ActivePage := TabSheet4
  else
    if FOption is TEditorCaret then
      PageControl1.ActivePage := TabSheet2
    else
      if FOption is TEditorWrapOption then
        PageControl1.ActivePage := TabSheet6
      else
        PageControl1.ActivePage := TabSheet3;
end;

// フォントの取得

function EnumFontFamProc(var EnumLogFont: TEnumLogFont;
  var NewTextMetric: TNewTextMetric; FontType: Integer;
  Data: Pointer): Integer; stdcall;
var
  Items: TStrings;
begin
  Items := TFormViewEditor(Data).ListBox1.Items;
  Result := 1;
  // @
  if EnumLogFont.elfLogFont.lfFaceName[0] = '@' then Exit;
  // TMPF_FIXED_PITCH = 1 is variable pitch font
  if not TFormViewEditor(Data).FShowTrueType and
    ((NewTextMetric.tmPitchAndFamily and 1) = 1) then Exit;
  Items.Add(EnumLogFont.elfLogFont.lfFaceName);
end;

procedure TFormViewEditor.BuildFontList;
var
  DC: HDC;
begin
  ListBox1.Items.Clear;
  DC:= GetDC(0);
  EnumFontFamilies(DC, nil, @EnumFontFamProc, Longint(Pointer(Self)));
  ReleaseDC(0, DC);
end;

procedure TFormViewEditor.CheckBox12Click(Sender: TObject);
var
  I: Integer;
begin
  FShowTrueType := CheckBox12.Checked;
  BuildFontList;
  I := ListBox1.Items.IndexOf(EditorProp1.Font.Name);
  if I >= 0 then
    ListBox1.ItemIndex := I
  else
  begin
    ListBox1.ItemIndex := 0;
    EditorProp1.Font.Name := ListBox1.Items[0];
  end;
end;

procedure TFormViewEditor.ListBox1Click(Sender: TObject);
begin
  EditorProp1.Font.Name := ListBox1.Items[ListBox1.ItemIndex];
end;

procedure TFormViewEditor.ListBox2Click(Sender: TObject);
begin
  Edit1.Text := ListBox2.Items[ListBox2.ItemIndex];
end;

procedure TFormViewEditor.Edit1Change(Sender: TObject);
begin
  EditorProp1.Font.Size := StrToIntDef(Edit1.Text, 10);
end;

procedure TFormViewEditor.UpdateFontColor(Sender: TObject);
begin
  Editor1.Font.Name := EditorProp1.Font.Name;
  Editor1.Font.Size := EditorProp1.Font.Size;
  Editor2.Color := EditorProp1.Color;
  Editor2.Font.Color := EditorProp1.Font.Color;
  Editor2.Font.Style := EditorProp1.Font.Style;
  Editor3.Color := EditorProp1.Color;
  Editor3.Font.Color := EditorProp1.Font.Color;
  Editor3.Font.Style := EditorProp1.Font.Style;
  FormPaint(Sender);
end;

procedure TFormViewEditor.UpdateMargin(Sender: TObject);
begin
  Editor2.Margin.Assign(EditorProp1.Margin);
  Editor3.Margin.Assign(EditorProp1.Margin);
  FormPaint(Sender);
end;

procedure TFormViewEditor.UpdateMarks(Sender: TObject);
begin
  Editor2.Marks.Assign(EditorProp1.Marks);
  Editor3.Marks.Assign(EditorProp1.Marks);
  FormPaint(Sender);
end;

procedure TFormViewEditor.UpdateScrollBars(Sender: TObject);
begin
  Editor1.ScrollBars := EditorProp1.ScrollBars;
end;

procedure TFormViewEditor.UpdateView(Sender: TObject);
var
  I, J: Integer;
begin
  J := ListBox4.ItemIndex;
  // TEditorBracketCollection
  Editor3.Lines.BeginUpdate;
  ListBox4.Items.BeginUpdate;
  try
    Editor3.Lines.Clear;
    ListBox4.Items.Clear;
    for I := 0 to EditorProp1.View.Brackets.Count - 1 do
      with EditorProp1.View.Brackets[I] do
      begin
        ListBox4.Items.Add(LeftBracket + ' ' + RightBracket);
        Editor3.Lines.Add(LeftBracket + ' Closed String ' + RightBracket);
      end;
  finally
    Editor3.Lines.EndUpdate;
    ListBox4.Items.EndUpdate;
  end;
  if J >= 0 then
  begin
    ListBox4.ItemIndex := J;
    ListBox4Click(Self);
  end;
  Editor2.View.Assign(EditorProp1.View);
  Editor3.View.Assign(EditorProp1.View);
  Button12.Enabled := ListBox4.Items.Count > 0;
  Button13.Enabled := ListBox4.Items.Count > 0;
  Button14.Enabled := ListBox4.Items.Count > 0;
  FormPaint(Sender);
end;

procedure TFormViewEditor.PageControl1Change(Sender: TObject);
begin
  FormPaint(Sender);
end;

procedure TFormViewEditor.FormPaint(Sender: TObject);
var
  R: TRect;
begin
  if Editor2.Visible then
  begin
    UpdateWindow(Editor2.Handle);
    R := Rect(
           EditorProp1.Margin.Left,
           EditorProp1.Margin.Top,
           EditorProp1.Margin.Left + Editor2.ColWidth * 8,
           EditorProp1.Margin.Top + Editor2.RowHeight
         );
    Editor2.Canvas.Brush.Color := EditorProp1.View.Colors.Select.BkColor;
    Editor2.Canvas.Font.Color := EditorProp1.View.Colors.Select.Color;
    Editor2.Canvas.Font.Style := EditorProp1.View.Colors.DBCS.Style;
    Editor2.DrawTextRect(R, EditorProp1.Margin.Left, EditorProp1.Margin.Top, '選択領域', 0);
  end;
end;

procedure TFormViewEditor.CheckBox1Click(Sender: TObject);
begin
  EditorProp1.Caret.FreeCaret := CheckBox1.Checked;
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.CheckBox2Click(Sender: TObject);
begin
  EditorProp1.Caret.AutoIndent := CheckBox2.Checked;
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.CheckBox3Click(Sender: TObject);
begin
  EditorProp1.Caret.InTab := CheckBox3.Checked;
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.CheckBox26Click(Sender: TObject);
begin
  EditorProp1.Caret.KeepCaret := CheckBox26.Checked;
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.CheckBox4Click(Sender: TObject);
begin
  EditorProp1.Caret.LockScroll := CheckBox4.Checked;
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.CheckBox5Click(Sender: TObject);
begin
  EditorProp1.Caret.NextLine := CheckBox5.Checked;
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.CheckBox6Click(Sender: TObject);
begin
  EditorProp1.Caret.TabIndent := CheckBox6.Checked;
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.CheckBox7Click(Sender: TObject);
begin
  EditorProp1.Caret.PrevSpaceIndent := CheckBox7.Checked;
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.CheckBox8Click(Sender: TObject);
begin
  EditorProp1.Caret.SoftTab := CheckBox8.Checked;
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.SpinEdit1Change(Sender: TObject);
begin
  EditorProp1.Caret.TabSpaceCount := SpinEdit1.Value;
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.RadioGroup1Click(Sender: TObject);
begin
  EditorProp1.Caret.Style := TEditorCaretStyle(RadioGroup1.ItemIndex);
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.RadioGroup3Click(Sender: TObject);
begin
  EditorProp1.Caret.SelDragMode := TDragMode(RadioGroup3.ItemIndex);
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.CheckBox28Click(Sender: TObject);
begin
  EditorProp1.Caret.SelMove := CheckBox28.Checked;
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.CheckBox29Click(Sender: TObject);
begin
  EditorProp1.Caret.RowSelect := CheckBox29.Checked;
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.CheckBox30Click(Sender: TObject);
begin
  EditorProp1.Caret.AutoCursor := CheckBox30.Checked;
  Editor5.Caret.Assign(EditorProp1.Caret);
end;

procedure TFormViewEditor.ComboBox1Change(Sender: TObject);
begin
  if Sender is TComboBox then
  begin
    with EditorProp1.Caret.Cursors, TComboBox(Sender) do
      case Tag of
        1: DefaultCursor := HStringToCursor(Items[ItemIndex]);
        2: DragSelCursor := HStringToCursor(Items[ItemIndex]);
        3: DragSelCopyCursor := HStringToCursor(Items[ItemIndex]);
        4: InSelCursor := HStringToCursor(Items[ItemIndex]);
        5: LeftMarginCursor := HStringToCursor(Items[ItemIndex]);
      end;
    Editor5.Caret.Cursors.Assign(EditorProp1.Caret.Cursors);
  end;
end;

procedure TFormViewEditor.ListBox3Click(Sender: TObject);
var
  B, C: TColor;
  Styles: TFontStyles;
  I: Integer;
begin
  case ListBox3.ItemIndex of
    0:
      begin
        B := EditorProp1.Color;
        C := EditorProp1.Font.Color;
        Styles := EditorProp1.Font.Style;
      end;
    1:
      begin
        B := EditorProp1.View.Colors.Ank.BkColor;
        C := EditorProp1.View.Colors.Ank.Color;
        Styles := EditorProp1.View.Colors.Ank.Style;
      end;
    2:
      begin
        B := EditorProp1.View.Colors.Comment.BkColor;
        C := EditorProp1.View.Colors.Comment.Color;
        Styles := EditorProp1.View.Colors.Comment.Style;
      end;
    3:
      begin
        B := EditorProp1.View.Colors.DBCS.BkColor;
        C := EditorProp1.View.Colors.DBCS.Color;
        Styles := EditorProp1.View.Colors.DBCS.Style;
      end;
    4:
      begin
        B := EditorProp1.View.Colors.Int.BkColor;
        C := EditorProp1.View.Colors.Int.Color;
        Styles := EditorProp1.View.Colors.Int.Style;
      end;
    5:
      begin
        B := EditorProp1.View.Colors.Str.BkColor;
        C := EditorProp1.View.Colors.Str.Color;
        Styles := EditorProp1.View.Colors.Str.Style;
      end;
    6:
      begin
        B := EditorProp1.View.Colors.Symbol.BkColor;
        C := EditorProp1.View.Colors.Symbol.Color;
        Styles := EditorProp1.View.Colors.Symbol.Style;
      end;
    7:
      begin
        B := EditorProp1.View.Colors.Reserve.BkColor;
        C := EditorProp1.View.Colors.Reserve.Color;
        Styles := EditorProp1.View.Colors.Reserve.Style;
      end;
    8:
      begin
        B := EditorProp1.View.Colors.Url.BkColor;
        C := EditorProp1.View.Colors.Url.Color;
        Styles := EditorProp1.View.Colors.Url.Style;
      end;
    9:
      begin
        B := EditorProp1.View.Colors.Mail.BkColor;
        C := EditorProp1.View.Colors.Mail.Color;
        Styles := EditorProp1.View.Colors.Mail.Style;
      end;
   10:
      begin
        B := EditorProp1.View.Colors.Select.BkColor;
        C := EditorProp1.View.Colors.Select.Color;
        Styles := EditorProp1.View.Colors.Select.Style;
      end;
   11:
      begin
        B := clWhite;
        C := EditorProp1.Marks.EofMark.Color;
        Styles := [];
      end;
   12:
      begin
        B := clWhite;
        C := EditorProp1.Marks.RetMark.Color;
        Styles := [];
      end;
   13:
      begin
        B := clWhite;
        C := EditorProp1.Marks.Underline.Color;
        Styles := [];
      end;
  else
    B := clWhite;
    C := clBlack;
    Styles := [];
  end;
  // BackgroundEabled
  if ListBox3.ItemIndex in [11..13] then
    ColorGrid1.BackgroundEnabled := False
  else
    ColorGrid1.BackgroundEnabled := True;
  // ColorIndex
  I := FColorList.IndexOf(Pointer(B));
  if I = -1 then
    I := 15; // clWhite
  ColorGrid1.BackgroundIndex := I;
  I := FColorList.IndexOf(Pointer(C));
  if I = -1 then
    I := 0; // clBlack;
  ColorGrid1.ForegroundIndex := I;
  // Style
  CheckBox13.OnClick := nil;
  CheckBox14.OnClick := nil;
  CheckBox15.OnClick := nil;
  CheckBox13.Checked := fsBold in Styles;
  CheckBox14.Checked := fsUnderline in Styles;
  CheckBox15.Checked := fsItalic in Styles;
  CheckBox13.OnClick := CheckBox13Click;
  CheckBox14.OnClick := CheckBox13Click;
  CheckBox15.OnClick := CheckBox13Click;
  if ListBox3.ItemIndex in [10..13] then
  begin
    CheckBox13.Enabled := False;
    CheckBox14.Enabled := False;
    CheckBox15.Enabled := False;
  end
  else
  begin
    CheckBox13.Enabled := True;
    CheckBox14.Enabled := True;
    CheckBox15.Enabled := True;
  end;
end;

procedure TFormViewEditor.ColorGrid1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  B, C: TColor;
begin
  B := TColor(FColorList.Items[ColorGrid1.BackgroundIndex]);
  C := TColor(FColorList.Items[ColorGrid1.ForegroundIndex]);
  case ListBox3.ItemIndex of
    0:
      begin
        EditorProp1.Color := B;
        EditorProp1.Font.Color := C;
      end;
    1:
      begin
        EditorProp1.View.Colors.Ank.BkColor := B;
        EditorProp1.View.Colors.Ank.Color := C;
      end;
    2:
      begin
        EditorProp1.View.Colors.Comment.BkColor := B;
        EditorProp1.View.Colors.Comment.Color := C;
      end;
    3:
      begin
        EditorProp1.View.Colors.DBCS.BkColor := B;
        EditorProp1.View.Colors.DBCS.Color := C;
      end;
    4:
      begin
        EditorProp1.View.Colors.Int.BkColor := B;
        EditorProp1.View.Colors.Int.Color := C;
      end;
    5:
      begin
        EditorProp1.View.Colors.Str.BkColor := B;
        EditorProp1.View.Colors.Str.Color := C;
      end;
    6:
      begin
        EditorProp1.View.Colors.Symbol.BkColor := B;
        EditorProp1.View.Colors.Symbol.Color := C;
      end;
    7:
      begin
        EditorProp1.View.Colors.Reserve.BkColor := B;
        EditorProp1.View.Colors.Reserve.Color := C;
      end;
    8:
      begin
        EditorProp1.View.Colors.Url.BkColor := B;
        EditorProp1.View.Colors.Url.Color := C;
      end;
    9:
      begin
        EditorProp1.View.Colors.Mail.BkColor := B;
        EditorProp1.View.Colors.Mail.Color := C;
      end;
   10:
      begin
        EditorProp1.View.Colors.Select.BkColor := B;
        EditorProp1.View.Colors.Select.Color := C;
      end;
   11: EditorProp1.Marks.EofMark.Color := C;
   12: EditorProp1.Marks.RetMark.Color := C;
   13: EditorProp1.Marks.Underline.Color := C;
  end;
end;

procedure TFormViewEditor.CheckBox13Click(Sender: TObject);

  function GetStyles: TFontStyles;
  begin
    Result := [];
    if CheckBox13.Checked then
      Result := Result + [fsBold];
    if CheckBox14.Checked then
      Result := Result + [fsUnderline];
    if CheckBox15.Checked then
      Result := Result + [fsItalic];
  end;

begin
  case ListBox3.ItemIndex of
    0: EditorProp1.Font.Style := GetStyles;
    1: EditorProp1.View.Colors.Ank.Style := GetStyles;
    2: EditorProp1.View.Colors.Comment.Style := GetStyles;
    3: EditorProp1.View.Colors.DBCS.Style := GetStyles;
    4: EditorProp1.View.Colors.Int.Style := GetStyles;
    5: EditorProp1.View.Colors.Str.Style := GetStyles;
    6: EditorProp1.View.Colors.Symbol.Style := GetStyles;
    7: EditorProp1.View.Colors.Reserve.Style := GetStyles;
    8: EditorProp1.View.Colors.Url.Style := GetStyles;
    9: EditorProp1.View.Colors.Mail.Style := GetStyles;
   10: EditorProp1.View.Colors.Select.Style := GetStyles;
  end;
end;


procedure TFormViewEditor.Edit2Change(Sender: TObject);
begin
  Editor2.Lines[1] := '0123456789  ' + Edit2.Text + 'AF';
  EditorProp1.View.HexPrefix := Edit2.Text;
end;

procedure TFormViewEditor.Edit3Change(Sender: TObject);
var
  S: String;
begin
  S := Edit3.Text;
  if Length(S) > 0 then
    Edit3.Text := S[1];
  Editor2.Lines[0] := '選択領域  ' + Edit3.Text + 'String' + Edit3.Text + '  #13#10';
  EditorProp1.View.Quotation := Edit3.Text;
end;

procedure TFormViewEditor.Edit4Change(Sender: TObject);
begin
  Editor2.Lines[2] := 'Editor1.View.Brackets[0]  ' + Edit4.Text + ' Commentline';
  EditorProp1.View.Commenter := Edit4.Text;
end;

procedure TFormViewEditor.CheckBox16Click(Sender: TObject);
begin
  EditorProp1.View.ControlCode := CheckBox16.Checked;
end;

procedure TFormViewEditor.CheckBox27Click(Sender: TObject);
begin
  EditorProp1.View.Mail := CheckBox27.Checked;
end;

procedure TFormViewEditor.CheckBox25Click(Sender: TObject);
begin
  EditorProp1.View.Url := CheckBox25.Checked;
end;

procedure TFormViewEditor.CheckBox9Click(Sender: TObject);
begin
  EditorProp1.Marks.RetMark.Visible := CheckBox9.Checked;
end;

procedure TFormViewEditor.CheckBox10Click(Sender: TObject);
begin
  EditorProp1.Marks.EofMark.Visible := CheckBox10.Checked;
end;

type
  TKokodakenoEditorMargin = class(TEditorMargin);

procedure TFormViewEditor.CheckBox11Click(Sender: TObject);
begin
  EditorProp1.Marks.Underline.Visible := CheckBox11.Checked;
  if EditorProp1.Marks.Underline.Visible then
    TKokodakenoEditorMargin(EditorProp1.Margin).Underline := 1
  else
    TKokodakenoEditorMargin(EditorProp1.Margin).Underline := 0;
end;

procedure TFormViewEditor.SpinEdit2Change(Sender: TObject);
begin
  EditorProp1.Margin.Top := SpinEdit2.Value;
end;

procedure TFormViewEditor.SpinEdit3Change(Sender: TObject);
begin
  EditorProp1.Margin.Left := SpinEdit3.Value;
end;

procedure TFormViewEditor.SpinEdit4Change(Sender: TObject);
begin
  EditorProp1.Margin.Line := SpinEdit4.Value;
end;

procedure TFormViewEditor.SpinEdit5Change(Sender: TObject);
begin
  EditorProp1.Margin.Character := SpinEdit5.Value;
end;

procedure TFormViewEditor.ListBox4Click(Sender: TObject);
var
  I, J: Integer;
  Item: TEditorBracketItem;
  C, B: TColor;
  Styles: TFontStyles;
begin
  I := ListBox4.ItemIndex;
  if I >= 0 then
  begin
    // Enabled
    Edit5.Enabled := True;
    Edit6.Enabled := True;
    Button2.Enabled := True;
    ColorGrid2.BackgroundEnabled := True;
    ColorGrid2.ForegroundEnabled := True;
    CheckBox17.Enabled := True;
    CheckBox18.Enabled := True;
    CheckBox19.Enabled := True;
    // BracketItem
    Item := EditorProp1.View.Brackets[I];
    B := Item.ItemColor.BkColor;
    C := Item.ItemColor.Color;
    Styles := Item.ItemColor.Style;
    J := FColorList.IndexOf(Pointer(B));
    if J = -1 then
      J := 15; // clWhite
    ColorGrid2.BackgroundIndex := J;
    J := FColorList.IndexOf(Pointer(C));
    if J = -1 then
      J := 0; // clBlack;
    ColorGrid2.ForegroundIndex := J;
    Edit5.Text := Item.LeftBracket;
    Edit6.Text := Item.RightBracket;
    CheckBox17.OnClick := nil;
    CheckBox18.OnClick := nil;
    CheckBox19.OnClick := nil;
    CheckBox17.Checked := fsBold in Styles;
    CheckBox18.Checked := fsUnderline in Styles;
    CheckBox19.Checked := fsItalic in Styles;
    CheckBox17.OnClick := CheckBox17Click;
    CheckBox18.OnClick := CheckBox17Click;
    CheckBox19.OnClick := CheckBox17Click;
  end;
end;

procedure TFormViewEditor.ColorGrid2MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  I := ListBox4.ItemIndex;
  if I >= 0 then
  begin
    EditorProp1.View.BeginUpdate;
    try
      EditorProp1.View.Brackets[I].ItemColor.BkColor :=
        TColor(FColorList.Items[ColorGrid2.BackgroundIndex]);
      EditorProp1.View.Brackets[I].ItemColor.Color :=
        TColor(FColorList.Items[ColorGrid2.ForegroundIndex]);
    finally
      EditorProp1.View.EndUpdate;
    end;
  end;
end;

procedure TFormViewEditor.CheckBox17Click(Sender: TObject);
var
  I: Integer;

  function GetStyles: TFontStyles;
  begin
    Result := [];
    if CheckBox17.Checked then
      Result := Result + [fsBold];
    if CheckBox18.Checked then
      Result := Result + [fsUnderline];
    if CheckBox19.Checked then
      Result := Result + [fsItalic];
  end;

begin
  I := ListBox4.ItemIndex;
  if I >= 0 then
  begin
    EditorProp1.View.BeginUpdate;
    try
      EditorProp1.View.Brackets[I].ItemColor.Style := GetStyles;
    finally
      EditorProp1.View.EndUpdate;
    end;
  end;
end;

procedure TFormViewEditor.Button1Click(Sender: TObject);
begin
  EditorProp1.View.Brackets.Add;
  ListBox4.ItemIndex := ListBox4.Items.Count - 1;
  ListBox4Click(Self);
end;

procedure TFormViewEditor.Button2Click(Sender: TObject);
var
  I: Integer;
begin
  I := ListBox4.ItemIndex;
  if I >= 0 then
  begin
    EditorProp1.View.Brackets[I].Free;
    if I > ListBox4.Items.Count - 1 then
      I := ListBox4.Items.Count - 1;
    if I >= 0 then
    begin
      ListBox4.ItemIndex := I;
      ListBox4Click(Self);
    end
    else
    begin
      Edit5.Text := '';
      Edit6.Text := '';
      Edit5.Enabled := False;
      Edit6.Enabled := False;
      Button2.Enabled := False;
      ColorGrid2.BackgroundEnabled := False;
      ColorGrid2.ForegroundEnabled := False;
      CheckBox17.Checked := False;
      CheckBox18.Checked := False;
      CheckBox19.Checked := False;
      CheckBox17.Enabled := False;
      CheckBox18.Enabled := False;
      CheckBox19.Enabled := False;
    end;
  end;
end;

procedure TFormViewEditor.Edit5Change(Sender: TObject);
begin
  Button3.Enabled := (Edit5.Text <> Edit6.Text) and
                     (Edit5.Text <> '') and
                     (Edit6.Text <> '');
end;

procedure TFormViewEditor.Button3Click(Sender: TObject);
var
  I: Integer;
begin
  I := ListBox4.ItemIndex;
  if I >= 0 then
  begin
    if (Edit5.Text = Edit6.Text) or (Edit5.Text = '') or (Edit6.Text = '') then
      raise Exception.Create('空白 ・ 同一の LeftBracket, RightBracket は指定出来ません。');
    EditorProp1.View.BeginUpdate;
    try
      EditorProp1.View.Brackets[I].LeftBracket := Edit5.Text;
      EditorProp1.View.Brackets[I].RightBracket := Edit6.Text;
    finally
      EditorProp1.View.EndUpdate;
    end;
  end;
end;

procedure TFormViewEditor.Button12Click(Sender: TObject);
var
  B: TColor;
begin
  if EditorProp1.View.Brackets.Count > 0 then
  begin
    B := EditorProp1.View.Brackets[0].ItemColor.BkColor;
    if MessageDlg('Change all BkColor to ' + ColorToString(B),
                  mtConfirmation, mbOkCancel, 0) = mrOk then
      EditorProp1.View.Brackets.SameBkColor(B);
  end;
end;

procedure TFormViewEditor.Button13Click(Sender: TObject);
var
  C: TColor;
begin
  if EditorProp1.View.Brackets.Count > 0 then
  begin
    C := EditorProp1.View.Brackets[0].ItemColor.Color;
    if MessageDlg('Change all Color to ' + ColorToString(C),
                  mtConfirmation, mbOkCancel, 0) = mrOk then
      EditorProp1.View.Brackets.SameColor(C);
  end;
end;

procedure TFormViewEditor.Button14Click(Sender: TObject);
var
  S: String;
  I: TFontStyle;
  Style: TFontStyles;
begin
  if EditorProp1.View.Brackets.Count > 0 then
  begin
    Style := EditorProp1.View.Brackets[0].ItemColor.Style;
    S := '';
    for I := Low(TFontStyle) to High(TFontStyle) do
      if I in Style then
      begin
        if (S <> '') and (I <> fsBold) then
          S := S + ', ';
        case I of
          fsBold     : S := S + 'fsBold';
          fsItalic   : S := S + 'fsItalic';
          fsUnderline: S := S + 'fsUnderline';
          fsStrikeOut: S := S + 'fsStrikeOut';
        end;
      end;
    if MessageDlg('Change all Style to [ ' + S + ' ]',
                  mtConfirmation, mbOkCancel, 0) = mrOk then
      EditorProp1.View.Brackets.SameStyle(Style);
  end;
end;


procedure TFormViewEditor.Button9Click(Sender: TObject);
begin
  if MessageDlg('Change all BkColor to ' + ColorToString(EditorProp1.Color),
                mtConfirmation, mbOkCancel, 0) = mrOk then
    EditorProp1.View.Colors.SameBkColor(EditorProp1.Color);
end;

procedure TFormViewEditor.Button10Click(Sender: TObject);
begin
  if MessageDlg('Change all Color to ' + ColorToString(EditorProp1.Font.Color),
                mtConfirmation, mbOkCancel, 0) = mrOk then
    EditorProp1.View.Colors.SameColor(EditorProp1.Font.Color);
end;

procedure TFormViewEditor.Button11Click(Sender: TObject);
var
  S: String;
  I: TFontStyle;
begin
  S := '';
  for I := Low(TFontStyle) to High(TFontStyle) do
    if I in EditorProp1.Font.Style then
    begin
      if (S <> '') and (I <> fsBold) then
        S := S + ', ';
      case I of
        fsBold     : S := S + 'fsBold';
        fsItalic   : S := S + 'fsItalic';
        fsUnderline: S := S + 'fsUnderline';
        fsStrikeOut: S := S + 'fsStrikeOut';
      end;
    end;
  if MessageDlg('Change all Style to [ ' + S + ' ]',
                mtConfirmation, mbOkCancel, 0) = mrOk then
    EditorProp1.View.Colors.SameStyle(EditorProp1.Font.Style);
end;

procedure TFormViewEditor.Button7Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Editor4.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TFormViewEditor.Button8Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
    Editor4.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TFormViewEditor.PopupMenu1Popup(Sender: TObject);
begin
  Undo1.Enabled := Editor4.CanUndo;
  Redo1.Enabled := Editor4.CanRedo;
  Cut1.Enabled := Editor4.Selected;
  Copy1.Enabled := Editor4.Selected;
  Paste1.Enabled := Clipboard.HasFormat(CF_TEXT);
end;

procedure TFormViewEditor.Undo1Click(Sender: TObject);
begin
  Editor4.Undo;
end;

procedure TFormViewEditor.Redo1Click(Sender: TObject);
begin
  Editor4.Redo;
end;

procedure TFormViewEditor.Cut1Click(Sender: TObject);
begin
  Editor4.CutToClipboard;
end;

procedure TFormViewEditor.Copy1Click(Sender: TObject);
begin
  Editor4.CopyToClipboard;
end;

procedure TFormViewEditor.Paste1Click(Sender: TObject);
begin
  Editor4.PasteFromClipboard;
end;

procedure TFormViewEditor.DeleteRow1Click(Sender: TObject);
begin
  Editor4.DeleteRow(Editor4.Row);
end;

procedure TFormViewEditor.SpeedButton1Click(Sender: TObject);
begin
  Edit7.Text := '、。，．・？！゛゜ヽヾゝゞ々ー）］｝」』!),.:;?]}｡｣､･ｰﾞﾟ';
end;

procedure TFormViewEditor.SpeedButton2Click(Sender: TObject);
begin
  Edit8.Text := '（［｛「『([{｢';
end;

procedure TFormViewEditor.SpeedButton3Click(Sender: TObject);
begin
  Edit9.Text := '、。，．,.｡､';
end;

procedure TFormViewEditor.CheckBox20Click(Sender: TObject);
begin
  EditorProp1.WordWrap := CheckBox20.Checked;
end;

procedure TFormViewEditor.CheckBox21Click(Sender: TObject);
begin
  EditorProp1.WrapOption.FollowPunctuation := CheckBox21.Checked;
end;

procedure TFormViewEditor.CheckBox22Click(Sender: TObject);
begin
  EditorProp1.WrapOption.FollowRetMark := CheckBox22.Checked;
end;

procedure TFormViewEditor.CheckBox23Click(Sender: TObject);
begin
  EditorProp1.WrapOption.Leading := CheckBox23.Checked;
end;

procedure TFormViewEditor.CheckBox24Click(Sender: TObject);
begin
  EditorProp1.WrapOption.WordBreak := CheckBox24.Checked;
end;

procedure TFormViewEditor.Edit7Change(Sender: TObject);
begin
  EditorProp1.WrapOption.FollowStr := Edit7.Text;
end;

procedure TFormViewEditor.Edit8Change(Sender: TObject);
begin
  EditorProp1.WrapOption.LeadStr := Edit8.Text;
end;

procedure TFormViewEditor.Edit9Change(Sender: TObject);
begin
  EditorProp1.WrapOption.PunctuationStr := Edit9.Text;
end;

procedure TFormViewEditor.SpinEdit6Change(Sender: TObject);
var
  I: Integer;
begin
  I := Max(SpinEdit6.MinValue, Min(SpinEdit6.MaxValue, StrToIntDef(SpinEdit6.Text, 20)));
  EditorProp1.WrapOption.WrapByte := I;
end;

procedure TFormViewEditor.RadioGroup2Click(Sender: TObject);
begin
  EditorProp1.ScrollBars := TScrollStyle(RadioGroup2.ItemIndex);
end;

procedure TFormViewEditor.Button6Click(Sender: TObject);
begin
  WinHelp(Handle, PChar('HEdit.hlp'), HELP_FINDER, 0);
end;

procedure TFormViewEditor.Button4Click(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to EditorProp1.View.Brackets.Count - 1 do
    if (EditorProp1.View.Brackets[I].LeftBracket = '') or
       (EditorProp1.View.Brackets[I].RightBracket = '') or
       (EditorProp1.View.Brackets[I].LeftBracket = EditorProp1.View.Brackets[I].RightBracket) then
    begin
      ModalResult := mrNone;
      PageControl1.ActivePage := TabSheet3;
      ListBox4.ItemIndex := I;
      ListBox4Click(Self);
      Edit5.SetFocus;
      raise Exception.Create('空白 ・ 同一の LeftBracket, RightBracket は指定出来ません。');
    end;
  // assign ReserveWordList
  EditorProp1.ReserveWordList.Assign(Editor4.Lines);
  // update FEditorProp
  FEditorProp.Assign(EditorProp1);
end;

procedure TFormViewEditor.WMHelp(var Message: TMessage);
var
  Control: TWinControl;
  ContextID: Integer;
  Buf: array[0..1] of Longint;
begin
  if TWMHelp(Message).HelpInfo.iContextType = HELPINFO_WINDOW then
  with PHelpInfo(Message.LParam)^ do
  begin
    Control := FindControl(hItemHandle);
    if (Control <> nil) and (Control.HelpContext <> 0) then
    begin
      ContextID := Control.HelpContext;
      Buf[0] := hItemHandle;
      Buf[1] := ContextID;
      { HELP_CONTEXTMENU or HELP_WM_HELP needs cotrol handle }
      WinHelp(hItemHandle, PChar('HEdit.hlp'), HELP_WM_HELP, Integer(@Buf[0]));
    end;
  end;
end;

end.
