
pass == 1 {
    w=$2;
    gsub(/=/,"_",w);
    gsub(/ /,"",w);
    tab[w]=$1
}

pass==2 {
    tgt=$1; # tolower($1) 
    n=split($2,as,/\//);
    ans="";
    
    for (x in as)
	if(tab[as[x]]>1)
	    if (ans == "")
		ans = as[x]
	    else
		ans = ans "/" as[x]
		
    if(tab[tgt]>1 && ans != "")
	print tgt,ans
}
