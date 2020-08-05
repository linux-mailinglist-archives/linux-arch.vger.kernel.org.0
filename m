Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B69023D020
	for <lists+linux-arch@lfdr.de>; Wed,  5 Aug 2020 21:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgHETaJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Aug 2020 15:30:09 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:44408 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728990AbgHETaF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Aug 2020 15:30:05 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7EDF61C0BD2; Wed,  5 Aug 2020 21:30:01 +0200 (CEST)
Date:   Wed, 5 Aug 2020 21:30:01 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] [TECH TOPIC] Planning code obsolescence
Message-ID: <20200805193001.nebwdutcek53pnit@duo.ucw.cz>
References: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
 <20200805172629.GA1040@bug>
 <CAMuHMdV20tZSu5gGsjf8h334+0xr1f=N9NvOoxHQGq42GYsj4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2as7iuittmdh4m5a"
Content-Disposition: inline
In-Reply-To: <CAMuHMdV20tZSu5gGsjf8h334+0xr1f=N9NvOoxHQGq42GYsj4g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--2as7iuittmdh4m5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-08-05 20:50:43, Geert Uytterhoeven wrote:
> Hi Pavel,
>=20
> On Wed, Aug 5, 2020 at 7:26 PM Pavel Machek <pavel@ucw.cz> wrote:
> > > I have submitted the below as a topic for the linux/arch/* MC that Mi=
ke
> > > and I run, but I suppose it also makes sense to discuss it on the
> > > ksummit-discuss mailing list (cross-posted to linux-arch and lkml) as=
 well
> > > even if we don't discuss it at the main ksummit track.
> >
> > > * Latest kernel in which it was known to have worked
> >
> > For some old hardware, I started collecting kernel version, .config and=
 dmesg from
> > successful boots. github.com/pavelmachek, click on "missy".
>=20
> You mean your complete hardware collection doesn't boot v5.8? ;-)

I need to do some pushing, and yes, maybe some more testing.

But I was wondering if someone sees this as useful and wants to
contribute more devices? :-).
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2as7iuittmdh4m5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXysIuQAKCRAw5/Bqldv6
8ne8AKCzcy8jflTVvnbaGcu03o4XWep3TgCgiOYXuMl+/WCzPV9BgoTFu+rV6qA=
=rLGV
-----END PGP SIGNATURE-----

--2as7iuittmdh4m5a--
