# itlwm

**An Intel Wi-Fi Adapter Kernel Extension for macOS, based on the OpenBSD Project.**

## Documentation

We highly recommend exploring our documentation before using this Kernel Extension:

- [Intro](https://OpenIntelWireless.github.io/itlwm)
- [Compatibility](https://openintelwireless.github.io/itlwm/Compat)
- [FAQ](https://openintelwireless.github.io/itlwm/FAQ)

## AirportItlwm no macOS 26 Tahoe

Este fork oferece suporte experimental ao macOS Tahoe 26.x em computadores
`x86_64`, usando a interface Wi-Fi nativa do macOS.

- O Wi-Fi 6 (802.11ax/HE) vem desativado por padrão. Adicione `itlwm_he=1` aos
  argumentos de inicialização para ativá-lo em adaptadores compatíveis.
- WPA2-Personal e redes de transição WPA2/WPA3 com PMF opcional são suportadas.
- WPA3 exclusivo, PMF obrigatório, AWDL/AirDrop e MLO não são suportados.
- A compatibilidade depende do adaptador Intel utilizado e ainda pode exigir
  testes específicos no Tahoe.

### Baixar a versão compilada

Baixe o arquivo ZIP mais recente na página de
[Releases deste fork](https://github.com/maxpicelli/itlwm/releases). Extraia o
ZIP antes de adicionar `AirportItlwm.kext` à pasta `EFI/OC/Kexts`.

### Comandos por dois cliques

Os arquivos `.command` da pasta `scripts` podem ser executados com dois cliques
pelo Finder. O macOS abrirá o Terminal e executará o processo automaticamente.
Se o sistema bloquear o arquivo na primeira execução, clique nele com o botão
direito e selecione **Abrir**.

#### Atualizar o fork

Abra `scripts/update_fork.command` para buscar as atualizações do projeto
original, mesclá-las na branch `main` local e enviá-las para o seu fork no
GitHub. Antes de executar, confirme que está na branch `main` e que não existem
alterações rastreadas aguardando commit.

Pelo Terminal, o comando equivalente é:

```sh
./scripts/update_fork.command
```

#### Criar a release localmente

Pré-requisitos:

- macOS com processador Intel (`x86_64`);
- Xcode instalado pela App Store;
- ferramentas de linha de comando do Xcode;
- Git e Python 3.

Instale as ferramentas de linha de comando, caso ainda não estejam presentes:

```sh
xcode-select --install
```

Clone este fork e entre na pasta do projeto:

```sh
git clone https://github.com/maxpicelli/itlwm.git
cd itlwm
```

Baixe o MacKernelSDK dentro da raiz do projeto e selecione exatamente a revisão
utilizada por esta versão:

```sh
git clone https://github.com/acidanthera/MacKernelSDK.git MacKernelSDK
git -C MacKernelSDK checkout 3f750085caa17ec3a7880f11c11bf4f48cd6a164
```

Abra `scripts/criar_release.command` para compilar o AirportItlwm para o macOS
Tahoe em modo Release. O script cria o ZIP na pasta `artifacts` e abre o Finder
mostrando o arquivo pronto.

Pelo Terminal, o comando equivalente é:

```sh
./scripts/criar_release.command
```

O ZIP terá um nome semelhante a:

```text
AirportItlwm-Tahoe-v2.4.0-RELEASE-ptbr-29a693c.zip
```

O `MacKernelSDK` e a pasta `artifacts` estão no `.gitignore`, portanto não serão
incluídos acidentalmente nos commits.

### Compilação manual

Como alternativa ao script, compile pelo Terminal:

```sh
xcodebuild -project itlwm.xcodeproj -scheme AirportItlwm-Tahoe \
  -configuration Release ARCHS=x86_64 CODE_SIGNING_ALLOWED=NO build
```

Ao final, procure por `** BUILD SUCCEEDED **`. O arquivo gerado estará em uma
pasta semelhante a:

```text
~/Library/Developer/Xcode/DerivedData/itlwm-*/Build/Products/Release/Tahoe/AirportItlwm.kext
```

## Download

[![Download from https://github.com/OpenIntelWireless/itlwm/releases](https://img.shields.io/github/v/release/OpenIntelWireless/itlwm?label=Download)](https://github.com/OpenIntelWireless/itlwm/releases)

## Questions and Issues

Check out our [FAQ Page](https://openintelwireless.github.io/itlwm/FAQ) for more info.

If you have other questions or feedback, feel free to [![Join the chat at https://gitter.im/OpenIntelWireless/itlwm](https://badges.gitter.im/OpenIntelWireless/itlwm.svg)](https://gitter.im/OpenIntelWireless/itlwm?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge).

We only accept bug reports in GitHub Issues, before opening an issue, you're recommended to reconfirm it with us on [Gitter](https://gitter.im/OpenIntelWireless/itlwm); once it's confirmed, please use the provided issue template.

## Credits

- [Acidanthera](https://github.com/acidanthera) for [MacKernelSDK](https://github.com/acidanthera/MacKernelSDK)
- [Apple](https://www.apple.com) for [macOS](https://www.apple.com/macos)
- [AppleIntelWiFi](https://github.com/AppleIntelWiFi) for [Black80211-Catalina](https://github.com/AppleIntelWiFi/Black80211-Catalina)
- [ErrorErrorError](https://github.com/ErrorErrorError) for UserClient bug fixes
- [Intel](https://www.intel.com) for [Wireless Adapter Firmwares](https://www.intel.com/content/www/us/en/support/articles/000005511/network-and-io/wireless.html) and [iwlwifi](https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi)
- [Linux](https://www.kernel.org) for [iwlwifi](https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi)
- [mercurysquad](https://github.com/mercurysquad) for [Voodoo80211](https://github.com/mercurysquad/Voodoo80211)
- [OpenBSD](https://openbsd.org) for [net80211, iwn, iwm, and iwx](https://github.com/openbsd/src)
- [pigworlds](https://github.com/OpenIntelWireless/itlwm/commits?author=pigworlds) for DVM devices support, MIRA bug fixes, and Tx aggregation for MVM Gen 1 devices
- [rpeshkov](https://github.com/rpeshkov) for [black80211](https://github.com/rpeshkov/black80211)
- [usr-sse2](https://github.com/usr-sse2) for implementing the usage of Apple RSN Supplicant and bug fixes
- [zxystd](https://github.com/zxystd) for developing [itlwm](https://github.com/OpenIntelWireless/itlwm)

## Acknowledgements

- [@penghubingzhou](https://github.com/startpenghubingzhou)
- [@Bat.bat](https://github.com/williambj1)
- [@iStarForever](https://github.com/XStar-Dev)
- [@stevezhengshiqi](https://github.com/stevezhengshiqi)
- [@DogAndPot](https://github.com/DogAndPot) for providing resources and help for system configuration
- [@Daliansky](https://github.com/Daliansky) for providing Wi-Fi cards
