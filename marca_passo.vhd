library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity marca_passo is
    port (SW: in std_logic_vector(1 downto 0);
			 clk, clr, div: in std_logic;
			 sa, sv, pa, pv: out std_logic);
end marca_passo;

architecture behavior of marca_passo is

	component ck_div is
		port (ck_in, div: in  std_logic;
				ck_out: out std_logic);
	end component;
	
signal clk_out: std_logic;
begin
	CLK0: ck_div port map(clk, div, clk_out);
	process(clk, SW)
	variable cnt: integer range 0 to 27000000 := 0; -- Contador para o tempo
	variable sa_generated: boolean := false;
	variable mod_val_5, mod_val_25: integer; -- Valor para o operador mod
		begin
		if rising_edge(clk) then
			cnt := cnt + 1;
			if clr = '0' then
				 cnt := 0;
				 sa_generated := false;
			end if;
			case div is
				when '1' => 
					mod_val_5 := 1350;
					mod_val_25 := 6750;
				when '0' =>
					mod_val_5 := 33750;
					mod_val_25 := 168750;
			end case;
			case SW is
				when "11" => 
					if cnt mod mod_val_5 = 0 and not(sa_generated) then -- 5ms
						sa <= '1';
						sa_generated := true;
					elsif cnt mod mod_val_25 = 0 then -- 25ms
						sv <= '1';
						cnt:=0;
						sa_generated := false;
					else
						sa <= '0';
						sv <= '0';
						pa <= '0';
						pv <= '0';
					end if;
				when "10" =>
					if cnt mod mod_val_5 = 0 and not(sa_generated) then -- 5ms
						pa <= '1';
						sa_generated := true;
					elsif cnt mod mod_val_25 = 0 then -- 25ms
						sv <= '1';
						cnt:=0;
						sa_generated := false;
					else
						sa <= '0';
						sv <= '0';
						pa <= '0';
						pv <= '0';
					end if;
				when "01" =>
					if cnt mod mod_val_5 = 0 and not(sa_generated) then -- 5ms
						sa <= '1';
						sa_generated := true;
					elsif cnt mod mod_val_25 = 0 then -- 25ms
						pv <= '1';
						cnt:=0;
						sa_generated := false;
					else
						sa <= '0';
						sv <= '0';
						pa <= '0';
						pv <= '0';
					end if;
				when "00" =>
					if cnt mod mod_val_5 = 0 and not(sa_generated) then -- 5ms
						pa <= '1';
						sa_generated := true;
					elsif cnt mod mod_val_25 = 0 then -- 25ms
						pv <= '1';
						cnt:=0;
						sa_generated := false;
					else
						sa <= '0';
						sv <= '0';
						pa <= '0';
						pv <= '0';
					end if;
			end case;
		end if;
	end process;
end behavior;