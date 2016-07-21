function [ pics ] = extract_rho( rho, pts )
    global map img space hei wid ang
    space = rho;
    [ hei, wid, ang] = size( rho);
    map = zeros( hei, wid, ang);
    P = size(pts,1);
    pics = zeros( 1, hei, wid);
    for i = 1:P
        x = pts(i,1);  y = pts(i,2);
        for k = 1:ang
            if ( rho( x, y, k) == 1 ) & ( map( x, y, k) == 0 )
                img = ones( hei, wid);
                DFS(x,y,k);
                %fprintf('pic=%d\n',hei*wid - sum(sum(img)));
                if hei*wid - sum(sum(img)) > 50 % a stroke should bigger than 50 pixels
                    pics(end+1,:,:) = img;
                end
            end
        end
    end
end

function DFS( x, y, z)
    global map img space hei wid ang
    img( x, y) = 0;
    map( x, y, z) = 1;
    for i = x-1 : 1 : x+1
        for j = y-1 : 1 : y+1
            for k = z-1 : 1 : z+1
                a = i; b = j; c = k;
                if i <1 
                    a = 1;
                elseif i>hei
                    a = hei;
                end
                if j <1 
                    b = 1;
                elseif j>wid
                    b = wid;
                end
                if k<1
                    c = ang;  % wrap
                elseif k>ang
                    c = 1;
                end
                %fprintf('i=%djy=%d,k=%d,a=%d,b=%d,c=%d\n',i,j,k,a,b,c);
                if ( space( a, b, c) == 1 ) & ( map( a, b, c) == 0 )
                    DFS(a,b,c);
                end
            end
        end
    end
end
