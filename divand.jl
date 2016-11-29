module divand
using Interpolations
using Base.Test

function ndgrid_fill(a, v, s, snext)
    for j = 1:length(a)
        a[j] = v[div(rem(j-1, snext), s)+1]
    end
end


function ndgrid{T}(vs::AbstractVector{T}...)
    n = length(vs)
    sz = map(length, vs)
    out = ntuple(i->Array{T}(sz), n)
    s = 1
    for i=1:n
        a = out[i]::Array
        v = vs[i]
        snext = s*size(a,i)
        ndgrid_fill(a, v, s, snext)
        s = snext
    end
    out
end



include("sparse_stagger.jl"); 
include("sparse_diff.jl"); 
include("sparse_interp.jl"); 
include("localize_separable_grid.jl");

function sparse_pack(mask)

j = find(mask)
m = length(j)
i = collect(1:m)
s = ones(m)
n = length(mask)
H = sparse(i,j,s,m,n)

end


function test()
    include("test_sparse_diff.jl"); 
#    include("test_localize_separable_grid.jl");

    
end

export test, sparse_stagger, sparse_diff, localize_separable_grid, ndgrid, sparse_pack, sparse_interp

end
