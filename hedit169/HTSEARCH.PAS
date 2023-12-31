{******************************************************************}
{                                                                  }
{  function SearchText                                             }
{                                                                  }
{  Start  : 1997/07/05                                             }
{  UpDate : 1999/07/25                                             }
{                                                                  }
{  Copyright  (C)  本田勝彦  <vyr01647@niftyserve.or.jp>           }
{                                                                  }
{  Delphi 1.0 CD-ROM Delphi\Demos\TextDemo\Search.Pas　を利用      }
{  TextLine: PChar と Start, Length を渡して、                     }
{  見つかった場合は先頭からのバイト数を Start に入れて             }
{  True を返す                                                     }
{                                                                  }
{******************************************************************}

unit HTSearch;

interface

uses Windows, SysUtils, StdCtrls, Dialogs;

const
  WordDelimiters: set of Char = [#$0..#$FF] -
    ['a'..'z','A'..'Z','1'..'9','0',#$81..#$9F,#$E0..#$FC, #$A6..#$DF];

type
  TSearchOption = (sfrDown, sfrMatchCase, sfrWholeWord,
    sfrNoMatchZenkaku, sfrReplace, sfrReplaceAll, sfrReplaceConfirm,
    sfrIncludeCRLF, sfrIncludeSpace, sfrWholeFile);
  TSearchOptions = set of TSearchOption;
  TSearchInfo = record
    Start, Length: Integer;
  end;

function SearchText( TextLine: PChar;
                     var Info: TSearchInfo;
                     const SearchString: String;
                     Options: TSearchOptions): Boolean;

implementation

type
  TCharMap = array[Char] of Char;

var
  UpperCharMap, LargeAlphaCharMap: TCharMap;
  Ch: Char;

const
  DBCSCharArray: array[Char] of String[2] =
  (#$00, #$01, #$02, #$03, #$04, #$05, #$06, #$07,  // 00
   #$08, #$09, #$0A, #$0B, #$0C, #$0D, #$0E, #$0F,  // 08
   #$10, #$11, #$12, #$13, #$14, #$15, #$16, #$17,  // 10
   #$18, #$19, #$1A, #$1B, #$1C, #$1D, #$1E, #$1F,  // 18
   '　', '！', '”', '＃', '＄', '％', '＆', '’',  // 20
   '（', '）', '＊', '＋', '，', '−', '．', '／',  // 28
   '０', '１', '２', '３', '４', '５', '６', '７',  // 30
   '８', '９', '：', '；', '＜', '＝', '＞', '？',  // 38
   '＠', 'Ａ', 'Ｂ', 'Ｃ', 'Ｄ', 'Ｅ', 'Ｆ', 'Ｇ',  // 40
   'Ｈ', 'Ｉ', 'Ｊ', 'Ｋ', 'Ｌ', 'Ｍ', 'Ｎ', 'Ｏ',  // 48
   'Ｐ', 'Ｑ', 'Ｒ', 'Ｓ', 'Ｔ', 'Ｕ', 'Ｖ', 'Ｗ',  // 50
   'Ｘ', 'Ｙ', 'Ｚ', '［', '￥', '］', '＾', '＿',  // 58
   '｀', 'ａ', 'ｂ', 'ｃ', 'ｄ', 'ｅ', 'ｆ', 'ｇ',  // 60
   'ｈ', 'ｉ', 'ｊ', 'ｋ', 'ｌ', 'ｍ', 'ｎ', 'ｏ',  // 68
   'ｐ', 'ｑ', 'ｒ', 'ｓ', 'ｔ', 'ｕ', 'ｖ', 'ｗ',  // 70
   'ｘ', 'ｙ', 'ｚ', '｛', '｜', '｝', '￣', #$7F,  // 78
   #$80, #$81, #$82, #$83, #$84, #$85, #$86, #$87,  // 80
   #$88, #$89, #$8A, #$8B, #$8C, #$8D, #$8E, #$8F,  // 88
   #$90, #$91, #$92, #$93, #$94, #$95, #$96, #$97,  // 90
   #$98, #$99, #$9A, #$9B, #$9C, #$9D, #$9E, #$9F,  // 98
   #$A0, '。', '「', '」', '、', '．', 'ヲ', 'ァ',  // A0
   'ィ', 'ゥ', 'ェ', 'ォ', 'ャ', 'ュ', 'ョ', 'ッ',  // A8
   'ー', 'ア', 'イ', 'ウ', 'エ', 'オ', 'カ', 'キ',  // B0
   'ク', 'ケ', 'コ', 'サ', 'シ', 'ス', 'セ', 'ソ',  // B8
   'タ', 'チ', 'ツ', 'テ', 'ト', 'ナ', 'ニ', 'ヌ',  // C0
   'ネ', 'ノ', 'ハ', 'ヒ', 'フ', 'ヘ', 'ホ', 'マ',  // C8
   'ミ', 'ム', 'メ', 'モ', 'ヤ', 'ユ', 'ヨ', 'ラ',  // D0
   'リ', 'ル', 'レ', 'ロ', 'ワ', 'ン', '゛', '゜',  // D8
   #$E0, #$E1, #$E2, #$E3, #$E4, #$E5, #$E6, #$E7,  // E0
   #$E8, #$E9, #$EA, #$EB, #$EC, #$ED, #$EE, #$EF,  // E8
   #$F0, #$F1, #$F2, #$F3, #$F4, #$F5, #$F6, #$F7,  // F0
   #$F8, #$F9, #$FA, #$FB, #$FC, #$FD, #$FE, #$FF); // F8

//////////////////////////////////////////////////////////////////////
//
// 以下は、瑠瓏さん(KHB05271)作の HenkanJ.pas をモディファイしたもの
//
// (1)
// end else if s[1] in [#$a6..#$af,#$b1..#$df] then begin
//                                         ↓
// end else if s[1] in [#$a6..#$af,#$b1..#$dd] then begin
//
// とし、'ﾞ'(#$DE), 'ﾟ'(#$DF) を記号として処理することで、゛゜に変換
// されるようにした。
//
// (2)
// よって if Kana[S[1]] = 0 then の処理は削除した。
//
// (3)
// 「ヴ」の処理を追加
//
// (4)
// また、if S[1] in ['0'..'9', 'A'..'Z', 'a'..'z'] then 以下の
// カタカナ以外の文字処理は、上記 DBCSCharArray から取得するようにした。
//

  Kana: array[#$A6..#$DF] of Byte =
  ($72,$21,
   $23,$25,$27,$29,$63,$65,$67,$43,
   $00,$22,$24,$26,$28,$2A,$AB,$AD, // $00 #$B0 ｰ
   $AF,$B1,$B3,$B5,$B7,$B9,$BB,$BD,
   $BF,$C1,$C4,$C6,$C8,$4A,$4B,$4C,
   $4D,$4E,$CF,$D2,$D5,$D8,$DB,$5E,
   $5F,$60,$61,$62,$64,$66,$68,$69,
   $6A,$6B,$6C,$6D,$6F,$73,$00,$00); // $00 #$DE ﾞ  #$DF ﾟ

function JisToSJis(N:WORD):WORD; register; assembler;
asm
    add  ax,0a17eh ; shr  ah,1      ; jb  @1
    cmp  al,0deh   ; sbb  al,5eh
@1: xor  ah,0e0h
end;

function WordToChar(N: Word):String;
begin
  Result := Char(Hi(N)) + Char(Lo(N))
end;

function HankToZen(S: String): String;
var
  W: Word;
begin
  Result := '';
  while Length(S) > 0 do
  begin
    if S[1] in [#$81..#$9F, #$E0..#$FC] then   // 全角文字
    begin
      Result := Result + Copy(S, 1, 2);
      Delete(S, 1, 2);
    end
    else                                       // 半角文字
      if S[1] in [#$A6..#$AF, #$B1..#$DD] then // ｦ..ｯ, ｱ..ﾝ
      begin
        W := $2500 + (Kana[S[1]] and $7F);
        if (Kana[S[1]] and $80) = 0 then       // ﾟﾞ が意味をなさない
        begin
          if (Length(S) > 1) and (S[1] = #$B3) and (S[2] = #$DE) then
          begin
            Result := Result + 'ヴ';           // ｳﾞ の処理
            Delete(S, 1, 2);
          end
          else
          begin
            Result := Result + DBCSCharArray[S[1]];
            Delete(S, 1, 1);
          end;
        end
        else                                    // ﾟﾞ が意味をなす
        begin
          if (Length(S) > 1) and (S[2] in [#$DE, #$DF]) then
          begin
            W := W + 1 + (Ord(S[2]) and 1);
            Delete(S, 2, 1);
          end;
          Result := Result + WordToChar(JisToSJis(W));
          Delete(S, 1, 1)
        end;
      end
      else
      begin                                     // 記号
        Result := Result + DBCSCharArray[S[1]];
        Delete(S, 1, 1);
      end;
  end;
end;

//////////////////////////////////////////////////////////////////////

function SearchBuf(  Buf: PChar;
                     var Info: TSearchInfo;
                     SearchString: String;
                     Options: TSearchOptions): PChar;
var
  SC, BufLen, I, P, C, Extend, L, CharLen: Integer;
  B: Byte;
  Direction: ShortInt;
  Pattern, S: String;
  DBCSPattern, DBCSBuffer, MatchChar, IsDakuten: Boolean;
  AttrBuffer: PChar;

  function FindNextWordStart(var BufPtr: PChar): Boolean;
  begin
    // 一語の先頭を見ているときは移動せずに真を返す
    if (Direction = 1) and not (BufPtr^ in WordDelimiters) and
       ((BufPtr = Buf) or
        ((BufPtr > Buf) and (Buf[BufPtr - Buf - 1] in WordDelimiters))) then
    begin
      Result := True;
      Exit;
    end;

    while (SC > 0) and
          ((Direction = 1) xor (BufPtr^ in WordDelimiters)) do
    begin
      Inc(BufPtr, Direction);
      Dec(SC);
    end;
    while (SC > 0) and
          ((Direction = -1) xor (BufPtr^ in WordDelimiters)) do
    begin
      Inc(BufPtr, Direction);
      Dec(SC);
    end;
    Result := SC >= 0;
    if (Direction = -1) and (BufPtr^ in WordDelimiters) then
    begin   { back up one char, to leave ptr on first non delim }
      Dec(BufPtr, Direction);
      Inc(SC);
    end;
    if AttrBuffer[BufPtr - Buf] = '2' then
    begin
      Inc(BufPtr, Direction);
      Dec(SC);
    end;
  end;

begin
  Result := nil;
  BufLen := StrLen(Buf);
  if (Info.Start < 0) or (Info.Start > BufLen) or (Info.Length < 0) then
    Exit;
  Pattern := SearchString;
  if not (sfrMatchCase in Options) then
    Pattern := AnsiUpperCase(Pattern);
  L := Length(Pattern);
  CharLen := 0;
  if sfrNoMatchZenkaku in Options then
  begin
    Pattern := HankToZen(Pattern);
    L := Length(Pattern);
    I := 1;
    while I <= L do
    begin
      if Pattern[I] in [#$81..#$9F, #$E0..#$FC] then
        Inc(I);
      Inc(I);
      Inc(CharLen);
    end;
  end;

  AttrBuffer := StrAlloc(BufLen + 1);
  try
    I := 0;
    while I < BufLen do
    begin
      if Buf[I] in [#$81..#$9F, #$E0..#$FC] then
      begin
        Move('12', AttrBuffer[I], 2);
        Inc(I);
      end
      else
        AttrBuffer[I] := '0';
      Inc(I);
    end;

    if sfrDown in Options then
    begin
      Direction := 1;
      Inc(Info.Start, Info.Length);
      if (Info.Start < BufLen) and (AttrBuffer[Info.Start] = '2') then
        Inc(Info.Start);
      if sfrNoMatchZenkaku in Options then
        SC := BufLen - Info.Start - CharLen
      else
        SC := BufLen - Info.Start - L;
      if SC < 0 then
        Exit;
      if Info.Start + SC > BufLen then
        Exit;
    end
    else
    begin
      Direction := -1;
      if not (sfrNoMatchZenkaku in Options) then
        Dec(Info.Start, L)
      else
        while CharLen > 0 do
        begin
          Dec(Info.Start);
          // 全角２バイト目か、ｳ, ｶ..ﾄ, ﾊ..ﾎ + ﾞﾟ
          if (Info.Start > 0) and
             ((AttrBuffer[Info.Start] = '2') or
              ((Buf[Info.Start] in [#$DE..#$DF]) and
               (Buf[Info.Start - 1] in [#$B3, #$B6..#$C4, #$CA..#$CE]))) then
            Dec(Info.Start);
          Dec(CharLen);
        end;
      if (Info.Start >= 0) and (AttrBuffer[Info.Start] = '2') then
        Dec(Info.Start);
      SC := Info.Start;
    end;
    if (Info.Start < 0) or (Info.Start > BufLen) then
      Exit;
    Result := PChar(@Buf[Info.Start]);

    //  search
    while SC >= 0 do
    begin
      // SC = 0 の時
      // Direction =  1 ... 最後の一語
      // Direction = -1 ... バッファの先頭
      if (sfrWholeWord in Options) and (SC > 0) then
        if not FindNextWordStart(Result) then Break;

      I := 0; // hit counter
      C := 0; // crlf, space counter
      P := 1; // pointer to Pattern
      while True do
      begin
        DBCSPattern := Pattern[P] in [#$81..#$9F, #$E0..#$FC];
        DBCSBuffer := Result[I + C] in [#$81..#$9F, #$E0..#$FC];
        IsDakuten := False;

        if sfrNoMatchZenkaku in Options then // 全角・半角を区別しない
          if sfrMatchCase in Options then    // 大文字小文字を区別する
            if DBCSBuffer then
              MatchChar := (Pattern[P] = Result[I + C]) and
                           (Pattern[P + 1] = Result[I + C + 1])
            else
            begin                            // 全角に変換して判別
              // ｳ, ｶ..ﾄ, ﾊ..ﾎ + ﾞﾟ
              if (Result[I + C] in [#$B3, #$B6..#$C4, #$CA..#$CE]) and
                 (Result[I + C + 1] in [#$DE..#$DF]) then
              begin
                S := HankToZen(Result[I + C] +
                               Result[I + C + 1]);
                IsDakuten := True;
              end
              else
                S := DBCSCharArray[Result[I + C]];
              MatchChar := (Pattern[P] = S[1]) and
                           (Pattern[P + 1] = S[2]);
            end
          else                               // 大文字小文字を区別しない
            if DBCSBuffer then               // 全角同士の判別
              if (Result[I + C] = #$82) and
                 (Result[I + C + 1] in [#$81..#$9A]) then // ａ..ｚ
                MatchChar :=
                  (Pattern[P] = #$82) and
                  (Pattern[P + 1] = LargeAlphaCharMap[Result[I + C + 1]])
              else
                MatchChar := (Pattern[P] = Result[I + C]) and
                             (Pattern[P + 1] = Result[I + C + 1])
            else
            begin                            // 全角に変換して比較
              // ｳ, ｶ..ﾄ, ﾊ..ﾎ + ﾞﾟ
              if (Result[I + C] in [#$B3, #$B6..#$C4, #$CA..#$CE]) and
                 (Result[I + C + 1] in [#$DE..#$DF]) then
              begin
                S := HankToZen(Result[I + C] +
                               Result[I + C + 1]);
                IsDakuten := True;
              end
              else
                S := DBCSCharArray[Result[I + C]];
              if (S[1] = #$82) and           // 大文字マップで判別
                 (S[2] in [#$81..#$9A]) then // ａ..ｚ
                MatchChar := (Pattern[P] = #$82) and
                             (Pattern[P + 1] = LargeAlphaCharMap[S[2]])
              else
                MatchChar := (Pattern[P] = S[1]) and
                             (Pattern[P + 1] = S[2]);
            end
        else                                 // 全角・半角を区別する
          if sfrMatchCase in Options then    // 大文字小文字を区別する
            if DBCSBuffer then
              MatchChar := DBCSPattern and
                           (Pattern[P] = Result[I + C]) and
                           (Pattern[P + 1] = Result[I + C + 1])
            else
              MatchChar := Pattern[P] = Result[I + C]
          else                               // 大文字小文字を区別しない
            if DBCSBuffer then
              if (Result[I + C] = #$82) and
                 (Result[I + C + 1] in [#$81..#$9A]) then // ａ..ｚ
                MatchChar :=
                  (Pattern[P] = #$82) and
                  (Pattern[P + 1] = LargeAlphaCharMap[Result[I + C + 1]])
              else
                MatchChar := (Pattern[P] = Result[I + C]) and
                             (Pattern[P + 1] = Result[I + C + 1])
            else
              MatchChar := Pattern[P] = UpperCharMap[Result[I + C]];
        if not MatchChar then
        begin
          Extend := 0;
          if I > 0 then
            if (sfrIncludeCRLF in Options) and
               (Result[I + C] in [#$0D, #$0A]) then
              Extend := 1
            else
              if (sfrIncludeSpace in Options) and
                 (Result[I + C] in [#$20, #$09]) then
                Extend := 1
              else
                if (sfrIncludeSpace in Options) and
                   (Result[I + C] = #$81) and
                   (Result[I + C + 1] = #$40) then
                  Extend := 2;
          if Extend > 0 then
          begin
            Inc(C, Extend);
            Continue;
          end
          else
            Break;
        end
        else
        begin
          Inc(I, Byte(DBCSBuffer or IsDakuten) + 1);
          Inc(P, Byte(DBCSPattern) + 1);
          if P > L then
            if (not (sfrWholeWord in Options)) or
               (SC = 0) or
               (Result[I + C] in WordDelimiters) then
            begin
              Info.Length := I + C;
              Exit;
            end
            else
              Break;
        end;
      end;
      Inc(Result, Direction);
      Dec(SC);
      if AttrBuffer[Result - Buf] = '2' then
      begin
        Inc(Result, Direction);
        Dec(SC);
      end;
    end;
    Result := nil;
  finally
    StrDispose(AttrBuffer);
  end;
end;

function SearchText( TextLine: PChar;
                     var Info: TSearchInfo;
                     const SearchString: String;
                     Options: TSearchOptions): Boolean;
var
  P: PChar;
begin
  Result := False;
  if (Length(SearchString) = 0) or (StrLen(TextLine) = 0) then
    Exit;
  P := SearchBuf(TextLine, Info, SearchString, Options);
  if P <> nil then
  begin
    //  Info.Length は SearchBuf 内でセットされる
    Info.Start := P - TextLine;
    Result := True;
  end;
end;

initialization
  for Ch := Low(UpperCharMap) to High(UpperCharMap) do
  begin
    UpperCharMap[Ch] := Ch;
    LargeAlphaCharMap[Ch] := Ch;
  end;
  // 大文字テーブル
  CharUpperBuff(PChar(@UpperCharMap), SizeOf(UpperCharMap));
  // ａ..ｚの２バイト目をＡ..Ｚの２バイト目にすり替え
  for Ch := #$81 to #$9A do
    LargeAlphaCharMap[Ch] := Char(Ord(Ch) - $21);

end.

