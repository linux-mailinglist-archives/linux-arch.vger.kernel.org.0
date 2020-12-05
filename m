Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5427B2CFEE9
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 21:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgLEUno (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 15:43:44 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:37066 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgLEUno (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 15:43:44 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C4F971C0B8B; Sat,  5 Dec 2020 21:43:01 +0100 (CET)
Date:   Sat, 5 Dec 2020 21:43:01 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 00/14] An alternative series for asymmetric AArch32
 systems
Message-ID: <20201205204301.GB8578@amd>
References: <20201124155039.13804-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <20201124155039.13804-1-will@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-11-24 15:50:25, Will Deacon wrote:
> Hello folks,
>=20
> Here's version four of the wonderful patches I previously posted here:
>=20
>   v1: https://lore.kernel.org/r/20201027215118.27003-1-will@kernel.org
>   v2: https://lore.kernel.org/r/20201109213023.15092-1-will@kernel.org
>   v3: https://lore.kernel.org/r/20201113093720.21106-1-will@kernel.org
>=20
> and which started life as a reimplementation of some patches from Qais:
>=20
>   https://lore.kernel.org/r/20201021104611.2744565-1-qais.yousef@arm.com
>=20
> The aim of this series is to allow 32-bit ARM applications to run on
> arm64 SoCs where not all of the CPUs support the 32-bit instruction set.
> Unfortunately, such SoCs are real and will continue to be productised
> over the next few years at least.

Out of curiosity, what systems are that?

Is the 32-bit available on the big or on the little cores?

And... fun way to accelerate demise of arm32 :-).

Best regards,
									Pavel
--=20
http://www.livejournal.com/~pavelmachek

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/L8NUACgkQMOfwapXb+vJKawCgoM+JfmKVtgscUMb1upqBcin4
lTMAn1VlyMbbfJqa4BTWIYugvngHmIor
=yYfr
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
