print$_=grep{@a=sort{$a<=>$b}split;$a[0]+$a[1]>$a[2]}<>;
