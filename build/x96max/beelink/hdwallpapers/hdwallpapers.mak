$(call MOD.APK,vendor,Backgrounds_HD_Wallpapers.apk,Огромная бесплатная коллекция красивых фонов)

# Добавим в установку минимальный набор красивых картинок
define INSTALL +=
	cp $(DIR)99-hdwallpapers $/vendor/etc/init.d
	mkdir -p $/vendor/app/Backgrounds_HD_Wallpapers/Wallpapers
	cp -a ingredients/wallpapers/* $/vendor/app/Backgrounds_HD_Wallpapers/Wallpapers/
	$(foreach _,$(wildcard ingredients/wallpapers/*),\
		tools/img-perm -m 0644 -c u:object_r:vendor_app_file:s0 $/vendor/app/Backgrounds_HD_Wallpapers/Wallpapers/$(notdir $_)$(NL))
endef
