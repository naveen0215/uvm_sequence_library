//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// Description: This file contains the top level and utility sequences
//     used by test_top. It can be extended to create derivative top
//     level sequences.
//
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//


typedef env_env_configuration  env_env_configuration_t;

class i3c_bench_sequence_base extends uvmf_sequence_base #(uvm_sequence_item);

  `uvm_object_utils( i3c_bench_sequence_base );

  // pragma uvmf custom sequences begin

typedef env_env_sequence_base #(
        .CONFIG_T(env_env_configuration_t)
        )
        env_env_sequence_base_t;
rand env_env_sequence_base_t env_env_seq;



  // UVMF_CHANGE_ME : Instantiate, construct, and start sequences as needed to create stimulus scenarios.
  // Instantiate sequences here
  typedef i3c_s_random_sequence  s_agent_random_seq_t;
  s_agent_random_seq_t s_agent_random_seq;
  // pragma uvmf custom sequences end

  // Sequencer handles for each active interface in the environment
  typedef i3c_s_transaction  s_agent_transaction_t;
  uvm_sequencer #(s_agent_transaction_t)  s_agent_sequencer; 


  // Top level environment configuration handle
  env_env_configuration_t top_configuration;

  // Configuration handles to access interface BFM's
  i3c_s_configuration  s_agent_config;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  // ****************************************************************************
  function new( string name = "" );
    super.new( name );
    // Retrieve the configuration handles from the uvm_config_db

    // Retrieve top level configuration handle
    if ( !uvm_config_db#(env_env_configuration_t)::get(null,UVMF_CONFIGURATIONS, "TOP_ENV_CONFIG",top_configuration) ) begin
      `uvm_info("CFG", "*** FATAL *** uvm_config_db::get can not find TOP_ENV_CONFIG.  Are you using an older UVMF release than what was used to generate this bench?",UVM_NONE);
      `uvm_fatal("CFG", "uvm_config_db#(env_env_configuration_t)::get cannot find resource TOP_ENV_CONFIG");
    end

    // Retrieve config handles for all agents
    if( !uvm_config_db #( i3c_s_configuration )::get( null , UVMF_CONFIGURATIONS , s_agent_BFM , s_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( i3c_s_configuration )::get cannot find resource s_agent_BFM" )

    // Assign the sequencer handles from the handles within agent configurations
    s_agent_sequencer = s_agent_config.get_sequencer();



    // pragma uvmf custom new begin
    // pragma uvmf custom new end

  endfunction

  // ****************************************************************************
  virtual task body();
    // pragma uvmf custom body begin

    // Construct sequences here

    env_env_seq = env_env_sequence_base_t::type_id::create("env_env_seq");

    s_agent_random_seq     = s_agent_random_seq_t::type_id::create("s_agent_random_seq");
    fork
      s_agent_config.wait_for_reset();
    join
    // Start RESPONDER sequences here
    fork
    join_none
    // Start INITIATOR sequences here
    fork
      repeat (25) s_agent_random_seq.start(s_agent_sequencer);
    join

env_env_seq.start(top_configuration.vsqr);

    // UVMF_CHANGE_ME : Extend the simulation XXX number of clocks after 
    // the last sequence to allow for the last sequence item to flow 
    // through the design.
    fork
      s_agent_config.wait_for_num_clocks(400);
    join

    // pragma uvmf custom body end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

