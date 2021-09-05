# Suppress-Reboot
Suppress Reboot after the installation of updates

I don't like the default behaviour of the Windows Update Orchestrator. I came up with this small batch file to hinder the Windows Update Orchestrator's reboot task. 

I have the following folders/files copied to some Hyper-V hosts, DC's and File Servers running Windows Server 2019 Standard and DataCenter:

- mkdir C:\Opt
- mkdir C:\Opt\DisableUpdateOrchestratorReboot
- mkdir C:\Opt\DisableUpdateOrchestratorReboot\Log
- mkdir C:\Opt\DisableUpdateOrchestratorReboot\Bin
- copy SuppressRebootWinUpdate.cmd C:\Opt\DisableUpdateOrchestratorReboot
- copy PsExec64.exe C:\Opt\DisableUpdateOrchestratorReboot\Bin
- copy PsExec.exe C:\Opt\DisableUpdateOrchestratorReboot\Bin
- copy Pstools.chm C:\Opt\DisableUpdateOrchestratorReboot\Bin

To disable the Windows Update Orchestrator's reboot task I did execute SuppressRebootWinUpdate.cmd as Administrator. 
This creates two scheduled tasks. One task to keep the reboot task disabled and one to make sure the task is executed during boot. 

The Scheduled Tasks are created in the folder "Suppression" (but feel free to change anything to your liking):
- SuppressRebootWinUpdate
- SuppressRebootWinUpdate-Kick-in-at-System-Start

Please note: 
- PsExec is required and can be acquired at the Sysinternals website: https://download.sysinternals.com/files/PSTools.zip
- Details are here: https://docs.microsoft.com/en-us/sysinternals/downloads/pstools

I am hoping this is helpful. Usage is at the user's own personal risk.
