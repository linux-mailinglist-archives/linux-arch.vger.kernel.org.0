Return-Path: <linux-arch+bounces-15842-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E51D39150
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 23:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD1753011B2F
	for <lists+linux-arch@lfdr.de>; Sat, 17 Jan 2026 22:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3352D2381;
	Sat, 17 Jan 2026 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lM4fMndR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746A18E1F;
	Sat, 17 Jan 2026 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768687509; cv=none; b=b7e9tgijnATxBUEjYu9kw1kIbawRs1nfZHDHFyCDeXXiSJ5JJVc7yPK28jFZITfmKO0VyJITc4lwFxNLini3P4tCVxXiTzRydBCSfPhi7/umm9g6fZD/wSzAIFLg3fNUtBGIaEigUAhIPvuL97jevns4NIDQwQA+QYEAujBftMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768687509; c=relaxed/simple;
	bh=WQTK7eDVQjh0COaMCjREUeY6vjpp+G+IPv4jTL59tNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FjVlDDb1Rzof2tJcsTkn1lz5nXVMoJR0eK4UrGI5BnY2bsOlBI+dC598mMjDm+2RY7bAYHWsimyM/FQDuzTjCdCEZyY/nrUw95y23FKUM4XetUMZV99deps/74cVWRqvZziLLWl9OO0dpe0fz5TayR9MlRDXEZZ2Hn/GZ1QPt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lM4fMndR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E19C4CEF7;
	Sat, 17 Jan 2026 22:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768687509;
	bh=WQTK7eDVQjh0COaMCjREUeY6vjpp+G+IPv4jTL59tNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lM4fMndR2w73kfdJlsiEZu82pogT+t9347UVMnT9l3MZSZ/iTnEYoEFMnfsKiw0lS
	 X0tYHdVarX4dUaaBpFAyd1BSggQ3sGqUGJJ2QgeqUDvr8jeBRS434vCKQNAq0a0Mhg
	 fw3GkuGR9mG28yQhjcD7tiL5XH6TsMZtzGppPgDFBoMrhfptXZrqlQRxaE+hEqetZo
	 +cZ9sDa8Je8Gsnse2A72aSC1u2OidodP56ddJalqHwBlgs5VZBE/xKWrNotdoKq5a1
	 11yStfRCeyOCUiADySCGKhGWD4FcO+lllWXzoalJ3FM9cFsXL2TsDWqGaqgdDDTzAU
	 DRG/HvdNK1n6g==
From: Thomas Gleixner <tglx@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Andy
 Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann
 <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Sun Jian <sun.jian.kdev@gmail.com>
Subject: Re: [PATCH 2/4] x86/vdso: Use 32-bit CHECKFLAGS for compat vDSO
In-Reply-To: <20260116-vdso-compat-checkflags-v1-2-4a83b4fbb0d3@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-2-4a83b4fbb0d3@linutronix.de>
Date: Sat, 17 Jan 2026 23:05:05 +0100
Message-ID: <87bjir3nfy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16 2026 at 08:40, Thomas Wei=C3=9Fschuh wrote:
> Manually override the CHECKFLAGS for the compat vDSO with the correct
> 32-bit configuration.

Fun. I just fixed the same thing half an hour ago:

   https://lore.kernel.org/lkml/20260117215542.342638347@kernel.org/

> Reported-by: Sun Jian <sun.jian.kdev@gmail.com>
> Closes: https://lore.kernel.org/lkml/20260114084529.1676356-1-sun.jian.kd=
ev@gmail.com/
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/x86/entry/vdso/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index f247f5f5cb44..ab571ad9b9ac 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -142,7 +142,10 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
>  endif
>  endif
>=20=20
> +CHECKFLAGS_32 :=3D $(CHECKFLAGS) -U__x86_64__ -D__i386__ -m32

Hmm. That keeps -m64. Seems not to matter much, but substituting both
seems to be more correct.

Thanks,

        tglx

