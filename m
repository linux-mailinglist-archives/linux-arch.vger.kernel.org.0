Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAFA35ED70
	for <lists+linux-arch@lfdr.de>; Wed, 14 Apr 2021 08:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhDNGpr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Apr 2021 02:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhDNGpq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Apr 2021 02:45:46 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DA2C061574;
        Tue, 13 Apr 2021 23:45:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FKtJY5rm7z9sVb;
        Wed, 14 Apr 2021 16:45:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1618382721;
        bh=/jodwSXgSQIoA9PKAVNuVIZztq5p2I1zYdAcnFOt/QI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nviLuOh6vv6t0otwNWX8zUg4K7TpYLIfF2mKXNz4miCmYGBKYPii8JbbMGE50K389
         /7gLpYYMyg8jf0tZMsL4WFsIoWGRC+VevBVJ7FoFLE9BeL9xdYWjBWs1jxxkf5wB9U
         BdD2uV49k4hNwvFJ8ckGLENvxVWo34hc9mhVkNTtvkyCnDIE2hcoqGNJ3Z1CpQHuFR
         WkIWVSg+uhV3LzZL47CHSmq/bnSPHp3RnaSFyarITSDS6Iey9YXTCG9e9F1PY5tY61
         xiBKcf/NoOetBTlhz5BzDAFqr0YjKsYU6bE43A7pK++5PbMej109F3sMRxyE9m/ybS
         Mv0hOdc6mGxFQ==
Date:   Wed, 14 Apr 2021 16:45:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/5] uapi: remove the unused HAVE_ARCH_STRUCT_FLOCK64
 define
Message-ID: <20210414164515.7358054a@canb.auug.org.au>
In-Reply-To: <CAK8P3a2MSJarPMfJ8RrSKDMXte3KQec=+GQ-LzV6HB7-Nm1FcQ@mail.gmail.com>
References: <20210412085545.2595431-1-hch@lst.de>
        <20210412085545.2595431-2-hch@lst.de>
        <CAK8P3a2MSJarPMfJ8RrSKDMXte3KQec=+GQ-LzV6HB7-Nm1FcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OE1o8UymrAeVhdVEl6xjBsl";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/OE1o8UymrAeVhdVEl6xjBsl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Mon, 12 Apr 2021 11:55:41 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Apr 12, 2021 at 10:55 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de> =20
>=20
> The patch looks good, but I'd like to see a description for each one.
> How about:
>=20
> | The check was added when Stephen Rothwell created the file, but
> | no architecture ever defined it.

Actually it was used by the xtensa architecture until Dec, 2006.

--=20
Cheers,
Stephen Rothwell

--Sig_/OE1o8UymrAeVhdVEl6xjBsl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmB2j3sACgkQAVBC80lX
0Gx4pggAkNW0y0/RLSwNvx8cwugIMwm76PePVHws/DSpK21w82ztk8XPzmrlHYlo
MP4xnpeval236Udlgam+Jc+7defed018uxwQyX1zKt+a0seZO9HrNSBZk8FwT1ck
rq+/vwVxpRmpXxh4wrHNZ9kEEB8siALYt1IhhjOMuPDEFZQhhRv+1GM11ZEb4TNm
QXiVEOPdln45S2tKu+icyaVERYFY/6j5minprLhTWeY7Rg/+eoZwC6KtkvXpRqfl
WsUS0axrNP124+5bOizsZyTaCeeLFwTQR18nvDu703iKPre8y4K3CEiM3YQddALr
8OeaCYAcDp1LKDXR1UZZmal4VJxxdg==
=76mG
-----END PGP SIGNATURE-----

--Sig_/OE1o8UymrAeVhdVEl6xjBsl--
