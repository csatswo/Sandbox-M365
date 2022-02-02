### Windows Sandbox configuration files for a disposable M365 management computer
##### Legacy version for Windows 1909

Sandbox requires an abosulte path for the Host Folder.  The `Sandbox-M365v1909.wsb` file will need to updated to reflect the correct path.

```xml
   <MappedFolder>
     <HostFolder>%PathToFolder%\Sandbox-M365\v1909</HostFolder>
```
For example:

```xml
   <MappedFolder>
     <HostFolder>C:\Users\csatswo\Documents\Sandbox-M365\v1909</HostFolder>
```
