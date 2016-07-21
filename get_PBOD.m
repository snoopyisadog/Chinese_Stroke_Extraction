function [ ret, pt ] = get_PBOD( im )
    global pic hei wid
    pic = im;
    [ hei, wid ] = size(im);
    gap = 3;
	range = 360/gap;
    ang = linspace(0,2*pi,360/gap);
    ret = zeros(hei, wid, 360/gap);
    pt = zeros(1,2)
    for i = 1:hei
        for j = 1:wid
            if im(i,j) == 0 % if this pixel is black
                pt(end+1,1:2) = [ i j ];
                for k = 1:size(ang,2)
                    ret(i,j,k) = distance2boundary(i,j,ang(k));
                    %fprintf('ret(%d,%d,%d) = %f\n',i,j,k,ret(i,j,k));
                end
            end
            %{
            for k = 1:range  % start from deg 1 because MATLAB
                ret(i,j,k) = distance2boundary(i,j,k*gap);
            end
            %}
        end
    end
    pt(1,:) = [];
end

function ret = distance2boundary(i,j,deg)
    global pic hei wid
    for d = 1:hei
        %fprintf('deg=%f\n',deg);
        x = round( i + d * cos(deg) );
        y = round( j + d * sin(deg) );
        %fprintf('i=%d,j=%d,deg=%f\n',i,j,deg);
        %fprintf('d=%d,x=%f,y=%f,deg=%f\n',d,x,y,deg);
		if pic(x,y) == 1
			break;
		end
    end
    ret = d;
end
