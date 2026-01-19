Return-Path: <linux-arch+bounces-15849-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A76D39F94
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 08:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FE5A300FE39
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jan 2026 07:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996C52EA480;
	Mon, 19 Jan 2026 07:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KMteFhi2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UL2CCvy/"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D052E7BD6;
	Mon, 19 Jan 2026 07:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807247; cv=none; b=plRm6mESaH7RS9N8K0k5tqfb/d02nHedXPYvvBqkJWEj5Ip40uUu6G6LsnCKmkrzt8stN0EXKHfcvy878CMZPc82HniEG5bVY2VUebOIXkOKyi34+dcqTvKV2ZxFrPsGedTj5Zu0v3E11tudz9YqYEIPCUrtEJ1ZlNzWi9FOwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807247; c=relaxed/simple;
	bh=f0J3gX53Ew7eB6W9i/cjKvO2y5onT8DjFTtQBnzQLME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOyydu1L5f3V+lf4aej7qA/C0Ir2ZLc4slFqHfJdfrxPUNRwA9BhiZkXuJGP2IQVMEA3zqHUw+DXH99qdvlNpqmmRhh7Jg8TZKasW8bg4DQyyxsPb3p4Rw/+3w9rB3owJ+OxrnhYvLrSPnXUxGZeVhxZN6CUHYuFvGxuB/oBx1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KMteFhi2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UL2CCvy/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Jan 2026 08:20:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768807244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRTox70A0o62jVnjXLxJ1XwztwmCr0KoQTGOxYe/6o4=;
	b=KMteFhi2pEfyTi1kC4hsmfdnBdpl+ml4Fkd9EAwz1BsPVFytdVwp2lasnkCF2/J44d2HH6
	lwOMMCkLOb6nLBYYjlHfIcf9fNgIZ0IxXTQVg8wWBQmqD6uS4M1NGwdwayHEK9bCw1FFp6
	xqe8UFch/J2KVU68R/kX2oOSTnqxnmQTN0DWBstFwgv5EeNSIUFcmUD5fvk/5uuqQ+/b2V
	KwwaGgHtqbvyi17Fy5/Q22tbNXVi8AZVXiehtFoWXbE7FD0Y1rE5ECRgOtujYHG+2bPURQ
	F1cnHv9FvohbXizxTusFLyprAmY/jGgLeTvZBHPI3Qu/deh7CD30/XGJUB+omA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768807244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRTox70A0o62jVnjXLxJ1XwztwmCr0KoQTGOxYe/6o4=;
	b=UL2CCvy/jHXfeCAAO8+E6oNcKIujrVuL9kBmuoIm2NSb5VibuAgakroLtfevnJF4/uc0pv
	fuZ/CWusBmz2AhAA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: Re: [PATCH 2/4] x86/vdso: Use 32-bit CHECKFLAGS for compat vDSO
Message-ID: <20260119081917-f47ff5da-4465-4b3e-8c94-42b96c932583@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-2-4a83b4fbb0d3@linutronix.de>
 <87bjir3nfy.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjir3nfy.ffs@tglx>

On Sat, Jan 17, 2026 at 11:05:05PM +0100, Thomas Gleixner wrote:
> On Fri, Jan 16 2026 at 08:40, Thomas Weiﬂschuh wrote:
> > Manually override the CHECKFLAGS for the compat vDSO with the correct
> > 32-bit configuration.
> 
> Fun. I just fixed the same thing half an hour ago:
> 
>    https://lore.kernel.org/lkml/20260117215542.342638347@kernel.org/

Assuming you are going to apply your patches bevore, can I respin my
remaining patches on top of tip/x86/entry?

> > Reported-by: Sun Jian <sun.jian.kdev@gmail.com>
> > Closes: https://lore.kernel.org/lkml/20260114084529.1676356-1-sun.jian.kdev@gmail.com/
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  arch/x86/entry/vdso/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> > index f247f5f5cb44..ab571ad9b9ac 100644
> > --- a/arch/x86/entry/vdso/Makefile
> > +++ b/arch/x86/entry/vdso/Makefile
> > @@ -142,7 +142,10 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
> >  endif
> >  endif
> >  
> > +CHECKFLAGS_32 := $(CHECKFLAGS) -U__x86_64__ -D__i386__ -m32
> 
> Hmm. That keeps -m64. Seems not to matter much, but substituting both
> seems to be more correct.

Fair enough.


Thomas

