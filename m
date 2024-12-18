Return-Path: <linux-arch+bounces-9422-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13129F628A
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 11:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E064016D9B0
	for <lists+linux-arch@lfdr.de>; Wed, 18 Dec 2024 10:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1941192598;
	Wed, 18 Dec 2024 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k+9+2dt8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yXhQ4Rje"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C511922F1;
	Wed, 18 Dec 2024 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517018; cv=none; b=B4EQQMS2/GWT9tcr/Cy87EaUUjOXEGxgFPbR+628Fsuq4z3/ewZHwIVB3sCpuqDSCOa5rxrl+qFCo9TGg1YHV9lj/dIxX0Y0o5liKO+JxmVy3YENlUhzDdyqIIDrTQBdBuHobg6YHpXLN/FFC6ePtpg93P5jxRVH9S+xGXTB/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517018; c=relaxed/simple;
	bh=ihn+cwpLFuIp9Uq0WGxgiKU3A/Qe52yNfvRUBWE46M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+hZ/9Jm6XDBtL/VwMgHpkQlA3CUwnloDI/TLPKxDsNe64+kALo6IW67PkbLUGhTeozgyhdyNloWxMZDuTtTCayB5n2yoQJ/o8wRkbkaFUNH1FJY+iTBULUv5sNUqlAKk39NJg/8hbcyYHvGErXJnXgjw1SwrzkJd2SJxbL/XSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k+9+2dt8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yXhQ4Rje; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 11:16:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734517014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asQwivYoQ6OyVNJBd3EdgJw1JjuKg7fNklboQjqanF4=;
	b=k+9+2dt84P2yu2JQjHriNsnfLK1U2zwMe3zETXzWpHvMFbzWIWRl0216I0Fp7Fs0GxVlyo
	yc6i4Q3Hu1q2hD8wlkaWxUa2/LSRxg2COBfpJYgxfKOVjFaVDrdSLxoJSE3b4rni7eSePg
	zI/dWD74oT5nZPEZZO7hwDCfBtI4dfQFjxRIFS9AkAU85OAfFsoE1hleSOYGu1n4z2yAZY
	Y1RK/InyIx+aLJuE6QRRzC4LUqndo/HAvuKeT1pLXt7sSb5Bh3nglAiSTENEvex8fG+geW
	f0ENU722o2Q/62/Nus5sE3hNF3ZF1A45agg8WoxbV4hKlyXpoR26vp6T9Jw1dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734517014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asQwivYoQ6OyVNJBd3EdgJw1JjuKg7fNklboQjqanF4=;
	b=yXhQ4RjeaS/+ewnR286ORrRNsrdJ4qpmR9IkiLgWDlKmPEPu6UZYxm4SDqI/YyJISRXAyJ
	qqASr10vg3j1/pBg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 12/17] powerpc/vdso: Switch to generic storage
 implementation
Message-ID: <20241218105556-6d6d0bcb-f2d7-418e-a4e6-1222c506d2cb@linutronix.de>
References: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
 <20241216-vdso-store-rng-v1-12-f7aed1bdb3b2@linutronix.de>
 <12120bbe-1d79-425b-982d-46af1fa5d70d@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12120bbe-1d79-425b-982d-46af1fa5d70d@csgroup.eu>

Hi Christophe,

On Wed, Dec 18, 2024 at 08:20:51AM +0100, Christophe Leroy wrote:
> Le 16/12/2024 à 15:10, Thomas Weißschuh a écrit :

[..]

> >   #ifdef CONFIG_TIME_NS
> > -static __always_inline
> > -const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
> > +static __always_inline const struct vdso_time_data *__ppc_get_vdso_u_timens_data(void)
> >   {
> > -	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
> > +	struct vdso_time_data *time_data;
> > +
> > +	asm(
> > +		"	bcl	20, 31, .+4\n"
> > +		"0:	mflr	%0\n"
> > +		"	addis	%0, %0, (vdso_u_timens_data - 0b)@ha\n"
> > +		"	addi	%0, %0, (vdso_u_timens_data - 0b)@l\n"
> > +	: "=r" (time_data) :: "lr");
> > +
> > +	return time_data;
> 
> Please don't do that, it kills optimisation efforts done when implementing
> VDSO time. Commit ce7d8056e38b ("powerpc/vdso: Prepare for switching VDSO to
> generic C implementation.") explains why.
> 
> For time data, the bcl/mflr dance is done by get_datapage macro called by
> cvdso_call macro in gettimeofday.S, and given to
> __cvdso_clock_gettime_data() by __c_kernel_clock_gettime() in
> vgettimeofday.c . Use that information and don't redo the bcl/mflr sequence.

So instead keeping the logic of this:

static __always_inline
const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
{
	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
}

Makes sense.

Adding a constant value should be cheaper or just as cheap as a
PC-relative addressing for all architectures, so it can go into the
generic code, too.

[..]

> >   }
> > +#define __arch_get_vdso_u_timens_data __ppc_get_vdso_u_timens_data
> 
> There is not #ifdef __arch_get_vdso_u_timens_data anywhere, this #define is
> not needed, the function should be called __arch_get_vdso_u_timens_data()
> directly as before, unnecessary indirections reduce readability.

I'll see how this works out with the include order and conflicts with
symbols in include/vdso/datapage.h.

> >   #endif
> > -static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
> > +static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
> >   {
> >   	return true;
> >   }


Thanks!
Thomas

