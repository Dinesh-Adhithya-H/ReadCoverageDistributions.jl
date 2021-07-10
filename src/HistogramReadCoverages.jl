export simulate_readcoverage,Para,increment!,hist_add!,vec_hist_add!,simulate_and_get_coveage_hist,plot_readcoverage_simulation

using OffsetArrays
using ProgressMeter
using PyPlot
using LsqFit


Base.@kwdef struct Para
    genome_length::Int = 10_000_000
    read_length::Int = 100
    read_number::Int
end

function increment!(h::Vector{T}, i::Int) where T <: Number
    if i > length(h)
        lh = length(h)
        resize!(h, i)
        for k in (lh + 1) : i
            @inbounds h[k] = zero(T)
        end
    end
    @inbounds h[i] += one(T)
    h
end


function hist_add!(h1::Vector{T}, h2::Vector{T}) where T <: Number
    if length(h1) <= length(h2)
        h = h2
        for i in 1:length(h1)
            @inbounds h[i] += h1[i]
        end
    else
        h = h1
        for i in 1:length(h2)
            @inbounds h[i] += h2[i]
        end
    end
    return h
end

function vec_hist_add!(hs1, hs2)
    @assert length(hs1) == length(hs2)
    map(hist_add!, hs1, hs2)
end

function simulate_and_get_coveage_hist(p::Para)
    # simulation
    g = fill(zero(Int32), p.genome_length) 
    for i in 1:p.read_number
        pos = rand(1:(p.genome_length - p.read_length))
        g[pos] += 1
        g[pos + p.read_length] -= 1
    end
#     @show g
    max_coverage_for_hist = 2
    hists = OffsetArray(map(x->Int[], 1:max_coverage_for_hist+1), 0:max_coverage_for_hist)
    # compute coverages
    g0 = 0 + g[1]
    p0 = 1
    for pos in 2:p.genome_length
        if g[pos] != 0
#             @show (g0, pos - p0)
            g0 <= max_coverage_for_hist && increment!(hists[g0], pos - p0)
            g0 += g[pos]
            p0 = pos
        end
    end
    hists
end

function simulate_readcoverage(n,genome_length,read_length,no_reads)
    paras = fill(Para(genome_length = genome_length,read_length=read_length,read_number=no_reads), n);
    res = @showprogress map(simulate_and_get_coveage_hist, paras);
    h = reduce(vec_hist_add!, res) ./ n
    return h
end

function plot_readcoverage_simulation(h,coverage,n=100)
    fig, ax = subplots()
    ax.scatter(1:length(h[coverage]),h[coverage])
    #ax.set_xlim(0,1500)
    #ax.set_ylim(1/n, maximum(h[coverage]))
    title(string(coverage)*" Coverages")
    ax.set_yscale("log")
end
