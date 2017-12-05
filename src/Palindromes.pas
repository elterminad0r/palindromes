program Palindromes;

function _is_palindrome(s: string; lower, upper: integer): boolean;
begin
    if lower >= upper then
        _is_palindrome := True
    else if s[lower] = s[upper] then
        _is_palindrome := _is_palindrome(s, lower + 1, upper - 1)
    else
        _is_palindrome := False;
end;

function is_palindrome(s: string): boolean;
begin
    is_palindrome := _is_palindrome(s, 1, length(s));
end;

function _clean(s: string; i: integer): string;
begin
    if i > length(s) then
        _clean := ''
    else if s[i] in ['A'..'Z', 'a'..'z'] then
        _clean := s[i] + _clean(s, i + 1)
    else
        _clean := _clean(s, i + 1);
end;

function clean(s: string): string;
begin
    clean := _clean(s, 1);
end;

function nrclean(s: string): string;
var
    i: char;
begin
    nrclean := '';
    for i in s do
        if i in ['A'..'Z','a'..'z'] then
            nrclean := nrclean + LowerCase(i);
end;

function nr_ispal(s: string): boolean;
var
    lower, upper: integer;
begin
    lower := 1;
    upper := length(s);
    while upper > lower do
        if s[lower] <> s[upper] then
            exit(False)
        else begin
            lower := lower + 1;
            upper := upper - 1;
        end;
    nr_ispal := True
end;

procedure menu;
var
    s: string;
begin
    write('Enter the word > '); readln(s);
    writeln('Palindrome?: ', is_palindrome(clean(s)),
                        ' ', nr_ispal(nrclean(s)));
end;

begin
    while true do menu;
end.
