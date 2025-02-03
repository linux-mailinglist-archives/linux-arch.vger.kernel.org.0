Return-Path: <linux-arch+bounces-9964-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF7FA2545A
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 09:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A253C1882125
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 08:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8391F9F47;
	Mon,  3 Feb 2025 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oazva1Dh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ju3CaImZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5DE26AE4;
	Mon,  3 Feb 2025 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738571123; cv=none; b=R3G/pkkTOjGbLvVYasCKYsdD8FWZgY1inmtJXD7cmlvubzCYzMw/6Hmvekd5I2zi4QDP34qQaY3P855elAanvKeM/mLM+jkDKVJiWYd3bX747DHey5ekyAQk0qP52TRAkwwm1CJ5g3uLi/vB5mUEX4Uw38VcSgjLCskmZGjOlrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738571123; c=relaxed/simple;
	bh=ov8wKyHMVzFvB347zx1eyYwTRt3HN0TILGdXhi3qSzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l97zZBqOSl8DWxscuUlj9mX1lvDDxJrZWDlj9hb1eIHRR8uGbygKOMT0Tr0l6bdD7NxE1jDZbLkk1mvVQK1KxXeGG2wF1dnLsgVpsOlt9YMis9FYCmzbklb8s6ISoG9kd1M1ubdntKOIKTTk7toUOIfyAlx2SapMACIquSoz9w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oazva1Dh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ju3CaImZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 3 Feb 2025 09:25:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738571118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=un4iesnffWxe46hDY0sU3lqmFY902YxwSt91z3nkPng=;
	b=oazva1DhV3fubsbOl+ixFap/FV5dqWDPWmZo26p5R769d67m2yFZYDVqTF9+OaQi7EbPIA
	2EOE04ovvYmc1VMqoC8IY6nIKZG3ozv1NOd3LR4m13kY8WCUrT+EHZOYnMqshalBtNpOfX
	zkBV1awemvFr5d16uxw4PiEwIJaiURoRsEFQlq/5S0Ps6I6+h2jj9i2y56DOXrQk7LCUDc
	VemVwx4+UVBlPkKzUbWjVq3qFDy8m62f67n8P2NJ8XO6IjyyvrFX2Em3/EAZbPI0G+4T3X
	I4vb0kmzQLgASaAklbn09vQ/B9bwEUdV2lvIPC5CwuUwhA9uxjbumLCir8rKlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738571118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=un4iesnffWxe46hDY0sU3lqmFY902YxwSt91z3nkPng=;
	b=Ju3CaImZemrhR5V41ni8QzPZYebfmNSDWfR9x1cmm7UOZOxX9FtuVyxSi0ZLH5nXU0w51V
	rbSz6/hJIXPy/EBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: Fix -Wmissing-prototypes on UM
Message-ID: <20250203092335-3cb21dd4-5276-4ac5-bd8d-7db6662f18f5@linutronix.de>
References: <20250203-um-io-v1-1-822af81bcdac@linutronix.de>
 <15b87c5f-92de-4201-9c67-a93d5dcefe68@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15b87c5f-92de-4201-9c67-a93d5dcefe68@app.fastmail.com>

On Mon, Feb 03, 2025 at 09:18:33AM +0100, Arnd Bergmann wrote:
> On Mon, Feb 3, 2025, at 08:26, Thomas Weißschuh wrote:
> > Building lib/iomap.o on UM triggers warnings about missing prototypes.
> > These prototypes should be defined by asm-generic/iomap.h, depending on
> > other symbols. For example "ioread64_lo_hi" is based on "readq".
> > However the generic variants of those tested symbols are defined in
> > asm-generic/io.h, only after asm-generic/iomap.h has already been
> > included, breaking the ifdef logic.
> 
> Sorry I never took the time to fix this so far.
> 
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -13,10 +13,6 @@
> >  #include <linux/types.h>
> >  #include <linux/instruction_pointer.h>
> > 
> > -#ifdef CONFIG_GENERIC_IOMAP
> > -#include <asm-generic/iomap.h>
> > -#endif
> > -
> >  #include <asm/mmiowb.h>
> >  #include <asm-generic/pci_iomap.h>
> > 
> > @@ -1250,4 +1246,8 @@ extern int devmem_is_allowed(unsigned long pfn);
> > 
> >  #endif /* __KERNEL__ */
> > 
> > +#ifdef CONFIG_GENERIC_IOMAP
> > +#include <asm-generic/iomap.h>
> > +#endif
> > +
> >  #endif /* __ASM_GENERIC_IO_H */
> 
> I have not tried it yet, but I suspect this is not the correct
> fix here. Unfortunately the indirect header inclusions in this
> file are way too complicated with corner cases in various
> architectures. How much testing have you given your patch
> across other targets? I think the last time we tried to address
> it, we broke mips or parisc.

It was build-tested on 0day.
I also gave it some light boot testing on kunit/qemu.
(Neither on mips or parisc)

