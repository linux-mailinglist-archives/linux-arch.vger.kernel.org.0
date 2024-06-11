Return-Path: <linux-arch+bounces-4826-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA951903EC8
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 16:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE961F21B43
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 14:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A51417D890;
	Tue, 11 Jun 2024 14:29:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E5A176FB2;
	Tue, 11 Jun 2024 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116161; cv=none; b=IbrIk81h9rhnbhd5ln1kTnu+6JDRqFRnMtfTokggKIxSx8cB2d7R/rerVa2vj+V3autXVk7G/SjHmW32RKuURldb4VHPhAZWTApPyIqCpptWJ95oacIFxnNVJAxrccAm30ZIRS+36bx/16vPgOnBD4h57HQQ35/9ipznEczAu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116161; c=relaxed/simple;
	bh=/PyfgjbCM3XPrWdeAnwT/SZFOQdUS4uQaLHY2BwYneE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHd9/hGm+y2II1VVFxT56WbjUFtAlTNTabxAzuWqiCXvhVhGY0UJJrj7pasb5QLS4OioNB4KHk4evd5N3ZmbgBuZYRF+JeYLRcQUnQmJN9vIirAM2jkMgcJDNQnhI/pG9/H6xoRr2OD4QUjbeJW33b+GUUIba3y9JOSL1FljqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58A28152B;
	Tue, 11 Jun 2024 07:29:42 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 952273F5A1;
	Tue, 11 Jun 2024 07:29:15 -0700 (PDT)
Date: Tue, 11 Jun 2024 15:29:09 +0100
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
Message-ID: <ZmhfNRViOhyn-Dxi@J2N7QTR9R3>
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
 <20240610204821.230388-5-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610204821.230388-5-torvalds@linux-foundation.org>

Hi Linus,

On Mon, Jun 10, 2024 at 01:48:18PM -0700, Linus Torvalds wrote:
> This implements the runtime constant infrastructure for arm64, allowing
> the dcache d_hash() function to be generated using as a constant for
> hash table address followed by shift by a constant of the hash index.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  arch/arm64/include/asm/runtime-const.h | 75 ++++++++++++++++++++++++++
>  arch/arm64/kernel/vmlinux.lds.S        |  3 ++
>  2 files changed, 78 insertions(+)
>  create mode 100644 arch/arm64/include/asm/runtime-const.h

From a quick scan I spotted a couple of issues (explained with fixes
below). I haven't had the chance to test/review the whole series yet.

Do we expect to use this more widely? If this only really matters for
d_hash() it might be better to handle this via the alternatives
framework with callbacks and avoid the need for new infrastructure.

> diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
> new file mode 100644
> index 000000000000..02462b2cb6f9
> --- /dev/null
> +++ b/arch/arm64/include/asm/runtime-const.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RUNTIME_CONST_H
> +#define _ASM_RUNTIME_CONST_H
> +
> +#define runtime_const_ptr(sym) ({				\
> +	typeof(sym) __ret;					\
> +	asm_inline("1:\t"					\
> +		"movz %0, #0xcdef\n\t"				\
> +		"movk %0, #0x89ab, lsl #16\n\t"			\
> +		"movk %0, #0x4567, lsl #32\n\t"			\
> +		"movk %0, #0x0123, lsl #48\n\t"			\
> +		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
> +		".long 1b - .\n\t"				\
> +		".popsection"					\
> +		:"=r" (__ret));					\
> +	__ret; })
> +
> +#define runtime_const_shift_right_32(val, sym) ({		\
> +	unsigned long __ret;					\
> +	asm_inline("1:\t"					\
> +		"lsr %w0,%w1,#12\n\t"				\
> +		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
> +		".long 1b - .\n\t"				\
> +		".popsection"					\
> +		:"=r" (__ret)					\
> +		:"r" (0u+(val)));				\
> +	__ret; })
> +
> +#define runtime_const_init(type, sym) do {		\
> +	extern s32 __start_runtime_##type##_##sym[];	\
> +	extern s32 __stop_runtime_##type##_##sym[];	\
> +	runtime_const_fixup(__runtime_fixup_##type,	\
> +		(unsigned long)(sym), 			\
> +		__start_runtime_##type##_##sym,		\
> +		__stop_runtime_##type##_##sym);		\
> +} while (0)
> +
> +// 16-bit immediate for wide move (movz and movk) in bits 5..20
> +static inline void __runtime_fixup_16(unsigned int *p, unsigned int val)
> +{
> +	unsigned int insn = *p;
> +	insn &= 0xffe0001f;
> +	insn |= (val & 0xffff) << 5;
> +	*p = insn;
> +}

