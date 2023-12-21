library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity coracao is
    port (SW: in std_logic_vector(1 downto 0);
			 clk, clr: in std_logic;
			 sa, sv, pa, pv: out std_logic);
end coracao;

architecture behavior of coracao is
	component marca_passo is
		 port (SW: in std_logic_vector(1 downto 0);
				 cnt: in integer range 0 to 27000000;
				 clk, clr: in std_logic;
				 pa, pv: out std_logic);
	end component;

variable cnt: integer range 0 to 27000000 := 0; -- Contador para o tempo

begin
	
	marca_passo0: marca_passo port map(SW, cnt, clk, clr, pa, pv);
  if rising_edge(clk) then
    cnt := cnt + 1;
    case SW is
		 when "11" => 
			if cnt mod 135000 = 0 then -- 5ms
			  sa <= '1';
			elsif cnt mod 675000 = 0 then -- 25ms
			  sv <= '1';
			  cnt:=0;
			else
				sa <= '0';
				sv <= '0';
			end if;
		 when "10" =>
			if cnt mod 675000 = 0 then -- 25ms
			  sv <= '1';
			  cnt:=0;
			else
				sa <= '0';
				sv <= '0';
			end if;
		 when "01" =>
			if cnt mod 135000 = 0 then -- 5ms
			  sa <= '1';
			elsif cnt mod 675000 = 0 then -- 25ms
			  cnt:=0;
			else
				sa <= '0';
				sv <= '0';
			end if;
		 when "00" =>
				sa <= '0';
				sv <= '0';
			end if;
  end if;
	sa <= sa_0;
	sv <= sv_0;
	
end behavior;