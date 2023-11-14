pragma circom 2.1.5;

template isZero(){
   signal input in;
   signal output out;
   out <-- (in == 0); 

}

component main = isZero();