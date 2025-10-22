Return-Path: <linux-arch+bounces-14274-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1E8BFE41B
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 23:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B948E3A811C
	for <lists+linux-arch@lfdr.de>; Wed, 22 Oct 2025 21:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0822DECAA;
	Wed, 22 Oct 2025 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB/NSEOY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB0275B16;
	Wed, 22 Oct 2025 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167479; cv=none; b=qn8ovFLylWHNWUuwFeCS6rz96hOfUdGYDziqwPe85psAhkaARp7Q22doyLlr4LGRLLXTkLcPNIqMwn9eVVIO/DGuqoj4sfBVYMIDVarq/Z6kwCcvZKChSS8Ak7k5qcLlmI0p2InndvJq+00tjfG0daoutPrtaZ0UncUcgf+iVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167479; c=relaxed/simple;
	bh=5v3JRmduY4uSzLf2Pqm6596Of3Jc6oNa3Sp1BFVrPsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rdd5W7oC5JxEmAO0FEcUN4NKMvPHLNB3Hvw+NFG6+jXaicPLYezaP3VhWPzYdVtlUnXgz/JCaN78WyUxuP0SkOdykxWkranRVk15x3/JH+D1qMMnfb8S8d56WDSApGr2c7jHOQipDvkpgvFsnm2H+m6k7qsHB2JrD//MbMoQj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB/NSEOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578E7C4CEE7;
	Wed, 22 Oct 2025 21:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761167478;
	bh=5v3JRmduY4uSzLf2Pqm6596Of3Jc6oNa3Sp1BFVrPsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WB/NSEOYaZfqO71RaPt4ZWYdN0blDNxWfW5ICS4fnS9/Stg8tNvDA58HxOwxxfAop
	 6hilG6zy+ngXSW5OHpCRTxNenF9Bk2EaGFRCumPTjrRK/bVON+bnvy/p0jMxSCxSLz
	 Mp+CQpC8F2aarMsxM/M65yF0VX2LxhP4WqDUOqiQqQxpBBwSLDBsOAGAEp/+f54G0J
	 5gfATau19beB423OmBeJDw9m3Jlk4q89eSCMKQ4jChXPVDrj46xZpnq4bMGDdW6jjZ
	 TIcUJFiK3RcYlJnhG+XHlTjtlGrXivlL71exLBuObtDML9tzLkoDNFK+ey2dSEnLdw
	 wIQpY+RrFrnDw==
Date: Wed, 22 Oct 2025 22:11:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>, james.morse@arm.com,
	Will Deacon <will@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	linuxarm@huawei.com, Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v4 3/6] lib: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
Message-ID: <20251022-tried-alright-752fa98ff086@spud>
References: <20251022113349.1711388-1-Jonathan.Cameron@huawei.com>
 <20251022113349.1711388-4-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Vn2cL8c0hs3HiHri"
Content-Disposition: inline
In-Reply-To: <20251022113349.1711388-4-Jonathan.Cameron@huawei.com>


--Vn2cL8c0hs3HiHri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 12:33:46PM +0100, Jonathan Cameron wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
>=20
> ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION provides the mechanism for
> invalidating certain memory regions in a cache-incoherent manner. Current=
ly
> this is used by NVDIMM and CXL memory drivers in cases where it is
> necessary to flush all data from caches by physical address range.
>=20
> In some architectures these operations are supported by system components
> that may become available only later in boot as they are either present
> on a discoverable bus, or via a firmware description of an MMIO interface
> (e.g. ACPI DSDT). Provide a framework to handle this case.
>=20
> Architectures can opt in for this support via
> CONFIG_GENERIC_CPU_CACHE_MAINTENANCE
>=20
> Add a registration framework. Each driver provides an ops structure and
> the first op is Write Back and Invalidate by PA Range. The driver may
> over invalidate.
>=20
> An optional completion check operation is also provided. If present
> that should be called to ensure that the action has finished.
>=20
> When multiple agents are present in the system each should register with
> this framework and the core code will issue the invalidate to all of them
> before checking for completion on each. This is done to avoid need for
> filtering in the core code which can become complex when interleave,
> potentially across different cache coherency hardware is going on, so it
> is easier to tell everyone and let those who don't care do nothing.
>=20
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

I'm fine with this stuff. I do wonder though, have you actually
encountered systems with the multiple "agents" or is that something
theoretical?

--Vn2cL8c0hs3HiHri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPlIcAAKCRB4tDGHoIJi
0ilcAQCnVKkCAStY/FbYOAkfI+W/JVlX+Y1Vm+WSmJKzsDcbvwD/WDlSH0CF9gAy
unvtdkqI/cCeZqx8cis9fpSarDvOjQY=
=Xs5l
-----END PGP SIGNATURE-----

--Vn2cL8c0hs3HiHri--

