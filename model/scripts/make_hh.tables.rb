def cens( a )
a.each{
        |s|
        ss = censor( s )
        puts "<column name='ss' description='#{s}' default='0' type='REAL' adaTypeName='Amount' />
}
end



['1 person ',
'2 person (No children) ',
'2 person (1 adult, 1 child) ',
'3 person (No children) ',
'3 person (2 adults, 1 child) ',
'3 person (1 adult, 2 children) ',
'4 person (No children) ',
'4 person (2+ adults, 1+ children) ',
'4 person (1 adult, 3 children) ',
'5+ person (No children) ',
'5+ person (2+ adults, 1+ children) ',
'5+ person (1 adult, 4+ children) '].each{
        |s|
        outs << censor( s )

}

