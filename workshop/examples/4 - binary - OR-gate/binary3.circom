pragma circom 2.1.5;

template AND() {      
    signal input {binary} a;
    signal input {binary} b;
    signal output {binary} out;

    out <== a*b;
}

template check_AND() {      
    signal input  in1;
    signal input  in2;
    signal output {binary} out;

    signal  {binary}  bin_in1 <== in1;
    signal  {binary}  bin_in2 <== in2;
    out <== AND()(bin_in1,bin_in2);
}

component main = check_AND();