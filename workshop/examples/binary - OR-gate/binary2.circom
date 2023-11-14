pragma circom 2.1.5;

template AND() {      
    signal input {binary} a;
    signal input {binary} b;
    signal output {binary} out;

    out <== a*b;
}

template check_AND() {      
    signal input {binary}in1;
    signal input {binary} in2;
    signal output {binary} out;

    out <== AND()(in1,in2);
}

component main = check_AND();