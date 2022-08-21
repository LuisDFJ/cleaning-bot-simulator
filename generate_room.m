function generate_room( f, blocks )
    figure( f );
    for i = 1 : length( blocks )
        h = patch;
        x = blocks{i}{1};
        color = blocks{i}{2};
        
        h.XData = x(:,1);
        h.YData = x(:,2);
        h.FaceColor = color;
    end
end