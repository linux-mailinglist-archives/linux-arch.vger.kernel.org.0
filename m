Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93E7488EAF
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jan 2022 03:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbiAJCk1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 21:40:27 -0500
Received: from shelob.surriel.com ([96.67.55.147]:54692 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiAJCk1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 21:40:27 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1n6kXT-0003a3-Qh; Sun, 09 Jan 2022 21:36:03 -0500
Message-ID: <b1d963a8adf4618a53f996283c1bfae37323bbb6.camel@surriel.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab
 lazy mms
From:   Rik van Riel <riel@surriel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Sun, 09 Jan 2022 21:36:03 -0500
In-Reply-To: <00f58dff-9df5-45ac-a078-d852f13b1dfe@www.fastmail.com>
References: <cover.1641659630.git.luto@kernel.org>
         <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
         <CAHk-=wj4LZaFB5HjZmzf7xLFSCcQri-WWqOEJHwQg0QmPRSdQA@mail.gmail.com>
         <3586aa63-2dd2-4569-b9b9-f51080962ff2@www.fastmail.com>
         <CAHk-=wi2MtYYTs08RKHtj9Vtm0dri-saWwYh0tj=QUUUDSJFRQ@mail.gmail.com>
         <430e3db1-693f-4d46-bebf-0a953fe6c2fc@www.fastmail.com>
         <CAHk-=wjkbFFvgnUqgO8omHgTJx0GDwhxP9Cw0g6E03zOVbC7HQ@mail.gmail.com>
         <484a7f37-ceed-44f6-8629-0e67a0860dc8@www.fastmail.com>
         <CAHk-=whJYoKgAAtb6pYQVSPnyLQsnS6+rU=0jBUqrZU76LyDqg@mail.gmail.com>
         <CAHk-=wgnTWk2zeOO1YQ_8S-xPf4Pr0vXBs7DnhOPdKQFHXOnxw@mail.gmail.com>
         <00f58dff-9df5-45ac-a078-d852f13b1dfe@www.fastmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-EaNlVd+rYIrB0vBh/aoH"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-EaNlVd+rYIrB0vBh/aoH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2022-01-09 at 17:52 -0700, Andy Lutomirski wrote:
> On Sun, Jan 9, 2022, at 1:51 PM, Linus Torvalds wrote:
>=20
>=20
>=20
> > > exit_mmap();
> > > for each cpu still in mm_cpumask:
> > > =C2=A0 smp_load_acquire
> > >=20
> > > That's it, unless the mm is actually in use
> >=20
> > Ok, now do this for a machine with 1024 CPU's.
> >=20
> > And tell me it is "scalable".
> >=20
>=20
> Do you mean a machine with 1024 CPUs and 2 bits set in mm_cpumask or
> 1024 CPU with 800 bits set in mm_cpumask?=C2=A0 In the former case, this
> is fine.=C2=A0 In the latter case, *on x86*, sure it does 800 loads, but
> we're about to do 800 CR3 writes to tear the whole mess down, so the
> 800 loads should be in the noise.=C2=A0 (And this series won't actually d=
o
> this anyway on bare metal, since exit_mmap does the shootdown.)

Also, while 800 loads is kinda expensive, it is a heck of
a lot less expensive than 800 IPIs.

--=20
All Rights Reversed.

--=-EaNlVd+rYIrB0vBh/aoH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmHbm5MACgkQznnekoTE
3oNRwggAuuCij8MbGWiAc10bmbNIP8YJDmlwcGw1kmYen0ynu8MioDOdKXhA8h8d
Eg85rRYlJQK3BLEsGRHuB9E01Pu9Co2syWXpk0bQe+efrvqoJdqOVVnk5A8tRrKK
YjQJJ7X0Lz3dM5+0CJNEFcX7guiek/ylvDo6Yy8H7AzSJj+BoO2wlNBonCFSpRvK
IE9tcrHVtVE0/aqLt3KUL6y1SUnj7B5XEt3BZMsZO7o+eGul0E8/E+IZISqJ4r+Q
towyfaJ8HaxWg4t40x8RsE91YGkcjf2CU0J8dtAnJrPyJ7WbabHe3R+r9SC2hx2F
RVbrF1N2DcD2eJwvRhVV0iAW445lKg==
=VOyH
-----END PGP SIGNATURE-----

--=-EaNlVd+rYIrB0vBh/aoH--

