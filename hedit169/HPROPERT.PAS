
{********************************************************************}
{                                                                    }
{    Property Editor & Component Editor for TEditor & TEditorProp    }
{                                                                    }
{    start  1999/10/04                                               }
{                                                                    }
{    update 2000/04/01                                               }
{                                                                    }
{    Copyright (c) 1999, 2000 本田勝彦 <katsuhiko.honda@nifty.ne.jp> }
{                                                                    }
{********************************************************************}

unit HPropert;

interface

uses
  Classes, DsgnIntf;

type
  TEditorClassPropertyEditor = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
  end;

  TEditorBracketsPropertyEditor = class(TEditorClassPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  TEditorCaretPropertyEditor = class(TEditorClassPropertyEditor)
  public
    procedure Edit; override;
  end;

  TEditorCursorsPropertyEditor = class(TCursorProperty)
  public
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  TEditorColorsPropertyEditor = class(TEditorClassPropertyEditor)
  public
    procedure Edit; override;
  end;

  TEditorMarginPropertyEditor = class(TEditorClassPropertyEditor)
  public
    procedure Edit; override;
  end;

  TEditorMarksPropertyEditor = class(TEditorClassPropertyEditor)
  public
    procedure Edit; override;
  end;

  TEditorViewPropertyEditor = class(TEditorClassPropertyEditor)
  public
    procedure Edit; override;
  end;

  TEditorWrapOptionPropertyEditor = class(TEditorClassPropertyEditor)
  public
    procedure Edit; override;
  end;

  TEditorComponentEditor = class(TComponentEditor)
  public
    procedure Edit; override;
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): String; override;
    function GetVerbCount: Integer; override;
  end;

  TEditorPropComponentEditor = class(TEditorComponentEditor)
  public
    procedure Edit; override;
  end;

  TStringsPropertyEditor = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

implementation

uses
  SysUtils, Controls, Forms, HEditor, HEdtProp, HViewEdt, HStrProp;

{ PropertyEditors }

type
  TPropEditorViewInfo = class(TEditorViewInfo);

{ TEditorClassPropertyEditor }

function TEditorClassPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paReadOnly];
end;


{ TEditorBracketsPropertyEditor }

procedure TEditorBracketsPropertyEditor.Edit;
var
  Parent, Component: TPersistent;
begin
  Parent := GetComponent(0);
  if Parent is TEditorViewInfo then
  begin
    Component := TPropEditorViewInfo(Parent).FComponent;
    if (Component is TEditorProp) and
       EditEditorProp(TEditorProp(Component),
                      TEditorViewInfo(Parent).Brackets) then
      Designer.Modified
    else
      if (Component is TEditor) and
         EditEditor(TEditor(Component),
                    TEditorViewInfo(Parent).Brackets) then
        Designer.Modified;
  end;
end;

function TEditorBracketsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;


{ TEditorCaretPropertyEditor }

procedure TEditorCaretPropertyEditor.Edit;
var
  Component: TPersistent;
begin
  Component := GetComponent(0);
  if (Component is TEditor) and
     EditEditor(TEditor(Component), TEditor(Component).Caret) then
    Designer.Modified
  else
    if (Component is TEditorProp) and
       EditEditorProp(TEditorProp(Component),
                      TEditorProp(Component).Caret) then
      Designer.Modified;
end;


{ TEditorCursorsProperty }

function TEditorCursorsPropertyEditor.GetValue: string;
begin
  Result := HCursorToString(TCursor(GetOrdValue));
end;

procedure TEditorCursorsPropertyEditor.GetValues(Proc: TGetStrProc);
begin
  HGetCursorValues(Proc);
end;

procedure TEditorCursorsPropertyEditor.SetValue(const Value: string);
begin
  if AnsiCompareText(RightArrowCursorIdent, Value) = 0 then
    SetOrdValue(crRightArrow)
  else
    if AnsiCompareText(DragSelCopyCursorIdent, Value) = 0 then
      SetOrdValue(crDragSelCopy)
    else
      inherited SetValue(Value);
end;


{ TEditorColorsPropertyEditor }

procedure TEditorColorsPropertyEditor.Edit;
var
  Parent, Component: TPersistent;
