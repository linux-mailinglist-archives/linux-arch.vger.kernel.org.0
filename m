Return-Path: <linux-arch+bounces-4146-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 679108BA224
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 23:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7470B209E8
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0748C180A81;
	Thu,  2 May 2024 21:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL689IVX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4EA1DDC5;
	Thu,  2 May 2024 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684729; cv=none; b=j8OlDmNaLhuAgvbRYwzsp9mL0Qzgr+6ZT9Za8hAOIztWFykwmX1QAhQHvkv/Vuk5O+EfLxOZAycPgRCJ+7gKPZGj1Htnh+784OFMqQaI1q5L622BGf1+QqNvG+f/thTgflq1vDYZnhw7BZDV7y/QKSiyoGgWQ5hBHpqH9vYR/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684729; c=relaxed/simple;
	bh=PfxdzMuI/E/kEWOl5s3Ui78OW1haAesBHk2zfGFvbNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSXHhRyL19bthtHsqKP+RLFOBjTlJ/gwJDX91MLVkDdPT4MkERlPOC1LZUNm+UJXXLNCt5k4eiX5vKDrFBDFZhGHGnFYsyCWk13Qwr6zzPo5R2kznG/Hb+z+9b9ddQfvR2+QBqigmiTgRoA4RALoZ71Jt+tfVrdDjVu08RkCqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL689IVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A670C113CC;
	Thu,  2 May 2024 21:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714684729;
	bh=PfxdzMuI/E/kEWOl5s3Ui78OW1haAesBHk2zfGFvbNA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cL689IVXTKaOolpTN2W3yZ4fHmX4h9GiV0nCFiWQSCMIwjvGS3wUD4pfhQ/8G11XJ
	 hcV2vML25l5e5cOmENmsjNG+vNVnVGLaNIbD+EeE01g6NslxYi9y8D9zkfCBz7jkxU
	 qV9PGEHt/oa6FtJQT9e1i3eOsM8rlSe+La6Jsx5oSbV49o958feTHsXbrRIGqxjgi5
	 cUj0sAX1Nasxx7dfWS6FSBGC71/OYVoAEpDSCuGiZju5yzvDaLRfzg5+YxhDKT0u+0
	 +C9X8fRi6feumN/nSYSiAsTYmEriWUBM/CfcKGxUglS/EAG0Y+rgFwrqd5gj1SI500
	 UTl9B73Yx3xxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DC359CE0962; Thu,  2 May 2024 14:18:48 -0700 (PDT)
Date: Thu, 2 May 2024 14:18:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	elver@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
	peterz@infradead.org, dianders@chromium.org, pmladek@suse.com,
	arnd@arndb.de, torvalds@linux-foundation.org, kernel-team@meta.com,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 cmpxchg 12/13] sh: Emulate one-byte cmpxchg
Message-ID: <0a429959-935d-4800-8d0c-4e010951996d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
 <20240501230130.1111603-12-paulmck@kernel.org>
 <1376850f47279e3a3f4f40e3de2784ae3ac30414.camel@physik.fu-berlin.de>
 <b7ae0feb-d401-43ee-8d5f-ce62ca224638@paulmck-laptop>
 <6f7743601fe7bd50c2855a8fd1ed8f766ef03cac.camel@physik.fu-berlin.de>
 <9a4e1928-961d-43af-9951-71786b97062a@paulmck-laptop>
 <20240502205345.GK2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502205345.GK2118490@ZenIV>

On Thu, May 02, 2024 at 09:53:45PM +0100, Al Viro wrote:
> On Thu, May 02, 2024 at 06:33:49AM -0700, Paul E. McKenney wrote:
> 
> > Understood, and this sort of compatibility consideration is why this
> > version of this patchset does not emulate two-byte (16-bit) cmpxchg()
> > operations.  The original (RFC) series did emulate these, which does
> > not work on a few architectures that do not provide 16-bit load/store
> > instructions, hence no 16-bit support in this series.
> > 
> > So this one-byte-only series affects only Alpha systems lacking
> > single-byte load/store instructions.  If I understand correctly, Alpha
> > 21164A (EV56) and later *do* have single-byte load/store instructions,
> > and thus are still just fine.  In fact, it looks like EV56 also has
> > two-byte load/store instructions, and so would have been OK with
> > the original one-/two-byte RFC series.
> 
> Wait a sec.  On Alpha we already implement 16bit and 8bit xchg and cmpxchg.
> See arch/alpha/include/asm/xchg.h:
> static inline unsigned long
> ____cmpxchg(_u16, volatile short *m, unsigned short old, unsigned short new)
> {
>        unsigned long prev, tmp, cmp, addr64;
> 
>        __asm__ __volatile__(
>        "       andnot  %5,7,%4\n"
>        "       inswl   %1,%5,%1\n"
>        "1:     ldq_l   %2,0(%4)\n"
>        "       extwl   %2,%5,%0\n"
>        "       cmpeq   %0,%6,%3\n"
>        "       beq     %3,2f\n"
>        "       mskwl   %2,%5,%2\n"
>        "       or      %1,%2,%2\n"
>        "       stq_c   %2,0(%4)\n"
>        "       beq     %2,3f\n"
>        "2:\n"
>        ".subsection 2\n"
>        "3:     br      1b\n"
>        ".previous"
>        : "=&r" (prev), "=&r" (new), "=&r" (tmp), "=&r" (cmp), "=&r" (addr64)
>        : "r" ((long)m), "Ir" (old), "1" (new) : "memory");
> 
>        return prev;
> }
> 
> Load-locked and store-conditional are done on 64bit value, with
> 16bit operations done in registers.  This is what 16bit store
> (assignment to unsigned short *) turns into with
>         stw $17,0($16)		// *(u16*)r16 = r17
> and without -mbwx
>         insql $17,$16,$17	// r17 = r17 << (8 * (r16 & 7))
>         ldq_u $1,0($16)		// r1 = *(u64 *)(r16 & ~7)
> 	mskwl $1,$16,$1		// r1 &= ~(0xffff << (8 * (r16 & 7))
> 	bis $17,$1,$17		// r17 |= r1
> 	stq_u $17,0($16)	// *(u64 *)(r16 & ~7) = r17
> 
> What's more, load-locked/store-conditional doesn't have 16bit and 8bit
> variants on any Alphas - it's always 32bit (ldl_l) or 64bit (ldq_l).
> 
> What BWX adds is load/store byte/word, load/store byte/word unaligned
> and sign-extend byte/word.  IOW, it's absolutely irrelevant for
> cmpxchg (or xchg) purposes.

If you are only ever doing atomic read-modify-write operations on the
byte in question, then agreed, you don't care about byte loads and stores.

But there are use cases that do mix smp_store_release() with cmpxchg(),
and those use cases won't work unless at least byte store is implemented.
Or I suppose that we could use cmpxchg() instead of smp_store_release(),
but that is wasteful for architectures that do support byte stores.

So EV56 adds the byte loads and stores needed for those use cases.

Or am I missing your point?

							Thanx, Paul

