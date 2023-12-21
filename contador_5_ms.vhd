	-- 33 750 or 1350 5ms
	-- 135 000 or 5400 20ms
library ieee;
use ieee.std_logic_1164.all;

entity contador_5_ms is
    port (ck_in, div: in std_logic;
          valor: out std_logic);
end contador_5_ms;

architecture behavior of contador_5_ms is

	
begin
	
   process(ck_in, div)
      variable cnt: integer range 0 to 13500000 := 0;
   begin
      if (rising_edge(ck_in)) then
			case div is
				when '1' =>
					if (cnt=1350) then
						cnt:=0;
						ax <= not ax;
					else
						cnt:=cnt+1;
					end if;
				when '0' =>
						if (cnt=33750) then
						cnt:=0;
						ax <= not ax;
					else
						cnt:=cnt+1;
					end if;
			end case;
      end if;
   end process;
   valor<=ax;
    
end behavior;