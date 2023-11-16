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
	out <== in;
	in*(in-1)=== 0;
}



template check_AND() {      
    signal input  in1;
    signal input  in2;
    signal output out;
	signal checkin1 <== AddBinaryTag()(in1);
 	signal checkin2 <== AddBinaryTag()(in2);	
    out <== AND()(checkin1,checkin2);
}

component main = check_AND();
