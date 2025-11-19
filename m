Return-Path: <linux-arch+bounces-14963-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20048C70B1F
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 19:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7A5A4E33DD
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EAA3043D7;
	Wed, 19 Nov 2025 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqvxYHbN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D62315785;
	Wed, 19 Nov 2025 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763577894; cv=none; b=NxJ4HzPfTMhjpWjZjm5uPGH1WDJikXnPZNS2jijCrN461sNdor+RXngyhS+znXy2IQa73mGcPYu+u91BjhfHWTex7xg0WvCRh9H0qAxLJWfoxGClUW3gXUtJerQCjRYhV+kIPMqn+1JFpQdfEaTrN9CG0OKvPTj9eIY5plS6tTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763577894; c=relaxed/simple;
	bh=7AAXhdIN9XNuNFY637AtV3mAm4gPrrFNTZMcjXFYErg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYpv7rY98SR5H4xHP6QC9RiXsotNlE5uDtQUSo75J/6LCvCSgiq5dsG0ycgT3u/7XF2ix00vsvx6kxNqTyc50SSmJh/+83KI2oMAu/5oqqBjiP1FYQYW/ka7aU+21HNTBr4xEzvyRa+VKtXjdeC3rpoTKsi572LVbhZEVyMI/IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqvxYHbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AF1C4CEF5;
	Wed, 19 Nov 2025 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763577890;
	bh=7AAXhdIN9XNuNFY637AtV3mAm4gPrrFNTZMcjXFYErg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mqvxYHbNym+xIqsVHSgdrQgyJOtvsXCayhPPiB6N/Xvv3p98UprOivIkAKOfo7tum
	 BjgCE9oANwa6vv9VBMkqKLdltF1qmWLo9ANzFpvr659h2LaYez6F3jA9FJz70tdeQJ
	 XBH/PBDaWttnGc0Z5GDo84/lH1A7gxjmFM6zL/jN3j/YzHtRzfSZWRomHTb7EvThz0
	 oyztU6NI7SNHvsvSFM1hoYk9u8MMmDnEjbIYoHsw3A6qAgfmxpMXoa/ELrr4/OO+CP
	 SOIt1uLy5+gHJzMJe41RZolswZO8i4mvTuFvAPolcdrlFh8/EX8RKHNQloElWsG/2L
	 gmQ3LNTVyCgLg==
Date: Wed, 19 Nov 2025 18:44:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	Dan Williams <dan.j.williams@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Drew Fustini <fustini@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, james.morse@arm.com,
	Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	linuxarm@huawei.com, Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v6 3/7] lib: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <20251119-charging-gallon-bea196c3a547@spud>
References: <20251117104800.2041329-1-Jonathan.Cameron@huawei.com>
 <20251117104800.2041329-4-Jonathan.Cameron@huawei.com>
 <3bf1793a-2ffd-4017-b4bf-dc63f3a2a7c8@infradead.org>
 <20251117-definite-uncounted-7cc07a377a71@spud>
 <20251118093041.00000c9e@huawei.com>
 <2241d985-0e35-41e5-93b1-1e8d4e7a84bf@infradead.org>
 <20251119094255.00000020@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8uMCJ8lN+XFmaZ3P"
Content-Disposition: inline
In-Reply-To: <20251119094255.00000020@huawei.com>


