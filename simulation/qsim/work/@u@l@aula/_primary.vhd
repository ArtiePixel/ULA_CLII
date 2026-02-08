library verilog;
use verilog.vl_types.all;
entity ULAula is
    port(
        S               : in     vl_logic_vector(3 downto 0);
        A               : in     vl_logic_vector(4 downto 0);
        B               : in     vl_logic_vector(4 downto 0);
        R               : in     vl_logic;
        O               : out    vl_logic_vector(4 downto 0);
        Cout            : out    vl_logic;
        Zero            : out    vl_logic
    );
end ULAula;
