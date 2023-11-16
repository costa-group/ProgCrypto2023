pragma circom 2.1.5;

//OUR GOAL: To change the code to have a correct version of IsZero.
template isZero(){
   signal input in;
   signal output out;
   out <== (in == 0); 

}

component main = isZero();
