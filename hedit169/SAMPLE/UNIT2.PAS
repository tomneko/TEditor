unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  HEditor, ComCtrls;

type
  TForm2 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Editor1: TEditor;
    TabSheet2: TTabSheet;
    Editor2: TEditor;
    TabSheet3: TTabSheet;
    Editor3: TEditor;
    TabSheet4: TTabSheet;
    Editor4: TEditor;
    TabSheet5: TTabSheet;
    Editor5: TEditor;
    TabSheet6: TTabSheet;
    Editor6: TEditor;
    procedure Editor1DrawLine(Sender: TObject; LineStr: string; X, Y,
      Index: Integer; ARect: TRect; Selected: Boolean);
    procedure Editor2DrawLine(Sender: TObject; LineStr: string; X, Y,
      Index: Integer; ARect: TRect; Selected: Boolean);
    procedure Editor2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Editor2Click(Sender: TObject);
    procedure Editor3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Editor3DblClick(Sender: TObject);
    procedure Editor4DrawLine(Sender: TObject; LineStr: string; X, Y,
      Index: Integer; ARect: TRect; Selected: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Editor6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Editor6DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure Editor6DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Editor6EndDrag(Sender, Target: TObject; X, Y: Integer);
  private
    FHintWindow: THintWindow;
    procedure ShowHintWindow(S: String);
    procedure HideHintWindow;
    procedure DrawDBSpaceMark(Editor: TEditor; R: TRect;
      X, Y: Integer; Selected: Boolean);
    procedure DrawTabMark(Editor: TEditor; R: TRect;
      X, Y: Integer; Selected: Boolean);
  public
    FFileList: TStringList;
  end;

implementation

uses
  ShellApi;

{$R *.DFM}

procedure TForm2.FormCreate(Sender: TObject);
begin
  FFileList := TStringList.Create;
  FFileList.Add('TEditor Demo  Drawing');
  FFileList.Add('TEditor Demo  WordWrap');
  FFileList.Add('TEditor Demo  HTML');
  FFileList.Add('TEditor Demo  BoxSelection');
  FFileList.Add('TEditor Demo  Split');
  FFileList.Add('TEditor Demo  Selection Drag and Drop');
  FHintWindow := THintWindow.Create(Self);
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  FFileList.Free;
end;

procedure TForm2.ShowHintWindow(S: String);
var
  CursorHeight: Integer;
  Rect: TRect;
  Pos: TPoint;
begin
  if not FHintWindow.HandleAllocated then
    FHintWindow.HandleNeeded;
  CursorHeight := GetSystemMetrics(SM_CYCAPTION);
  GetCursorPos(Pos);
  Rect := Bounds(0, 0, Screen.Width, 0);
  DrawText(FHintWindow.Canvas.Handle, PChar(S),
    -1, Rect, DT_CALCRECT or DT_LEFT or DT_WORDBREAK or DT_NOPREFIX);
  OffsetRect(Rect, Pos.X, Pos.Y + CursorHeight);
  Inc(Rect.Right, 6);
  Inc(Rect.Bottom, 2);
  FHintWindow.ActivateHint(Rect, S);
end;

procedure TForm2.HideHintWindow;
begin
  if FHintWindow.HandleAllocated then
    FHintWindow.ReleaseHandle;
end;

procedure TForm2.DrawTabMark(Editor: TEditor; R: TRect;
  X, Y: Integer; Selected: Boolean);
var
  W, Xm, Ym: Integer;
begin
  // ���t�g�}�[�W����荶�ɂ͕`�悵�Ȃ�
  if X < R.Left then
    Exit;
  if Editor <> nil then
  begin
    X := X + 2;
    Y := Y + (Editor.RowHeight - Editor.Margin.Line) div 2;
    if Editor.ColWidth > 13 then
    begin
      W := 2;
      Ym := 5;
      Xm := 5;
    end
    else
    begin
      W := 1;
      Ym := 1;
      Xm := 3;
    end;
    with Editor.Canvas do
    begin
      if Selected then
        Pen.Color := Editor.View.Colors.Select.Color
      else
        Pen.Color := clGray;
      Pen.Width := W;
      MoveTo(X, Y - Ym);
      LineTo(X + Xm, Y);
      MoveTo(X, Y + Ym);
      LineTo(X + Xm, Y);
    end;
  end;
end;

procedure TForm2.DrawDBSpaceMark(Editor: TEditor; R: TRect;
  X, Y: Integer; Selected: Boolean);
var
  C: Integer;
begin
  if Editor <> nil then
  begin
    X := X + 2;
    Y := Y + 2;
    C := Editor.ColWidth - Editor.Margin.Character;
    // ���t�g�}�[�W����荶�ɂ͕`�悵�Ȃ�
    if X + C * 2 - 4 < R.Left then
      Exit;
    with Editor.Canvas do
    begin
      if Selected then
        Pen.Color := Editor.View.Colors.Select.Color
      else
        Pen.Color := clGray;
      Pen.Width := 1;
      Pen.Style := psSolid;
      Brush.Style := bsClear;
//      Rectangle(X, Y, X + C * 2 - 4, Y + C * 2 - 4);
      MoveTo(Max(R.Left, X), Y + C * 2 - 4);
      LineTo(X + C * 2 - 4, Y + C * 2 - 4);
      LineTo(X + C * 2 - 4, Y);
      LineTo(Max(R.Left - 1, X), Y);
      if X >= R.Left then
        LineTo(X, Y + C * 2 - 4);
    end;
  end;
end;

// �ȉ��̃C�x���g�n���h���́A�����̃C���X�^���X����Q�Ƃ����̂�
// Sender as TEditor �ɑ΂��ď������s���d�l�ɂȂ��Ă���

procedure TForm2.Editor1DrawLine(Sender: TObject; LineStr: string; X, Y,
  Index: Integer; ARect: TRect; Selected: Boolean);
var
  S: String;
  Parser: TEditorParser;
  E, T, C, P, Xp: Integer;
  Editor: TEditor;
begin
  // Editor �̎擾
  if Sender is TEditor then
    Editor := Sender as TEditor
  else
    Exit;
  // LineStr �́A�^�u���X�y�[�X�ɓW�J���ꂽ������Ȃ̂ŁA
  // ListString[Index] ���擾����
  S := Editor.ListString[Index];
  // ���̒��ɁA�^�u���S�p�X�y�[�X������ꍇ��������
  if (Pos(#9, S) > 0) or (Pos(#$81#$40{'�@'}, S) > 0) then
  begin
    E := 0;
    T := Editor.Caret.TabSpaceCount;
    C := Editor.ColWidth;
    Parser := TEditorParser.Create(S);
    try
      while Parser.Token <> toEof do
      begin
        case Parser.Token of
          toTab:
            begin
              P := Parser.SourcePos;
              // ���[�h���b�v���Ă���ꍇ�AX �͑O�̍s�����񒷕�
              // �f�N�������g����Ă���̂Ŏg�p���Ȃ��B
              Xp := Editor.Margin.Left - Editor.LeftScrollWidth +
                    P * C + E;
              // ARect �̒��ł����`�悷��
              if (ARect.Left <= Xp ) and (Xp <= ARect.Right - C) then
                DrawTabMark(Editor, ARect, Xp, Y, Selected);
              // �^�u��W�J�����s�N�Z���l��ێ�����
              Inc(E, (T - ((P + E div C) mod T + 1)) * C);
            end;
          toDBSymbol:
            if Parser.TokenString = #$81#$40 then
            begin
              P := Parser.SourcePos;
              // ���[�h���b�v���Ă���ꍇ�AX �͑O�̍s�����񒷕�
              // �f�N�������g����Ă���̂Ŏg�p���Ȃ��B
              Xp := Editor.Margin.Left - Editor.LeftScrollWidth +
                    P * C + E;
              // ARect �̒��ł����`�悷��
//              if (ARect.Left <= Xp ) and
//                 (Xp <= ARect.Right - C * 2) then
                DrawDBSpaceMark(Editor, ARect, Xp, Y, Selected);
            end;
        end;
        Parser.NextToken;
      end;
    finally
      Parser.Free;
    end;
  end;
end;

procedure TForm2.Editor2DrawLine(Sender: TObject; LineStr: string; X, Y,
  Index: Integer; ARect: TRect; Selected: Boolean);
var
  I, Xp: Integer;
  Parser: TEditorParser;
  Editor: TEditor;
begin
  // Editor �̎擾
  if Sender is TEditor then
    Editor := Sender as TEditor
  else
    Exit;
  Parser := TEditorParser.Create(LineStr);
  try
    while Parser.Token <> toEof do
    begin
      if Parser.TokenString = '��' then
      begin
        Xp := X + Parser.SourcePos * Editor.ColWidth;
        // �e��`��
        if Selected then
          // �I��̈�̔w�i�F
          Editor.Canvas.Brush.Color := Editor.View.Colors.Select.BkColor
        else
          Editor.Canvas.Brush.Color := Editor.Color;
        Editor.Canvas.Font.Style := [fsBold];
        Editor.Canvas.Font.Color := clSilver;
        Editor.Canvas.Brush.Style := bsSolid;
        Editor.DrawTextRect(ARect, Xp + 1, Y + 1, Parser.TokenString, ETO_CLIPPED);
        // ���̂�`��
        if Selected then
          // �I��̈�̕����F
          Editor.Canvas.Font.Color := Editor.View.Colors.Select.Color
        else
          Editor.Canvas.Font.Color := clLime;
        Editor.Canvas.Brush.Style := bsClear;
        Editor.DrawTextRect(ARect, Xp, Y, Parser.TokenString, ETO_CLIPPED);
      end;
      Parser.NextToken;
    end;
  finally
    Parser.Free;
  end;
end;

procedure TForm2.Editor2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  I: Integer;
  S: String;
begin
  if Sender is TEditor then
    with Sender as TEditor do
    begin
      S := WordFromPos(Point(X, Y));
      if ReserveWordList.Find(S, I) then
        Cursor := crDefault
      else
        case CursorState of
          mcClient: Cursor := Caret.Cursors.DefaultCursor;
          mcLeftMargin: Cursor := Caret.Cursors.LeftMarginCursor;
          mcInSel: Cursor := Caret.Cursors.InSelCursor;
          mcDragging: Windows.SetCursor(Screen.Cursors[Caret.Cursors.DragSelCursor]);
          mcDraggingCopy: Windows.SetCursor(Screen.Cursors[Caret.Cursors.DragSelCopyCursor]);
        end;
    end;
end;

procedure TForm2.Editor2Click(Sender: TObject);
var
  Editor: TEditor;
  APos: TPoint;
  S: String;
  I: Integer;
begin
  if Sender is TEditor then
  begin
    Editor := Sender as TEditor;
    with Editor do
    begin
      GetCursorPos(APos);
      S := WordFromPos(Editor.ScreenToClient(APos));
      if ReserveWordList.Find(S, I) then
        case I of
          0: WrapOption.FollowPunctuation := False;
          1: WrapOption.FollowPunctuation := True;
          2: WrapOption.FollowRetMark := False;
          3: WrapOption.FollowRetMark := True;
          4: WrapOption.Leading := False;
          5: WrapOption.Leading := True;
          6: WrapOption.WordBreak := False;
          7: WrapOption.WordBreak := True;
        end;
    end;
  end;
end;

procedure TForm2.Editor3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Sender is TEditor then
    with Sender as TEditor do
      case TokenFromPos(Point(X, Y)) of
        toUrl:
          begin
            Cursor := crDefault;
            ShowHintWindow('�_�u���N���b�N����ƍs���܂��B');
          end;
        toMail:
          begin
            Cursor := crDefault;
            ShowHintWindow('���[�����҂����Ă���܂��B');
          end;
      else
        HideHintWindow;
        case CursorState of
          mcClient: Cursor := Caret.Cursors.DefaultCursor;
          mcLeftMargin: Cursor := Caret.Cursors.LeftMarginCursor;
          mcInSel: Cursor := Caret.Cursors.InSelCursor;
          mcDragging: Windows.SetCursor(Screen.Cursors[Caret.Cursors.DragSelCursor]);
          mcDraggingCopy: Windows.SetCursor(Screen.Cursors[Caret.Cursors.DragSelCopyCursor]);
        end;
      end;
end;

procedure TForm2.Editor3DblClick(Sender: TObject);
var
  S: String;
  C: Char;
  Editor: TEditor;
begin
  if Sender is TEditor then
  begin
    Editor := Sender as TEditor;
    C := Editor.TokenFromCaret;
    if (C = toUrl) or (C = toMail) then
    begin
      HideHintWindow;
      if C = toUrl then
        S := Editor.TokenStringFromCaret
      else
        S := 'mailto:' + Editor.TokenStringFromCaret;
      ShellExecute(Handle, 'OPEN', PChar(S), '', '', SW_SHOW);
    end
    else
      Editor.SelectTokenFromCaret;
  end;
end;

procedure TForm2.Editor4DrawLine(Sender: TObject; LineStr: string; X, Y,
  Index: Integer; ARect: TRect; Selected: Boolean);
var
  Editor: TEditor;
begin
  // Editor �̎擾
  if Sender is TEditor then
    Editor := Sender as TEditor
  else
    Exit;
  if (LineStr = 'abc') or
     (LineStr = 'defg') or
     (LineStr = 'hijk') then
  with Editor.Canvas do
  begin
    Brush.Color := Editor.View.Colors.Select.BkColor;
    Font.Color := Editor.View.Colors.Select.Color;
    Editor.DrawTextRect(ARect, X, Y, LineStr, ETO_OPAQUE or ETO_CLIPPED);
  end;
end;

// Drag & Drop

procedure TForm2.Editor6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  R, C: Integer;
begin
  if (Sender is TEditor) and (Button = mbLeft) then
    with TEditor(Sender) do
    begin
      // X, Y �ʒu�� Row, Col �l���擾�B������ False ��n���̂��~�\�P
      PosToRowCol(X, Y, R, C, False);
      // �h���b�O�\��Ԃł������I��̈���ł���΃h���b�O�J�n
      if CanSelDrag and (Margin.Left <= X) and IsSelectedArea(R, C) then
        TEditor(Sender).BeginDrag(False);
    end;
end;

procedure TForm2.Editor6DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  R, C: Integer;
begin
  if (Sender is TEditor) and (Source is TEditor) then
    with TEditor(Sender) do
    begin
      // ��ɍs�������̓X�N���[������
      if Y <= Margin.Top then
        Row := Row - 1;
      // �h���b�O�I�u�W�F�N�g�ɃL�����b�g��ǐ�������
      // �����ł��AFalse ��n���~�\�P
      PosToRowCol(X, Y, R, C, False);
      SetRowCol(R, C);
      Accept := True;
    end;
end;

// �~�\�P�ɂ��ẮAIsSelectedArea, PosToRowCol �̃w���v���Q�Ƃ��ĉ������B

procedure TForm2.Editor6DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if (Sender is TEditor) and (Source is TEditor) then
    with TEditor(Sender) do
      if Source = Sender then
        // ���g�̃f�[�^���ړ����̓R�s�[
        if GetKeyState(VK_CONTROL) < 0 then
          // ssCtrl �L�[��������Ă���ꍇ�̓R�s�[
          CopySelection(Row, Col)
        else
          // �ړ�
          MoveSelection(Row, Col)
      else
      begin
        // ���l�̃f�[�^�Ȃ̂őI����Ԃ̏ꍇ�͉������Ă���
        // �L�����b�g�ʒu�֑��l�̑I��̈敶�����}������
        CleanSelection;
        SetSelTextBuf(PChar(TEditor(Source).SelText));
      end;
end;

procedure TForm2.Editor6EndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  // BeginDrag(False) ������A�}�E�X�𓮂������ƂȂ��h���b�v
  // �����ꍇ�̂��߂̏���
  if Sender is TEditor then
    TEditor(Sender).CleanSelection;
end;

end.