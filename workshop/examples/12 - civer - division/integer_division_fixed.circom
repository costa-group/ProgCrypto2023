pragma circom 2.1.5;


template Num2Bits(n) {
    signal input in;
    signal output {binary} out[n];
    var lc1=0;

    var e2=1;
    for (var i = 0; i<n; i++) {
        out[i] <-- (in >> i) & 1;
        out[i] * (out[i] -1 ) === 0;
        lc1 += out[i] * e2;
        e2 = e2+e2;
    }
    lc1 === in;
}

template NOT() {
    signal input {binary} in;
    signal output {binary} out;

    out <== 1 + in - 2*in;
    
    spec_postcondition out == !in;
}

template LessThan(n) {
    assert(n <= 252);
    signal input {maxbit} in_0;
    signal input {maxbit} in_1;
    signal output {binary} out;
    
    assert(in_0.maxbit <= n);
    assert(in_1.maxbit <= n);
    
    component n2b = Num2Bits(n+1);
    n2b.in <== in_0 + (1<<n) - in_1;
    out <== 1-n2b.out[n]; 
      
    for (var i = 0; i < n; i++){
        _ <== n2b.out[i];
    }    
    
    spec_postcondition out == (in_0 < in_1);
}

template GreaterThan(n) {
    signal input {maxbit} in_0;
    signal input {maxbit} in_1;
    signal output {binary} out;


    component lt = LessThan(n);

    lt.in_0 <== in_1;
    lt.in_1 <== in_0;
    lt.out ==> out;
    
    spec_postcondition out == (in_0 > in_1);
}

template LessEqThan(n){
    signal input {maxbit} in_0;
    signal input {maxbit} in_1;
    signal output {binary} out;
    assert(in_0.maxbit <= n);
    assert(in_1.maxbit <= n);

    component gt = GreaterThan(n);
    gt.in_0 <== in_0;
    gt.in_1 <== in_1;
    
    component nt = NOT();
    nt.in <== gt.out;
    nt.out ==> out;
    
    spec_postcondition out == (in_0 <= in_1);

}
template AddMaxbitTag(n) {
    signal input in;
    signal output {maxbit} out;
    
    _ <== Num2Bits(n)(in);

    out.maxbit = n;
    out <== in;
    
    spec_postcondition out == in;
}



template IntegerDivision(n){
    signal input {maxbit} dividend;
    signal input {maxbit} divisor;
    
    signal output quotient;
    signal output remainder;
    
    remainder <-- dividend % divisor;
    quotient <-- (dividend - remainder) / divisor;
    
    signal lt_remainder <== LessThan(n)(AddMaxbitTag(n)(remainder), divisor);
    lt_remainder === 1;

    signal lt_quotient <== LessEqThan(n)(AddMaxbitTag(n)(quotient), dividend );
    lt_quotient === 1;
    
    dividend === divisor * quotient + remainder;
    
    spec_postcondition dividend == divisor * quotient + remainder;
    spec_postcondition quotient <= dividend;
    spec_postcondition remainder < divisor;

}


template A(n){
    signal input dividend;
    signal input divisor;
    
    signal output quotient;
    signal output remainder;

    (quotient, remainder) <== IntegerDivision(n)(AddMaxbitTag(n)(dividend), AddMaxbitTag(n)(divisor));
}


component main = A(80);