--8uMCJ8lN+XFmaZ3P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 09:42:55AM +0000, Jonathan Cameron wrote:
> On Tue, 18 Nov 2025 17:18:31 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
>=20
> > On 11/18/25 1:30 AM, Jonathan Cameron wrote:
> > > On Tue, 18 Nov 2025 00:13:07 +0000
> > > Conor Dooley <conor@kernel.org> wrote:
> > >  =20
> > >> On Mon, Nov 17, 2025 at 10:51:11AM -0800, Randy Dunlap wrote: =20
> > >>> Hi,
> > >>>
> > >>> On 11/17/25 2:47 AM, Jonathan Cameron wrote:   =20
> > >>>> diff --git a/lib/Kconfig b/lib/Kconfig
> > >>>> index e629449dd2a3..e11136d188ae 100644
> > >>>> --- a/lib/Kconfig
> > >>>> +++ b/lib/Kconfig
> > >>>> @@ -542,6 +542,10 @@ config MEMREGION
> > >>>>  config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> > >>>>  	bool
> > >>>> =20
> > >>>> +config GENERIC_CPU_CACHE_MAINTENANCE
> > >>>> +	bool
> > >>>> +	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> > >>>> +
> > >>>>  config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
> > >>>>  	bool   =20
> > >>>
> > >>> Architectures and/or platforms select ARCH_HAS_*.
> > >>>
> > >>> With this change above, it becomes the only entry in
> > >>> lib/Kconfig that does "select ARCH_HAS_anytning".
> > >>>
> > >>> so I think this is wrong, back*wards.   =20
> > >>
> > >> Maybe it is backwards, but I feel like this way is more logical. ARM=
64
> > >> has memregion invalidation only because this generic approach is
> > >> enabled, so the arch selects what it needs to get the support. =20
> > >=20
> > > Exactly this. Catalin requested this form in response to an earlier
> > > version where arm64 Kconfig just had both selects for pretty much that
> > > reason. This is expected to be used on a subset of architectures.
> > > It is similar to things like GENERIC_ARCH_NUMA in this respect (thoug=
h the
> > > arch_numa_init() etc in there are called only from other arch code
> > > so no ARCH_HAS_ symbols are associated with them).
> > >  =20
> > >> Alternatively, something like =20
> > >=20
> > > I'm fine with this solution if Randy prefers it. =20
> >=20
> > I do much prefer this alternative.
> >=20
> > > Thanks for your help with this. =20
> >=20
> > Thanks for listening.
>=20
> Conor,
>=20
> Given it is your proposed solution, I'm guessing you'll either spin a pat=
ch
> on top or squash it into original.  If you spin a patch for this.
>=20
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

New patch I think, since you say Catalin specifically asked for the
current setup.

>=20
> Thanks again!
>=20
> Jonathan
>=20
> >=20
> >=20
> > >> | diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > >> | index 5f7f63d24931..75b2507f7eb2 100644
> > >> | --- a/arch/arm64/Kconfig
> > >> | +++ b/arch/arm64/Kconfig
> > >> | @@ -21,6 +21,7 @@ config ARM64
> > >> |  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
> > >> |  	select ARCH_HAS_CACHE_LINE_SIZE
> > >> |  	select ARCH_HAS_CC_PLATFORM
> > >> | +	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> > >> |  	select ARCH_HAS_CURRENT_STACK_POINTER
> > >> |  	select ARCH_HAS_DEBUG_VIRTUAL
> > >> |  	select ARCH_HAS_DEBUG_VM_PGTABLE
> > >> | @@ -146,7 +147,6 @@ config ARM64
> > >> |  	select GENERIC_ARCH_TOPOLOGY
> > >> |  	select GENERIC_CLOCKEVENTS_BROADCAST
> > >> |  	select GENERIC_CPU_AUTOPROBE
> > >> | -	select GENERIC_CPU_CACHE_MAINTENANCE
> > >> |  	select GENERIC_CPU_DEVICES
> > >> |  	select GENERIC_CPU_VULNERABILITIES
> > >> |  	select GENERIC_EARLY_IOREMAP
> > >> | diff --git a/lib/Kconfig b/lib/Kconfig
> > >> | index 09aec4a1e13f..ac223e627bc5 100644
> > >> | --- a/lib/Kconfig
> > >> | +++ b/lib/Kconfig
> > >> | @@ -544,8 +544,9 @@ config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> > >> |  	bool
> > >> | =20
> > >> |  config GENERIC_CPU_CACHE_MAINTENANCE
> > >> | -	bool
> > >> | -	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> > >> | +	def_bool y
> > >> | +	depends on ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> > >> | +	depends on ARM64
> > >> | =20
> > >> |  config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
> > >> |  	bool
> > >> implies (to me at least) that arm64 has memregion invalidation as an
> > >> architectural feature and that the GENERIC_CPU_CACHE_MAINTENANCE opt=
ion
> > >> is a just common cross-arch code, like generic entry etc, rather than
> > >> being the option gating the drivers that provide the feature in the
> > >> first place.
> > >>
> > >> I didn't really care which way it went, and was gonna post something=
 to
> > >> squash and avoid another revision, but I found the resultant Kconfig
> > >> setup to be make less sense to me than what came before. If the swit=
ched
> > >> around version is less likely to be problematic etc, then sure, but I
> > >> amn't convinced by switching it at a first glance. =20
> >=20
> >=20
>=20

--8uMCJ8lN+XFmaZ3P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaR4QGwAKCRB4tDGHoIJi
0jzVAP485em5r734PUQARl/Redcopl3WHKhio24hv69dhS+NiwEA4Tf9EI8upkHE
ZhRrHxrcKvSCFgpopKmIEp+fHS2OBwU=
=DQ0+
-----END PGP SIGNATURE-----

--8uMCJ8lN+XFmaZ3P--

