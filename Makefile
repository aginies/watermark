.PHONY: build

build:
	flatpak install -y flathub org.flatpak.Builder
	flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpak
	flatpak run org.flatpak.Builder \
		--force-clean \
		--install \
		--install-deps-from=flathub \
		--ccache \
		--mirror-screenshots-url=https://dl.flathub.org/media/ \
		--user \
		--repo=repo \
		builddir \
		io.github.aginies.watermark.yml

localbuild:
	flatpak install -y flathub org.flatpak.Builder
	flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpak
	flatpak run org.flatpak.Builder \
                --force-clean \
                --install \
                --install-deps-from=flathub \
                --ccache \
                --mirror-screenshots-url=https://dl.flathub.org/media/ \
                --user \
                --repo=repo_local \
                builddir_local \
		io.github.aginies.watermark_local.yml

lint:
	flatpak run --command=flatpak-builder-lint \
	       	org.flatpak.Builder manifest io.github.aginies.watermark.yml

run:
	flatpak run io.github.aginies.watermark

json:
	flatpak_pip_generator --requirements-file=requirements.txt

trans:
	xgettext --language=Python --keyword=_ -o locale/watermark_app_gtk_new.pot watermark_app_gtk.py
	cp -av locale/watermark_app_gtk.pot locale/fr/LC_MESSAGES/watermark_app_gtk.po
	cp -av locale/watermark_app_gtk.pot locale/es/LC_MESSAGES/watermark_app_gtk.po

trans2:
	msgfmt locale/fr/LC_MESSAGES/watermark_app_gtk.po -o locale/fr/LC_MESSAGES/watermark_app_gtk.mo
	msgfmt locale/es/LC_MESSAGES/watermark_app_gtk.po -o locale/es/LC_MESSAGES/watermark_app_gtk.mo
