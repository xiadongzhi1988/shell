#!/bin/bash

awk 'BEGIN{
s=60/360;
a=1/180;
b=1/240;
c=1/300;
d=1/360;
while(s<1)
{
  if(s<1)
  {
    for(i=1;i<=60;i++)
    {
      s+=a;
      t+=1;
      if(s>=1)
      {
        break;
      }
    }
  }

    if(s<1)
    {
      s-=b*60;
      t+=60;
    }
    
  if (s<1)
  {
    for(i=1;i<=60;i++)
    {
      s+=c;
      t+=1;
      if(s>=1)
      {
        break;
      }
    }
  }
 
   if(s<1)
   {  
     s-=d*60;
     t+=60;
   }
}
print t;
}'
