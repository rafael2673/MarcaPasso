library ieee;
use ieee.std_logic_1164.all;

entity ck_div is
   port (ck_in, div: in  std_logic;
         ck_out: out std_logic);
end ck_div;

architecture logica of ck_div is
signal ax : std_logic := '0';

begin 
	
   process(ck_in, div)
      variable cnt: integer range 0 to 13500000 := 0;
   begin
      if (rising_edge(ck_in)) then
			case div is
				when '1' =>
					if (cnt=99) then
						cnt:=0;
						ax <= not ax;
					else
						cnt:=cnt+1;
					end if;
				when '0' =>
						if (cnt=3) then
						cnt:=0;
						ax <= not ax;
					else
						cnt:=cnt+1;
					end if;
			end case;
      end if;
   end process;
   ck_out<=ax;
end logica;