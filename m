Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BFE488C10
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 20:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiAITh3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 14:37:29 -0500
Received: from shelob.surriel.com ([96.67.55.147]:50952 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbiAITh1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 14:37:27 -0500
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1n6e0I-0001Ru-12; Sun, 09 Jan 2022 14:37:22 -0500
Message-ID: <803a5d61426b149abf08e19759e086893e379382.camel@surriel.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab
 lazy mms
From:   Rik van Riel <riel@surriel.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Sun, 09 Jan 2022 14:37:21 -0500
In-Reply-To: <1B6896F0-7A51-4936-8B50-0B86551FA3B7@gmail.com>
References: <cover.1641659630.git.luto@kernel.org>
         <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
         <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com>
         <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
         <B728EEE2-1EB9-4ACD-9F4E-423276380C0C@gmail.com>
         <ba2522fbabc8a81befd27ef20588f9356f7b885b.camel@surriel.com>
         <1B6896F0-7A51-4936-8B50-0B86551FA3B7@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-CP9cQdjxomTbAfjFq8L2"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-CP9cQdjxomTbAfjFq8L2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2022-01-09 at 11:34 -0800, Nadav Amit wrote:
>=20
>=20
> > On Jan 9, 2022, at 11:22 AM, Rik van Riel <riel@surriel.com> wrote:
> >=20
> > On Sun, 2022-01-09 at 00:49 -0800, Nadav Amit wrote:
> > >=20
> > > It is possible for instance to get rid of is_lazy, keep the CPU
> > > on mm_cpumask when switching to kernel thread, and then if/when
> > > an IPI is received remove it from cpumask to avoid further
> > > unnecessary TLB shootdown IPIs.
> > >=20
> > > I do not know whether it is a pure win, but there is a tradeoff.
> >=20
> > That's not a win at all. It is what we used to have before
> > the lazy mm stuff was re-introduced, and it led to quite a
> > few unnecessary IPIs, which are especially slow on virtual
> > machines, where the target CPU may not be running.
>=20
> You make a good point about VMs.
>=20
> IIUC Lazy-TLB serves several goals:
>=20
> 1. Avoid arch address-space switch to save switching time and
> =C2=A0=C2=A0 TLB misses.
> 2. Prevent unnecessary IPIs while kernel threads run.
> 3. Avoid cache-contention on mm_cpumask when switching to a kernel
> =C2=A0=C2=A0 thread.
>=20
> Your concern is with (2), and this one is easy to keep regardless
> of the rest.
>=20
> I am not sure that (3) is actually helpful, since it might lead
> to more cache activity than without lazy-TLB, but that is somewhat
> orthogonal to everything else.

I have seen problems with (3) in practice, too.

For many workloads, context switching is much, much more
of a hot path than TLB shootdowns, which are relatively
infrequent by comparison.

Basically ASID took away only the first concern from your
list above, not the other two.

--=20
All Rights Reversed.

--=-CP9cQdjxomTbAfjFq8L2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmHbOXEACgkQznnekoTE
3oO8Ywf+I58H/vuvwuIGORyLNgDGBaVY2wJ+L0xT4qAxywlEGTVN9J77TVEftLeG
7BXqgNISqI7a6hIF70aToUS2MRmDBza/RmO4kWaq9ud1AvY36cJXlFbQVrAN9Kzl
7nlY0y4oXlZkiAL+7YluU+DicLHb/YIfmJ7xc82GlEBFiwK8Ld5mbHf0+Ezx8EoU
X9NmQzW+l8QcPhCFBMLV5yQm+Vmk/Wb28kTRFsou6/jX4nFN9vWjnavXtP8uCECi
ulYkol580vUFWsBvRu1sjj0u3jRJaQxqr3Awq38T1ANTfMxRAj0yt6N8rhX//5Tw
4i59n3ArphgQvhnytbp+VIvyGjySSQ==
=T+Yp
-----END PGP SIGNATURE-----

--=-CP9cQdjxomTbAfjFq8L2--

