::NobleBannersMod <- {};

::mods_registerMod("mod_noble_banners", 1.0.1, "Noble Banners");
::mods_queue(null, ">mod_msu", function() {
	
	::mods_hookBaseClass("scenarios/world/starting_scenario", function(o) {
		
		local onSpawnPlayer = ::mods_getMember(o, "onSpawnPlayer")
		::mods_override(o, "onSpawnPlayer", function() {
			onSpawnPlayer();
			
			local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
			local northMost = null;
			local houses = [];
			
			foreach (n in nobles)
			{
				local house = {
					Faction = n,
					North = 0
				}
				local maxY = 0;
				foreach (s in n.getSettlements())
				{
					if (s.getTile().Coords.Y > house.North)
					{
						house.North = s.getTile().Coords.Y;
					}
				}
				
				houses.push(house);
			}
			
			houses.sort(function ( _a, _b )
			{
				if (_a.North > _b.North)
				{
					return -1;
				}
				else if (_a.North < _b.North)
				{
					return 1;
				}

				return 0;
			});
			
			local northBanners = [2, 6, 8];
			local middleBanners = [3, 5,7];
			local southBanners = [4, 9, 10];
			
			logInfo("banners");
			
			houses[0].Faction.setBanner(northBanners[this.Math.rand(0, northBanners.len() - 1)]);
			houses[1].Faction.setBanner(middleBanners[this.Math.rand(0, middleBanners.len() - 1)]);
			houses[2].Faction.setBanner(southBanners[this.Math.rand(0, southBanners.len() - 1)]);
			
		});
		
		
	});
	
});