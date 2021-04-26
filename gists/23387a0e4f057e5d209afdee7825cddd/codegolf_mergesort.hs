import Data.List
g x|y<-x>>=h=x:[z|x/=y,z<-g y++[sort<$>x]]
h[a]=[[a]]
h x=foldr(\x[b,a]->[x:a,b])[[],[]]x