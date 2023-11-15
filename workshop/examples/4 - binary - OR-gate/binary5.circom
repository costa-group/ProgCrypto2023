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
    
    out <== AND()(AddBinaryTag()(in1),AddBinaryTag()(in2));
}

component main = check_AND();