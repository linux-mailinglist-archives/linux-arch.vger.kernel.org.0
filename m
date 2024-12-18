Return-Path: <linux-arch+bounces-9427-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E27339F6A50
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 16:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE8A16DF01
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEDB1DFD9C;
	Wed, 18 Dec 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pJxxVRCM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wbyFSBHC"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B64B199FC1;
	Wed, 18 Dec 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536781; cv=none; b=pnUi7/MGKJRU5bEn/zrScPs1SDJagjL0iT6bUwmz7vWMWd8TwLVFMP18HQ/THhkHz+HaKf6vr/nRYjMTdrSgmeTpkvbFFKcSfTgwB0T8CwU1V+u5/G+71Gi32Cw2yTacOgyBwEGGcy7ZqiPmK4pQ+VrGP+E/sXrPqsuu+hafAbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536781; c=relaxed/simple;
	bh=8mzaNGbQnlEeEBZwXNXOSZYw/hPlC8f2GH3t1IuGrkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYphhJFZQiVDrpgP86NY7O0lhM0q+clnrBnU5Sx2hHOBoGYr0b739Oq0OBpDJO4G1fkPuV4bgWAV2k8pHF1Z74RAxuO8xwq9HpyPfo3iAwKvaG+VA2WDMaFiDtx1qMOvgX7vhbYLCiU84YpwLjJDJEQS03ThHQCUr1b8HUGpFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pJxxVRCM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wbyFSBHC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 16:46:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734536777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PCfBV+N+0D5I2Uv7/hn0t8iMmZx5bcl62I6AxJsW8A=;
	b=pJxxVRCMHJdngSkzFgGSzBMnBJkDpDuzYyVQMMKK8s3jy4v88LTqHGSsTUFgwaCSaDtpLZ
	9Hz+NSXpB8buHGBeis4umt1p6y1gfXS+W/AM4nWblrH5gJgmsDTKEmgPHIxrL1TURvlt99
	aT2WVnX2bYOlW3X+S+Mecm0lX7V/SRbRpNstAWH6PZljh+0jmjttXmJWtOpxsaQWnDaeRw
	l9mFBpQQhDK9hywRLcUiS2JorNnttHGskIcqaBxCKPMKpA3hMQ9YEKUiIRZnZzY8m8Wfok
	kefZk2jPlkA3QweN8xWEXObFI0S9FXUHUoYjCf486xhj3+SxKW3ibx1LPjcCaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734536777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PCfBV+N+0D5I2Uv7/hn0t8iMmZx5bcl62I6AxJsW8A=;
	b=wbyFSBHCt2AOMp8iwQLVuUtFnc5a3Q7N/OLe/EpksL5g0UriFWxndXCsQj4joqste9Sv6B
	7KCkZHwqquxkbHBQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Conor Dooley <conor@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 07/17] riscv: vdso: Switch to generic storage
 implementation
Message-ID: <20241218162031-ee920684-db10-4f17-b1cb-50373d7ea954@linutronix.de>
References: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
 <20241216-vdso-store-rng-v1-7-f7aed1bdb3b2@linutronix.de>
 <20241218-action-matchbook-571b597b7f55@spud>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218-action-matchbook-571b597b7f55@spud>

Hi Conor,

