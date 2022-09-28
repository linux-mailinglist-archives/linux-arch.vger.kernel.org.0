Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AEC5EE657
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 22:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiI1UAq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 16:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiI1UAX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 16:00:23 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C981F620;
        Wed, 28 Sep 2022 12:59:45 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.177]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MwwqB-1pT0TL06W3-00yP2d; Wed, 28 Sep 2022 21:59:20 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 9FB173C184;
        Wed, 28 Sep 2022 21:59:18 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 4051E41C6; Wed, 28 Sep 2022 21:59:16 +0200 (CEST)
Date:   Wed, 28 Sep 2022 21:59:16 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3 5/7] kbuild: unify two modpost invocations
Message-ID: <YzSnlIChHmKdKFt8@bergen.fjasle.eu>
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-6-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EILb05vUvebWtUkL"
Content-Disposition: inline
In-Reply-To: <20220924181915.3251186-6-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:UcXuaPHvMOy396OYrCATBxzmBf4xnt5u4U4lYvYEyKiFKcIjiE1
 Zx3t6HG2Zvm/LfawJhneucj2AT91CEPvWwzyt4PmBiwNu4u6ImtaT+Qd1fDJD8shn8WHDUk
 Y1JwWKECS8si+UUukWwqp6TxRnEbuaU8u3lWrF9TH46BlmuJkJKYVp1VO3GqJXgb+Mpoyjq
 Bbnw/PEfZIERQmf+MfGlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0I95jDAw2sk=:W1GZFxJ1oVO6ksGn0Glr5z
 vaAB2VQwAYZS3DAAbzzN5M09B5dsQGQtRd7/2bXLxkkxPc+5JjPKdx/lyVmWP1xBYoLDV1jQN
 dE45Kd7Rx/eDh/xlAwvHIgbmxAAcusRBvdodDo+11t8I5fSYm9e3Qymxj60ARiQITjcRMNKU5
 x4kDCYJauoJdUSm21/xe9/yVQ4Lsa90qDBq4BmmT/e7fyfWzjof/T76RK5vbR3Qddb/Tye6ro
 KeFlF8WcVXNdsfE1x7Q9UxGmkQljVBGeH73DtGaxWF6hQVKdkWdgYELDKx8yGXZEdOU/QSnzC
 Bs6dgPXK7WTGzjismuCx3YHKGfA5pSUeotGOmqIxWmSd82gzGWcWGZxYzsHXom+xIR8otUMtN
 OVrFZXapgauNnfeCn8UQJcjAy9oJvoxRXMTxrjpGmhCXNnxOl3IiHQSfa90uis6Zl6FO8YLRL
 f9CNEMTzjU54hj/7K7AOsPBK1GeJ2JTU9Eqm5NbaF4z6BUIDHIAuPJ/oeIZo1nvXmBKojym2a
 RxOlb/fElYz4TOwGJ7hUaI5OsIAqs29KM6Om8aLtMQsb50S7ngheG2wYt7E0F0TVVTFPGRmZg
 XuuLqIC8fJXXODK03Hy/ZH0j6p5R3JV/IlqjpvsFZgLed2cd5pnsT9NeiEnzAH4UR4t+lPiXz
 7yKcOjkh/iMLSbrOZFDgWiP5DO0XeOBSyjwjjLmmzYBIDyltt3ktEPiPHTrH7+eCfKKVyp225
 frd0JCSeRY30XDv2hsoDzHybuUc8uEeaCwIBrnwyFFer8yrrRdZVWlpzmvrpxsKbam9hhHeE0
 PMt/QjX
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--EILb05vUvebWtUkL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 25 Sep 2022 03:19:13 +0900 Masahiro Yamada wrote:
> Currently, modpost is executed twice; first for vmlinux, second
> for modules.
>=20
> This commit merges them.
>=20
> Current build flow
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>   1) build obj-y and obj-m objects
>     2) link vmlinux.o
>       3) modpost for vmlinux
>         4) link vmlinux
>           5) modpost for modules
>             6) link modules (*.ko)
>=20
> The build steps 1) through 6) are serialized, that is, modules are
> built after vmlinux. You do not get benefits of parallel builds when
> scripts/link-vmlinux.sh is being run.
>=20
> New build flow
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>   1) build obj-y and obj-m objects
>     2) link vmlinux.o
>       3) modpost for vmlinux and modules
>         4a) link vmlinux
>         4b) link modules (*.ko)
>=20
> In the new build flow, modpost is invoked just once.
>=20
> vmlinux and modules are built in parallel. One exception is
> CONFIG_DEBUG_INFO_BTF_MODULES=3Dy, where modules depend on vmlinux.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> (no changes since v1)
>=20
>  Makefile                  | 30 ++++++++++---
>  scripts/Makefile.modfinal |  2 +-
>  scripts/Makefile.modpost  | 93 ++++++++++++---------------------------
>  scripts/link-vmlinux.sh   |  3 --
>  4 files changed, 53 insertions(+), 75 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index b5dfb54b1993..cf9d7b1d8c14 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1152,7 +1152,7 @@ cmd_link-vmlinux =3D                               =
                  \
