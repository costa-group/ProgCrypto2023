pragma circom 2.1.5;

template OR() {      
    signal input {binary} a;
    signal input {binary} b;
    signal output {binary} out;

    out <== a + b - a * b;
}

template isZero(){
   signal input in;
   signal output out;
   signal inv <-- in == 0 ? 0 : 1/inv;
   out <== -in*inv + 1; 

}

template at_least_one_is_zero() {      
    signal input  in1;
    signal input  in2;
    signal output {binary} out;

    out <== OR()(isZero()(in1),isZero()(in2));  
}

component main = at_least_one_is_zero();