On Wed, Dec 18, 2024 at 03:08:28PM +0000, Conor Dooley wrote:
> On Mon, Dec 16, 2024 at 03:10:03PM +0100, Thomas Weiﬂschuh wrote:
> > The generic storage implementation provides the same features as the
> > custom one. However it can be shared between architectures, making
> > maintenance easier.
> > 
> > Co-developed-by: Nam Cao <namcao@linutronix.de>
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  arch/riscv/Kconfig                                 |  3 +-
> >  arch/riscv/include/asm/vdso.h                      |  2 +-
> >  .../include/asm/vdso/{time_data.h => arch_data.h}  |  8 +-
> >  arch/riscv/include/asm/vdso/gettimeofday.h         | 14 +---
> >  arch/riscv/include/asm/vdso/vsyscall.h             |  9 ---
> >  arch/riscv/kernel/sys_hwprobe.c                    |  3 +-
> >  arch/riscv/kernel/vdso.c                           | 90 +---------------------
> >  arch/riscv/kernel/vdso/hwprobe.c                   |  6 +-
> >  arch/riscv/kernel/vdso/vdso.lds.S                  |  7 +-
> >  9 files changed, 18 insertions(+), 124 deletions(-)
> 
> Fails to build:
> Patch 7/17: Test 1/12: .github/scripts/patches/tests/build_rv32_defconfig.sh
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:11:33: warning: declaration of 'struct riscv_hwprobe' will not be visible outside of this function [-Wvisibility]
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:15:41: warning: declaration of 'struct riscv_hwprobe' will not be visible outside of this function [-Wvisibility]
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:19:37: error: call to undeclared function '__arch_get_vdso_u_arch_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:19:31: error: incompatible integer to pointer conversion initializing 'const struct vdso_arch_data *' with an expression of type 'int' [-Wint-conversion]
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:22:36: error: arithmetic on a pointer to an incomplete type 'struct riscv_hwprobe'
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:30:40: error: incomplete definition of type 'const struct vdso_arch_data'
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:31:24: error: incompatible pointer types passing 'struct riscv_hwprobe *' to parameter of type 'struct riscv_hwprobe *' [-Werror,-Wincompatible-pointer-types]
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:35:7: error: call to undeclared function 'riscv_hwprobe_key_is_valid'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:35:35: error: incomplete definition of type 'struct riscv_hwprobe'
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:36:5: error: incomplete definition of type 'struct riscv_hwprobe'
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:36:18: error: incomplete definition of type 'const struct vdso_arch_data'
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:36:44: error: incomplete definition of type 'struct riscv_hwprobe'
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:39:5: error: incomplete definition of type 'struct riscv_hwprobe'
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:40:5: error: incomplete definition of type 'struct riscv_hwprobe'
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:43:4: error: arithmetic on a pointer to an incomplete type 'struct riscv_hwprobe'
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:49:39: warning: declaration of 'struct riscv_hwprobe' will not be visible outside of this function [-Wvisibility]
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:53:37: error: call to undeclared function '__arch_get_vdso_u_arch_data'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:53:31: error: incompatible integer to pointer conversion initializing 'const struct vdso_arch_data *' with an expression of type 'int' [-Wint-conversion]
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:55:36: error: arithmetic on a pointer to an incomplete type 'struct riscv_hwprobe'
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:71:61: error: incomplete definition of type 'const struct vdso_arch_data'
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:71:29: error: use of undeclared identifier 'RISCV_HWPROBE_WHICH_CPUS'
>   /build/tmp.cAQOaMfDA3/arch/riscv/kernel/vdso/hwprobe.c:72:24: error: incompatible pointer types passing 'struct riscv_hwprobe *' to parameter of type 'struct riscv_hwprobe *' [-Werror,-Wincompatible-pointer-types]
>   fatal error: too many errors emitted, stopping now [-ferror-limit=]
> 
> Might be a clang thing, allmodconfig with clang doesn't build either.

The proposed generic storage infrastructure currently expects that all
its users also use HAVE_GENERIC_VDSO.
I missed rv32 when checking this assumption.

I can add a bunch of ifdefs into the storage code to handle this.

Or we re-add the time vDSO functions which were removed in commit
d4c08b9776b3 ("riscv: Use latest system call ABI").
Today there are upstream ports of musl and glibc which can use them.
(currently musl even tries to use __vdso_clock_gettime() as 64-bit only
on rv32 due to a copy-and-paste error from its rv64 code)

There is precedence in providing 64bit only vDSO functions, for example
__vdso_clock_gettime64() in arm.
I do have a small, so far untested, proof-of-concept patch for it.
This would even be less code than the ifdefs.

What do you think about it?


Thomas