>  	$(CONFIG_SHELL) $< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";   =
 \
>  	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
> =20
> -vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
> +vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) modpost FORCE
>  	+$(call if_changed_dep,link-vmlinux)
> =20
>  targets :=3D vmlinux
> @@ -1428,7 +1428,13 @@ endif
>  # Build modules
>  #
> =20
> -modules: $(if $(KBUILD_BUILTIN),vmlinux) modules_prepare
> +# *.ko are usually independent of vmlinux, but CONFIG_DEBUG_INFOBTF_MODU=
LES
> +# is an exception.
> +ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> +modules: vmlinux
> +endif
> +
> +modules: modules_prepare
> =20
>  # Target to prepare building external modules
>  modules_prepare: prepare
> @@ -1741,8 +1747,12 @@ ifdef CONFIG_MODULES
>  $(MODORDER): $(build-dir)
>  	@:
> =20
> -modules: modules_check
> -	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
> +# KBUILD_MODPOST_NOFINAL can be set to skip the final link of modules.
> +# This is solely useful to speed up test compiles.
> +modules: modpost
> +ifneq ($(KBUILD_MODPOST_NOFINAL),1)
> +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
> +endif
> =20
>  PHONY +=3D modules_check
>  modules_check: $(MODORDER)
> @@ -1773,6 +1783,11 @@ KBUILD_MODULES :=3D
> =20
>  endif # CONFIG_MODULES
> =20
> +PHONY +=3D modpost
> +modpost: $(if $(single-build),, $(if $(KBUILD_BUILTIN), vmlinux.o)) \
> +	 $(if $(KBUILD_MODULES), modules_check)
> +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
> +
>  # Single targets
>  # ----------------------------------------------------------------------=
-----
>  # To build individual files in subdirectories, you can do like this:
> @@ -1792,16 +1807,19 @@ single-ko :=3D $(sort $(filter %.ko, $(MAKECMDGOA=
LS)))
>  single-no-ko :=3D $(filter-out $(single-ko), $(MAKECMDGOALS)) \
>  		$(foreach x, o mod, $(patsubst %.ko, %.$x, $(single-ko)))
> =20
> -$(single-ko): single_modpost
> +$(single-ko): single_modules
>  	@:
>  $(single-no-ko): $(build-dir)
>  	@:
> =20
>  # Remove MODORDER when done because it is not the real one.
>  PHONY +=3D single_modpost

