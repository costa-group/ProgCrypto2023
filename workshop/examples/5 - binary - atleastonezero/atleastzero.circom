pragma circom 2.1.5;


//OUR GOAL: Fill the code necessary to have a correct implement of at_least_one_is_zero().

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

    //to fill.
}

component main = at_least_one_is_zero();