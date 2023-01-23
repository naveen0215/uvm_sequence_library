//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records i3c_m transaction information using
//       a covergroup named i3c_m_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class i3c_m_transaction_coverage  extends uvm_subscriber #(.T(i3c_m_transaction ));

  `uvm_component_utils( i3c_m_transaction_coverage )

  T coverage_trans;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  // ****************************************************************************
  covergroup i3c_m_transaction_cg;
    // pragma uvmf custom covergroup begin
    // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
    option.auto_bin_max=1024;
    option.per_instance=1;
    read_write: coverpoint coverage_trans.read_write;
    scl: coverpoint coverage_trans.scl;
    sda: coverpoint coverage_trans.sda;
    wr_data[]: coverpoint coverage_trans.wr_data[];
    rd_data[]: coverpoint coverage_trans.rd_data[];
    slave_address: coverpoint coverage_trans.slave_address;
    register_address: coverpoint coverage_trans.register_address;
    size: coverpoint coverage_trans.size;
    ack: coverpoint coverage_trans.ack;
    index: coverpoint coverage_trans.index;
    raddr: coverpoint coverage_trans.raddr;
    slave_add_ack: coverpoint coverage_trans.slave_add_ack;
    reg_add_ack: coverpoint coverage_trans.reg_add_ack;
    wr_data_ack [$]: coverpoint coverage_trans.wr_data_ack [$];
    // pragma uvmf custom covergroup end
  endgroup

  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    i3c_m_transaction_cg=new;
    `uvm_warning("COVERAGE_MODEL_REVIEW", "A covergroup has been constructed which may need review because of either generation or re-generation with merging.  Please note that transaction variables added as a result of re-generation and merging are not automatically added to the covergroup.  Remove this warning after the covergroup has been reviewed.")
  endfunction

  // ****************************************************************************
  // FUNCTION : build_phase()
  // This function is the standard UVM build_phase.
  //
  function void build_phase(uvm_phase phase);
    i3c_m_transaction_cg.set_inst_name($sformatf("i3c_m_transaction_cg_%s",get_full_name()));
  endfunction

  // ****************************************************************************
  // FUNCTION: write (T t)
  // This function is automatically executed when a transaction arrives on the
  // analysis_export.  It copies values from the variables in the transaction 
  // to local variables used to collect functional coverage.  
  //
  virtual function void write (T t);
    `uvm_info("COV","Received transaction",UVM_HIGH);
    coverage_trans = t;
    i3c_m_transaction_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