PHONY +=3D single_modules

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> -single_modpost: $(single-no-ko) modules_prepare
> +single_modules: $(single-no-ko) modules_prepare
>  	$(Q){ $(foreach m, $(single-ko), echo $(extmod_prefix)$m;) } > $(MODORD=
ER)
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
> +ifneq ($(KBUILD_MODPOST_NOFINAL),1)
> +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
> +endif
>  	$(Q)rm -f $(MODORDER)
> =20
>  single-goals :=3D $(addprefix $(build-dir)/, $(single-no-ko))
> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> index 35100e981f4a..a3cf9e3647c9 100644
> --- a/scripts/Makefile.modfinal
> +++ b/scripts/Makefile.modfinal
> @@ -55,7 +55,7 @@ if_changed_except =3D $(if $(call newer_prereqs_except,=
$(2))$(cmd-check),      \
>  	printf '%s\n' 'cmd_$@ :=3D $(make-cmd)' > $(dot-target).cmd, @:)
> =20
>  # Re-generate module BTFs if either module's .ko or vmlinux changed
> -$(modules): %.ko: %.o %.mod.o scripts/module.lds $(if $(KBUILD_BUILTIN),=
vmlinux) FORCE
> +$(modules): %.ko: %.o %.mod.o scripts/module.lds $(and $(CONFIG_DEBUG_IN=
FO_BTF_MODULES),$(KBUILD_BUILTIN),vmlinux) FORCE
>  	+$(call if_changed_except,ld_ko_o,vmlinux)
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  	+$(if $(newer-prereqs),$(call cmd,btf_ko))
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 04ad00917b2f..2daf760eeb25 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -32,9 +32,6 @@
>  # Step 4 is solely used to allow module versioning in external modules,
>  # where the CRC of each module is retrieved from the Module.symvers file.
> =20
> -# KBUILD_MODPOST_NOFINAL can be set to skip the final link of modules.
> -# This is solely useful to speed up test compiles
> -
>  PHONY :=3D __modpost
>  __modpost:
> =20
> @@ -45,24 +42,23 @@ MODPOST =3D scripts/mod/modpost								\
>  	$(if $(CONFIG_MODVERSIONS),-m)							\
>  	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
>  	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)					\
> +	$(if $(KBUILD_NSDEPS),-d $(MODULES_NSDEPS))					\
> +	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-=
N)	\
>  	-o $@
> =20
> -ifdef MODPOST_VMLINUX
> -
> -quiet_cmd_modpost =3D MODPOST $@
> -      cmd_modpost =3D $(MODPOST) $<
> -
> -vmlinux.symvers: vmlinux.o
> -	$(call cmd,modpost)
> +# 'make -i -k' ignores compile errors, and builds as many modules as pos=
sible.
> +ifneq ($(findstring i,$(filter-out --%,$(MAKEFLAGS))),)
> +MODPOST +=3D -n
> +endif
> =20
> -__modpost: vmlinux.symvers
> +ifeq ($(KBUILD_EXTMOD),)
> =20
>  # Generate the list of in-tree objects in vmlinux
>  # ----------------------------------------------------------------------=
-----
> =20
>  # This is used to retrieve symbol versions generated by genksyms.
>  ifdef CONFIG_MODVERSIONS
> -vmlinux.symvers: .vmlinux.objs
> +vmlinux.symvers Module.symvers: .vmlinux.objs
>  endif
> =20
>  # Ignore libgcc.a
> @@ -83,24 +79,12 @@ targets +=3D .vmlinux.objs
>  .vmlinux.objs: $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
>  	$(call if_changed,vmlinux_objs)
> =20
> -else
> -
> -ifeq ($(KBUILD_EXTMOD),)
> -
> -input-symdump :=3D vmlinux.symvers
> -output-symdump :=3D modules-only.symvers
> -
> -quiet_cmd_cat =3D GEN     $@
> -      cmd_cat =3D cat $(real-prereqs) > $@
> -
> -ifneq ($(wildcard vmlinux.symvers),)
> -
> -__modpost: Module.symvers
> -Module.symvers: vmlinux.symvers modules-only.symvers FORCE
> -	$(call if_changed,cat)
> -
> -targets +=3D Module.symvers
> +vmlinux.o-if-present :=3D $(wildcard vmlinux.o)
> +output-symdump :=3D vmlinux.symvers
> =20
> +ifdef KBUILD_MODULES
> +output-symdump :=3D $(if $(vmlinux.o-if-present), Module.symvers, module=
s-only.symvers)
> +missing-input :=3D $(filter-out $(vmlinux.o-if-present),vmlinux.o)
>  endif
> =20
>  else
> @@ -112,56 +96,35 @@ src :=3D $(obj)
>  # Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
>  include $(or $(wildcard $(src)/Kbuild), $(src)/Makefile)
> =20
> -# modpost option for external modules
> -MODPOST +=3D -e
> -
> -input-symdump :=3D Module.symvers $(KBUILD_EXTRA_SYMBOLS)
> +module.symvers-if-present :=3D $(wildcard Module.symvers)
>  output-symdump :=3D $(KBUILD_EXTMOD)/Module.symvers
> +missing-input :=3D $(filter-out $(module.symvers-if-present), Module.sym=
vers)
> =20
> -endif
> -
> -existing-input-symdump :=3D $(wildcard $(input-symdump))
> -
> -# modpost options for modules (both in-kernel and external)
> -MODPOST +=3D \
> -	$(addprefix -i ,$(existing-input-symdump)) \
> -	$(if $(KBUILD_NSDEPS),-d $(MODULES_NSDEPS)) \
> -	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-=
N)
> -
> -# 'make -i -k' ignores compile errors, and builds as many modules as pos=
sible.
> -ifneq ($(findstring i,$(filter-out --%,$(MAKEFLAGS))),)
> -MODPOST +=3D -n
> -endif
> +MODPOST +=3D -e $(addprefix -i ,$(module.symvers-if-present) $(KBUILD_EX=
TRA_SYMBOLS))
> =20
> -# Clear VPATH to not search for *.symvers in $(srctree). Check only $(ob=
jtree).
> -VPATH :=3D
> -$(input-symdump):
> -	@echo >&2 'WARNING: Symbol version dump "$@" is missing.'
> -	@echo >&2 '         Modules may not have dependencies or modversions.'
> -	@echo >&2 '         You may get many unresolved symbol warnings.'
> +endif # ($(KBUILD_EXTMOD),)
> =20
> -# KBUILD_MODPOST_WARN can be set to avoid error out in case of undefined=
 symbols
