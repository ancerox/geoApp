 arr1 = [2,3,6,12,15];
 arr2 = [23,15,10,12,5];

let target = 8;

let x = 0;
let y = 0;


for (let i = 0; i < arr1.length; i++){
  
    for (let j = 0; j < arr2.length; j++){
  
      if (Math.abs((arr1[i] + arr2[j] - target) )< Math.abs(arr1[x] + arr2[y] - target)){
        x = i;
        y = j;
      }
      
  
}
  
}

  console.log(arr1[x] + arr2[y]);
