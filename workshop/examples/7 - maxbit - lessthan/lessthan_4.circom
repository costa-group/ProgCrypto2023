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


template LessThan(n) {
    assert(n <= 252);
    signal input {maxbit} in_0;
    signal input {maxbit} in_1;
    signal output {binary} out;
    
    assert(in_0.maxbit <= n);
    assert(in_1.maxbit <= n);

    component n2b = Num2Bits(n+1);
    n2b.in <== in_0+ (1<<n) - in_1;
    out <== 1-n2b.out[n];
    for (var i = 0; i < n; i++){
        _ <== n2b.out[i];
    }
}


template AddMaxbitTag(n) {
    signal input in;
    signal output {maxbit} out;
    
    _ <== Num2Bits(n)(in);

    out.maxbit = n;
    out <== in;
}

template CheckedLessThan(n){
    signal input in_0;
    signal input in_1;
    signal output {binary} out;
    
    signal {maxbit} checked_in_0 <== AddMaxbitTag(n)(in_0);
    signal {maxbit} checked_in_1 <== AddMaxbitTag(n)(in_1);
    
     out <== LessThan(n)(checked_in_0, checked_in_1);

}

component main = CheckedLessThan(10);
