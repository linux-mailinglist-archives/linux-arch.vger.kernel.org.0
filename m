Return-Path: <linux-arch+bounces-4831-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4B19042B4
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 19:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADF2289C52
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7342B9DD;
	Tue, 11 Jun 2024 17:48:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4873B5CDE9;
	Tue, 11 Jun 2024 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128138; cv=none; b=GRiHMaBHDKJd1KypLmoT3mCk/dxzv7EwlqdRptBLuzBiuPbrPK5z/+4pl+xPDtZpALTsaxoBYXMPS2ENavLTnOk9KAkRdvbQSIKHQ3FonLNz4y5711sS4kFeId6edqIa+AQEn3ia//EMXTLl88PV3t7XU+qCE+z4mPyL1Xo+BiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128138; c=relaxed/simple;
	bh=6PB6r+2ivy1DqOODJ6xPwma2D1oQ5gkONrmouW8ygT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwuYjuWzh9U5S6SHNPe6oQ0Q0x+0OZoADLOZMLuHQtQTXQBGnYBjmbgBANfNvLCp6gmVrkXhs6hu7bduE1CJ+HaFl1lhjk8ibw6oAI5HqjoYKiIphlgcRrjyVPht+R1PMxWvypx/4EZ3nkYyDve3HKx6v/t8wVu5wVuJeCoAxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD344152B;
	Tue, 11 Jun 2024 10:49:19 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06D643F73B;
	Tue, 11 Jun 2024 10:48:52 -0700 (PDT)
Date: Tue, 11 Jun 2024 18:48:47 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 4/7] arm64: add 'runtime constant' support
Message-ID: <ZmiN_7LMp2fbKhIw@J2N7QTR9R3>
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-5-torvalds@linux-foundation.org>
 <ZmhfNRViOhyn-Dxi@J2N7QTR9R3>
 <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiHp60JjTs=qZDboGnQxKSzv=hLyjEp+8StqvtjOKY64w@mail.gmail.com>

On Tue, Jun 11, 2024 at 09:56:17AM -0700, Linus Torvalds wrote:
> On Tue, 11 Jun 2024 at 07:29, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > Do we expect to use this more widely? If this only really matters for
> > d_hash() it might be better to handle this via the alternatives
> > framework with callbacks and avoid the need for new infrastructure.
> 
> Hmm. The notion of a callback for alternatives is intriguing and would
> be very generic, but we don't have anything like that right now.
> 
> Is anybody willing to implement something like that? Because while I
> like the idea, it sounds like a much bigger change.

Fair enough if that's a pain on x86, but we already have them on arm64, and
hence using them is a smaller change there. We already have a couple of cases
which uses MOVZ;MOVK;MOVK;MOVK sequence, e.g.

	// in __invalidate_icache_max_range()
        asm volatile(ALTERNATIVE_CB("movz %0, #0\n"
                                    "movk %0, #0, lsl #16\n"
                                    "movk %0, #0, lsl #32\n"
                                    "movk %0, #0, lsl #48\n",
                                    ARM64_ALWAYS_SYSTEM,
                                    kvm_compute_final_ctr_el0)
                     : "=r" (ctr));

... which is patched via the callback:

	void kvm_compute_final_ctr_el0(struct alt_instr *alt,
				       __le32 *origptr, __le32 *updptr, int nr_inst)
	{
		generate_mov_q(read_sanitised_ftr_reg(SYS_CTR_EL0),
			       origptr, updptr, nr_inst);
	}       

... where the generate_mov_q() helper does the actual instruction generation.

So if we only care about a few specific constants, we could give them their own
callbacks, like kvm_compute_final_ctr_el0() above.

[...]

> > We have some helpers for instruction manipulation, and we can use
> > aarch64_insn_encode_immediate() here, e.g.
> >
> > #include <asm/insn.h>
> >
> > static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
> > {
> >         u32 insn = le32_to_cpu(*p);
> >         insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_16, insn, val);
> >         *p = cpu_to_le32(insn);
> > }
> 
> Ugh. I did that, and then noticed that it makes the generated code
> about ten times bigger.
> 
> That interface looks positively broken.
> 
> There is absolutely nobody who actually wants a dynamic argument, so
> it would have made both the callers and the implementation *much*
> simpler had the "AARCH64_INSN_IMM_16" been encoded in the function
> name the way I did it for my instruction rewriting.
>
> It would have made the use of it simpler, it would have avoided all
> the "switch (type)" garbage, and it would have made it all generate
> much better code.

Oh, completely agreed. FWIW, I have better versions sat in my
arm64/insn/rework branch, but I haven't had the time to get all the rest
of the insn framework cleanup sorted:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?h=arm64/insn/rework&id=9cf0ec088c9d5324c60933bf3924176fea0a4d0b

I can go prioritise getting that bit out if it'd help, or I can clean
this up later.

Those allow the compiler to do much better, including compile-time (or
runtime) checks that immediates fit. For example:

	void encode_imm16(__le32 *p, u16 imm)
	{
		u32 insn = le32_to_cpu(*p);

		// Would warn if 'imm' were u32.
		// As u16 always fits, no warning
		BUILD_BUG_ON(!aarch64_insn_try_encode_unsigned_imm16(&insn, imm));

		*p = cpu_to_le32(insn);
	}

... compiles to:

	<encode_imm16>:
	       ldr     w2, [x0]
	       bfi     w2, w1, #5, #16
	       str     w2, [x0]
	       ret

... which I think is what you want?

> So I did that change you suggested, and then undid it again.
> 
> Because that whole aarch64_insn_encode_immediate() thing is an
> abomination, and should be burned at the stake.  It's misdesigned in
> the *worst* possible way.
> 
> And no, this code isn't performance-critical, but I have some taste,
> and the code I write will not be using that garbage.

Fair enough.

Mark.

