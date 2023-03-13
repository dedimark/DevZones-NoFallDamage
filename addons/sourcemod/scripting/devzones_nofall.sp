#include <sourcemod>
#include <devzones>
#include <sdkhooks>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "SM DEV ZONES - No Fall Damage", 
	author = "ByDexter", 
	description = "", 
	version = "1.1", 
	url = "https://steamcommunity.com/id/ByDexterTR/"
};

public void OnClientPostAdminCheck(int client)
{
	SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
}

public Action OnTakeDamage(int client, int &attacker, int &inflictor, float &damage, int &damagetype)
{
	if (IsValidClient(client) && Zone_IsClientInZone(client, "nofall") && damagetype & DMG_FALL)
	{
		return Plugin_Handled;
	}
	return Plugin_Continue;
}

bool IsValidClient(int client, bool nobots = true)
{
	if (client <= 0 || client > MaxClients || !IsClientConnected(client) || (nobots && IsFakeClient(client)))
	{
		return false;
	}
	return IsClientInGame(client);
} 