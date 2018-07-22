function convBconv()
    global config mem;
    curr_layer_idx = config.misc.current_layer;
    mem.deltas{curr_layer_idx+1} = reshape(accumarray(mem.convBconv{curr_layer_idx+2}, mem.deltas{curr_layer_idx+1}(:)), ...
                                            mem.orig_activation_size{curr_layer_idx+1}(2), mem.orig_activation_size{curr_layer_idx+1}(1))';
                                           %size(mem.layer_inputs{curr_layer_idx+1}, 1), size(mem.layer_inputs{curr_layer_idx+1}, 2));
    
    mem.grads{curr_layer_idx+1} = mem.deltas{curr_layer_idx+1} * mem.activations{curr_layer_idx}';
    mem.grads{curr_layer_idx+1+config.layer_num} = sum(mem.deltas{curr_layer_idx+1}, 2);
	mem.delta_act = config.weights{curr_layer_idx+1}' * mem.deltas{curr_layer_idx+1};
end

