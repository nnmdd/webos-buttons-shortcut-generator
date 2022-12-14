# Генератор ярлыков.
позволяет сгенерировать и установить ярлык нужного вам приложения на любую из 4 кнопок пульта:

	ivi 		okko
	кинопоиск	movies
____  
## Список необходимого  

для работы нужен webos-cli который есть внутри Webos SDK minimal (https://webostv.developer.lge.com/develop/tools/sdk-downloading-installer#minimal-installer)  
возможно устанавливать SDK не обязательно, достаточно распаковать webos_cli_tv.zip в удобное место  
файл webos_cli_tv.zip живёт внутри webOS_SDK_TV_win64.zip, который распаковывается из скачанного webOS_SDK_TV_Installer_win64_min.zip.  
больше вложений богу вложений!  
для установки сгенерированного ярлыка нужно добавить телевизор через скрипт ares-setup-device 
____  
## Установка, настройка, использование

для установки генератора распаковать архив а папку в папку CLI\bin из webos_cli_tv.zip.  
перед началом использования нужно отредактировать файл install.cmd указав имя телевизора использованное в ares-setup-device.  
для генерации ярлыков запускать файл constructor.cmd. готовые ярлыки хранятся в папке readyapps, заменяясь при генерации ярлыка с тем же именем.  
для установки сгенерированных ярлыков запускать файл install.cmd  

## Описание структуры

в папке `apps` содержатся профили для запускаемых приложений названные по их id.  
название папки не влияет на то какое приложение будет запускаться, всё определяется содержимым файла index.html, однако название будет фигурировать в имени файла.  
в папке `buttons` профили для 4 кнопок, по 2 на каждую, обычный, такой ярлык не видно в списке установленных приложений и с приставкой visible - такие ярлыки видно в списке  

## Создание своего ярлыка или кнопки

Чтобы приложение `vokino` привязать на любую из 4 кнопок нужно:
1. создать копию папки `lampa` из папки `apps` с названием `vokino`  
2. изменить файл `index.html`, указав id приложения которое планируем запускать.  
id можно подсмотреть в файле `appinfo.json` в папке запускаемого приложения.  
в случае с `vokino` это `/media/developer/apps/usr/palm/applications/vokinotv/appinfo.json` со значением id `vokinotv`  

таким образом в файле index.html строки:
```html
  webOS.service.request("luna://com.webos.applicationManager", {
    method: "launch",
    parameters: { "id": "com.lampa.tv" },
```
нужно изменить на:
```html
   webOS.service.request("luna://com.webos.applicationManager", {
    method: "launch",
    parameters: { "id": "vokinotv" },
```
3. после этого собрать приложение с помощью скрипта, добавленная вами папка появится в списке доступных  

точно так же можно поступить и с кнопками из папки buttons если ваша отсутствует в списке, но тогда нужно менять id приложения в файле appinfo.json  
скрипт динамически строит меню на основании списка папок внутри apps/buttons
