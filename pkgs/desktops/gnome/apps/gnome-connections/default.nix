{ lib
, stdenv
, fetchurl
, meson
, ninja
, pkg-config
, vala
, gettext
, itstool
, appstream-glib
, desktop-file-utils
, wrapGAppsHook
, glib
, gtk3
, libhandy
, libsecret
, libxml2
, gtk-vnc
, gtk-frdp
, gnome
}:

stdenv.mkDerivation rec {
  pname = "gnome-connections";
  version = "45.0";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${lib.versions.major version}/${pname}-${version}.tar.xz";
    hash = "sha256-ufq1JbkKPifRE8FvuGjCucR7+BSTENFNuGLqGRLAb7g=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    vala
    gettext
    itstool
    appstream-glib
    desktop-file-utils
    glib # glib-compile-resources
    wrapGAppsHook
  ];

  buildInputs = [
    glib
    gtk-vnc
    gtk3
    libhandy
    libsecret
    libxml2
    gtk-frdp
  ];

  passthru = {
    updateScript = gnome.updateScript {
      packageName = pname;
    };
  };

  meta = with lib; {
    homepage = "https://gitlab.gnome.org/GNOME/connections";
    description = "A remote desktop client for the GNOME desktop environment";
    mainProgram = "gnome-connections";
    maintainers = teams.gnome.members;
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}
