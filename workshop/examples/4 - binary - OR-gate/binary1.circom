pragma circom 2.1.5;

template AND() {      
    signal input a;
    signal input b;
    signal output out;

    out <== a*b;
}




template check_AND() {      
    signal input in1;
    signal input in2;
    signal output out;

    out <== AND()(in1,in2);
}

component main = check_AND();