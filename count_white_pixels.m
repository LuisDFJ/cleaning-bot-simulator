function c = count_white_pixels( f, val )
    figure( f );
    F = getframe( gcf ).cdata;
    F = F(:,:,3);
    c = sum( F(:) == val );
end