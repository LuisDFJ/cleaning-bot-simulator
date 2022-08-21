function v = pack_collision( blocks )
    len = 0;
    for i = 1 : length( blocks )
        len = len + size( blocks{i}{1}, 1 ) + 1;
    end
    v = zeros( len, 2 );
    c = 1;
    for i = 1 : length( blocks )
        block = blocks{i}{1};
        len = size( block, 1 );
        v(c:c+len,:) = [ block; block(1,:) ];
        c = c + len + 1;
    end
end