begin
  Parent := GetComponent(0);
  if Parent is TEditorViewInfo then
  begin
    Component := TPropEditorViewInfo(Parent).FComponent;
    if (Component is TEditorProp) and
       EditEditorProp(TEditorProp(Component),
                      TEditorViewInfo(Parent).Colors) then
      Designer.Modified
    else
      if (Component is TEditor) and
         EditEditor(TEditor(Component),
                    TEditorViewInfo(Parent).Colors) then
        Designer.Modified;
  end;
end;


{ TEditorMarginPropertyEditor }

procedure TEditorMarginPropertyEditor.Edit;
var
  Component: TPersistent;
begin
  Component := GetComponent(0);
  if (Component is TEditor) and
     EditEditor(TEditor(Component), TEditor(Component).Margin) then
    Designer.Modified
  else
    if (Component is TEditorProp) and
       EditEditorProp(TEditorProp(Component),
                      TEditorProp(Component).Margin) then
      Designer.Modified;
end;


{ TEditorMarksPropertyEditor }

procedure TEditorMarksPropertyEditor.Edit;
var
  Component: TPersistent;
begin
  Component := GetComponent(0);
  if (Component is TEditor) and
     EditEditor(TEditor(Component), TEditor(Component).Marks) then
    Designer.Modified
  else
    if (Component is TEditorProp) and
       EditEditorProp(TEditorProp(Component),
                      TEditorProp(Component).Marks) then
      Designer.Modified;
end;


{ TEditorViewPropertyEditor }

procedure TEditorViewPropertyEditor.Edit;
var
  Component: TPersistent;
begin
  Component := GetComponent(0);
  if (Component is TEditor) and
     EditEditor(TEditor(Component), TEditor(Component).View) then
    Designer.Modified
  else
    if (Component is TEditorProp) and
       EditEditorProp(TEditorProp(Component),
                      TEditorProp(Component).View) then
      Designer.Modified;
end;


{ TEditorWrapOptionPropertyEditor }

procedure TEditorWrapOptionPropertyEditor.Edit;
var
  Component: TPersistent;
begin
  Component := GetComponent(0);
  if (Component is TEditor) and
     EditEditor(TEditor(Component), TEditor(Component).WrapOption) then
    Designer.Modified
  else
    if (Component is TEditorProp) and
       EditEditorProp(TEditorProp(Component),
                      TEditorProp(Component).WrapOption) then
      Designer.Modified;
end;


{ TEditorComponentEditor }

procedure TEditorComponentEditor.Edit;
begin
  if EditEditor(TEditor(Component), TEditor(Component).Caret) then
    Designer.Modified;
end;

function TEditorComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

function TEditorComponentEditor.GetVerb(Index: Integer): String;
begin
  Result := Component.Name + ' の編集(&H)';
end;

procedure TEditorComponentEditor.ExecuteVerb(Index: Integer);
begin
  Edit;
end;


{ TEditorPropComponentEditor }

procedure TEditorPropComponentEditor.Edit;
begin
  if EditEditorProp(TEditorProp(Component), nil) then
    Designer.Modified;
end;


{  TStringsPropertyEditor  }

procedure TStringsPropertyEditor.Edit;
var
  Form: TFormStringsEditor;
  Editor: TEditor;
begin
  Form:= TFormStringsEditor.Create(Application);
  try
    if GetComponent(0) is TComponent then
      Form.FFileList.Add(
        TComponent(GetComponent(0)).Owner.Name + '.' +
        TComponent(GetComponent(0)).Name + '.' +
        GetName);
    (*
       TEditor の場合は、Caret, Color, Font, Margin, Marks,
       ReserveWordList, ScrollBars, View, WrapOption, WordWrap
       プロパティを EditorProp1 経由で受け継ぐ
    *)
    if GetComponent(0) is TEditor then
    begin
      Editor := GetComponent(0) as TEditor;
      Form.EditorProp1.Assign(Editor);
      Form.EditorProp1.AssignTo(Form.Editor1);
    end;

    // TStrings データを受け取る
    Form.Editor1.Lines.Assign(TStrings(GetOrdValue));

    if Form.ShowModal = mrOK then
    begin
      SetOrdValue(Longint(TStrings(Form.Editor1.Lines)));
      Modified;
    end;
  finally
    Form.Free;
  end;
end;

function TStringsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result:= [paDialog, paReadOnly];
end;

end.
