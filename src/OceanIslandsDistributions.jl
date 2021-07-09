module OceanIslandDistributions
using OffsetArrays
using ProgressMeter
using PyPlot
using LsqFit
include("ReadCoverageDistributions.jl")

Base.@kwdef struct Para
    genome_length::Int = 10_000_000
    read_length::Int = 100
    read_number::Int
end

function simulate_and_get_coveage_hist_2(p::Para)
    
    # simulation
    g = fill(zero(Int32), p.genome_length) 
    for i in 1:p.read_number
        pos = rand(1:(p.genome_length - p.read_length))
        g[pos] += 1
        g[pos + p.read_length] -= 1
    end
    
#     @show g
    
    max_coverage_for_hist = 1
    hists = OffsetArray(map(x->Int[], 1:max_coverage_for_hist+1), 0:max_coverage_for_hist)
    
    # compute coverages
    g0 = 0 + g[1]
    p0 = 1
    for pos in 2:p.genome_length
        if (g0==0) && (g[pos] >0)
            increment!(hists[0], pos - p0)
            g0 += g[pos]
            p0 = pos
        elseif (g0 >0) && (g[pos] == - g0)
            increment!(hists[1], pos - p0)
            g0 += g[pos]
            p0 = pos
        elseif g[pos]!=0
            g0+=g[pos]
        end
    end
    hists
end

function simulate_oceansislands(n,genome_length,read_length,no_reads)
    paras = fill(Para(genome_length = genome_length,read_length=read_length,read_number=no_reads), n);
    res = @showprogress map(simulate_and_get_coveage_hist2, paras);
    h = reduce(vec_hist_add!, res) ./ n
    return h
end

function plot_oceansislands_simulation(h,coverage,n=100)
    fig, ax = subplots()
    ax.scatter(1:length(h[coverage]),h[coverage])
    #ax.set_xlim(0,1500)
    #ax.set_ylim(1/n, maximum(h[coverage]))
    title(string(coverage)*" Coverages")
    ax.set_yscale("log")
end

function no_islands_vs_no_reads_simulation(genome_length,read_length,number_reads,width,n)
    counter=[]
    for i in 1:width:number_reads
        n = 30
        paras = fill(Para(genome_length,read_length, i), n);
        h = mapreduce(simulate_and_get_coveage_hist_2, vec_hist_add!, paras)
        h= h./ n
        push!(counter,sum(h[1]))
    end
    return counter
end

function no_oceans_vs_no_reads_simulation(genome_length,read_length,number_reads,width,n)
    counter=[]
    for i in 1:width:number_reads
        n = 30
        paras = fill(Para(genome_length,read_length, i), n);
        h = mapreduce(simulate_and_get_coveage_hist_2, vec_hist_add!, paras)
        h= h./ n
        push!(counter,sum(h[0]))
    end
    return counter
end

function avg_length_oceans_vs_no_reads_simulation(genome_length,read_length,number_reads,width,n)
    counter=[]
    for i in 1:width:number_reads
        n = 30
        paras = fill(Para(genome_length,read_length, i), n);
        h = mapreduce(simulate_and_get_coveage_hist_2, vec_hist_add!, paras)
        h= h./ n
        val=sum(h[0].*[i for i in 1:length(h[0])])/sum(h[0])
        push!(counter,val)
    end
    return counter
end

function avg_length_islands_vs_no_reads_simulation(genome_length,read_length,number_reads,width,n)
    counter=[]
    for i in 1:width:number_reads
        n = 30
        paras = fill(Para(genome_length,read_length, i), n);
        h = mapreduce(simulate_and_get_coveage_hist_2, vec_hist_add!, paras)
        h= h./ n
        val=sum(h[1].*[i for i in 1:length(h[1])])/sum(h[1])
        push!(counter,val)
    end
    return counter
end

function simulate_and_get_coveage_hist_3(p::Para)
    # simulation
    g = fill(zero(Int32), p.genome_length) 
    g1 = fill(zero(Int32), p.genome_length) 
    for i in 1:p.read_number
        pos = rand(1:(p.genome_length - p.read_length))
        g[pos] += 1
        g[pos + p.read_length] -= 1
        g1[pos] += 1
    end
    hists = zeros(1:p.read_number)
    reads=0
    g0 = 0
    for pos in 1:p.genome_length
        if g[pos] != 0 || g1[pos]>0
            g0 += g[pos]
            reads+=g1[pos]
            if g0==0
                hists[reads]+=1
                reads=0
            end
        end
    end
    hists
end

function no_reads_vs_no_islands(n,genome_length,read_length,read_number)
    p=Para(genome_length=genome_length,read_length=read_length,read_number=read_number)
    a=simulate_and_get_coveage_hist_3(p);
    for j in 1:n-1
        a=a+simulate_and_get_coveage_hist_3(p);
    end
    a=a./n;
    return a
end

end


