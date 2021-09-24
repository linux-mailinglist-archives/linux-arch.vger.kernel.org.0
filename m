Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDF5416C71
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244264AbhIXG7w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Sep 2021 02:59:52 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40058 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244234AbhIXG7w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Sep 2021 02:59:52 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 26DA11C0BA3; Fri, 24 Sep 2021 08:58:18 +0200 (CEST)
Date:   Fri, 24 Sep 2021 08:58:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH V3 01/22] Documentation: LoongArch: Add basic
 documentations
Message-ID: <20210924065817.GA8576@amd>
References: <20210917035736.3934017-1-chenhuacai@loongson.cn>
 <20210917035736.3934017-2-chenhuacai@loongson.cn>
 <20210923205929.GA23210@duo.ucw.cz>
 <CAAhV-H5MPtfsBDH9Vo1e1n0oES_jHUrKJqk6Jgu=KD+WFFrKxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <CAAhV-H5MPtfsBDH9Vo1e1n0oES_jHUrKJqk6Jgu=KD+WFFrKxA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >
> > > +Relationship of Loongson and LoongArch
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +LoongArch is a RISC ISA which is different from any other existing o=
nes, while
> > > +Loongson is a family of processors. Loongson includes 3 series: Loon=
gson-1 is
> > > +32-bit processors, Loongson-2 is low-end 64-bit processors, and Loon=
gson-3 is
> > > +high-end 64-bit processors. Old Loongson is based on MIPS, and New
> > > Loongson is
> >
> > s/processors/processor/ , I guess.
> Should be processor series here, thanks.

Makes sense (as do the other fixes), thanks.

> > > +Official web site of Loongson and LoongArch (Loongson Technology Cor=
p. Ltd.):
> > > +
> > > +  http://www.loongson.cn/index.html
> >
> > It would be better to point to english version of page.
> The English version doesn't exist at present.

Append (cn) so that people know what to expect?

Best regards,
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmFNdwkACgkQMOfwapXb+vLWWgCcDA+7tf3sgwOsUIfM7B+4lmd0
ysAAniU5OBlYG6MgIwh9ueZAONcOJBlv
=1aRs
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
