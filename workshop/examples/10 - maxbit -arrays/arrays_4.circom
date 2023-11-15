pragma circom 2.1.5;


function max(in0, in1, in2){
    if (in0 > in1){
        if (in0 > in2){
            return in0;
        } else{
            return in2;
        }
    } else{
        if (in1 > in2){
            return in1;
        } else{
            return in2;
        }
    }

}

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

template AddMaxbitTag(n) {
    signal input in;
    signal output {maxbit} out;
    
    _ <== Num2Bits(n)(in);

    out.maxbit = n;
    out <== in;
}


template GenerateArrayMaxbit(){
    signal input {maxbit} in_0;
    signal input {maxbit} in_1;
    signal input {maxbit} in_2;
    
    signal output {maxbit} out[3];
    
    out.maxbit = max(in_0.maxbit, in_1.maxbit, in_2.maxbit);
    
    out[0] <== in_0;
    out[1] <== in_1;
    out[2] <== in_2;
    
    log(out.maxbit);
}

template AuxMain(n_0, n_1, n_2){
    signal input in_0;
    signal input in_1;
    
    signal {maxbit} checked_in_0 <== AddMaxbitTag(n_0)(in_0);
    signal {maxbit} checked_in_1 <== AddMaxbitTag(n_1)(in_1);

    signal output out[3] <== GenerateArrayMaxbit()(checked_in_0, checked_in_1, 5);
}




component main = AuxMain(15, 5, 10);
