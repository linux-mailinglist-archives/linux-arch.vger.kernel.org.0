Return-Path: <linux-arch+bounces-14852-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4A7C66A08
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 01:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C95135A705
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 00:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455B28635D;
	Tue, 18 Nov 2025 00:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNjrX6GQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3CB2AD35;
	Tue, 18 Nov 2025 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763424798; cv=none; b=c5VcyGv6o4Q/MgQMjZGDtjTIjEl0jBGzMErBZpxHLFk2Rq7gK7CQj+Rjck8iqL82MzBBNqVhu6YwtBqtoqZweTu5XqSPEQgaC2mEDa3ZnVQsghP+4y8ZHFKAjxn0euJt+dRE7ClI18B5AKq3N0Tdg3VDgS1oFI9c+42Fjp0Osr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763424798; c=relaxed/simple;
	bh=FA/B9Ov2AMGG74Hew1VbR3PJqHVMWv8DmTnLRuNyv0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aueGQWBGCf1ahJZeIEYuYcWL9w8eWkQ6rSjVo4oXaE8P88O91Z3YpauB+Nny48dUy3//VEUp0CuvUzzIzpafindOnAFxZtR555+VgBumVkhkMC0ZT6ObYu3LJmOz1BWbjSRVxPPX3l38vQs/c+/7h0Rw+b13vfThWCBrrUVmSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNjrX6GQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7D3C19423;
	Tue, 18 Nov 2025 00:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763424796;
	bh=FA/B9Ov2AMGG74Hew1VbR3PJqHVMWv8DmTnLRuNyv0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NNjrX6GQ+2j8/hvb2kxvzwqGZySojwDESUweIZ6sgye6A2Zs8p2VLCSnIY9CWNEge
	 l6jE1bXGcJlT6JVMl+clC6zD8DQcisfaVPJoALcYuLz//pHVm1DfLtH1js7bZeoH4K
	 wpqR8wUS/9tKTnGzCLxGS/6NgI3dOU86jdcDrGFJ1DVnaPFPXgAI9vaEnGOUuOLtOu
	 udFawlouxXWSbfDO4zfuGq9kecgERtnjuIuMMyOQDbKNSZC5mHBPOVGVCFNDbOlmyD
	 hFXfuHFNBaZIaoM2EWytAijxyehm7iVJP7mXxnnbZEg3uvj5zENTdALE6Wond1oGjZ
	 n7K3V+abTjNYw==
Date: Tue, 18 Nov 2025 00:13:07 +0000
From: Conor Dooley <conor@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
Message-ID: <20251117-definite-uncounted-7cc07a377a71@spud>
References: <20251117104800.2041329-1-Jonathan.Cameron@huawei.com>
 <20251117104800.2041329-4-Jonathan.Cameron@huawei.com>
 <3bf1793a-2ffd-4017-b4bf-dc63f3a2a7c8@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BAm6i4nhj7rGKbyg"
Content-Disposition: inline
In-Reply-To: <3bf1793a-2ffd-4017-b4bf-dc63f3a2a7c8@infradead.org>


--BAm6i4nhj7rGKbyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 10:51:11AM -0800, Randy Dunlap wrote:
> Hi,
>=20
> On 11/17/25 2:47 AM, Jonathan Cameron wrote:
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index e629449dd2a3..e11136d188ae 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -542,6 +542,10 @@ config MEMREGION
> >  config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> >  	bool
> > =20
> > +config GENERIC_CPU_CACHE_MAINTENANCE
> > +	bool
> > +	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> > +
> >  config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
> >  	bool
>=20
> Architectures and/or platforms select ARCH_HAS_*.
>=20
> With this change above, it becomes the only entry in
> lib/Kconfig that does "select ARCH_HAS_anytning".
>=20
> so I think this is wrong, back*wards.

Maybe it is backwards, but I feel like this way is more logical. ARM64
has memregion invalidation only because this generic approach is
enabled, so the arch selects what it needs to get the support.
Alternatively, something like
| diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
| index 5f7f63d24931..75b2507f7eb2 100644
| --- a/arch/arm64/Kconfig
| +++ b/arch/arm64/Kconfig
| @@ -21,6 +21,7 @@ config ARM64
|  	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
|  	select ARCH_HAS_CACHE_LINE_SIZE
|  	select ARCH_HAS_CC_PLATFORM
| +	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
|  	select ARCH_HAS_CURRENT_STACK_POINTER
|  	select ARCH_HAS_DEBUG_VIRTUAL
|  	select ARCH_HAS_DEBUG_VM_PGTABLE
| @@ -146,7 +147,6 @@ config ARM64
|  	select GENERIC_ARCH_TOPOLOGY
|  	select GENERIC_CLOCKEVENTS_BROADCAST
|  	select GENERIC_CPU_AUTOPROBE
| -	select GENERIC_CPU_CACHE_MAINTENANCE
|  	select GENERIC_CPU_DEVICES
|  	select GENERIC_CPU_VULNERABILITIES
|  	select GENERIC_EARLY_IOREMAP
| diff --git a/lib/Kconfig b/lib/Kconfig
| index 09aec4a1e13f..ac223e627bc5 100644
| --- a/lib/Kconfig
| +++ b/lib/Kconfig
| @@ -544,8 +544,9 @@ config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
|  	bool
| =20
|  config GENERIC_CPU_CACHE_MAINTENANCE
| -	bool
| -	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
| +	def_bool y
| +	depends on ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
| +	depends on ARM64
| =20
|  config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
|  	bool
implies (to me at least) that arm64 has memregion invalidation as an
architectural feature and that the GENERIC_CPU_CACHE_MAINTENANCE option
is a just common cross-arch code, like generic entry etc, rather than
being the option gating the drivers that provide the feature in the
first place.

I didn't really care which way it went, and was gonna post something to
squash and avoid another revision, but I found the resultant Kconfig
setup to be make less sense to me than what came before. If the switched
around version is less likely to be problematic etc, then sure, but I
amn't convinced by switching it at a first glance.

--BAm6i4nhj7rGKbyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRu6EgAKCRB4tDGHoIJi
0nZFAQDM8N23xRqxSRbXxCvV9U3SK6crnsbKb90b4UmJQ3Sp2AD+KZGuSHNYRHyF
VDJQehUnQg16E9RkkY+PqRspoEYItwc=
=ZlO7
-----END PGP SIGNATURE-----

--BAm6i4nhj7rGKbyg--

