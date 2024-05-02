Return-Path: <linux-arch+bounces-4144-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AF08BA1BA
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 22:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350F11C20E7D
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 20:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A9175551;
	Thu,  2 May 2024 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HWM9bdT2"
X-Original-To: linux-arch@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB591E86E;
	Thu,  2 May 2024 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714683236; cv=none; b=IUBkYkhgQoWWfBpKG88r8tXGDshZuezesIGSpopvnwQh+pHdPVtRME4ZdYY3LObMV92ToqoMEYCQLZlN0gqrYEFbdSPxHRcoXBkfrKgHniIa8BP8crukizKvesM2935xpfVmlfzPh/60zhqWS2su1dfQWvHypNXg/A6cze2rmV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714683236; c=relaxed/simple;
	bh=ghIPjHOXuynFov9l2WTsehnzHFgGKXQ+0861Gxb40jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oY/qphg6+vI8KRTFDk/1sNuHT/cV5WyzbXBoBNNyJPTsGJErYfNk4Br9bzP32prNCCGdwbzGLjmhHfmrajSVtpwLhNmzgH1UJ+wGUQheFN8Wfx0EOFS680mHpsaA5DBDBMfic92/pdZNaGBGuc+c1pb5Uw8wo0opEX6UALQD4GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HWM9bdT2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZwE+6iSbDqfYkwTjfWS+C3Qxi2K0orF6yWIiQ3BYZYg=; b=HWM9bdT2UmJgncvqRTLy+CXKZ7
	+Dtb0WGZA26RDDJG0OinZZZbIEP1IdDxaR4qaM/AXvF7zxBheyZXebJ9qJMTaPAU1EAgrHbc88JUD
	h8gslmpMSs588eRrC1tNUN0wuLbDnBbXHZPFxqxAmaFOTp11veGD1oXP+Bd20gP2EmqXab7GKu/ai
	QjmlkYBVOxWV76EtjJFp3bXw+mzqjmdlWn024RtUJEDWVUnckYNzs7DEcwRbXNd6pwgtLKFTgRzR2
	OFXiLs26eR8QJoqbHrZIs9jZoKQqlpC8PSd3tprK8p1ZHfd4J6WNEcdlQnjuIvaiU7oPXveSet8R/
	Tpi3MOPg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2dR3-009k91-1x;
	Thu, 02 May 2024 20:53:45 +0000
Date: Thu, 2 May 2024 21:53:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
Message-ID: <20240502205345.GK2118490@ZenIV>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org>
 <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
 <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
 <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 02, 2024 at 06:33:49AM -0700, Paul E. McKenney wrote:

> Understood, and this sort of compatibility consideration is why this
> version of this patchset does not emulate two-byte (16-bit) cmpxchg()
> operations.  The original (RFC) series did emulate these, which does
> not work on a few architectures that do not provide 16-bit load/store
> instructions, hence no 16-bit support in this series.
> 
> So this one-byte-only series affects only Alpha systems lacking
> single-byte load/store instructions.  If I understand correctly, Alpha
> 21164A (EV56) and later *do* have single-byte load/store instructions,
> and thus are still just fine.  In fact, it looks like EV56 also has
> two-byte load/store instructions, and so would have been OK with
> the original one-/two-byte RFC series.

Wait a sec.  On Alpha we already implement 16bit and 8bit xchg and cmpxchg.
See arch/alpha/include/asm/xchg.h:
static inline unsigned long
____cmpxchg(_u16, volatile short *m, unsigned short old, unsigned short new)
{
       unsigned long prev, tmp, cmp, addr64;

       __asm__ __volatile__(
       "       andnot  %5,7,%4\n"
       "       inswl   %1,%5,%1\n"
       "1:     ldq_l   %2,0(%4)\n"
       "       extwl   %2,%5,%0\n"
       "       cmpeq   %0,%6,%3\n"
       "       beq     %3,2f\n"
       "       mskwl   %2,%5,%2\n"
       "       or      %1,%2,%2\n"
       "       stq_c   %2,0(%4)\n"
       "       beq     %2,3f\n"
       "2:\n"
       ".subsection 2\n"
       "3:     br      1b\n"
       ".previous"
       : "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
       : "r" ((long)m), "Ir" (old), "1" (new) : "memory");

       return prev;
}

Load-locked and store-conditional are done on 64bit value, with
16bit operations done in registers.  This is what 16bit store
(assignment to unsigned short *) turns into with
        stw $17,0($16)		// *(u16*)r16 = r17
and without -mbwx
        insql $17,$16,$17	// r17 = r17 << (8 * (r16 & 7))
        ldq_u $1,0($16)		// r1 = *(u64 *)(r16 & ~7)
	mskwl $1,$16,$1		// r1 &= ~(0xffff << (8 * (r16 & 7))
	bis $17,$1,$17		// r17 |= r1
	stq_u $17,0($16)	// *(u64 *)(r16 & ~7) = r17

What's more, load-locked/store-conditional doesn't have 16bit and 8bit
variants on any Alphas - it's always 32bit (ldl_l) or 64bit (ldq_l).

What BWX adds is load/store byte/word, load/store byte/word unaligned
and sign-extend byte/word.  IOW, it's absolutely irrelevant for
cmpxchg (or xchg) purposes.

