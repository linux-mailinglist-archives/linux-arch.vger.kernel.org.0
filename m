Return-Path: <linux-arch+bounces-14751-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BDC5D2ED
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 13:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214293ABD28
	for <lists+linux-arch@lfdr.de>; Fri, 14 Nov 2025 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B7E230BCC;
	Fri, 14 Nov 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIDx9yAS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FED22D7A1;
	Fri, 14 Nov 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763124770; cv=none; b=jW72jM+lEKqIxHxZ3zNvbdUmTxCQOP5N8Fn/2TA0TrpVhAjgFRI7KburXKWKZcgfxKPb3a9xqVyXksS7hAZrw1Mzf8Z3v7pYnqTUHL+uu8U6P8tskB2NUG7AtG4hIqoHNDcfikeniycAvoPw9ghmVpKXoHlMjpSxSPfz7tp74J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763124770; c=relaxed/simple;
	bh=6VphuKq2Z604/Y/bm30jdFUeDgNsvqjJPARDxw7M1cQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKOnK1svoxfOMeSUIp9/TA4Tt8o3eumhAiZyztqdo4nC+YJiBPbjOTu1fVcjnkD+W7dvdhrdJ5/pmphawCo66wXys4f1E8iiwVQaZcrZ5bQwX8GOYMeBMuF1zKeYP80MGzALLAxwEahHEgw/OeeXDT18PsWvhM1aO9z4muH6MXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIDx9yAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14DAC4CEFB;
	Fri, 14 Nov 2025 12:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763124770;
	bh=6VphuKq2Z604/Y/bm30jdFUeDgNsvqjJPARDxw7M1cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QIDx9yASFfZiqhuxTYbuMYVdvwU6dUNnk/MSujK+ASdclnRPOUZbNTQuCis2Ilc1P
	 hrXneM9cQ8B4FIDoDxqrePxMR2KL+KI5xN9nKFyK/5DfnH3SbitdhzIZx1jqQyqSSQ
	 7q/APRxayxN0XdeHDdi5MxaJzyk1DmFr+EGTv39iIikknUvi1fu0TTW3yeOotU1fRU
	 /fAvtaId9qE2Avp/ifpfgmcISSPp7lm7aOGeXjR7MHTz3y5on6lVYGFmPBs1LpNijB
	 yuJXap7kcbkF97Raabtgb+KCs6nVrnt+Uund+fDtKIgdLu7WA1qJDJ+pjxrxdv95pc
	 t0QKHjPHozJ1Q==
Date: Fri, 14 Nov 2025 12:52:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: arnd@arndb.de, Catalin Marinas <catalin.marinas@arm.com>,
	linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	Dan Williams <dan.j.williams@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Drew Fustini <fustini@kernel.org>,
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
Subject: Re: [PATCH v5 0/6]  Cache coherency management subsystem
Message-ID: <20251114-juror-stiffness-046b47b8d9f7@spud>
References: <20251031111709.1783347-1-Jonathan.Cameron@huawei.com>
 <20251108-spearmint-contend-aa3dd8a0220e@spud>
 <20251114124958.00006a85@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yeJqfqlYgNstOKbS"
Content-Disposition: inline
In-Reply-To: <20251114124958.00006a85@huawei.com>


--yeJqfqlYgNstOKbS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 12:49:58PM +0000, Jonathan Cameron wrote:
> On Sat, 8 Nov 2025 20:02:52 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > Arnd,
> >=20
> > On Fri, Oct 31, 2025 at 11:17:03AM +0000, Jonathan Cameron wrote:
> > > Support system level interfaces for cache maintenance as found on some
> > > ARM64 systems. It is expected that systems using other CPU architectu=
res
> > > (such as RiscV) that support CXL memory and allow for native OS flows
> > > will also use this. This is needed for correct functionality during
> > > various forms of memory hotplug (e.g. CXL). Typical hardware has MMIO
> > > interface found via ACPI DSDT. A system will often contain multiple
> > > hardware instances.
> > >=20
> > > Includes parameter changes to cpu_cache_invalidate_memregion() but no
> > > functional changes for architectures that already support this call.
> > >=20
> > > How to merge?
> > > - Current suggestion would be via Conor's drivers/cache tree which ro=
utes
> > >   through the SoC tree. =20
> >=20
> > I was gonna put this in linux-next, but I'm not really sure that Arnd
> > was satisfied with the discussion on the previous version about
> > suitability of the directory: https://lore.kernel.org/all/2025102811434=
8.000006ed@huawei.com/
> >=20
> > Arnd, did that response satisfy you, or nah?
>=20
> Seems Arnd is busy.  Conor, if you are happy doing so, maybe push it to a=
 tree
> linux-next picks up, but hold off on the pull request until Arnd has had =
a chance
> to reply?

Yeah, I did step one of that last night and will put it in linux-next
=66rom Monday. Ultimately the PR goes to Arnd, so he can judge it there
anyway.

--yeJqfqlYgNstOKbS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaRcmGgAKCRB4tDGHoIJi
0onVAQD2iKKx0IizfAkg+H6zlKCEwvYhA65Pv6UxxL4osqTj/wD/fpvXj1YHfiHx
eyDCpQIW29m6pDBP18HBv4dusvusNww=
=yFYx
-----END PGP SIGNATURE-----

--yeJqfqlYgNstOKbS--

