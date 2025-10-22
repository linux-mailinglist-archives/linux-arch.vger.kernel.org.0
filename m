Return-Path: <linux-arch+bounces-14273-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD60BFE37F
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 22:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EC764FD03C
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 20:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDA5301009;
	Wed, 22 Oct 2025 20:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMDWLrfV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBD43009C3;
	Wed, 22 Oct 2025 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166048; cv=none; b=RBLZKQwkbbZZMtxds+IdV0kUero4q5sB05W7dTPeIBpbuwDwldV/NSjtgeEGZmt60TUBzFIGL91TbRRY3UXU3m2F+ytAbBjYvi4Nbyeiqx1eYUHe6t2FgUFpD7N4x4DghyVUJK5bXVgcurr/JLnb6XLs1rZhE1o/hKMQFwEe+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166048; c=relaxed/simple;
	bh=e4wpAeuwnWxwPsv6xR22bTAFdrGhHjpoATj1khsZ/3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjZaTWtmpIHvdKZ+xMOTAGundTbepc5SX2rsiVrm7AkW/M6OYfGN9DY5oF0insv/OAhaL39svhAl0cz3TH+V3wgcDuY0LB0hscXEwL2mcIcsrFwgnbOyAM2oJnhpeywdBbFR2QDY/IAmvvEE3FzTvqG77BQlQ4JzcgnzcyXVoEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMDWLrfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F71BC4CEE7;
	Wed, 22 Oct 2025 20:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761166047;
	bh=e4wpAeuwnWxwPsv6xR22bTAFdrGhHjpoATj1khsZ/3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMDWLrfV+vZznUoPf7CPswB3dBThpbX2cO+2bWvkQ50o2TCrvoCdE1Cd8xXrUFRoi
	 4RQOPMKhr+0tnSOK+DiKcMtj1oDkCTxPA4mHmnI44BotWVAjb9ldTnLMyTQjyS1Glb
	 ijl24xdpzSdzrCZEKhn++IHDQPpZbUdTkCvlJsrAxJb/YRqToadM7K56X3TBjl4HEM
	 Kyj7DofAye5roHM4RI4hcbcHBS9HAWzaMufkLYbmgqUo5c4mw2HV49+ecHPYhV766I
	 BEuFIsEhcM7FbKPeKnO/YdST5KXQbtfPvLsfWmyESS1GnxaOKoG42xaOoXjHPKwp4J
	 2Yalv6aXeJwRQ==
Date: Wed, 22 Oct 2025 21:47:21 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	Dan Williams <dan.j.williams@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, james.morse@arm.com,
	Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	linuxarm@huawei.com, Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v4 0/6] Cache coherency management subsystem
Message-ID: <20251022-harsh-juggling-2d4778b0649e@spud>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
 <20251022122241.d2aa0d7864f67112aa7691bf@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="S6HWZzkHmuKfgcDz"
Content-Disposition: inline
In-Reply-To: <20251022122241.d2aa0d7864f67112aa7691bf@linux-foundation.org>


--S6HWZzkHmuKfgcDz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:22:41PM -0700, Andrew Morton wrote:
> On Wed, 22 Oct 2025 12:33:43 +0100 Jonathan Cameron <Jonathan.Cameron@hua=
wei.com> wrote:
>=20
> > Support system level interfaces for cache maintenance as found on some
> > ARM64 systems. This is needed for correct functionality during various
> > forms of memory hotplug (e.g. CXL). Typical hardware has MMIO interface
> > found via ACPI DSDT.
> >=20
> > Includes parameter changes to cpu_cache_invalidate_memregion() but no
> > functional changes for architectures that already support this call.
>=20
> I see additions to lib/ so presumably there is an expectation that
> other architectures might use this.
>=20
> Please expand on this.  Any particular architectures in mind?  Any
> words of wisdom which maintainers of those architectures might benefit
> from?

It seems fairly probable that we're gonna end up with riscv systems
where drivers are being used for both this and the existing non-standard
cache ops stuff.

> > How to merge?  When this is ready to proceed (so subject to review
> > feedback on this version), I'm not sure what the best route into the
> > kernel is. Conor could take the lot via his tree for drivers/cache but
> > the generic changes perhaps suggest it might be better if Andrew
> > handles this?  Any merge conflicts in drivers/cache will be trivial
> > build file stuff. Or maybe even take it throug one of the affected
> > trees such as CXL.
>=20
> Let's not split the series up.  Either CXL or COnor's tree is fine my
> me.

CXL is fine by me, greater volume there probably by orders of magnitude.

--S6HWZzkHmuKfgcDz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPlC2QAKCRB4tDGHoIJi
0tdvAQDJHGwCvxYrXGJs6nPPk7w5pV6+UajlzpKhldIVtCgm2QD/XrQK+qDLbAJA
ymsJdZLdZoCSVVQ542yRJc4RjGzDnA8=
=4U3B
-----END PGP SIGNATURE-----

--S6HWZzkHmuKfgcDz--

