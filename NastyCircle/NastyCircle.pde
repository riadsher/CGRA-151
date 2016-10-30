size(120,120);

int R=50;
int offsetX=60;
int offsetY=120;
for(int x =0-R;x<=R;x++){
  for (int y =0-R ; y <=R ; y++){
    float k = pow(x,2)+pow(y,2)-pow(R,2);
    if((k>=0 && k<R*2)){
     stroke(0);
     point(x+offsetX,y+offsetY);
     }
     else if(k<0){
      stroke(0,0,255);
      point(x+offsetX,y+offsetY);
     }
  }
}