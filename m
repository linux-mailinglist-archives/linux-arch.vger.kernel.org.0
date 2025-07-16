Return-Path: <linux-arch+bounces-12817-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C886B07839
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 16:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BCDA5839D9
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 14:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E8A253F00;
	Wed, 16 Jul 2025 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt45FC45"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9747519AD5C;
	Wed, 16 Jul 2025 14:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676519; cv=none; b=Rk2qAOQ1++My9bdSUwtSMbgA3YqUQkn8KQhAi8XtQPWGl8sN2xDDYCrNiyV1mcwtGjaj9U80f01GEuWiMrE+w2CEOwkGicpQB44Fls/u+xzX7zs05zHq+zF9Z5zr2ZGDQgR9hmP2hDMHwXXHZyJdpbujut7bbBbT2h64FF9KGkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676519; c=relaxed/simple;
	bh=m6dMr4mmc+ehuhuOcxxv5TIdC9hKtCvMg4Uo67cqnrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtLv/tuR3GVYoidNhCQ9NJXcWbr0aTNne08Hg9JUVxYkQN6oMNfg35Ceh3layWK1DYTku2lsmHTlWB94oKfBi63xwb5KYLHAf/huAUpeHPm/yLEJWGDt0gfmKSZNeBk5e/YwEPyteI5C7wCK9JEtkpbUJCRJYq0HF7fFsYxARrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt45FC45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14A3C4CEEB;
	Wed, 16 Jul 2025 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752676517;
	bh=m6dMr4mmc+ehuhuOcxxv5TIdC9hKtCvMg4Uo67cqnrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dt45FC45lr4Y5Yj3uPvtIZIp6ciObQ9O2GVHJqBWqI/DLPZcpWsBg+1utqSq+YDw+
	 TTJ19/zC3kTV+soJUz1OQg6F20EoxtqkYFznrlG07TYT9OwefLF+uUOoxgh73ZfBBh
	 8SLneOMyK6P6c1iwB2WDkSzSjY245qEG5+H7F2QqcQx2Mh9mjqPlZFwKhRcF5+24Ct
	 cNsz5f+KIF7vHtSZJm9SAA2iNaGsi09yJS4bgJ5Rq9l9ZvQpLb37Tq3YiEMeKhwgUF
	 3O9gxF1imLn9OunEnp/rcY/rLf2AqX97EG5ibd/BdzyrfVM1RgO08vlXbJqogYNczt
	 9YD87lNN0ufMw==
Date: Wed, 16 Jul 2025 15:35:09 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Christopher Hall <christopher.s.hall@intel.com>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Werner Abt <werner.abt@meinberg-usa.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Nam Cao <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH 06/14] vdso/gettimeofday: Return bool from
 clock_gettime() helpers
Message-ID: <69499cb9-b13b-4eec-a7c4-c219a77c6260@sirena.org.uk>
References: <20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
 <02bcd954-5323-4663-a766-f53c67c5a18f@samsung.com>
 <CGME20250708154921eucas1p1fd8fa4374610a991ca5c67bd612ca0c2@eucas1p1.samsung.com>
 <e8c6b9a7-eaa6-4947-98e1-9d6fecc958d4@samsung.com>
 <20250709092958-37148883-ed89-40fe-8cd5-ded5dd60957e@linutronix.de>
 <eb5feef3-0a7d-438c-9dbb-00d1d72fad66@samsung.com>
 <6bee5ae0-2a9e-4793-a5bd-9e6c72b03f27@sirena.org.uk>
 <20250716142933-41089f40-0628-4821-83a3-fddbd4c4f9bf@linutronix.de>
 <3a9504d1-2c6a-459a-a98e-3010d34b546c@sirena.org.uk>
 <20250716152041-189100b1-7f5e-4388-8ada-b79ec09d18f5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BuIqEQ3Xb0IJOloe"
Content-Disposition: inline
In-Reply-To: <20250716152041-189100b1-7f5e-4388-8ada-b79ec09d18f5@linutronix.de>
X-Cookie: osteopornosis:


--BuIqEQ3Xb0IJOloe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 03:23:24PM +0200, Thomas Wei=DFschuh wrote:

> Can you try the following?
> I missed this despite the double-checking after the last reported issue.

I needed to fix that up a bit, it was missing an update of the final ret
in the function and didn't apply directly to -next for some reason so I
had to manually apply but it seems to do the trick, thanks!

Tested-by: Mark Brown <broonie@kernel.org>

with this against -next:

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 97aa9059a5c97..487e3458e536e 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -365,18 +365,18 @@ __cvdso_clock_gettime32_data(const struct vdso_time_d=
ata *vd, clockid_t clock,
 			     struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
-	int ret;
+	bool ok;
=20
-	ret =3D __cvdso_clock_gettime_common(vd, clock, &ts);
+	ok =3D __cvdso_clock_gettime_common(vd, clock, &ts);
=20
-	if (unlikely(ret))
+	if (unlikely(!ok))
 		return clock_gettime32_fallback(clock, res);
=20
-	/* For ret =3D=3D 0 */
+	/* For ok =3D=3D true */
 	res->tv_sec =3D ts.tv_sec;
 	res->tv_nsec =3D ts.tv_nsec;
=20
-	return ret;
+	return 0;
 }
=20
 static __maybe_unused int

--BuIqEQ3Xb0IJOloe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh3uJ0ACgkQJNaLcl1U
h9CA4Af/Tjt27XD+sH0XsHGiqrvVkfVxva7ofqhkGScEh/mKgfSbmkbXHANzMMcN
i0cqh+YA1JvkdO9PRMQKygFdjOmHF6f8fLJ89tv362PI4fWlABSmiorpUwrX/J76
1DnAJBk3+BI/Ea4E5KVldzfU+figgDJeX1YWeicBcnGCnMrdHPub+24Wgclm4MIs
mxPCfZnczo7mLioF3QxjetxtWIFrsPNxoRJp7kJN0Kyz6lGJQBmZc+dY1UzEVtyR
GBCX/hWkjFxJzX9EBQ3d7C/LgP6AuvykylzYC2M5AZC9TOzvRpEhjp6WGJHCRrwa
K72ju7AAJ/9Vit9ykmOIMbQUpAZUYA==
=rAsr
-----END PGP SIGNATURE-----

--BuIqEQ3Xb0IJOloe--

