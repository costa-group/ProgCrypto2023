pragma circom 2.1.5;


template Power(n){
    signal input in;
    signal output out;
    
    signal aux[n+1];
    
    if (n == 0){
        out <== 1;
        _ <== in; 
    } else{
        aux[0] <== 1;
        for (var i = 0; i < n; i++){
            aux[i + 1] <== aux[i] * in;
        }
        out <== aux[n];
    }
}

// Computes the array [in[0] ** 0, in[1] ** 1, ... in[n-1] ** (n-1)]
template ComputePowers(n){
   signal input in[n];
   signal output out[n];
   
   for (var i = 0; i < n; i++){
       out[i] <== Power(i)(in[i]);
   }
}



component main = ComputePowers(10);
