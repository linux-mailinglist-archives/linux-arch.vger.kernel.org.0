Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED45C289D78
	for <lists+linux-arch@lfdr.de>; Sat, 10 Oct 2020 04:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgJJCZk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 22:25:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55867 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729929AbgJJCDF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 22:03:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4C7Sr70VJfz9sSn;
        Sat, 10 Oct 2020 13:02:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1602295351;
        bh=RiinYVDjJ86lX4CNtxFBjSdehdzMMJDshahbJ1KMzOg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Q9aOlvzBgO2GMz5IEgKig+U3t/dlCaldOJjjOQlphDRaYEHkxsvs8Jz4m5F6G/R+/
         5M17rjM/eYQXr6eI+DbMfbQQplOPvhjtbt5P4IrdMe+UMf/vBsI1ZlIQrrfIeNVH3z
         IAFIfAN1XXZyDqVKS5m2EEpyS24XbohrzhhDmco1a+EwW4IZf7MtqgHACzMJxChsAz
         c4utfnuoEnGorMaz5hJwGjQyD+ouL9Fe7IAbuxVZi3D2fa/kSTxreD3ij5qsazz1mo
         NPVRxWcrqh9jAZev3lmURU7wn8KelxSDY4V2LZUlnA1NMrDPtnnDnlIbno04Tb+0wL
         L3rdqVPIlCk5Q==
Date:   Sat, 10 Oct 2020 13:02:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/23] Use asm-generic for mmu_context no-op
 functions
Message-ID: <20201010130230.69e5c1a5@canb.auug.org.au>
In-Reply-To: <CAK8P3a1XqhV+7OVgWhGg3az4Y+_6V-mCjcJ1dBenwD+ZUaaT9g@mail.gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
        <159965079776.3591084.10754647036857628984.b4-ty@arndb.de>
        <CAK8P3a1XqhV+7OVgWhGg3az4Y+_6V-mCjcJ1dBenwD+ZUaaT9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yzH.L4Tfh.m3v5j11Jxarnb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/yzH.L4Tfh.m3v5j11Jxarnb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Fri, 9 Oct 2020 16:01:22 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Sep 9, 2020 at 1:27 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Wed, 2 Sep 2020 00:15:16 +1000, Nicholas Piggin wrote: =20
> > > It would be nice to be able to modify mmu_context functions or add a
> > > hook without updating all architectures, many of which will be no-ops.
> > >
> > > The motivation for this series is a change to lazy mmu handling, but
> > > this series stands on its own as a good cleanup whether or not we end
> > > up making that change.
> > >
> > > [...] =20
> >
> > Applied to asm-generic, thanks! =20
>=20
> Hi Nick,
>=20
> I just noticed a fatal mistake I made when pushing it to the branch on
> kernel.org: I used to have both a 'master' and an 'asm-generic' branch
> in asm-generic.git but tried to remove the 'master' one as there is not
> really any point in having two.
>=20
> Unfortunately I forgot to check which one of the two was part of
> linux-next, and it was the other one, so none of the patches I picked
> up ever saw any wider testing aside from the 0day bot building it
> (successfully).
>=20
> Are there other changes that depend on this? If not, I would
> just wait until -rc1 and then either push the branch correctly or
> rebase the patches on that first, to avoid pushing something that
> did not see the necessary testing.

If it is useful enough (or important enough), then put in in your
linux-next included branch, but don't ask Linus to merge it until the
second week of the merge window ... no worse than some other stuff I
see :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/yzH.L4Tfh.m3v5j11Jxarnb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+BFjYACgkQAVBC80lX
0GxhkwgAoRZOvmcp7V4S8zFT6NGWaKJhO/x2JhvSqFL8TMGmO5ZKmcB59f/wrl+4
EQOc9lyUYPmIV6mEBAtySWKfyCzEK7HJpKeAG+yyJ2QaJLW2UClQuCQ+nUXyNljb
iNaG2rsPhYf/ytr/eZ6EpcO5P6oh0wvmlDT4bfSI5urCPmYt5bOh2RYZ2ch4/2CH
l9YUSVK+q8Hk9sMmY+0Fw/AAa8IsyXculJ/t5gAj6rew/cxD7nz7OHmkPRNg4CK3
gHW7CqlIvbu9Pjl3j9HqIaLXMb+wgiQaQCUdMlwRf3Ba646SpfnCNkp5tqNx5uuT
Z77xpUbwxYgABdlVLOPAgN5jGdzczQ==
=cicz
-----END PGP SIGNATURE-----

--Sig_/yzH.L4Tfh.m3v5j11Jxarnb--
