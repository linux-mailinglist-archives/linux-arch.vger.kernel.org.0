Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4175EE4D1
	for <lists+linux-arch@lfdr.de>; Wed, 28 Sep 2022 21:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbiI1TKd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Sep 2022 15:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiI1TKc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2022 15:10:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66976A4A9;
        Wed, 28 Sep 2022 12:10:25 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.177]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mow06-1p18ZR3rKg-00qSZY; Wed, 28 Sep 2022 21:09:56 +0200
Received: from localhost.fjasle.eu (bergen.fjasle.eu [IPv6:fdda:8718:be81:0:6f0:21ff:fe91:394])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 303523C004;
        Wed, 28 Sep 2022 21:09:54 +0200 (CEST)
Authentication-Results: leknes.fjasle.eu; dkim=none; dkim-atps=neutral
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id 7FCC2B4D; Wed, 28 Sep 2022 21:09:53 +0200 (CEST)
Date:   Wed, 28 Sep 2022 21:09:53 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v3 1/7] kbuild: hard-code KBUILD_ALLDIRS in
 scripts/Makefile.package
Message-ID: <YzScAYUStPbp9o0i@bergen.fjasle.eu>
References: <20220924181915.3251186-1-masahiroy@kernel.org>
 <20220924181915.3251186-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yisc45JTu+esueRF"
Content-Disposition: inline
In-Reply-To: <20220924181915.3251186-2-masahiroy@kernel.org>
Jabber-ID: nicolas@jabber.no
X-Operating-System: Debian GNU/Linux bookworm/sid
X-Provags-ID: V03:K1:KLB40yBRNF3j4INUsUj1VHniQuyqvKGqpeRCIP/Jt6wnFKpl7Fj
 2kka9RLgLaW3Aq0aan4q/Df+dqzcczGxzTLXa9dvjDhcNEdj132kD9vkq20USnCIeRZwqEA
 SZi3S03gz803ihnUUASf56Vdzf5uH+SYVdIt1GDWtBvcJ/DOlMSb+iW5kzTi+MDw6//ZqHI
 F27fQ6w606K7PnQPAyt8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xWfgeOQ8fzU=:kekw7fS0mmwRT0uLAvOpvL
 fiHDPT/P2tQAvs4bKPQOG7FjzTX2SEpW95McmIWCKS6OGolTVD2ZdJlU3G+I2bAjeDBO5FoNp
 0n2G52F24ajgjvQUDxKnxe1x8Xib+vu2ozk3Y2ihB4GJ/91tHW7mMOuwct0Ce0vkPJqLN5Uso
 umkKigxQyqw9cWAhkR+PcOFvk7CYWWy0+tFZ7GF96gfqtXtAJAxQpVIuJDEu5zGiqJee4Ogew
 8mNbwcCX47RR3AeQS3ZaisoMxJayEZWyG/680XRcO+CWfJf/ZbDqepImml/VZfdvzt6tbdI17
 Jyo0E3dawOdck8kJ2Zq+cxVhDEWOQ7FWNlQ6TuPTU0sQMCkQXET+EgcSlk3SiiCZpjlsJavCB
 IrakeZPvoDy4C2O5Tn1kiR087oZ+DKA/2Yet5FTtfvVr31hMKYV3p103LaDqzkFYAUUjoWv1B
 8SiacZycDpSdI0DzPtbxUN+bGPIiP5IMdHKfdnn0o6hg1S/oPRTO0VgRQHVgZa2UxXwFnL1SG
 Wdz3gBXDHlghyy5UvRcZgDSBDEl+u+59D+LsQNUGZmA/orOpR6zG8stJju48GHAkIPKPThASp
 xRIb/eOoiIOOEMq/c/FIeLV1SF8n0MydbBuEPmfnPFkfrAbFvNmBJ9Mgwq3WakguG8+kpiSMR
 t0xhnGnDxScPFtCLH2AzFH4ezoIyv+1pAk83Do+wjB4EfO2qBvtCoKXEPMIA3WX13RSe4t7BP
 uAfD0BOP74DRCWw8346xlwPrbEmtTPYYxm7dpz2IQ5sqMqqzq1oAlhDCKngu05mkX95QVG38k
 jW7Wkc8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--yisc45JTu+esueRF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 25 Sep 2022 03:19:09 +0900 Masahiro Yamada wrote:
