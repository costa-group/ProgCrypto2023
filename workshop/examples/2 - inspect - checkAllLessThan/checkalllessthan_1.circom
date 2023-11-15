pragma circom 2.1.5;

template Num2Bits(n) {
    signal input in;
    signal output out[n];
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
    signal input in_0;
    signal input in_1;
    signal output out;

    component n2b = Num2Bits(n+1);

    n2b.in <== in_0+ (1<<n) - in_1;

    out <== 1-n2b.out[n];
    
}

template CheckAllLessThan(n_bits, n){
    signal input in[n];
    signal input size;
    
    component lt[n];
    
    for (var i = 0; i < n; i++){
        lt[i] = LessThan(n_bits);
        lt[i].in_0 <== in[i]; 
        lt[i].in_1 <== size;
    }

    
}

component main = CheckAllLessThan(10, 5);
