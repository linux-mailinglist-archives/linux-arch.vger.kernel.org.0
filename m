Return-Path: <linux-arch+bounces-14589-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A16CC43467
	for <lists+linux-arch@lfdr.de>; Sat, 08 Nov 2025 21:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3243B0170
	for <lists+linux-arch@lfdr.de>; Sat,  8 Nov 2025 20:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF6E22422A;
	Sat,  8 Nov 2025 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNKbxfnK"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A8D26ACB;
	Sat,  8 Nov 2025 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762632180; cv=none; b=NYx+tTSXiLHctrU7nN3+9EgG2kBs/iRCpoPb74ODxYhv2i4jcqC0k+DocnKzi2NpDNz9SHNwtb3b4dFupOtNj1nHPS8lppPhrO5RE6axgWhXzq07CdVxqxVoZ+6Xz0Bi/0llQQBvH/wOEhXqDhrEyv1vrHFYi+5IH99/2WvUZd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762632180; c=relaxed/simple;
	bh=mZx3reTRacDiFfpeRs79kIi23F+uPMRdn0mb7yCb4lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTL/tG73w5icU/I0SUiOoB/+cwj/92zRowZCmVfbkV+6OKG/V+ieHlb2fb8IAHb2WamhSEwAELR9d7lRDXZMo3JBvtqRr+5bS3N8YHpsk9TgLW+nWGNiw3oECu73j3LLaiRckIIBXPA3pUhdc9TCMyrUcyn8IuPhakInjdJxYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNKbxfnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DD7C19422;
	Sat,  8 Nov 2025 20:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762632180;
	bh=mZx3reTRacDiFfpeRs79kIi23F+uPMRdn0mb7yCb4lA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNKbxfnKqppFyjDbgVviqAKjzuqyrl142Vll5JtXbXhMZx9ScsfOQGWSjhVrVnTF/
	 W46Amq2iHTbMWiCV73eSF5dNnu4nOzVILXSQ0LwZNmPAfs5De8lf7RP8n0+ocYLUNm
	 Y0VB9/W4SBQYKN1XLrr7dsoUZ4XsZynyKqAhxqqge6RicKHf/c+V+JYIipWSV0NVV8
	 Lheh82/DHzO8neWxDIm+NArCVP+u2Y2PHaLtEcwgjDMqVCKMgomUWZB9H7QUMJRnik
	 NCFaIIMPr9Rrq/TqyVfDXSRrfIjwbI19FqZ5vVSIzcx/P5X6qOHcwJMWBACW0al3Fw
	 9iOlOfua0KiDQ==
Date: Sat, 8 Nov 2025 20:02:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, arnd@arndb.de
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
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
Subject: Re: [PATCH v5 0/6]  Cache coherency management subsystem
Message-ID: <20251108-spearmint-contend-aa3dd8a0220e@spud>
References: <20251031111709.1783347-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BnXojPaReIke2Qi9"
Content-Disposition: inline
In-Reply-To: <20251031111709.1783347-1-Jonathan.Cameron@huawei.com>


--BnXojPaReIke2Qi9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Arnd,

On Fri, Oct 31, 2025 at 11:17:03AM +0000, Jonathan Cameron wrote:
> Support system level interfaces for cache maintenance as found on some
> ARM64 systems. It is expected that systems using other CPU architectures
> (such as RiscV) that support CXL memory and allow for native OS flows
> will also use this. This is needed for correct functionality during
> various forms of memory hotplug (e.g. CXL). Typical hardware has MMIO
> interface found via ACPI DSDT. A system will often contain multiple
> hardware instances.
>=20
> Includes parameter changes to cpu_cache_invalidate_memregion() but no
> functional changes for architectures that already support this call.
>=20
> How to merge?
> - Current suggestion would be via Conor's drivers/cache tree which routes
>   through the SoC tree.

I was gonna put this in linux-next, but I'm not really sure that Arnd
was satisfied with the discussion on the previous version about
suitability of the directory: https://lore.kernel.org/all/20251028114348.00=
0006ed@huawei.com/

Arnd, did that response satisfy you, or nah?

Cheers,
Conor.

>   *  Andrew Morton has expressed he is fine with the MM related changes
>      going via another appropriate tree.
>   *  CXL maintainers expressed that they don't consider it appropriate
>      to go through theit tree.
>   *  The tiny touching of Arm specific code has an ack from Catalin.

--BnXojPaReIke2Qi9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQ+h7AAKCRB4tDGHoIJi
0mbmAPoDNoN5c++N+FdbOde62VPsuE/nQLuJqXMbpVYRgssj5gD9HgGSIr/5NCGC
GU4C//DABkFlJ0fo45ADpizmnDu8JQ8=
=3UFm
-----END PGP SIGNATURE-----

--BnXojPaReIke2Qi9--

