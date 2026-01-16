Return-Path: <linux-arch+bounces-15834-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EFAD2DD37
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 09:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9061D30096B0
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jan 2026 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719622FFFA6;
	Fri, 16 Jan 2026 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RDvMYr6j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y8AIgy8v"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE02FFDD8;
	Fri, 16 Jan 2026 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551326; cv=none; b=qorfQz6UeM8GEvFVCWS0XGqsiZbdJKxLMG3JK9K3lUiL++NyCbtU6llP1eAIOZIU4q2m+y0FbM9t5BV3hp2WMp5UAaPaWhntPZqRCS2wJ0g3noKQxdgc3lL1mdNyok6YbzjBGcE4j0OIBJdH9BDZIK6vSv3IttD7N2PpMiP+B7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551326; c=relaxed/simple;
	bh=qfyi8d0/0C+LuYOJaqZylC8AUVd42U4bxDzWgeXXuLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTAUB6WBoZlasDpJthnHcdUF2lzhm69EI5jf9cyxpsIQK2l45fCo5wgK2XZCYXHBH439Ku1CmZiVy1xxeuq++ckSQFWy3beZ22CwPxk831vLPy4FF/2cSCTLUIbOgHcUVXBrGmYcdH/Qt0a40SAe6Sle+EoOWNPjGb7+PUimKSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RDvMYr6j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y8AIgy8v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Jan 2026 09:15:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768551323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ9t9VI6sM0SIpP0Ehrlucw2Pq4omhPEIAajqXkX+S0=;
	b=RDvMYr6jQ6t5vZMyQBAufN5jvBe6P7B4HhmJ4zz63Knu5tFPiDzNyyoJTkcOoQ3/cZunFb
	dfWqhDk4q/57EMBdQfNRaH67BSRJ9QKFNFcQlcJWDcbyDmkhoHT0VBy3MVZOxus+LZ4+mR
	aX6kmcnvqtJAvJ4YFvlSHmWBsNegwqgqf62XhJeFnh8Vh58GDoTqRbX59zZ1uuGa5dun9z
	YITOWI2IA03s73OMdB7LQEZ5d/oem0et7Lr3o8vbarXEkHB+HVoLRVbCZumtUNhegBiSWx
	UMzeNFb5IQCSawOakTwX9ZdFIMaq1U/u2iTuzDhMURE2VZaRawqvEltO5vjfEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768551323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VZ9t9VI6sM0SIpP0Ehrlucw2Pq4omhPEIAajqXkX+S0=;
	b=Y8AIgy8vdc6miMMyy0DldO7jUqGszY8g7VxoM9i8TQSXy62bMu9M4IA5ps0w66rzMSmewy
	H/hQzTDpll456QAQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 3/4] s390/vdso: Trim includes in linker script
Message-ID: <20260116091110-17084414-30a6-4d56-8f88-734d1840ea2b@linutronix.de>
References: <20260116-vdso-compat-checkflags-v1-0-4a83b4fbb0d3@linutronix.de>
 <20260116-vdso-compat-checkflags-v1-3-4a83b4fbb0d3@linutronix.de>
 <7827adb0-b2a8-4809-8f5e-859102600e02@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7827adb0-b2a8-4809-8f5e-859102600e02@app.fastmail.com>

On Fri, Jan 16, 2026 at 08:45:02AM +0100, Arnd Bergmann wrote:
> On Fri, Jan 16, 2026, at 08:40, Thomas Weiﬂschuh wrote:
> > Some of the included files are unnecessary or too broad.
> >
> > This is a preparation for a new validation step to validate the
> > consistency of __BITS_PER_LONG. vdso.lds.S may be preprocessed with a
> > 32-bit compiler, but __BITS_PER_LONG is always 64.
> >
> > Trim the includes to the necessary ones.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> It's certainly a good idea to limit the use of asm/page.h and the
> other headers here. 
> 
> > There are other ways to solve this issue, for example using
> > KBUILD_CPPFLAGS += -m64.
> 
> I think we should probably do that as well, especially since my
> kernel.org cross-compilers still default to a 32-bit s390 target
> for historic reasons, but the kernel no longer supports 32-bit
> userland.

Agreed. However I'd like to keep this series as small as possible.
The same change should also be done to a bunch of other architectures.


Thomas

