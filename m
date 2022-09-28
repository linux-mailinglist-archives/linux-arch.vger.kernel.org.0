Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EC95EE5CD
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 21:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiI1TiV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 15:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiI1TiU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 15:38:20 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F112E48E89;
        Wed, 28 Sep 2022 12:38:15 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.177]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M3lsh-1oeRxJ1A3f-000xTg; Wed, 28 Sep 2022 21:37:46 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id B3DD33C004;
        Wed, 28 Sep 2022 21:37:44 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 2CA4941C6; Wed, 28 Sep 2022 21:37:43 +0200 (CEST)
Date:   Wed, 28 Sep 2022 21:37:43 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3 4/7] kbuild: move vmlinux.o rule to the top Makefile
Message-ID: <YzSih2IQkgpWj59C@bergen.fjasle.eu>
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-5-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OKXlH7/1ZlkiNRGL"
Content-Disposition: inline
In-Reply-To: <20220924181915.3251186-5-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:3EER6+kkATtJZDvyDTvCzBJq4aMgP3YAZnZoV9ndc8/07nekr0I
 6TwYsejRqB9oKE3qAhvKU+/A7aGrF2gbElSFKWNZFNd3dzRjsbptLPJsK4AvEs4nK3zuhOk
 Vc+1z4l3vNUwXkT+U6gkdaFIGaG7/HhW5qZDf+XvtenQjisMWiWpDGQsVNDOXtRE1cymlIZ
 YuhxFR4EnaPofFcVilC4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nwW654U9npw=:2Zaxzznq1y3Ii5sox0XcFn
 DoKu3yqfpk3Hr77pIPmyShgnlLXhfG8ue3SJ7x11kjRcs1wMePMHvLARF0+iqEE9knN9kmUGF
 R1UaGJ6QqgAx4+3V8xlgICpJ9hCr6x/Xx+8riXgt/MKqXepn5QMdOx57B5yfeCWShheHcgfyE
 iQf6k+aG9jE029yiQT+CeLkYhfh853VbZp9fBhFLEoyuyK95aG7mPy45LntJEvYvygO0zeEm6
 xe4PEhqbGDwp0WdzJGsT7Af4TXj/kCQ2pvHzCXNHKzFqVJXsIkn8I5k9TGmepuDQWy+4Gk07d
 bQlpKXixWWg7pC7kFbfZgqOvqbHaHowaMBqvUJhLr/uRRQZmpJeTXthFma/r88PvmVHUllOB9
 FHo9Kpq62QizmiCkjP4WmjgMdGNjU8+WQXZND3bOCDHOlQYCPM/U5x3+Q5UfQnOnLhaRz/xfv
 VI1mVlmdkIo5c8UsAifYAIMMR1TZEzlyfjOFj0ZHb9iVk44X7XA/Zko0Kgt7yTANrt95rKY2b
 6o9TxJYUrYU95WEqbVrWF4s11BIgZYAJQQnEDhvW7lBPBCwgz2ho1oJtxaCs7fNEWBvxNA4fa
 M4feIg0h3JZ2TDyil7lvWtdQOdE9QJWyyRtW5HKvuluaRHEioER5m7wTCZSBMxpI0FyMUgE2Z
 Ic1b2x24DxA0+zk9xMNq7T/NjztiZV8PEIQ/ac7MDOEEkuwe8OI7QcScJpPiKaRYmBjQHtRjx
 DGeYMFw0imLxkOduA5haCM5IptF/PYdz3k5v66ZFcNOXcw/Ki8woYOg39eSXFbWYOs+qpTIHN
 iC5XxVe
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--OKXlH7/1ZlkiNRGL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 25 Sep 2022 03:19:12 +0900 Masahiro Yamada wrote:
> Move the build rules of vmlinux.o out of scripts/link-vmlinux.sh to
> clearly separate 1) pre-modpost, 2) modpost, 3) post-modpost stages.
> This will make furture refactoring possible.

s/furture/future/

>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
> (no changes since v1)
>=20
>  Makefile                | 5 ++++-
>  scripts/link-vmlinux.sh | 3 ---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 92413b6de451..b5dfb54b1993 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1142,6 +1142,9 @@ quiet_cmd_autoksyms_h =3D GEN     $@
>  $(autoksyms_h):
>  	$(call cmd,autoksyms_h)
> =20
> +vmlinux.o: autoksyms_recursive $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_L=
IBS) FORCE
> +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vmlinux_o
> +
>  ARCH_POSTLINK :=3D $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postli=
nk)
> =20
>  # Final link of vmlinux with optional arch pass after final link
> @@ -1149,7 +1152,7 @@ cmd_link-vmlinux =3D                               =
                  \
>  	$(CONFIG_SHELL) $< "$(LD)" "$(KBUILD_LDFLAGS)" "$(LDFLAGS_vmlinux)";   =
 \
>  	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
> =20
> -vmlinux: scripts/link-vmlinux.sh autoksyms_recursive $(vmlinux-deps) FOR=
CE
> +vmlinux: scripts/link-vmlinux.sh vmlinux.o $(KBUILD_LDS) FORCE
>  	+$(call if_changed_dep,link-vmlinux)
> =20
>  targets :=3D vmlinux
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 161bca64e8aa..07486f90d5e2 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -214,9 +214,6 @@ if [ "$1" =3D "clean" ]; then
>  	exit 0
>  fi
> =20
> -#link vmlinux.o
> -${MAKE} -f "${srctree}/scripts/Makefile.vmlinux_o"
> -
>  # modpost vmlinux.o to check for section mismatches
>  ${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=3D1
> =20
> --=20
> 2.34.1

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

--OKXlH7/1ZlkiNRGL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmM0ooYACgkQB1IKcBYm
EmmuNw//UaXnTs0KyNhHnKMvn+HXdz2ofuw7GZ/wF0Zwg3Dm5THz4G6rX/zEQ8/S
IqxWW2IBefVuf4N58v/mkBHfaoLSmHmA/pwd/2oB6bJ4sDX3HECgqfruhwL8Zlqn
P1ygfhtMRjEam3HeIUs0J+s5JHbqJ0a3jH2QVOLSNRnKKDU+YUoHcqNgcOS1A93m
zA6LIsxSIhcRnaSYM+i0o54Tij5HQcY2BQJFpJ1O8f7Hs1LQbOXPNGCcP+ISi2r7
J8+d7yMWxy8RwicXSJvBnpPfRRhljd+uBNjQ/imqs7JkImy3RbxVhkjgh9eMNfQo
ArJhnUjSFgic54sO9I29jAxym1m/jqBC2uqm7FM/SjVjGbLW8VeuUvtiEJAqBxhX
/aH+68s16SBDDo6TBgfCCoMEmC2VbeLtAYOE2b/n1zv/xd1TXOYPDJm0JHlzLavk
q1MsHzO022+PpHPqtRbSCQwxXdp3Z/jZBQgLQMXdGHSyhEsgqFAbVdYL6jqxKEZU
cYAjGkCYCwM/dqZRH538Wbio/X3NyB4PtJShIuX06Z+15Julk2rqN+4u+JxoB1Oo
XDYxoWQ9971muUtFuIWjxZL5JKk1GsHFEjkIe4iXr9gla8cE5WAf5etQmravBLdT
e13nsXvts2BR5VLggo9zK29oJ6brzIt1k8ppptwWybZaHAbQ8K0=
=ci1M
-----END PGP SIGNATURE-----

--OKXlH7/1ZlkiNRGL--
