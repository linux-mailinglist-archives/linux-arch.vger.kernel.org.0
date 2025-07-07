Return-Path: <linux-arch+bounces-12582-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D10AFABC9
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 08:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 776267A7F42
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jul 2025 06:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AB9272811;
	Mon,  7 Jul 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0McAEBd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zV1dM3Ar"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0742750FD;
	Mon,  7 Jul 2025 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751869295; cv=none; b=W8gnPzuRG10UN3HedEJHWtb/v/MOHpG3ZAcrEDU4bgDyKrtOLoHMM/ZqqBhOBiuF2YDiOFvaBZku+Wzp8XRAedaoMxFk7oKFG71WdzipOqsiVyxjFb+EJl0EREt/rHU/RRGxD5vzBZiMHV+5V40AamuNTzqAwuxDPNIDE5xT+pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751869295; c=relaxed/simple;
	bh=0Qix+5IrucWSQp6L8TIoN9VIU+Ie84qGF844acu2iM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aILcJQ43wJMb4vfPjwMYN/moLgs+H9Ppys1SVg2WVhzYHjVTpQ+XB7MxXh3zy7G11X0x35UkZ4aMZSHXrlBtALRIdF+FODk25gIyT+buuWe7vTC4BxRvSYkk1eyWTjwO/5G0XQg62GMpWB9GBH5xMVnoviZXC3zt96ZrPIGv3CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0McAEBd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zV1dM3Ar; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 7 Jul 2025 08:21:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751869291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6Nq2wlWcj6YING0FPFLwQLo2jrC6/nA6s1unWICjVI=;
	b=n0McAEBd5y6R5Cug4tP83Sunp+0n7kgn9ODazGWXwJDQ4Eia00Xdv/cbvLKzTEAHIS9Uwb
	eetOfHmufKgk/yIuksvOWumln3GMK4AgOq9lM+pQbLG9+3Kpcm9wUNz0iHUV00kutT+dYU
	WCmsPV21qfUw/EpeQfbU06iDpoMQam7H/CTqYHy24UqCPSlrhxJzpNROkl+JuWUgE0kCyw
	IVuSUsd1zho+aSgjHaB/oDBb6EeJXvV5gCSFJnAuD2QXk3hySPhANJpi7C+gDLwfrDVEHg
	98Nfjfo06Pqxyu+WK8zS6cSXNvtYHSAgyJHo08BcRynqiWo0UEI5IGKDaJ87DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751869291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M6Nq2wlWcj6YING0FPFLwQLo2jrC6/nA6s1unWICjVI=;
	b=zV1dM3ArUP8VnI016Gn0Nf3+0JBjys1+YLcxyso463WRHrb0IsQb1/LEaCOwNkwftjTqds
	dSAm4pfANP55wKCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Christopher Hall <christopher.s.hall@intel.com>, 
	Miroslav Lichvar <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, 
	David Woodhouse <dwmw2@infradead.org>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Nam Cao <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH 13/14] Revert "selftests: vDSO: parse_vdso: Use UAPI
 headers instead of libc headers"
Message-ID: <20250707081018-cdef0e77-5149-4a3b-a73b-bd8e38853f2a@linutronix.de>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-13-df7d9f87b9b8@linutronix.de>
 <87a55hrqws.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a55hrqws.ffs@tglx>

On Sun, Jul 06, 2025 at 10:43:47PM +0200, Thomas Gleixner wrote:
> On Tue, Jul 01 2025 at 10:58, Thomas Weißschuh wrote:
> > This reverts commit c9fbaa879508 ("selftests: vDSO: parse_vdso: Use UAPI headers instead of libc headers")
> >
> > The kernel headers were used to make parse_vdso.c compatible with nolibc.
> > Unfortunately linux/elf.h is incompatible with glibc's sys/auxv.h.
> > When using glibc it is therefore not possible build parse_vdso.c as part of the
> > same compilation unit as its caller as sys/auxv.h is needed for getauxval().
> >
> > In the meantime nolibc gained its own elf.h, providing compatibility with the
> > documented libc interfaces.
> 
> I'm kinda surprised to find this here in this series. Isn't that commit
> c9fbaa879508 obsolete since nolibc got it's own elf.h?

Correct.

> So this should just go straight to Linus, no?

It could. But the next patch of this series depends on it for now.
So to avoid ordering issues I kept both patches together.


Thomas

