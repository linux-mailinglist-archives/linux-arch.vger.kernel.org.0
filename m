Return-Path: <linux-arch+bounces-15891-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C3CD3C075
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 08:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8BC13E6B9C
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFA9331A4A;
	Tue, 20 Jan 2026 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qRtM2/LI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ux0BDTS3"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9039E6D5;
	Tue, 20 Jan 2026 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893832; cv=none; b=Q6ane6yQjP+7g54svv9Vys0ZtgVKkJdo9lIKC1I3rMbxCnf1P4VAgQoktfNy8BickPTrrDeE0yG3lE7/ioasl02j09P1ZFqqQylcOVZvwB3zQG6UKeaztdzV7SCBrni1lh6Dk/PyPIwbCEKV7lpEQBtbUyzFrO+mmyYCKocoDqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893832; c=relaxed/simple;
	bh=Ljz+Gi83a+JjPR+sLBysbfNI9oaAQkIfbhdX/r1AD/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnJxQLDfc6K9nQp+UxRv8IXY0EIXIyp6XLiGbg9QXxBqAhVM7V/FmidHFDuV2rESvR3BuyQ/HC9+BB53j+BlqNvAfTuBe98/pb7JlKQ0LnTG71qu6UIL1EMch2q3L8puY7+PmD5GxHPRXG37HR1QEqJ6zv5MILtDrwdM35XCypU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qRtM2/LI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ux0BDTS3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Jan 2026 08:23:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768893820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdrEJPqx1MFOvrLI5OPYmPHWL96zfvhnQqnu+2d5v4w=;
	b=qRtM2/LICWrYpv7CqHVGjW3oNUf5zeSQFvVn7pxVIbqfRjNlWsKtowiCAuo7wPw4bTMhZF
	vZ7kyPZkvRrJ6SFbDfsGauMu/yAWoXgh0+otpAtdHkwjXeaXrDj/ddU+0M796ldT3py2FA
	H/J7J6LCXcTjNsypVemOAhQjSwu2xYplIpe6Lc3xHt+S8d6b/6GQKP4HK12fl9yyDBYG6e
	iXHhGl4u+cbf0LkeSEz1Ot2nLWG1O1Kprw+SAXFWTU2YORD/K1EdiTmK96nQ5VbnNr6FGb
	9OBJg+7ZhGSfG8bRIjWQ7Wn9oLuHZOTx6IEK0JDbJ3KblXlfJH61VFq0pkxfIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768893820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdrEJPqx1MFOvrLI5OPYmPHWL96zfvhnQqnu+2d5v4w=;
	b=ux0BDTS3LJjapFbL4YTAJJf8nKUPpr8oWdyJfad7Z3Tu4BKdj46czIj7hpk/EJnJHSsTDa
	K9T/V5n3wFQW6oAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Laight <david.laight.linux@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 4/4] asm-generic/bitsperlong.h: Add sanity checks for
 __BITS_PER_LONG
Message-ID: <20260120081136-f413a6d5-05a5-4adc-a687-474ae349e771@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-4-4a83b4fbb0d3@linutronix.de>
 <20260119100619.479bcff3@pumpkin>
 <20260119111037-4decf57f-2094-4fac-bcf4-03506791b197@linutronix.de>
 <20260119103758.3afb5927@pumpkin>
 <20260119114526-a15e7172-fc4c-40d0-a651-7c4a21acb1c8@linutronix.de>
 <72a2744a-debc-4d8f-b418-5d6a595c2578@app.fastmail.com>
 <20260119143735-ca5b7901-b501-4cb8-8e5d-10f4e2f8b650@linutronix.de>
 <4e4b1b5b-5f7d-4604-b5ef-0d0726263843@app.fastmail.com>
 <20260119174730.5a20169d@pumpkin>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119174730.5a20169d@pumpkin>

On Mon, Jan 19, 2026 at 05:47:30PM +0000, David Laight wrote:
> On Mon, 19 Jan 2026 15:57:49 +0100
> "Arnd Bergmann" <arnd@arndb.de> wrote:
> 
> > On Mon, Jan 19, 2026, at 14:41, Thomas Weißschuh wrote:
> > > On Mon, Jan 19, 2026 at 01:45:04PM +0100, Arnd Bergmann wrote:  
> > >> On Mon, Jan 19, 2026, at 11:56, Thomas Weißschuh wrote:  
> > >> > On Mon, Jan 19, 2026 at 10:37:58AM +0000, David Laight wrote:  
> > >> >> 
> > >> >> Don't you need a check that it isn't wrong on a user system?
> > >> >> Which is what I thought it was doing.  
> > >> >
> > >> > Not really. The overrides defined by arch/*/include/uapi/asm/bitsperlong.h are
> > >> > being tested here. If they work in the kernel build I assume they also work
> > >> > in userspace.  
> > >> 
> > >> I think You could just move check into include/asm-generic/bitsperlong.h
> > >> to make this more obvious with the #ifdef __KERNEL__, and remove the
> > >> disabled check from my original version there.  
> > >
> > > Ok. I'd like to keep your existing test though, as it tests something different
> > > and it would be nice to have that too at some point.  
> > 
> > Sure, that works too. I wonder if one of the recent vdso cleanups
> > also happened to address the problem with the incorrect BITS_PER_LONG
> > being visible in the vdso code. Maybe we can already turn that on again.
> 
> There is vdso/bits.h, but everything actually includes linux/bits.h first.

These cleanups do not help unfortunately. We can skip the check for BUILD_VDSO,
but there are still plenty other places where it will break.

> I was wondering what happens if you are actually using the 'uapi' headers
> to build programs (may nolibc ones).
> On x86-64, 'gcc foo.c' might work, but 'gcc -m32 foo.c' will find exactly
> the same headers and go badly wrong unless everything is based on
> compiler defines.

I can't follow. __BITS_PER_LONG automatically adapts.

From arch/x86/include/uapi/asm/bitsperlong.h:

#if defined(__x86_64__) && !defined(__ILP32__)
# define __BITS_PER_LONG 64
#else
# define __BITS_PER_LONG 32
#endif


BITS_PER_LONG on the other hand is never exposed in the uapi headers.

> An assert (of some kind) that checks the pre-processor BITS_PER_LONG
> constant actually matches sizof (long) seems reasonable for all build.
> The alternative is to (somehow) manage to avoid needing a pre-processor
> constant at all, moving everything to 'integer constant expressions'
> instead (good luck with that...).

We do have exactly that assertion in include/asm-generic/bitsperlong.h.
(As mentioned in the patch description we are discussing)
The assertion is disabled because it fails. There are multiple places where
we build 32-bit code with a 64-bit kernel configuration.
The compat vDSO, early boot code and probably more I don't know about.
Is it ugly? Yes. Should we '#define BITS_PER_LONG __BITS_PER_LONG' at some
point? Yes. But we first need to audit all the users to check if it is safe
to do so. At some point in the future in another series.

> I'm most of the way through a 'de-bloat' patchset for bits.h.
> I'm sure there is a good reason why GENMASK(hi, lo) isn't defined
> as '((type)2 << hi) - ((type)1 << lo)'.
> Since that definition doesn't need the bit-width in any form.
> (Just beat up any static checker that objects to '2 << hi' being zero.)
> I've only made that change for ASM files - IIRC the assembler only
> supports one size of signed integer.

No idea, and I don't see the relation to the patches under discussion.


Thomas

