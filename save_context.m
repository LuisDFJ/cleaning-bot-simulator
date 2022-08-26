name = 'record.mat';

if isfile( name )
    record = load( 'record.mat' );
    sc = [ record.sc, c ];
    sd = [ record.sd, d ];
    scp = [ record.scp, clean_percent ];
    stime = [ record.stime, time ];
    sstep = [ record.sstep, step ];
else
    sc = c;
    sd = d;
    scp = clean_percent;
    stime = time;
    sstep = step;
end

save( name, 'sc', 'sd', 'scp', 'stime', 'sstep' )
