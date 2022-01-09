Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016D2488C0B
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jan 2022 20:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiAIT3u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Jan 2022 14:29:50 -0500
Received: from shelob.surriel.com ([96.67.55.147]:50904 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiAIT3t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jan 2022 14:29:49 -0500
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Jan 2022 14:29:49 EST
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1n6dlb-0007k0-8a; Sun, 09 Jan 2022 14:22:11 -0500
Message-ID: <ba2522fbabc8a81befd27ef20588f9356f7b885b.camel@surriel.com>
Subject: Re: [PATCH 16/23] sched: Use lightweight hazard pointers to grab
 lazy mms
From:   Rik van Riel <riel@surriel.com>
To:     Nadav Amit <nadav.amit@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Date:   Sun, 09 Jan 2022 14:22:10 -0500
In-Reply-To: <B728EEE2-1EB9-4ACD-9F4E-423276380C0C@gmail.com>
References: <cover.1641659630.git.luto@kernel.org>
         <7c9c388c388df8e88bb5d14828053ac0cb11cf69.1641659630.git.luto@kernel.org>
         <739A3109-04DD-4BA5-A02B-52EE30E820AE@gmail.com>
         <CAHk-=wiEZO-uyFELSZgYmxF7eOLHrvh-kMWY5qTKjckOdNQxpA@mail.gmail.com>
         <B728EEE2-1EB9-4ACD-9F4E-423276380C0C@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3bYF5AhkVoIli31LXQXk"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--=-3bYF5AhkVoIli31LXQXk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2022-01-09 at 00:49 -0800, Nadav Amit wrote:
>=20
> It is possible for instance to get rid of is_lazy, keep the CPU
> on mm_cpumask when switching to kernel thread, and then if/when
> an IPI is received remove it from cpumask to avoid further
> unnecessary TLB shootdown IPIs.
>=20
> I do not know whether it is a pure win, but there is a tradeoff.

That's not a win at all. It is what we used to have before
the lazy mm stuff was re-introduced, and it led to quite a
few unnecessary IPIs, which are especially slow on virtual
machines, where the target CPU may not be running.

--=20
All Rights Reversed.

--=-3bYF5AhkVoIli31LXQXk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAmHbNeIACgkQznnekoTE
3oO3dAgAnFIAWZSgHJZ3+KDjfwPiBN0+9hgcTu2bwk1/RcslCWYksrooQ8MPI8Sl
NQmy31fqVLA5x0bmynjpS30u4hDl7qywvazXv8Z+CGh3IDoilsbF83Gf/ZkH6NCa
bQKj5/ujChp33NHLyVCHq5hHNP6iLm0V2DVb/tSInTsVcR4C3CiCzO2dDKt306DG
spuz5xx8i4WeU4mQs6+3aSD6UQobhVozIKaYyaD5RAFLf4yVMgrhfxcojOtU0F4B
Ot2LmnTn2cKPZJldGPsnLkGmH4NiaXfvsetBaOXH91TR7DWsbLtNOso59qzvra6+
WFjZVTZ3AMx8EK3a1AOeIBUZiJ/GRg==
=lb9o
-----END PGP SIGNATURE-----

--=-3bYF5AhkVoIli31LXQXk--

