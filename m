Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F205EE5B3
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 21:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiI1TbB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 15:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiI1Ta5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 15:30:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE330923E8;
        Wed, 28 Sep 2022 12:30:50 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.177]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M7s1M-1oZnHB4Bvu-0050Zc; Wed, 28 Sep 2022 21:30:16 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 14AEF3C004;
        Wed, 28 Sep 2022 21:30:14 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 576D141C6; Wed, 28 Sep 2022 21:30:12 +0200 (CEST)
Date:   Wed, 28 Sep 2022 21:30:12 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3 2/7] kbuild: list sub-directories in ./Kbuild
Message-ID: <YzSgxO21BsKYfRlz@bergen.fjasle.eu>
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-3-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LJduFS1w5/sC0bYM"
Content-Disposition: inline
In-Reply-To: <20220924181915.3251186-3-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:OHeO7k/NrDffZ+eRwfbw7Jw2nPpulxEEzyhoGLVrKN/dJdt9teq
 53nGB/7OgfXFeDeIZoYChlUrM8of95xvFM8fRkLYIzlNtOltnCyjdUbcli3H4DTqR81QOIX
 LkOeClf4B9EsFbdF1NdeQlKQCXbF9dWrCUyM2Qv31BRnRvvX5ltnAUVUUoQWiPgftduGQ6a
 aef7udSk7dCS9E1/UfmzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i8oXOYhivC0=:Fukd8DzUDNo/QrfxqKE+wj
 7d5vaXRaSiLG73JE8x6Aa+sNAekyj+bRFjkICmpvC4bInmzL65FmDenkeuIvh3IIyOJrbsLDa
 oDaVHmsjg0qbd31VC42TzunxVLV7ZG3FsoYbxU53YmhX1eOMkWoDDs8liAi0i4OZ0lvMC7l+1
 wYyysH1d/3+RaD4kSbGsXJ1vyHacP9ovyZu9DqIevRafcy92BbGzd9mBkNLg3/jbp/Qgbt6TY
 Aba4/taOBkI/EhRy/SivxXFeeFPwe4gMdAsRyzHmMr/t7v1s2H3+L/JRG16pePWxAolIdHGmI
 6IKZYNnrCh7tOM7CaUpoPXf7Lx4Xu8mIyMoVFprsjt11oRC2WCuSi2/vx9dPWaA76mX0IGZ27
 xsU/NUPmE2jSN9ZVRb7L5rgsZXzIUcv+N5Weg6BxkVbwBFgEFu9+wJC+o5quwVR8V/kCSriC4
 EBpFMkj7Fbq67bVDZmPd2+q5EegyjCLCEqzpl3LyEJnXAK0SnuJFGqkpuiJ9fxFkIoFFpuGT+
 2zaQOJgLFVuqVrGSAMroByJneFi8pEYxA0VLnr4H7TkJI1yI4PKFSPGZ5vzgoixfzKrjSSrYG
 JpyPrbW3HdySq2pRuA/11jt7zNVRbfJIA856Q42YD1yET9AMlU02gEay+x4VI/982riKvRBiZ
 3Xd7K18aSwLB+f5RsXhgj1H6VROlmKbfWPlTxuwBNg4/vNk6+Keg2uZgdgFlYuxP3BBB1yVhG
 NDKrVouvS6QZ/WDuU8rU8jNJNlDyhbVRvLBidgZZpZV5B06BwfLIe1q3cWYEzeVopddqo0fdt
 i4ttc1W
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--LJduFS1w5/sC0bYM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 25 Sep 2022 03:19:10 +0900 Masahiro Yamada wrote:
> Use the ordinary obj-y syntax to list subdirectories.
>=20
> Note1:
> Previously, the link order of lib-y depended on CONFIG_MODULES; lib-y
> was linked before drivers-y when CONFIG_MODULES=3Dy, otherwise after
> drivers-y. This was a bug of commit 7273ad2b08f8 ("kbuild: link lib-y
> objects to vmlinux forcibly when CONFIG_MODULES=3Dy"), but it was not a
> big deal after all. Now, all objects listed in lib-y are linked last,
> irrespective of CONFIG_MODULES.
>=20
> Note2:
> Finally, the single target build in arch/*/lib/ works correctly. There was
> a bug report about this. [1]
>=20
>   $ make ARCH=3Darm arch/arm/lib/findbit.o
>     CALL    scripts/checksyscalls.sh
>     AS      arch/arm/lib/findbit.o
>=20
> [1]: https://lore.kernel.org/linux-kbuild/YvUQOwL6lD4%2F5%2FU6@shell.arml=
inux.org.uk/
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>=20
> Changes in v3:
>   - Also move libs-y to fix the bug reported by:
>      https://lore.kernel.org/linux-kbuild/20220921043946.GA1355561@roeck-=
us.net/
>=20
>  Kbuild               | 24 ++++++++++++++++
>  Makefile             | 65 ++++++++++++++------------------------------
>  scripts/Makefile.lib |  2 ++
>  3 files changed, 46 insertions(+), 45 deletions(-)
>=20
> diff --git a/Kbuild b/Kbuild
> index 0b9e8a16a621..8a37584d1fd6 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -72,3 +72,27 @@ $(atomic-checks): $(obj)/.checked-%: include/linux/ato=
mic/%  FORCE
>  PHONY +=3D prepare
>  prepare: $(offsets-file) missing-syscalls $(atomic-checks)
>  	@:
> +
> +# Ordinary directory descending
> +# ----------------------------------------------------------------------=
-----
> +
> +obj-y			+=3D init/
> +obj-y			+=3D usr/
> +obj-y			+=3D arch/$(SRCARCH)/
> +obj-y			+=3D $(ARCH_CORE)
> +obj-y			+=3D kernel/
> +obj-y			+=3D certs/
> +obj-y			+=3D mm/
> +obj-y			+=3D fs/
> +obj-y			+=3D ipc/
> +obj-y			+=3D security/
> +obj-y			+=3D crypto/
> +obj-$(CONFIG_BLOCK)	+=3D block/
> +obj-$(CONFIG_IO_URING)	+=3D io_uring/
> +obj-y			+=3D $(ARCH_LIB)
> +obj-y			+=3D drivers/
> +obj-y			+=3D sound/
> +obj-$(CONFIG_SAMPLES)	+=3D samples/
> +obj-$(CONFIG_NET)	+=3D net/
> +obj-y			+=3D virt/
> +obj-y			+=3D $(ARCH_DRIVERS)
> diff --git a/Makefile b/Makefile
> index eb4bbbc898d0..f793c3b1eaec 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -676,11 +676,8 @@ endif
> =20
>  ifeq ($(KBUILD_EXTMOD),)
>  # Objects we will link into vmlinux / subdirs we need to visit
> -core-y		:=3D init/ usr/ arch/$(SRCARCH)/
> -drivers-y	:=3D drivers/ sound/
> -drivers-$(CONFIG_SAMPLES) +=3D samples/
> -drivers-$(CONFIG_NET) +=3D net/
> -drivers-y	+=3D virt/
> +core-y		:=3D
> +drivers-y	:=3D
>  libs-y		:=3D lib/
>  endif # KBUILD_EXTMOD
> =20
> @@ -1099,33 +1096,24 @@ export MODORDER :=3D $(extmod_prefix)modules.order
>  export MODULES_NSDEPS :=3D $(extmod_prefix)modules.nsdeps
> =20
>  ifeq ($(KBUILD_EXTMOD),)
> -core-y			+=3D kernel/ certs/ mm/ fs/ ipc/ security/ crypto/
> -core-$(CONFIG_BLOCK)	+=3D block/
> -core-$(CONFIG_IO_URING)	+=3D io_uring/
> =20
> -vmlinux-dirs	:=3D $(patsubst %/,%,$(filter %/, \
> -		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
> -		     $(libs-y) $(libs-m)))
> -
> -vmlinux-alldirs	:=3D $(sort $(vmlinux-dirs) Documentation . \
> +build-dir	:=3D .
> +clean-dirs	:=3D $(sort . Documentation \
>  		     $(patsubst %/,%,$(filter %/, $(core-) \
>  			$(drivers-) $(libs-))))
> =20
> -build-dirs	:=3D $(vmlinux-dirs)
> -clean-dirs	:=3D $(vmlinux-alldirs)
> -
> -subdir-modorder :=3D $(addsuffix /modules.order, $(build-dirs))
> -
> +export ARCH_CORE	:=3D $(core-y)
> +export ARCH_LIB		:=3D $(filter %/, $(libs-y))
> +export ARCH_DRIVERS	:=3D $(drivers-y) $(drivers-m)
>  # Externally visible symbols (used by link-vmlinux.sh)
> -KBUILD_VMLINUX_OBJS :=3D $(head-y) $(patsubst %/,%/built-in.a, $(core-y))
> -KBUILD_VMLINUX_OBJS +=3D $(addsuffix built-in.a, $(filter %/, $(libs-y)))
> +
> +KBUILD_VMLINUX_OBJS :=3D $(head-y) ./built-in.a
>  ifdef CONFIG_MODULES
>  KBUILD_VMLINUX_OBJS +=3D $(patsubst %/, %/lib.a, $(filter %/, $(libs-y)))
>  KBUILD_VMLINUX_LIBS :=3D $(filter-out %/, $(libs-y))
>  else
>  KBUILD_VMLINUX_LIBS :=3D $(patsubst %/,%/lib.a, $(libs-y))
>  endif
> -KBUILD_VMLINUX_OBJS +=3D $(patsubst %/,%/built-in.a, $(drivers-y))
> =20
>  export KBUILD_VMLINUX_OBJS KBUILD_VMLINUX_LIBS
>  export KBUILD_LDS          :=3D arch/$(SRCARCH)/kernel/vmlinux.lds
> @@ -1140,7 +1128,7 @@ ifdef CONFIG_TRIM_UNUSED_KSYMS
>  # (this can be evaluated only once include/config/auto.conf has been inc=
luded)
>  KBUILD_MODULES :=3D 1
> =20
> -autoksyms_recursive: descend modules.order
> +autoksyms_recursive: $(build-dir) modules.order
>  	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
>  	  "$(MAKE) -f $(srctree)/Makefile autoksyms_recursive"
>  endif
> @@ -1168,7 +1156,7 @@ targets :=3D vmlinux
> =20
>  # The actual objects are generated when descending,
>  # make sure no implicit rule kicks in
> -$(sort $(vmlinux-deps) $(subdir-modorder)): descend ;
> +$(sort $(vmlinux-deps)): $(build-dir) ;
> =20
>  filechk_kernel.release =3D \
>  	echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalver=
sion $(srctree))"
> @@ -1439,13 +1427,6 @@ endif
> =20
>  modules: $(if $(KBUILD_BUILTIN),vmlinux) modules_prepare
> =20
> -cmd_modules_order =3D cat $(real-prereqs) > $@
> -
> -modules.order: $(subdir-modorder) FORCE
> -	$(call if_changed,modules_order)
> -
> -targets +=3D modules.order
> -
>  # Target to prepare building external modules
>  modules_prepare: prepare
>  	$(Q)$(MAKE) $(build)=3Dscripts scripts/module.lds
> @@ -1716,9 +1697,7 @@ else # KBUILD_EXTMOD
>  KBUILD_BUILTIN :=3D
>  KBUILD_MODULES :=3D 1
> =20
> -build-dirs :=3D $(KBUILD_EXTMOD)
> -$(MODORDER): descend
> -	@:
> +build-dir :=3D $(KBUILD_EXTMOD)
> =20
>  compile_commands.json: $(extmod_prefix)compile_commands.json
>  PHONY +=3D compile_commands.json
> @@ -1756,6 +1735,9 @@ PHONY +=3D modules modules_install modules_prepare
> =20
>  ifdef CONFIG_MODULES
> =20
> +$(MODORDER): $(build-dir)
> +	@:
> +
>  modules: modules_check
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
> =20
> @@ -1809,7 +1791,7 @@ single-no-ko :=3D $(filter-out $(single-ko), $(MAKE=
CMDGOALS)) \
> =20
>  $(single-ko): single_modpost
>  	@:
> -$(single-no-ko): descend
> +$(single-no-ko): $(build-dir)
>  	@:
> =20
>  # Remove MODORDER when done because it is not the real one.
> @@ -1819,24 +1801,17 @@ single_modpost: $(single-no-ko) modules_prepare
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
>  	$(Q)rm -f $(MODORDER)
> =20
> -single-goals :=3D $(addprefix $(extmod_prefix), $(single-no-ko))
> -
> -# trim unrelated directories
> -build-dirs :=3D $(foreach d, $(build-dirs), \
> -			$(if $(filter $d/%, $(single-goals)), $d))
> +single-goals :=3D $(addprefix $(build-dir)/, $(single-no-ko))
> =20
>  endif
> =20
> -# Handle descending into subdirectories listed in $(build-dirs)
>  # Preset locale variables to speed up the build process. Limit locale
>  # tweaks to this spot to avoid wrong language settings when running
>  # make menuconfig etc.
>  # Error messages still appears in the original language
> -PHONY +=3D descend $(build-dirs)
> -descend: $(build-dirs)
> -$(build-dirs): prepare
> -	$(Q)$(MAKE) $(build)=3D$@ need-builtin=3D1 need-modorder=3D1 \
> -	$(filter $@/%, $(single-goals))
> +PHONY +=3D $(build-dir)
> +$(build-dir): prepare
> +	$(Q)$(MAKE) $(build)=3D$@ need-builtin=3D1 need-modorder=3D1 $(single-g=
oals)
> =20
>  clean-dirs :=3D $(addprefix _clean_, $(clean-dirs))
>  PHONY +=3D $(clean-dirs) clean
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 3fb6a99e78c4..140dcc3c57bd 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -89,6 +89,7 @@ always-y			+=3D $(dtb-y)
> =20
>  # Add subdir path
> =20
> +ifneq ($(obj),.)
>  extra-y		:=3D $(addprefix $(obj)/,$(extra-y))
>  always-y	:=3D $(addprefix $(obj)/,$(always-y))
>  targets		:=3D $(addprefix $(obj)/,$(targets))
> @@ -100,6 +101,7 @@ multi-obj-m	:=3D $(addprefix $(obj)/, $(multi-obj-m))
>  multi-dtb-y	:=3D $(addprefix $(obj)/, $(multi-dtb-y))
>  real-dtb-y	:=3D $(addprefix $(obj)/, $(real-dtb-y))
>  subdir-ym	:=3D $(addprefix $(obj)/,$(subdir-ym))
> +endif
> =20
>  # Finds the multi-part object the current object will be linked into.
>  # If the object belongs to two or more multi-part objects, list them all.
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--LJduFS1w5/sC0bYM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmM0oL8ACgkQB1IKcBYm
EmkygxAAhp0Ac/Cb/3c0elU6hFQKy/XKpIqdQi8bbC/1/c22Il7lfzMnJqc9Y3BS
sC31ur/ViXYiL0PwTJ+p//UeXccKhE6TriBg9R3GOEdEZrS3T5JbutxWfbxRB3x+
0aUrukvWXrlRiiKhV7TWW30zIwPysvLeHe/pGRLgNbpWnltZmYYJSLEJlT2eFCRP
QRosAtBgXHX57j8cityAoXuj+xgHfL6kGmzhG/w/ZI/VyVttRn2CzOWW9UcJN8//
CVCnZptJ30HpvMkSRHHwblkq7c3x9PJ7lCSxPaNJDs7BssG0zsZov78uegtmvBIS
yRu3dOV/9S7GXiJeUNQoJRuhUg0pt7gBexAHPeZmptZUaugBZUt7Ftmc5TKcfAFY
GY6jhXXePCQUPPsf98lVOkAgkUnbicd0c28OhKW4LbeMOpHzrXFhp/Z6grCdqWg+
HAj/GtPP8y2MLXY+/4CIIbncUQdxeP9O43KR1WezeuTrqAhdlNyceDwtQ1Cyj7+k
XR++eC7OfCeoMr0UocwXnebS2YG6bwUdPYVdqjMal5kdCXiCRS50uakV559X75us
0adbZrca1nvnGx6wV4eUjDxOZcD0DVqg+CmoJyaE1zOxKlvy8G2QOYjsQNYVU4Ry
Q6GrOehyRmyV9v82908cQdYD4b/zlefUam39mqYlkJWCk2XXtnY=
=6h61
-----END PGP SIGNATURE-----

--LJduFS1w5/sC0bYM--
