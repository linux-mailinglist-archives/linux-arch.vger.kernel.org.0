Return-Path: <linux-arch+bounces-13828-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBCABB2122
	for <lists+linux-arch@lfdr.de>; Thu, 02 Oct 2025 01:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA76A19C429D
	for <lists+linux-arch@lfdr.de>; Wed,  1 Oct 2025 23:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365E4248F47;
	Wed,  1 Oct 2025 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5OrcNnJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B33594A;
	Wed,  1 Oct 2025 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759361502; cv=none; b=Tx9Rvs3Y17VJX5G128B8+8ZM3wJA2vOSndgXALB7eegak7UBd5UGT1jrp7B29jlXolBdYqwGXfciFQbwaoyarE81mhVZhwSTd6GcnuX3QuG0sN5z0aLwtPeflX1dM+vglqFzxKXcGlDnYNCI5yAm+ajlxih6x3qx5l4HzPDFlPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759361502; c=relaxed/simple;
	bh=OGlK5L3ggNTJFXop7r3keERa3EKrM29ZMElxPIYJMHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCiIYqRnQVyqARP47s5/l7ZIJtPpoOOHUhamfOC6j8joOfK65t4jxMrzGOnfTbaoUOgP+t/bQ5vexlTBeoYq5UCh9tUTVySO/mwG7ovWbtlcR2aHLkLIXHZ0o7bz6XfOm/z7HJEjuoMkxm6C3JgeCXlDiZZp/t3HdY0800MGfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5OrcNnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44208C4CEF1;
	Wed,  1 Oct 2025 23:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759361501;
	bh=OGlK5L3ggNTJFXop7r3keERa3EKrM29ZMElxPIYJMHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t5OrcNnJRZl6gflPLlO7LLBZEmOdJ3NXgYQ6CdBf0v3BaHJ2P+n2N3PvXwMTW9gUr
	 6EtiPCgl/JHF1O/UqUSAQpR+II3zPB4XAACMoDGzV1U309o90SzIVHUZyZGJePz0NZ
	 thzUy7XLC2KYkrjk+yhbYcz06jFv01RJjA8bbjrhyofxtjg2PQP/vFv7ik+PoVR6ci
	 fpouJohZ0OdV1MOe1uKinrV/n96glTjZou5zhNpgdGw8ha02geNWO/KBnM+N3U4xZp
	 3xYqSDeuesYjm5rRBIRiY3w5+R5FiESXDdUAxJO61jjztSAgyVQ291xNYtqdYvWHex
	 1kcqbBWu67kog==
Date: Thu, 2 Oct 2025 00:31:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, Will Deacon <will@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
	Yushan Wang <wangyushan12@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 4/8] MAINTAINERS: Add Jonathan Cameron to drivers/cache
Message-ID: <20251002-strainer-kindly-8e654868337a@spud>
References: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
 <20250820102950.175065-5-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O121PAwtnwfexBg5"
Content-Disposition: inline
In-Reply-To: <20250820102950.175065-5-Jonathan.Cameron@huawei.com>


--O121PAwtnwfexBg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:29:46AM +0100, Jonathan Cameron wrote:
> Seems unfair to inflict the cache-coherency drivers on Conor with out
> also stepping up as a second maintainer for drivers/cache.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v3: Add lib/cache_maint.c and include/cache_coherency.h
>     Conor, do you mind those two being in this entry? Seems silly to spin
>     another MAINTAINERS entry for a few 10s of lines of simple code.

Oh damn, I just found this randomly while wondering if this series was
going ahead - you forgot to CC me here! I don't mind the extra bits, I
think this makes sense, splitting it out would imply a different path
for merging.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

FWIW, I don't mind using some non-personal tree location for this, but
that's something that can be done independently if it's needed.

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa4..039d10ded9e9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23967,10 +23967,13 @@ F:	drivers/staging/
> =20
>  STANDALONE CACHE CONTROLLER DRIVERS
>  M:	Conor Dooley <conor@kernel.org>
> +M:	Jonathan Cameron <jonathan.cameron@huawei.com>
>  S:	Maintained
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
>  F:	Documentation/devicetree/bindings/cache/
>  F:	drivers/cache
> +F:	include/cache_coherency.h
> +F:	lib/cache_maint.c
> =20
>  STARFIRE/DURALAN NETWORK DRIVER
>  M:	Ion Badulescu <ionut@badula.org>
> --=20
> 2.48.1
>=20

--O121PAwtnwfexBg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaN251gAKCRB4tDGHoIJi
0toUAP0dOcmtbXnxZnNoXXCM7kD2Nsf3MpJIf+ZHnwEDwUNU6wEAvn+n1seE9hkC
hVZLo8CCugs4ulT80RBNTP9Auu7ODw8=
=p30I
-----END PGP SIGNATURE-----

--O121PAwtnwfexBg5--

