# Sandbox-M365
### Windows Sandbox configuration files for a disposable M365 management computer
##### Requires update version 2004
Sandbox currently requires an abosulte path for the Host Folder.  The `M365sandbox.wsb` file will need to updated to reflect the correct path.
```
   <MappedFolder>
     <HostFolder>%PathToFolder%\M365Sandbox</HostFolder>
```
For example:
```
   <MappedFolder>
     <HostFolder>C:\Users\csatswo\Documents\M365Sandbox</HostFolder>
```
