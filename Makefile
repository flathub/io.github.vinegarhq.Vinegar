build:
	flatpak install -y org.freedesktop.Sdk//23.08 org.freedesktop.Platform//23.08 org.freedesktop.Sdk.Extension.golang/x86_64/23.08 org.freedesktop.Sdk.Compat.i386/x86_64/23.08 org.freedesktop.Sdk.Extension.toolchain-i386/x86_64/23.08 org.freedesktop.Sdk.Extension.mingw-w64/x86_64/23.08
	flatpak-builder --ccache --force-clean build-dir io.github.vinegarhq.Vinegar.yml
	flatpak-builder --force-clean --user --install build-dir io.github.vinegarhq.Vinegar.yml
	$(MAKE) post-build
post-build:
	sed -i '5 s/vinegar/discordrpc-wrapper.sh/' ~/.local/share/flatpak/app/io.github.vinegarhq.Vinegar/current/active/export/share/applications/io.github.vinegarhq.Vinegar.app.desktop
	sed -i '4 s/vinegar/discordrpc-wrapper.sh/' ~/.local/share/flatpak/app/io.github.vinegarhq.Vinegar/current/active/export/share/applications/io.github.vinegarhq.Vinegar.desktop
	sed -i '6 s/vinegar/discordrpc-wrapper.sh/' ~/.local/share/flatpak/app/io.github.vinegarhq.Vinegar/current/active/export/share/applications/io.github.vinegarhq.Vinegar.player.desktop
run:
	flatpak run io.github.vinegarhq.Vinegar
clean:
	rm -rf .flatpak-builder
	rm -rf build-dir
uninstall:
	flatpak remove io.github.vinegarhq.Vinegar --delete-data

.PHONY: build run clean uninstall
