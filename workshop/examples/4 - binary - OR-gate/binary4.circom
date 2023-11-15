pragma circom 2.1.5;

template AND() {      
    signal input {binary} a;
    signal input {binary} b;
    signal output {binary} out;

    out <== a*b;
}

template AddBinaryTag(){
    signal input in;
    signal output {binary} out;
    in*(in-1) === 0;
    out <== in;
}


template check_AND() {      
    signal input  in1;
    signal input  in2;
    signal output {binary} out;

    signal bin_in1 <== AddBinaryTag()(in1);
    signal bin_in2 <== AddBinaryTag()(in2);
    out <== AND()(bin_in1,bin_in2);
}

component main = check_AND();