Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795065EE5C4
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 21:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbiI1Tft (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 15:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiI1Tfo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 15:35:44 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94F92C64D;
        Wed, 28 Sep 2022 12:35:38 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.177]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MVe5c-1olMZw2jRs-00RW05; Wed, 28 Sep 2022 21:35:12 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 5E4DE3C004;
        Wed, 28 Sep 2022 21:35:11 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 1BEBB41C6; Wed, 28 Sep 2022 21:35:11 +0200 (CEST)
Date:   Wed, 28 Sep 2022 21:35:11 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3 3/7] kbuild: move .vmlinux.objs rule to
 Makefile.modpost
Message-ID: <YzSh78fbBg8Oi4EB@bergen.fjasle.eu>
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-4-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SAODo2KDIrZTTBHq"
Content-Disposition: inline
In-Reply-To: <20220924181915.3251186-4-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:G4jAdtHaoQb+4jZJsvDBO1i7fZZ8Av+ySsafo1u4O94qejklpye
 /UeKrLQ8NKX6DWhR1GSILLFYDi3id2RCxYoBWoU1q0RojjwWKdrU8pwr0qY4iC9kTxuFmep
 LVWUX+YGJb5Z9+WWYXuA9LYNocybwn9aE6NMdIf4OEXmTF4zuJzsrhDmZrEhgfuv/mlQL2s
 A8cYVaib7rWuvmyCEHvhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t0HwOX5b+Dg=:GdIUI25tjD9swDS4VXnjwO
 lhcjw+3y3410DdT3LXpEo2fl7cuEx9JeuviHYnZYD/V8uhT/x/wuOb8vkpwWzCdJcyfGAWRiq
 Hz8cwQZ5duGyWtl0NXR613Ths+n3sGGCzA4x4Qsvd/y23jWyhRY66bmfhE8xWjJOLoG5MbbGb
 Nx0z/gYodGIsgbxjDno0TX9g8APgLDJcvwTgrwPIS+qEjEQUjJNwZgL2dSh5ymZBZLzaNDKB9
 IWbKPrbHKFOKHQ89PUt/Qns1kJzoBcxEAR+cYvNdUVrXGvptDk6HUjpflA5Z2OpprpDnJynbP
 fYl7ru/oW6tHQL/S1lIVKv1q0RqyV8JVxlrgPq1LAAG/hZ7m/g4pPGni9nAu7XiVfbs/OYWOD
 TuMaPtIbCu89Gac18+QCq7iQxK+aE3hcbRSB2LlC/K0sImBhLBmQ3MKP/kkxClkXmCO4vRsk1
 lFWevwHP+7T101j9TyUwjM/vIjZRuTVwhKl4msmBLiMtMQDtfhjKjwnVDChtawDn/F+pkCbht
 7o7mOLNEhhWboLEXh76jW3q4n1+cYRGSZuc8vmceyL91frPzzvcUXsdnHpP5nldGg1j2QWoXb
 zG0YYstz+Gj67sGoTqjC0/8LRJbzk7CPbk5KSa9DYcKG87R8uUSMRPKZHr4EHDwuwX7egw4KS
 SOPbB7aJbTPSuMCC4q4TgFIBuMmvIlEam3TJtZbKIEiWnUFdaI2kL33ZsF5IDCmSh4tlHWijk
 qMFDI/wRBfwYPQdvT0gW2rjKyJjRaIDziphlc3wL6Mf4GCsU2JfNOHLq543URhq71zP6KISQA
 5nL9GMC
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--SAODo2KDIrZTTBHq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 25 Sep 2022 03:19:11 +0900 Masahiro Yamada wrote:
> .vmlinux.objs is used by modpost, so scripts/Makefile.modpost is
> a better place to generate it.
>=20
> It is used only when CONFIG_MODVERSIONS=3Dy. It should be guarded
> by "ifdef CONFIG_MODVERSIONS".
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> (no changes since v1)
>=20
>  Makefile                 |  2 +-
>  scripts/Makefile.modpost | 30 ++++++++++++++++++++++++++++--
>  scripts/link-vmlinux.sh  | 18 ------------------
>  3 files changed, 29 insertions(+), 21 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index f793c3b1eaec..92413b6de451 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1477,7 +1477,7 @@ endif # CONFIG_MODULES
>  # Directories & files removed with 'make clean'
>  CLEAN_FILES +=3D include/ksym vmlinux.symvers modules-only.symvers \
>  	       modules.builtin modules.builtin.modinfo modules.nsdeps \
> -	       compile_commands.json .thinlto-cache
> +	       compile_commands.json .thinlto-cache .vmlinux.objs
> =20
>  # Directories & files removed with 'make mrproper'
>  MRPROPER_FILES +=3D include/config include/generated          \
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 911606496341..04ad00917b2f 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -57,6 +57,32 @@ vmlinux.symvers: vmlinux.o
> =20
>  __modpost: vmlinux.symvers
> =20
> +# Generate the list of in-tree objects in vmlinux
> +# ----------------------------------------------------------------------=
-----
> +
> +# This is used to retrieve symbol versions generated by genksyms.
> +ifdef CONFIG_MODVERSIONS
> +vmlinux.symvers: .vmlinux.objs
> +endif
> +
> +# Ignore libgcc.a
> +# Some architectures do '$(CC) --print-libgcc-file-name' to borrow libgc=
c.a
> +# from the toolchain, but there is no EXPORT_SYMBOL in it.
> +
> +quiet_cmd_vmlinux_objs =3D GEN     $@
> +      cmd_vmlinux_objs =3D		\
> +	for f in $(real-prereqs); do	\
> +		case $${f} in		\
> +		*libgcc.a) ;;		\
> +		*.a) $(AR) t $${f} ;;	\
> +		*) echo $${f} ;;	\
> +		esac			\
> +	done > $@
> +
> +targets +=3D .vmlinux.objs
> +.vmlinux.objs: $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
> +	$(call if_changed,vmlinux_objs)
> +
>  else
> =20
>  ifeq ($(KBUILD_EXTMOD),)
> @@ -134,6 +160,8 @@ ifneq ($(KBUILD_MODPOST_NOFINAL),1)
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
>  endif
> =20
> +endif
> +
>  PHONY +=3D FORCE
>  FORCE:
> =20
> @@ -141,6 +169,4 @@ existing-targets :=3D $(wildcard $(sort $(targets)))
> =20
>  -include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
> =20
> -endif
> -
>  .PHONY: $(PHONY)
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 8d982574145a..161bca64e8aa 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -199,7 +199,6 @@ cleanup()
>  	rm -f System.map
>  	rm -f vmlinux
>  	rm -f vmlinux.map
> -	rm -f .vmlinux.objs
>  	rm -f .vmlinux.export.c
>  }
> =20
> @@ -218,23 +217,6 @@ fi
>  #link vmlinux.o
>  ${MAKE} -f "${srctree}/scripts/Makefile.vmlinux_o"
> =20
> -# Generate the list of in-tree objects in vmlinux
> -#
> -# This is used to retrieve symbol versions generated by genksyms.
> -for f in ${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}; do
> -	case ${f} in
> -	*libgcc.a)
> -		# Some architectures do '$(CC) --print-libgcc-file-name' to
> -		# borrow libgcc.a from the toolchain.
> -		# There is no EXPORT_SYMBOL in external objects. Ignore this.
> -		;;
> -	*.a)
> -		${AR} t ${f} ;;
> -	*)
> -		echo ${f} ;;
> -	esac
> -done > .vmlinux.objs
> -
>  # modpost vmlinux.o to check for section mismatches
>  ${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=3D1
> =20
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--SAODo2KDIrZTTBHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmM0oe4ACgkQB1IKcBYm
EmkSdQ/+JjtFAyePNDxsvNjCS+8bUzfBzfy8g9w6F9PDpddYhq5EU7uq6rpxMAUT
3cIDwhMXJddtWOkPhIXVVZ5xDSWhwdcDPEjzgvz/NAHMaf57V9utWVN4gg1ZXSyR
FoDZpghZxPp0LvJIS040Ofj7ZcCfXdarJ87MlrVRc+wHA6fjguij/4M1ksit1hmV
yVn++6rmkvbybcZyYQzBTKedMAJ0V96FwxUg8CWXV2+S+tEd2LfIo5prRJ3JsATY
zsm6hoSh+GQXRNYoUbqA7NdpegbNW1u74nTAxRExJyf3X9M3B/FJWgJn0a5KAaGm
pnPbG02RwFcQVMO3ITNZHA+d3KKDkhcC2akDEQlWH3EWt32WDLwsrTxNG/VznEU/
cimGbfcochTmny5gy/q4m3X/aKpnbwojYauQGixzAOblZ59mZmcxL83TibJN45Dk
t+CodbNdXf5ymNqwINDr5kST43kJ/Y9/rFkyqZ6WqX2XpT9g/g/K9TUXYQbFoIpR
uycFlQP09kT4jYFmbi+zR/kmADQxjRy6kWOzlJCmAAJmpeQ89PUg8GnNPDhRhnog
18UcLeLVohnKQOqPgfvyEk0U/nG3wTldkmLgNSIbRTLMrazXEhkT0wawvDPfvZRo
HG1Hq/lmbnXl3bn3f/MlbdzL9RtzrvJ4ynOosfiWVEwxZd4Bonc=
=nhaj
-----END PGP SIGNATURE-----

--SAODo2KDIrZTTBHq--
