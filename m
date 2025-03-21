Return-Path: <linux-arch+bounces-11041-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7FCA6C5FE
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 23:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1322D189554E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 22:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273E622AE5D;
	Fri, 21 Mar 2025 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDTGb5ab"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EA15D5B6;
	Fri, 21 Mar 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742596342; cv=none; b=Jgl/H5xT1lHITiV0ETkg8YCDBdhAtmn0cTJnZOngLD8kaBo3nEVu1kJ6ceXSEOeX0NHr34aiE1Cpgu/iK4wIU3GFE8NKL7kF/iwM5X2DFNmaNrOOb/Jrl9PX1pmiENj0SmMH+UrCFhVMHrOTJDECxdbhGz+uUyjliJR5jD3jl9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742596342; c=relaxed/simple;
	bh=UzLNiQ5Wvn9rKAUANHTjv00uwdzSTTzEUgki6vN47rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvG1pg8s5aIUGKoUNvZ+Ov0RRnl8OJuf2fnKdD8uKufMbEkcdSAbjEtni3Tp3ws7NlhCKMqedGhvIF+u8Xyv8bFBVMYggPNqZwwU77imTabdeRigv+GnK/TZHxyCg4On8duRIF8QMER90zc1A+Kv8AKyjQkGOzOuI9g2LNBTO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDTGb5ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF287C4CEE3;
	Fri, 21 Mar 2025 22:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742596340;
	bh=UzLNiQ5Wvn9rKAUANHTjv00uwdzSTTzEUgki6vN47rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDTGb5abR2KDLvK+8ds6skrd6W1UtIQ/hokDvvG5OHnrB5GRHzihjplyW9Dr6mGpr
	 tEFr6YgI0z7nOq6Kx1wY3wBBfL5doWPuT5YcTSDhhAUucE8NvOQMIA0N9ya7UAm4fU
	 Pb3O3ag7abVK/wR4RA8RqfmEbPRIEgpRBdh7dyJtt9VAYOPHFmnSzMGyM2u6cZusYc
	 mWDW9sq91fVXSWYLo2rhrIdcTxgPAzhU0SAyO+t38GtP/8FppDTrHGkR3eLlvoEzoD
	 3mwDR9Fy85FsneXge0VU8VtdxCaPsGl6+nMjgHrPGVaYbRTWumxuYDjRLg6I5kWrhN
	 Aom54EoL5NaEQ==
Date: Fri, 21 Mar 2025 22:32:15 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	james.morse@arm.com, Yicong Yang <yangyicong@huawei.com>,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linuxarm@huawei.com, Yushan Wang <wangyushan12@huawei.com>,
	linux-mm@kvack.org, gregkh@linuxfoundation.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH 0/6] Cache coherency management subsystem
Message-ID: <20250321-failing-squatted-37a88909bde2@spud>
References: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eWBfxz5cC1rG3K4K"
Content-Disposition: inline
In-Reply-To: <20250320174118.39173-1-Jonathan.Cameron@huawei.com>


--eWBfxz5cC1rG3K4K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 05:41:12PM +0000, Jonathan Cameron wrote:
> Note that I've only a vague idea of who will care about this
> so please do +CC others as needed.
>=20
> On x86 there is the much loved WBINVD instruction that causes a write back
> and invalidate of all caches in the system. It is expensive but it is
> necessary in a few corner cases. These are cases where the contents of
> Physical Memory may change without any writes from the host. Whilst there
> are a few reasons this might happen, the one I care about here is when
> we are adding or removing mappings on CXL. So typically going from
> there being actual memory at a host Physical Address to nothing there
> (reads as zero, writes dropped) or visa-versa. That involves the
> reprogramming of address decoders (HDM Decoders); in the near future
> it may also include the device offering dynamic capacity extents. The
> thing that makes it very hard to handle with CPU flushes is that the
> instructions are normally VA based and not guaranteed to reach beyond
> the Point of Coherence or similar. You might be able to (ab)use
> various flush operations intended to ensure persistence memory but
> in general they don't work either.
>=20
> So on other architectures such as ARM64 we have no instruction similar to
> WBINVD but we may have device interfaces in the system that provide a way
> to ensure a PA range undergoes the write back and invalidate action. This
> RFC is to find a way to support those cache maintenance device interfaces.
> The ones I know about are much more flexible than WBINVD, allowing
> invalidation of particular PA ranges, or a much richer set of flush types
> (not supported yet as not needed for upstream use cases).
>=20
> To illustrate how a solution might work, I've taken both a HiSilicon
> design (slight quirk as registers overlap with existing PMU driver)
> and more controversially a firmware interface proposal from ARM
> (wrapped up in made up ACPI) that was dropped from the released spec
> but for which the alpha spec is still available.
>=20
> Why drivers/cache?
> - Mainly because it exists and smells like a reasonable place.
> - Conor, you are maintainer for this currently do you mind us putting this
>   stuff in there?

drivers/cache was just something to put the cache controller drivers we
have on RISC-V that implement the various arch_dma*() callbacks in
non-standard ways that made more sense than drivers/soc/<soc vendor>
since the controllers are IP provided by CPU vendors. There's only
two drivers here now, but I am aware of another two non-standard CMO
mechanisms if the silicon with them so there'll likely be more in the
future :) I'm only really maintainer of it to avoid it being another
thing for Palmer to look after :)

I've only skimmed this for now, but I think it is reasonable to put them
here. Maybe my skim is showing, but it would not surprise me to see a
driver providing both non-standard arch_dma*() callbacks as well as
dealing with CXL mappings via this new class on RISC-V in the future..
Either way, I think it'd probably be a good idea to add ?you? as a
co-maintainer if the directory is going to be used for your proposed
interface/drivers, for what I hope is an obvious reason!

--eWBfxz5cC1rG3K4K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ93o7wAKCRB4tDGHoIJi
0qSeAQCDYiitjFXwNZKbbEFUkUXhfIYYuu03HmpuYwBJ0POhpgEAmO04672uw1BL
hytebcnudQFH53/qJg2okVO4XHPPLAw=
=cvbz
-----END PGP SIGNATURE-----

--eWBfxz5cC1rG3K4K--

