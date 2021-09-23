Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B010A416705
	for <lists+linux-arch@lfdr.de>; Thu, 23 Sep 2021 22:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbhIWVBD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 17:01:03 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:34040 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhIWVBD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Sep 2021 17:01:03 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CD9BC1C0BA5; Thu, 23 Sep 2021 22:59:29 +0200 (CEST)
Date:   Thu, 23 Sep 2021 22:59:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V3 01/22] Documentation: LoongArch: Add basic
 documentations
Message-ID: <20210923205929.GA23210@duo.ucw.cz>
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-2-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20210917035736.3934017-2-chenhuacai@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add some basic documentations for LoongArch. LoongArch is a new RISC
> ISA, which is a bit like MIPS or RISC-V. LoongArch includes a reduced
> 32-bit version (LA32R), a standard 32-bit version (LA32S) and a 64-bit
> version (LA64).
>=20
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

> +Relationship of Loongson and LoongArch
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +LoongArch is a RISC ISA which is different from any other existing ones,=
 while
> +Loongson is a family of processors. Loongson includes 3 series: Loongson=
-1 is
> +32-bit processors, Loongson-2 is low-end 64-bit processors, and Loongson=
-3 is
> +high-end 64-bit processors. Old Loongson is based on MIPS, and New
> Loongson is

s/processors/processor/ , I guess.

> +Official web site of Loongson and LoongArch (Loongson Technology Corp. L=
td.):
> +
> +  http://www.loongson.cn/index.html

It would be better to point to english version of page.

> +Developer web site of Loongson and LoongArch (Software and Documentation=
s):

Documentation.

BR,								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYUzqsQAKCRAw5/Bqldv6
8vGmAJ9JXgVOqzCePPliXgVLLk/zRabUfQCeKP9TE9OX76UJSpSYHk3YkyKt/tc=
=vT6P
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