As-is this will break BE kernels as instructions are always encoded
little-endian regardless of data endianness. We usually handle that by
using __le32 instruction pointers and using le32_to_cpu()/cpu_to_le32()
when reading/writing, e.g.

#include <asm/byteorder.h>

static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
{
	u32 insn = le32_to_cpu(*p);
	insn &= 0xffe0001f;
	insn |= (val & 0xffff) << 5;
	*p = cpu_to_le32(insn);
}

We have some helpers for instruction manipulation, and we can use 
aarch64_insn_encode_immediate() here, e.g.

#include <asm/insn.h>

static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
{
	u32 insn = le32_to_cpu(*p);
	insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_16, insn, val);
	*p = cpu_to_le32(insn);
}

> +static inline void __runtime_fixup_ptr(void *where, unsigned long val)
> +{
> +	unsigned int *p = lm_alias(where);
> +	__runtime_fixup_16(p, val);
> +	__runtime_fixup_16(p+1, val >> 16);
> +	__runtime_fixup_16(p+2, val >> 32);
> +	__runtime_fixup_16(p+3, val >> 48);
> +}

This is missing the necessary cache maintenance and context
synchronization event.

After the new values are written, we need cache maintenance (a D$ clean
to PoU, then an I$ invalidate to PoU) followed by a context
synchronization event (e.g. an ISB) before CPUs are guaranteed to use
the new instructions rather than the old ones.

Depending on how your system has been integrated, you might get away
without that. If you see:

  Data cache clean to the PoU not required for I/D coherence

... in your dmesg, that means you only need the I$ invalidate and
context synchronization event, and you might happen to get those by
virtue of alternative patching running between dcache_init_early() and
the use of the patched instructions.

However, in general, we do need all of that. As long as this runs before
secondaries are brought up, we can handle that with
caches_clean_inval_pou(). Assuming the __le32 changes above, I'd expect
this to be:

static inline void __runtime_fixup_ptr(void *where, unsigned long val)
{
	__le32 *p = lm_alias(where);
	__runtime_fixup_16(p, val);
	__runtime_fixup_16(p + 1, val >> 16);
	__runtime_fixup_16(p + 2, val >> 32);
	__runtime_fixup_16(p + 3, val >> 48);

	caches_clean_inval_pou((unsigned long)p, (unsigned long)(p + 4));
}

> +// Immediate value is 5 bits starting at bit #16
> +static inline void __runtime_fixup_shift(void *where, unsigned long val)
> +{
> +	unsigned int *p = lm_alias(where);
> +	unsigned int insn = *p;
> +	insn &= 0xffc0ffff;
> +	insn |= (val & 63) << 16;
> +	*p = insn;
> +}

As with the other bits above, I'd expect this to be:

static inline void __runtime_fixup_shift(void *where, unsigned long val)
{
	__le32 *p = lm_alias(where);
	u32 insn = le32_to_cpu(*p);
	insn = aarch64_insn_encode_immediate(AARCH64_INSN_IMM_R, insn, val);
	*p = cpu_to_le32(insn);

	caches_clean_inval_pou((unsigned long)p, (unsigned long)(p + 1));
}

Mark.

> +
> +static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
> +	unsigned long val, s32 *start, s32 *end)
> +{
> +	while (start < end) {
> +		fn(*start + (void *)start, val);
> +		start++;
> +	}
> +}
> +
> +#endif
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 755a22d4f840..55a8e310ea12 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -264,6 +264,9 @@ SECTIONS
>  		EXIT_DATA
>  	}
>  
> +	RUNTIME_CONST(shift, d_hash_shift)
> +	RUNTIME_CONST(ptr, dentry_hashtable)
> +
>  	PERCPU_SECTION(L1_CACHE_BYTES)
>  	HYPERVISOR_PERCPU_SECTION
>  
> -- 
> 2.45.1.209.gc6f12300df
> 
> 

