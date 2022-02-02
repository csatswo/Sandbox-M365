# Sandbox-M365
### Windows Sandbox legacy configuration files for a disposable M365 management computer
##### Updated for 21H2

Sandbox currently requires an abosulte path for the Host Folder.  The `Sandbox-M365.wsb` file will need to updated to reflect the correct path.

```xml
   <MappedFolder>
     <HostFolder>%PathToFolder%\Sandbox-M365</HostFolder>
```

For example:

```xml
   <MappedFolder>
     <HostFolder>C:\Users\csatswo\Documents\Sandbox-M365</HostFolder>
```

The folder defined for the guest machine needs the match the path used for the Logon Command.

For example:

```xml
   <SandboxFolder>C:\Sandbox-M365</SandboxFolder> 
```

```xml
   <Command>C:\Sandbox-M365\Sandbox-M365.cmd</Command>
```
