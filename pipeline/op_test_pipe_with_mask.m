function op_test_pipe_with_mask(in, mask_li, gt_out)    
    set_mask_list(mask_li);
    op_test_pipe(in, gt_out);        
end
