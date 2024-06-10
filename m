Return-Path: <linux-arch+bounces-4790-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C6901E96
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 11:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE277285ECD
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41124745F4;
	Mon, 10 Jun 2024 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DbH62QL3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F842AA1
	for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013038; cv=none; b=N4Br/qRoyM/QUFB08K7VRiaP0UX6HWQLcnnDNpkIquVMCxnTv+T3KwmFyaWiXxQwwfSDD84qEQJOXMPE+nBQWyU26gchms9cCo8LhXRQaLVEJzjOezmLzRKreiCqwa5qzLRzMVGkANx7/IaoNLR4C6u+g17oRD3NmnOIcyMd+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013038; c=relaxed/simple;
	bh=kNNDXK7b4Xh+VnuAituAR6H2aCNCWwfL0tJnJ02Fld0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3NGdLdtoeZ/ZLC8r5qG2z6xB2AbvZmH+YIlCR/Hmb8ZuYDHe/PZ0ezaPjo1Zq4d68qZZgyS4PIhKrLlrEA1sOqHef6G/dE0T96UEm/YYglydGPMKrtaJ1sTR66sfekKiS+G9gRfsjAni2IgaGKMOb5mnuEmJ43B4Zmjqt0prOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=DbH62QL3; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c804e092dso1982295e87.2
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 02:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1718013033; x=1718617833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhQD8jBDixvGePNZ6fOoJzlYpyPik3HQbXqtSjqWnKg=;
        b=DbH62QL3Yf09vLs8vSQcXvmymxPi1BL8P2Fki5BgHN3KE12OybJQmw/ArDgBakIrFh
         a+ANP8SaFqXBjIreefD1TJrpAAuDJR3t6ELDnIUTv3F8gKHU3Lvy/ebycEqE1vjyziQt
         SiAW+LztaboFD7VcFXbWe4duKltiHkZSyNEF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013033; x=1718617833;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhQD8jBDixvGePNZ6fOoJzlYpyPik3HQbXqtSjqWnKg=;
        b=lkPKVOWKIvM8KBRuBRz99Rd5831P5yL9JXAEzwS1GrVu0VgsRv4OUJYW03E0IMTKR9
         GvDh6iH4xJCSTGepfrJZPQMpJmh2za+vxrncZ3O3YlmNP77NGC05czrSOFhioEmmPWKa
         JngDXBL2vZQ9Kr5S+M/gYwyRdEQ3pgGdWr7QHFgKbEgJsyZkzWakVNg7YJij1H4ULwhJ
         CdamFNutPctAw7ggO9lnMwRFdZwjmf/g+SFmjUu2phcokieVNALbfSxk3xilO3lI1ctK
         2dIuaRK7p/9K8t3cw9cnWR5eAFcXqdtNVaLaq2S1p3mTRGFyHkvIKbQyWl0rTtJ6Kn+6
         ELrg==
X-Forwarded-Encrypted: i=1; AJvYcCV8pvPmRu9EQRUjNJjmKNODFz1wTf1P2L5IrsYdvSGrJuXEIdd4yzgjJ7ymXsJKEK1fAA9f2I3vozWdKQbJD1iNQLVwG5AUgLGBbQ==
X-Gm-Message-State: AOJu0YyN6j9WZoDtBsdT8ja0xpKnO4E8oUlYPRFdZJ6rJN/aKv8l57Ml
	NVfKF4YbaU0muyiBK13pVBN3QIkhycRzT7dYHjPhU9U1p18L6G6ZmtuR142NFF0=
X-Google-Smtp-Source: AGHT+IFXRyQyWFMKLYjD/GBJg5pDqk4f2+NssyhuQ2d4Jvbvj9FZNmR27tUBN89axQ8hkLV0zY+hdg==
X-Received: by 2002:a05:6512:3e25:b0:52b:c195:5d9c with SMTP id 2adb3069b0e04-52bc195620fmr7292894e87.61.1718013032740;
        Mon, 10 Jun 2024 02:50:32 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c8f4f52c1sm101195e87.266.2024.06.10.02.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 02:50:32 -0700 (PDT)
Message-ID: <29a8ceb4-a699-433b-8a11-be6b3c9fd045@rasmusvillemoes.dk>
Date: Mon, 10 Jun 2024 11:50:31 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
Content-Language: en-US, da
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20240608193504.429644-2-torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/06/2024 21.35, Linus Torvalds wrote:
> Needs more comments and testing, but it works, and has a generic
> fallback for architectures that don't support it.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> 
> Notes from the first hack: I renamed the infrastructure from "static
> const" to "runtime const".  We end up having a number of uses of "static
> const" that are related to the C language notion of "static const"
> variables or functions, and "runtime constant" is a bit more descriptive
> anyway. 
> 
> And this now is properly abstracted out, so that any architecture can
> choose to implement their own version, but it all falls back on "just
> use the variable".