> My plan is to list subdirectories in ./Kbuild. Once it occurs,
> $(vmlinux-alldirs) will not contain all subdirectories.
>=20
> Let's hard-code the directory list until I get around to implementing
> a more sophisticated way for generating a source tarball.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> Changes in v3:
>   - New patch
>=20
>  Makefile                 | 2 --
>  scripts/Makefile.package | 5 ++++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 57cf4a5bea6d..eb4bbbc898d0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1129,8 +1129,6 @@ KBUILD_VMLINUX_OBJS +=3D $(patsubst %/,%/built-in.a=
, $(drivers-y))
> =20
>  export KBUILD_VMLINUX_OBJS KBUILD_VMLINUX_LIBS
>  export KBUILD_LDS          :=3D arch/$(SRCARCH)/kernel/vmlinux.lds
> -# used by scripts/Makefile.package
> -export KBUILD_ALLDIRS :=3D $(sort $(filter-out arch/%,$(vmlinux-alldirs)=
) LICENSES arch include scripts tools)
> =20
>  vmlinux-deps :=3D $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_=
LIBS)
> =20
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 5017f6b2da80..8bbcced67c22 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -29,7 +29,10 @@ KDEB_SOURCENAME ?=3D linux-upstream
>  KBUILD_PKG_ROOTCMD ?=3D"fakeroot -u"
>  export KDEB_SOURCENAME
>  # Include only those top-level files that are needed by make, plus the G=
PL copy
> -TAR_CONTENT :=3D $(KBUILD_ALLDIRS) .config .scmversion Makefile \
> +TAR_CONTENT :=3D Documentation LICENSES arch block certs crypto drivers =
fs \
> +               include init io_uring ipc kernel lib mm net samples scrip=
ts \
> +               security sound tools usr virt \
> +               .config .scmversion Makefile \
>                 Kbuild Kconfig COPYING $(wildcard localversion*)
>  MKSPEC     :=3D $(srctree)/scripts/package/mkspec
> =20
> --=20
> 2.34.1

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--yisc45JTu+esueRF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmM0m/gACgkQB1IKcBYm
Emmz6A/9GudZhGDEuiScPxyeaDy8UnaNrQ46o6QWmCK7meL9JifsDg33A+C/w2E5
4wTarbibMH1Z2NUx5R8KYUiNFdKHvQmj5tGb5bvUBeEfbBXKFPnINEPRLy5pZd4M
MI0AI/bEmfJBRh9p32D1PpmIQaytKbb+0z8VoVV5rluWWXl8d/QFxxn8sTO3s+21
MYCXrSRP8Jj4qbdZ27uCkCvLHBaKoBLZpzMx7vJSpgmDjIy0rOsbCtNLmilI1bOt
uMOh8ND3sSRQ96Olg7VPsanP3axjpP9DN1FmY8DRAjA2//115mN884P2+hIlEu6j
LiXZXhcyIqyR6nUqC6fhqRKWCaB3FcYBFTT2QE1UJwJcwLAA9TvXkC2nYr8Bn8+B
gDWykOU/s/mws4GBnVSqO85DQkT/9PW1JgD0Xam4gxT+Sl5ETHCWkf8s0w397+vN
jLHyvY9VKUGsqLe0WmKEfScohzVaNV4eKAqCP0jndr8mSpGFQ2ONuYHUPo3NwTGY
rbhjzvE6UEnS0JVaX/BXZtE/tg14MK0jq/lPVbcmEQdFXoRPZdelMGC8i2nuaeeL
sgZ42vXFLJs1qYU5JMB2QxUKlMi3k5KLHZ9i5IEGCFXSdOvDZ6Wx3A1pO1JiimaL
5tD0/FWrjjA3baDGLEDqS/TWQLEoCDmxlDguSl710B6sjYNXfe0=
=RsJ9
-----END PGP SIGNATURE-----

--yisc45JTu+esueRF--
