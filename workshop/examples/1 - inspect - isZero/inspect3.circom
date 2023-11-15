pragma circom 2.1.5;

template isZero(){
   signal input in;
   signal output out;
   signal inv <-- in == 0 ? 0 : 1/inv;
   out <== -in*inv + 1; 

}

component main = isZero();