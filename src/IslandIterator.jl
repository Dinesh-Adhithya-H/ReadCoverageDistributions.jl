struct IslandIteratorState
    pos
end


struct IslandIterator
    read_start_pos
    read_length
end


function Base.iterate(iter::IslandIterator, state = nothing)
    
    
    pos = isnothing(state) ? 1 : state.pos
    no_reads = 1
    
    pos == length(iter.read_start_pos) && return ((1,iter.read_length), IslandIteratorState(pos+1))
    pos>length(iter.read_start_pos) && return nothing

    while iter.read_start_pos[pos]+iter.read_length>=iter.read_start_pos[pos+1]
        pos += 1
        no_reads+=1
        pos == length(iter.read_start_pos) && return  ((no_reads,iter.read_length+iter.read_start_pos[pos]-iter.read_start_pos[pos-no_reads+1]), IslandIteratorState(pos + 1))
    end
    
    return ((no_reads,iter.read_length+iter.read_start_pos[pos]-iter.read_start_pos[pos-no_reads+1]), IslandIteratorState(pos + 1))
end
