Return-Path: <linux-arch+bounces-10327-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8388BA40651
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2025 09:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D380719C76F3
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2025 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3220F2063D6;
	Sat, 22 Feb 2025 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="ndlk6Xh1"
X-Original-To: linux-arch@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AC62010FD;
	Sat, 22 Feb 2025 08:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740212468; cv=none; b=IYFM3WwrYIKsysQ1pRRce/E/xCzzfJ4/vatz4f0KCWdBIhIN01aSPJYxzgnPTIQbktaJBsHMSlW4F896d1S/Bypt4alc3wfrTbRM6XIfoQPRtDqPSAhLNG/d06NVq9MquHQF/iFzj1PvV04MzLcA02Oiia/qiJc9L9VvTyOazC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740212468; c=relaxed/simple;
	bh=C95UfLmMcJXU7vJhaKdMpplzfIPky73B5XuPmB/zLbg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BmDWcHKoKh6ZiHX34JuxHc5PpoR+XJSrokLgY86vxilElGRy8/RaSeHnMXRI+fNvYicazGyd3xqfMtDaww5wKTcLlFT5UHm0csqqa89m/xRKDCUwimr9lOzUk03uhg/Et2NHqF0dzcvddJilCzGC4cmB67X8e03vZyn1stw3pY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=ndlk6Xh1; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1740212460;
	bh=1q+MziLP+LRP2VrK2FzjijCA1tPSm0Mct61S8QV7OY4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ndlk6Xh1LDQ4IVzyCwXm+//RroUMYlrg93bkaGOnu/PB6zPDKJjYVM1f8u1zbnorm
	 6Wj9dxVkDjMZ8iYBCSeLLJkBb4sDAbSbTyaqhai1+lbpRWyuiyTuixexNlOL6xLK8h
	 Mbghzm1Uih9WOBd+JPF+dxhjdCJtmTB+W3bP4HQ8=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id BF6C9676E3;
	Sat, 22 Feb 2025 03:20:52 -0500 (EST)
Message-ID: <afc16fdc2417c3a761b880950c6c03998366e92f.camel@xry111.site>
Subject: Re: [PATCH v3 10/18] LoongArch: vDSO: Switch to generic storage
 implementation
From: Xi Ruoyao <xry111@xry111.site>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge
 Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>,  Thomas Gleixner
 <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Anna-Maria Behnsen	 <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon	 <will@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, "Jason A. Donenfeld"	 <Jason@zx2c4.com>, Paul
 Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt	 <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Huacai Chen	 <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Russell King	 <linux@armlinux.org.uk>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik	 <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Thomas
 Bogendoerfer	 <tsbogend@alpha.franken.de>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao	 <naveen@kernel.org>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Ingo Molnar	 <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen	 <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,  Arnd Bergmann	
 <arnd@arndb.de>, Guo Ren <guoren@kernel.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
	linux-csky@vger.kernel.org
Date: Sat, 22 Feb 2025 16:20:51 +0800
In-Reply-To: <20250204-vdso-store-rng-v3-10-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de>
	 <20250204-vdso-store-rng-v3-10-13a4669dfc8c@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-04 at 13:05 +0100, Thomas Wei=C3=9Fschuh wrote:
> The generic storage implementation provides the same features as the
> custom one. However it can be shared between architectures, making
> maintenance easier.
>=20
> Co-developed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Tested-by: Xi Ruoyao <xry111@xry111.site>

/* snip */

> diff --git a/arch/loongarch/include/asm/vdso/getrandom.h b/arch/loongarch=
/include/asm/vdso/getrandom.h
> index e80f3c4ac7481ba7f9f5d9210fefa78c3293243b..48c43f55b039b42168698614d=
0479b7a872d20f3 100644
> --- a/arch/loongarch/include/asm/vdso/getrandom.h
> +++ b/arch/loongarch/include/asm/vdso/getrandom.h

You can drop "#include <vdso/vdso.h>" in this file.

> @@ -28,11 +28,6 @@ static __always_inline ssize_t getrandom_syscall(void =
*_buffer, size_t _len, uns
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> -static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_d=
ata(void)
> -{
> -	return &_loongarch_data.rng_data;
> -}
> -
> =C2=A0#endif /* !__ASSEMBLY__ */
> =C2=A0
> =C2=A0#endif /* __ASM_VDSO_GETRANDOM_H */

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

