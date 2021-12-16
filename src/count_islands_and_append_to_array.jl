function binforlength(len,bins,max_island_length)
    return floor(Int, ((len+eps())/max_island_length) * bins)
end

function count_islands_and_append_to_array!(genome_length, g::Vector 
        ; max_no_of_reads::Int,read_length::Int) 
        # returns arrays of length 100 , with maximum possible length of islands of a particular 
        # read length mapped to be 100 and least possible length of a island ie. read length of a single island mapped to 1.
    
        data=[]
        number_of_reads = length(g)
        no_islands=zeros(max_no_of_reads)
        cum_length_islands=zeros(max_no_of_reads)
        hist_island_dist=[zeros(100) for i in 1:max_no_of_reads]
        for (r, len) in IslandIterator(g, read_length)
            if r<=max_no_of_reads
                no_islands[r]+=1
                cum_length_islands[r]+=len
                hist_island_dist[r][binforlength(len,100,r*read_length)]+=1.0
            end

        end

        for i in 1:max_no_of_reads
                push!(data, (genome_length,number_of_reads,i, no_islands[i], cum_length_islands[i],hist_island_dist[i]))
        end
        
        return data

end