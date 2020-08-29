// ------ #include ------ //

#include <sourcemod>
#include <devzones>
#include <multicolors>
#include <sdkhooks>

// ------ #pragma ------ //

#pragma semicolon 1
#pragma newdecls required

// ------ myinfo ------ //

public Plugin myinfo = 
{
	name = "SM DEV ZONES - No Fall Damage",
	author = "ByDexter",
	description = "",
	version = "1.0",
	url = "https://steamcommunity.com/id/ByDexterTR/"
};

public void OnClientDisconnect(int client)
{
	SDKUnhook(client, SDKHook_OnTakeDamage, OnTakeDamage);
}

public void Zone_OnClientEntry(int client, const char[] zone)
{
	if(client < 1 || client > MaxClients || !IsClientInGame(client) ||!IsPlayerAlive(client)) 
		return;
		
	if(StrContains(zone, "nofall", false) == 0)
	{
		SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
		CPrintToChat(client, "{darkred}[ByDexter] {green}nofall bölgesine {default}girdiniz.");
	}
}

public void Zone_OnClientLeave(int client, const char[] zone)
{
	if(StrContains(zone, "nofall", false) == 0)
	{
		SDKUnhook(client, SDKHook_OnTakeDamage, OnTakeDamage);
		CPrintToChat(client, "{darkred}[ByDexter] {green}nofall bölgesinden {default}ayrıldınız.");
	}
}

public Action OnTakeDamage(int client, int &attacker, int &inflictor, float &damage, int &damagetype) 
{
	if (damagetype & DMG_FALL)
	{
		CPrintToChat(client, "{darkred}[ByDexter] {green}nofall bölgesinde {default}olduğunuz için {darkblue}fall damage yemediniz.");
		return Plugin_Handled;
	}
	return Plugin_Continue;
}