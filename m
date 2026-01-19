Return-Path: <linux-arch+bounces-15871-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C58D3AF51
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 16:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02B7C30424B2
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FFF38A9B3;
	Mon, 19 Jan 2026 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IxFzXmDT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aLyl2rfo"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A0438B9AC;
	Mon, 19 Jan 2026 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837180; cv=none; b=oPImTpAEe4xBr81d+JKun8ereyHc8cU3ZfCmZBD5Rvfj6/zLCeLGyCn9LbfnbHVaYnYVVZjkHMYkf7vx8SyZ0U1iM6UCZmJza+jc5uU4gbbflHFx1hstNidLRxeKTeS0E/DDmMlWNkVfEoX0K0tZFc5O7hQFZeXc2zNjudLhoyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837180; c=relaxed/simple;
	bh=ZtTM7XywD17Kq9z/oenOTpYd/xCRaoEx2A7YFQ/Mseo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpLz0Ad2qmrZI8WclFXSoklzvYip7ehJI+rLhUrctNGgVzZDnqaNjBPLill9nriRanjRmGJjPGgryCoLoyltM9ytE/WRVSWpCWti6SHmZX4veYAZK07bY8qxNQokRN3A7fE39VhdL0Pt6ZTCUio1c0y4ZGOq3rokbkS52cONGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IxFzXmDT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aLyl2rfo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Jan 2026 16:39:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768837168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBvULJqnuv7uvt9fLS88PIQT8UUaxuVf0OpoQDeZ0Vw=;
	b=IxFzXmDTuBIJRGCzNcRgN5bl4aOBI8HwUlPEQsyfJU8b8zcEq0t8cccubuAEPAf6bYsy9S
	Nsjm3ibutfHtB+vEl/+V1pggRtGRWM/C0m1Bffa7TtPKCqCYnJoHg+TmpTSx3kJpl4lAnF
	bKuxARYAESaFNVqqd95P1Em0sXPsREwTivB6A9s8PD71Rwurqqe3L1u6mzIlnf9j7GC1Gg
	+PJQ3fNUPh26Hcd7o3lwgAYkteCWhUQwQ5U37Cibxq8+arupj6AFBzYaU47zdGzA1M++Ie
	mktExse8AhG5yKwEUBSbwVnoQiQPi0uQt4wfDVa1HUWpCJ/UtPlGLZlU/FZEMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768837168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lBvULJqnuv7uvt9fLS88PIQT8UUaxuVf0OpoQDeZ0Vw=;
	b=aLyl2rfoZy61c0skMmX873VleeF3BX55HG83wwoGxFslNP2FIw6YihHxHMLI0Lg8N1RgVh
	pyPdFoRRMK0MwcBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260119163559-b20b14d7-56ca-4f17-8800-83f618d778b8@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
 <1a77fda4-3cf6-4c19-aa36-b5f0e305b313@zytor.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a77fda4-3cf6-4c19-aa36-b5f0e305b313@zytor.com>

On Mon, Jan 19, 2026 at 07:33:13AM -0800, H. Peter Anvin wrote:
> On 2026-01-15 23:40, Thomas Weiﬂschuh wrote:
> > The value of __BITS_PER_LONG from architecture-specific logic should
> > always match the generic one if that is available. It should also match
> > the actual C type 'long'.
> > 
> > Mismatches can happen for example when building the compat vDSO. Either
> > during the compilation, see commit 9a6d3ff10f7f ("arm64: uapi: Provide
> > correct __BITS_PER_LONG for the compat vDSO"), or when running sparse
> > when mismatched CHECKFLAGS are inherited from the kernel build.
> > 
> > Add some consistency checks which detect such issues early and clearly.
> > The tests are added to the UAPI header to make sure it is also used when
> > building the vDSO as that is not supposed to use regular kernel headers.
> > 
> > The kernel-interal BITS_PER_LONG is not checked as it is derived from
> > CONFIG_64BIT and therefore breaks for the compat vDSO. See the similar,
> > deactivated check in include/asm-generic/bitsperlong.h.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  include/uapi/asm-generic/bitsperlong.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/include/uapi/asm-generic/bitsperlong.h b/include/uapi/asm-generic/bitsperlong.h
> > index fadb3f857f28..9d762097ae0c 100644
> > --- a/include/uapi/asm-generic/bitsperlong.h
> > +++ b/include/uapi/asm-generic/bitsperlong.h
> > @@ -28,4 +28,18 @@
> >  #define __BITS_PER_LONG_LONG 64
> >  #endif
> >  
> > +/* Consistency checks */
> > +#ifdef __KERNEL__
> > +#if defined(__CHAR_BIT__) && defined(__SIZEOF_LONG__)
> > +#if __BITS_PER_LONG != (__CHAR_BIT__ * __SIZEOF_LONG__)
> > +#error Inconsistent word size. Check uapi/asm/bitsperlong.h
> > +#endif
> > +#endif
> > +
> > +#ifndef __ASSEMBLER__
> > +_Static_assert(sizeof(long) * 8 == __BITS_PER_LONG,
> > +	       "Inconsistent word size. Check uapi/asm/bitsperlong.h");
> > +#endif
> > +#endif /* __KERNEL__ */
> > +
> >  #endif /* _UAPI__ASM_GENERIC_BITS_PER_LONG */
> > 
> 
> Do we actually support any compilers which *don't* define __SIZEOF_LONG__?

When building the kernel not. I used this pattern because it is used
further up in the file. There it makes sense as it is actually a userspace
header which needs to support all kinds of compilers.
But this new check is gated behind __KERNEL__ anyways...
For the next revision I will move it into the regular kernel-internal
bitsperlong.h. That will be less confusing and still handle the vDSO build,
due to the way our header hierarchy works.


Thomas