Well, I think it lacks a little. I made it so that an arch didn't need
to implement support for all runtime_const_*() helpers (I'll use that
name because yes, much better than rai_), but could implement just
runtime_const_load() and not the _shift_right thing, and then the base
pointer would be loaded as an immediate, and the shift count would also
be loaded as an immediate, but into a register, and the actual shift
would be with the shift amount from that register, so no D$ access.

So I think it should be something like

#ifndef runtime_const_load(x)
#define runtime_const_load(x) (x)
#endif
#ifndef runtime_const_shift_right_32
#define runtime_const_shift_right_32(val, sym) ((u32)val >>
runtime_const_load(sym))
#endif

etc. (This assumes we add some type-generic runtime_const_load that can
be used both for pointers and ints; supporting sizeof() < 4 is probably
not relevant, but could also be done).

Otherwise, if we want to add some runtime_const_mask32() thing to
support hash tables where we use that model, one would have to hook up
support on all architectures at once. Similarly, architectures that are
late to the party won't need to do the full monty at once, just
implementing runtime_const_load() would be enough to get some of the win.

> Rasmus - I've cleaned up my patch a lot, and it now compiles fine on
> other architectures too, although obviously with the fallback of "no
> constant fixup".  As a result, my patch is actually smaller and much
> cleaner, and I ended up liking my approach more than your RAI thing
> after all. 

Yeah, it's nice and small. I was probably over-ambitious, as I also
wanted to, eventually, use runtime_const_load() for lots of the *_cachep
variables and similar. With my approach I didn't have to modify the
linker script every time a new use is introduced, and also didn't have
to modify the place that does the initialization - but it did come at
the cost of only patching everything at once at the end of init, thus
requiring the trampoline to do the loads from memory in the meantime.
But that was partly also for another too ambitious thing: eventually
allowing this to be used for __read_mostly and not just __ro_after_init
stuff (various run-time limits etc.).

> 
>  arch/x86/include/asm/runtime-const.h | 61 ++++++++++++++++++++++++++++
>  arch/x86/kernel/vmlinux.lds.S        |  3 ++
>  fs/dcache.c                          | 24 +++++++----
>  include/asm-generic/Kbuild           |  1 +
>  include/asm-generic/runtime-const.h  | 15 +++++++
>  include/asm-generic/vmlinux.lds.h    |  8 ++++
>  6 files changed, 104 insertions(+), 8 deletions(-)
>  create mode 100644 arch/x86/include/asm/runtime-const.h
>  create mode 100644 include/asm-generic/runtime-const.h
> 
> diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
> new file mode 100644
> index 000000000000..b4f7efc0a554
> --- /dev/null
> +++ b/arch/x86/include/asm/runtime-const.h
> @@ -0,0 +1,61 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_RUNTIME_CONST_H
> +#define _ASM_RUNTIME_CONST_H
> +
> +#define runtime_const_ptr(sym) ({				\
> +	typeof(sym) __ret;					\
> +	asm("mov %1,%0\n1:\n"					\
> +		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
> +		".long 1b - %c2 - .\n\t"			\
> +		".popsection"					\
> +		:"=r" (__ret)					\
> +		:"i" ((unsigned long)0x0123456789abcdefull),	\
> +		 "i" (sizeof(long)));				\
> +	__ret; })
> +
> +// The 'typeof' will create at _least_ a 32-bit type, but
> +// will happily also take a bigger type and the 'shrl' will
> +// clear the upper bits
> +#define runtime_const_shift_right_32(val, sym) ({		\
> +	typeof(0u+(val)) __ret = (val);				\
> +	asm("shrl $12,%k0\n1:\n"				\
> +		".pushsection runtime_shift_" #sym ",\"a\"\n\t"	\
> +		".long 1b - 1 - .\n\t"				\
> +		".popsection"					\
> +		:"+r" (__ret));					\
> +	__ret; })

Don't you need a cc clobber here? And for both, I think asm_inline is
appropriate, as you really want to tell gcc that this just consists of a
single instruction, the .pushsection games notwithstanding.

I know it's a bit more typing, but the section names should be
"runtime_const_shift" etc., not merely "runtime_shift".



