library verilog;
use verilog.vl_types.all;
entity ULAula_vlg_sample_tst is
    port(
        A               : in     vl_logic_vector(5 downto 0);
        B               : in     vl_logic_vector(5 downto 0);
        R               : in     vl_logic;
        S               : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end ULAula_vlg_sample_tst;
