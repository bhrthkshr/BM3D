function denoise_configure()    
    global config;
    config.input_size = [64 64];
    config.chs = 3;
    config.forward_pass_scheme = {'conv_v', 'conv_v', 'conv_f', 'out'};
    config.nonlinearity = 'tanh';   % 'relu', 'tanh', 'sigmoid'
    config.output_activation = 'nil';   % 'softmax', 'inherit', 'nil'
    config.cost_function = 'L2 norm'; % 'cross entropy', 'L2 norm'
    config.kernel_size = [16 16; 1 1; 8 8];
    config.conv_hidden_size = [512 512];
    config.full_hidden_size = [];
    config.output_size = [56 56 3];
    config.batch_size = 1;
    config.compute_device = 'CPU';
    
    % the following items are only for training
    config.learning_rate = 0.01;
    config.weight_range = 0.01;
    config.decay = 5e-7 / 10;
    config.normalize_init_weights = 0;
    config.dropout_full_layer = 0;
    config.optimization = 'adagrad';
end
