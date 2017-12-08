program revpals;

uses
    SysUtils;

function _clean(s: string; i: integer): string;
begin
    if i > length(s) then
        _clean := ''
    else if s[i] in ['A'..'Z', 'a'..'z'] then
        _clean := LowerCase(s[i]) + _clean(s, i + 1)
    else
        _clean := _clean(s, i + 1);
end;

function clean(s: string): string;
begin
    clean := _clean(s, 1);
end;

function _reverse(s: string; i: integer): string;
begin
    if i > length(s) then
        _reverse := ''
    else if s[i] in ['A'..'Z','a'..'z'] then
        _reverse := _reverse(s, i + 1) + LowerCase(s[i])
    else
        _reverse := _reverse(s, i + 1);
end;

function reverse(s: string): string;
begin
    reverse := _reverse(s, 1);
end;

function is_pal(s: string): boolean;
begin
    is_pal := reverse(s) = clean(s);
end;

var
    i: integer;
begin
    for i := 1 to ParamCount do
        writeln(ParamStr(i), ' ', is_pal(ParamStr(i)));
end.
