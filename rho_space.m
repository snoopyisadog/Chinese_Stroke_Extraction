function [ rho ] = rho_space( im, ppod, pt )
    gap = 3;
    %ang = linspace(0, 2*pi, 180/gap);
    [hei, wid, ang] = size(ppod);
    rho = zeros( hei, wid, ang);
    for i = 1:hei
        for j = 1:wid
            %for k = 1:size(ang,2)
                x = squeeze ( ppod(i,j,:) );
                [ pks, locs] = findpeaks( [ x(11:end); x(1:10) ] ); % offset to get peaks
                % maybe I can change this standard to bigger than some
                % value then => 1
                rho( i, j, mod( (locs+9), ang)+1 ) = 1;
        end
    end
end

