pragma circom 2.1.0;
spec_tags {binary} in{
	0 <= in && in <= 1
} 

spec_tags {maxbit} in{
	0 <= in && in <= 2**in.maxbit-1
} 

spec_tags {max} in{
	0 <= in && in <= in.max
}

spec_tags {max_abs} in{
     0 <= in + in.max_abs && in <= in.max_abs
}


spec_tags {maxbit_abs} in{
     0 <= in +  2**in.maxbit_abs && in <= 2 ** in.maxbit_abs
}


spec_tags {is_zero} in{
	in == 0
}


spec_tags {is_one} in{
	in == 1
}



spec_tags {min} in{
	in.min <= in 
}


spec_tags {is_positive} in{
	0 <= in && in <= 10944121435919637611123202872628637544274182200208017171849102093287904247808
}

spec_tags {is_negative} in{
	10944121435919637611123202872628637544274182200208017171849102093287904247809 <= in && in <= 21888242871839275222246405745257275088548364400416034343698204186575808495616
}
