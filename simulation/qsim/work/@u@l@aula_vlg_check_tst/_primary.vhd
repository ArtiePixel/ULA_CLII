library verilog;
use verilog.vl_types.all;
entity ULAula_vlg_check_tst is
    port(
        Cout            : in     vl_logic;
        O               : in     vl_logic_vector(4 downto 0);
        Zero            : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end ULAula_vlg_check_tst;