> +
> +#define runtime_const_init(type, sym, value) do {	\
> +	extern s32 __start_runtime_##type##_##sym[];	\
> +	extern s32 __stop_runtime_##type##_##sym[];	\
> +	runtime_const_fixup(__runtime_fixup_##type,	\
> +		(unsigned long)(value), 		\
> +		__start_runtime_##type##_##sym,		\
> +		__stop_runtime_##type##_##sym);		\
> +} while (0)
> +
> +/*
> + * The text patching is trivial - you can only do this at init time,
> + * when the text section hasn't been marked RO, and before the text
> + * has ever been executed.
> + */
> +static inline void __runtime_fixup_ptr(void *where, unsigned long val)
> +{
> +	*(unsigned long *)where = val;
> +}
> +
> +static inline void __runtime_fixup_shift(void *where, unsigned long val)
> +{
> +	*(unsigned char *)where = val;
> +}
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
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 3509afc6a672..6e73403e874f 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -357,6 +357,9 @@ SECTIONS
>  	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
>  #endif
>  
> +	RUNTIME_CONST(shift, d_hash_shift)
> +	RUNTIME_CONST(ptr, dentry_hashtable)
> +

Hm, doesn't this belong in the common linker script? I mean, if arm64
were to implement support for this, they'd also have to add this
boilerplate to their vmlinux.lds.S? And then if another
RUNTIME_CONST(ptr, ...) use case is added that goes in all
at-that-point-in-time supporting architectures' vmlinux.lds.S. Doesn't
seem to scale.

>  	. = ALIGN(PAGE_SIZE);
>  
>  	/* freed after init ends here */
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 407095188f83..4511e557bf84 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -97,12 +97,14 @@ EXPORT_SYMBOL(dotdot_name);
>   */
>  
>  static unsigned int d_hash_shift __ro_after_init;
> -
>  static struct hlist_bl_head *dentry_hashtable __ro_after_init;
>  
> -static inline struct hlist_bl_head *d_hash(unsigned int hash)
> +#include <asm/runtime-const.h>
> +

Please keep the #includes together at the top of the file.

> +static inline struct hlist_bl_head *d_hash(unsigned long hashlen)
>  {
> -	return dentry_hashtable + (hash >> d_hash_shift);
> +	return runtime_const_ptr(dentry_hashtable) +
> +		runtime_const_shift_right_32(hashlen, d_hash_shift);
>  }

Could you spend some words on this signature change? Why should this now
(on 64BIT) take the full hash_len as argument, only to let the compiler
(with the (u32) cast) or cpu (in the x86_64 case, via the %k modifier if
I'm reading things right) only use the lower 32 bits?

The patch would be even smaller without this, and perhaps it could be
done as a separate patch if it does lead to (even) better code generation.

>  
>  static void __d_rehash(struct dentry *entry)
>  {
> -	struct hlist_bl_head *b = d_hash(entry->d_name.hash);
> +	struct hlist_bl_head *b = d_hash(entry->d_name.hash_len);
>  
>  	hlist_bl_lock(b);
>  	hlist_bl_add_head_rcu(&entry->d_hash, b);
> @@ -3129,6 +3131,9 @@ static void __init dcache_init_early(void)
>  					0,
>  					0);
>  	d_hash_shift = 32 - d_hash_shift;
> +
> +	runtime_const_init(shift, d_hash_shift, d_hash_shift);
> +	runtime_const_init(ptr, dentry_hashtable, dentry_hashtable);
>  }
>  
>  static void __init dcache_init(void)
> @@ -3157,6 +3162,9 @@ static void __init dcache_init(void)
>  					0,
>  					0);
>  	d_hash_shift = 32 - d_hash_shift;
> +
> +	runtime_const_init(shift, d_hash_shift, d_hash_shift);
> +	runtime_const_init(ptr, dentry_hashtable, dentry_hashtable);
>  }
>  

Aside: That duplication makes me want to make dcache_init() grow an 'int
early' arg, change the body accordingly and change the call sites to
dcache_init(1) / dcache_init(0). But since the functions propably only
change once per decade or something like that, probably not worth it.

> +/*
> + * This is the fallback for when the architecture doesn't
> + * support the runtime const operations.
> + *
> + * We just use the actual symbols as-is.
> + */
> +#define runtime_const_ptr(sym) (sym)
> +#define runtime_const_shift_right_32(val, sym) ((u32)(val)>>(sym))
> +#define runtime_const_init(type,sym,value) do { } while (0)

Hm, I wonder if there's ever a case where you want to patch using any
other value than what you've just assigned to sym. IOW, why doesn't
runtime_const_init just take type,sym args?

It can't be to support some 'struct global { void *this; } g' where you
then want to use the identifier g_this for the tables and g.this for the
value, 'cause that wouldn't work with the fallbacks vs the x86
implementation - one would need runtime_const_ptr(g.this) and the other
runtime_const_ptr(g_this) at the use sites.

Rasmus