> -ifneq ($(KBUILD_MODPOST_WARN)$(filter-out $(existing-input-symdump), $(i=
nput-symdump)),)
> +ifneq ($(KBUILD_MODPOST_WARN)$(missing-input),)
>  MODPOST +=3D -w
>  endif
> =20
> +modorder-if-needed :=3D $(if $(KBUILD_MODULES), $(MODORDER))
> +
>  # Read out modules.order to pass in modpost.
>  # Otherwise, allmodconfig would fail with "Argument list too long".
>  quiet_cmd_modpost =3D MODPOST $@
> -      cmd_modpost =3D sed 's/ko$$/o/' $< | $(MODPOST) -T -
> -
> -$(output-symdump): $(MODORDER) $(input-symdump) FORCE
> -	$(call if_changed,modpost)
> +      cmd_modpost =3D \
> +	$(if $(missing-input), \
> +		echo >&2 "WARNING: $(missing-input) is missing."; \
> +		echo >&2 "         Modules may not have dependencies or modversions.";=
 \
> +		echo >&2 "         You may get many unresolved symbol warnings.";) \
> +	sed 's/ko$$/o/' $(or $(modorder-if-needed), /dev/null) | $(MODPOST) $(v=
mlinux.o-if-present) -T -
> =20
>  targets +=3D $(output-symdump)
> +$(output-symdump): $(modorder-if-needed) $(vmlinux.o-if-present) $(moudl=
e.symvers-if-present) FORCE
> +	$(call if_changed,modpost)
> =20
>  __modpost: $(output-symdump)
> -ifneq ($(KBUILD_MODPOST_NOFINAL),1)
> -	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
> -endif
> -
> -endif
> -
>  PHONY +=3D FORCE
>  FORCE:
> =20
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 07486f90d5e2..6a197d8a88ac 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -214,9 +214,6 @@ if [ "$1" =3D "clean" ]; then
>  	exit 0
>  fi
> =20
> -# modpost vmlinux.o to check for section mismatches
> -${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=3D1
> -
>  info MODINFO modules.builtin.modinfo
>  ${OBJCOPY} -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
>  info GEN modules.builtin
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--EILb05vUvebWtUkL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmM0p44ACgkQB1IKcBYm
EmmJYhAArH4TmGCzpTNlS7pfLHE1VH/++XXiwYjhzHtCdybjnHbhkuVpZESGM69C
2669XuWTJDH2JpbEIF29rqvZTvgl9Z4ZFXhZWUJVXmuxLSsg0y6qvz57lpmAoRkh
DnybSgrHBPtuctcc+9rktIbhb5QwI8OCUEwrz4WYZHy8V5Qr+RYuKxFbvehV4sNp
9hD9HO08tX+uTF9W8kzDU++MbcjK1uLdfSisuia9+HMVR3LyDWqIoiGFKsyOOTA0
4fH/RtvZn76ZBm21X1BZxxTG1cmMYZga2VSWg29wqgwCeFkz3hbS57myLZOuHU3F
c+sha8SlRW/WwISdAOhNYVF8UC6iIq6VO2zvUAAMgpQ2Xri77/t+lzXAlt8HaXY7
EJqm+KEQSyND96WpoxndVf3FsNqgmGoAuqIckldi8/MPD7E0wKtj4pcSjhs/dhSh
ua1Ok9rJWcbxrYunJbXVZKuoUeeGZoJLsiNEsAEiQmLielRYJ7o9BraiYC8RMtSF
ID+aNvl2mxuTLcu7ioPySAdtS5gOuZD5iCtzUWl1DMgtbGQgkOBb/9sHnK0fXWgd
669PnNwtdXO5L4+vgs+Mu536gnf7F/6xz3OdaQDLL+SfFrTnSMCTlY6jnbWAFq6P
C+PkIJC053o0jBgC46HxS+hgn2p1YM6QR4lCO3+02cbEJoZQqZw=
=SSrz
-----END PGP SIGNATURE-----

--EILb05vUvebWtUkL--
