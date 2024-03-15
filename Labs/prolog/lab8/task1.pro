% --------
% book( Title, Authors, Publisher, Year, CallNumber )
% --------
book(
'The craft of Prolog',
'R. A. O''Keefe',
'MIT Press',
1990,
'QA 76.73 .P76 O38 1990'
).

book(
'Programming in Prolog',
'W. F. Clocksin, C. S. Mellish',
'Springer',
2003,
'QA 76.73 .P76 C57 2003'
).

book(
'Prolog for programmers',
'F. Kluzniak, S. Szpakowicz',
'Academic Press',
1985,
'QA 76.73 .P76 K58 1985'
).

book(
'Prolog programming for artificial intelligence',
'I. Bratko',
'Addison-Wesley',
2001,
'Q 336 .B74 2001'
).

% --------
% reader( CardNumber, Name )
% --------
reader( 1234567, 'James Brown' ).
reader( 2345678, 'Jacques Brun' ).
reader( 3456789, 'Giacomo Bruno' ).

% --------
% checkedOut( CardNumber, CallNumber )
% --------
checkedOut( 1234567, 'QA 76.73 .P76 C57 2003' ).
checkedOut( 2345678, 'QA 76.73 .P76 C57 2003').
checkedOut( 3456789, 'Q 336 .B74 2001' ).
checkedOut( 2345678, 'QA 76.73 .P76 K58 1985').

% findall(Title, book(Title, _, 'MIT Press',_, _), PublishedByMIT).

% findall(Title, (book(Title, _, _, Year, _), Year > 2000), PublishedAfter2000). 

% findall(Title, (reader(CardNumber, 'Jacques Brun'), checkedOut(CardNumber, CallNumber), book(Title, _, _, _, CallNumber)), Results).

