Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7280528A31B
	for <lists+linux-arch@lfdr.de>; Sun, 11 Oct 2020 01:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390733AbgJJW63 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Oct 2020 18:58:29 -0400
Received: from ozlabs.org ([203.11.71.1]:47073 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730933AbgJJTBN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 10 Oct 2020 15:01:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4C7vRJ1RQwz9sSn;
        Sun, 11 Oct 2020 06:01:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1602356460;
        bh=9Mo+fNHM3G6Ny1Gfh76bA35x/o/SeYtWfZ501dVJD1w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qbYj5/OqDvB+tmkZjGXA+ZjJPdufN0ZSM0jLTuQdcj0U4ZEdGOXsUf4x6BtiXwPqJ
         TEbZbem0dxHcT1I/balVwh1sBBPPkVvhZR9fREL+yuEtEitWEv9MrDogvBxDlKKa2L
         udl0dX518XrJoad/W+Iblca6s3WbNiEoFs87lQMJIJp9oeGx5piXoAQNXClZIlpHLS
         7vfcAX4z6yBvV7+3OtQTA5GSoCLoQByMSaHIddGamZrd9KhM/eIjK8sKl9Vvrnh1zP
         mJzIQIa+QXDYqhmrKpOn516nh/ykQuNc84HcBffCrRGrhj6l7EMZmr4rqfWFw1vjPN
         TBneZlNkOGDww==
Date:   Sun, 11 Oct 2020 06:00:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/23] Use asm-generic for mmu_context no-op
 functions
Message-ID: <20201011060059.3e2db5f8@canb.auug.org.au>
In-Reply-To: <CAK8P3a0EgaGEtOQzsjR8YhALAaSxScsAhaQLMqU9UmEdhKQ+-Q@mail.gmail.com>
References: <20200901141539.1757549-1-npiggin@gmail.com>
        <159965079776.3591084.10754647036857628984.b4-ty@arndb.de>
        <CAK8P3a1XqhV+7OVgWhGg3az4Y+_6V-mCjcJ1dBenwD+ZUaaT9g@mail.gmail.com>
        <20201010130230.69e5c1a5@canb.auug.org.au>
        <CAK8P3a0EgaGEtOQzsjR8YhALAaSxScsAhaQLMqU9UmEdhKQ+-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=Dpubf2JgjUd0vIrjIspISL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--Sig_/=Dpubf2JgjUd0vIrjIspISL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Sat, 10 Oct 2020 10:25:11 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Oct 10, 2020 at 4:02 AM Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> > On Fri, 9 Oct 2020 16:01:22 +0200 Arnd Bergmann <arnd@arndb.de> wrote:
> > =20
> > > Are there other changes that depend on this? If not, I would
> > > just wait until -rc1 and then either push the branch correctly or
> > > rebase the patches on that first, to avoid pushing something that
> > > did not see the necessary testing. =20
> >
> > If it is useful enough (or important enough), then put in in your
> > linux-next included branch, but don't ask Linus to merge it until the
> > second week of the merge window ... no worse than some other stuff I
> > see :-( =20
>=20
> By itself, it's a nice cleanup, but it doesn't provide any immediate
> benefit over the previous state, while potentially introducing a
> regression in one of the less tested architectures.

OK.

> The question to me is really whether Nick has any pending work
> that he would like to submit after this branch is merged into
> mainline.

--=20
Cheers,
Stephen Rothwell

--Sig_/=Dpubf2JgjUd0vIrjIspISL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+CBOsACgkQAVBC80lX
0GyKaQf9FzCxcpdhGS52PVKxDHwAAK67sUfj1EFa071yFeYzwaAmvvHvOf2P7HUf
szlwvwDekQQny623qnZu0Ar4Yen0sG/+t6aZyZeCk0z6WvXJ7JarmdpMs09rxQ4o
2aqCAFfT/KDBHaj9Ra3vW9y/QxNT7ZMxL8lw4s7xr/ghc8Si93xdToXGFzG2gNiI
K1XD/jx7EVPBS9o9RbY7Rf09o0gVHR7XaoQqpJsEN5cZVHR+OvUubDuSaiiam0u0
A9fAt1UKZ4e4hNTA6hyWA887n4qAj9cmXVjRAQoG16H5MaE4fzBi+TRKFodPtM9j
9isKcdGCKwWy/FjvEpwvVT8HcGIb2Q==
=IcY2
-----END PGP SIGNATURE-----

--Sig_/=Dpubf2JgjUd0vIrjIspISL--
