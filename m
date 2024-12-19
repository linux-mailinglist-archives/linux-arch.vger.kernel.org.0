Return-Path: <linux-arch+bounces-9429-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B939F74D4
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 07:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3544C1892F1C
	for <lists+linux-arch@lfdr.de>; Thu, 19 Dec 2024 06:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E620216E3D;
	Thu, 19 Dec 2024 06:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XMcC+wO5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lizvNDYm"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C89321764D;
	Thu, 19 Dec 2024 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734589831; cv=none; b=D8LLjF+nYrcIXLLgG4R/Yxqyj5LozZy+Af7ymJ/7bWPiCuKMoSkGrGdBrvEzjywoUHKh7LVgiiUiHIsa4TpF+0fDOF40SFiQ4ngLxyWiP6Eo+n9gp+qZfMO+FyjmFD8w5j+8C0UXr3P+qEslpiG5QRze8v4/c/52rZ3fEgGLUo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734589831; c=relaxed/simple;
	bh=gx8EWvXEhDpBIT2WxmsZgF1bYeZS2CW4WJ1TCZh8HNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZSUywYZjzcx1cMkm8XHdH2L0N6i6wqG1KjsCzvS+/fituTCEASbCloCtGrHqKTnDvZ4Ru8o1M9AW76hkcl3mTo0hKnrWUDUt5n0UWNCq4+aW1oN2/WLgOrCrI4wGrdywih8Q25Ff/N5ic4b244bhsGQ5aCuQMjmfkxJB/aa+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XMcC+wO5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lizvNDYm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 19 Dec 2024 07:30:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734589827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brEM+ootPH6y2/YCviVjC+RLeQ0QzlEBqocyy/WfD3U=;
	b=XMcC+wO5/gyjwqszz2FEVmDMXZQx3pF5bzw/D/U+DhwYKJv9REWbX40X23G5YodGhMzxLG
	1UAr8nKjyY0Kf1RGg/8CcSlJteWhtoj0+amS1nzNd19YUishyFWMegPVlkma7haH/l0bQx
	UPXdUdr/bOcUjZEv7/IyAq5X8UvpyOl8Eoo1LOwkra69ZA9udzJSpGYhAqPejllDppzmui
	/1w9LTvVZWo0hHFiKy1wqjTm8CZxIqay1gQlNDOetKKVwrQU522w45o4hbBkEqiMJm3FRu
	2KrYtc6E7LcXV7UbkCQjg7cmZZOV9vw1zDDr9jgfGCnIhmX4pZsWlB8a3x2avw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734589827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brEM+ootPH6y2/YCviVjC+RLeQ0QzlEBqocyy/WfD3U=;
	b=lizvNDYmwqC1Sdr28wyZPYco75yXNbVdywOf7fbIN5mEEvywWt8AvsOHhKYx2j3f09NW7x
	awEMWr7EktvpdPBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Conor Dooley <conor@kernel.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Anna-Maria Gleixner <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
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
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH 07/17] riscv: vdso: Switch to generic storage
 implementation
Message-ID: <20241219072552-7cd4512c-4f61-408a-9422-167a6f2810db@linutronix.de>
References: <20241216-vdso-store-rng-v1-0-f7aed1bdb3b2@linutronix.de>
 <20241216-vdso-store-rng-v1-7-f7aed1bdb3b2@linutronix.de>
 <20241218-action-matchbook-571b597b7f55@spud>
 <20241218162031-ee920684-db10-4f17-b1cb-50373d7ea954@linutronix.de>
 <137c0594-e178-4c91-bc8b-5f99b3ddb2f0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <137c0594-e178-4c91-bc8b-5f99b3ddb2f0@app.fastmail.com>

On Wed, Dec 18, 2024 at 05:35:31PM +0100, Arnd Bergmann wrote:
> On Wed, Dec 18, 2024, at 16:46, Thomas Weißschuh wrote:
> > On Wed, Dec 18, 2024 at 03:08:28PM +0000, Conor Dooley wrote:
> >> On Mon, Dec 16, 2024 at 03:10:03PM +0100, Thomas Weißschuh wrote:
> 
> >> Might be a clang thing, allmodconfig with clang doesn't build either.
> >
> > The proposed generic storage infrastructure currently expects that all
> > its users also use HAVE_GENERIC_VDSO.
> > I missed rv32 when checking this assumption.
> >
> > I can add a bunch of ifdefs into the storage code to handle this.
> >
> > Or we re-add the time vDSO functions which were removed in commit
> > d4c08b9776b3 ("riscv: Use latest system call ABI").
> > Today there are upstream ports of musl and glibc which can use them.
> > (currently musl even tries to use __vdso_clock_gettime() as 64-bit only
> > on rv32 due to a copy-and-paste error from its rv64 code)
> 
> Adding back __vdso_clock_gettime() wouldn't work on rv32 because there
> is no fallback syscall for it, and it wouldn't really help since
> there is no existing userspace that uses time32 structures.

My original paragraph was worded confusingly.
It was about re-adding time-related vDSO function *in general*, not the
specific 32-bit ones.
The new ones should be 64-bit only, indeed.

> > There is precedence in providing 64bit only vDSO functions, for example
> > __vdso_clock_gettime64() in arm.
> > I do have a small, so far untested, proof-of-concept patch for it.
> > This would even be less code than the ifdefs.
> >
> > What do you think about it?
> 
> Yes, simply exposing the normal time64 syscalls through vdso
> should be fine. I think this currently works on everything except
> rv32 and sparc32, probably because neither of them have actual
> users that are able to test.

Should it use the specific _vdso_clock_gettime64() naming or leave out
the 64 suffix?


General Note: I'll continue working on this next year.


Thanks,
Thomas

