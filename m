Return-Path: <linux-arch+bounces-6666-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87282960CF6
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 16:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401DF288CEB
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D3A1C4620;
	Tue, 27 Aug 2024 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMzayiYy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FF01C4618
	for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767524; cv=none; b=Y1+bY+w1tkCJLF/1YGfSekU/+krz4A7VDG90scDN50m75y+XpG6xG71RixkpD48gXRK7rPgUldh99XNI8iw+JvLoni48sZINE2OUh5+2TrLZnCHjPTrJapzaS+nUq17cC55fCsg+ItKQJrUl5XgRf445WtjlRx+HNt5IPXcUJ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767524; c=relaxed/simple;
	bh=YlgI63gCz/ubRuS1K7XOYNhWSUxwbaCiZSATcfZJFr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gv7hMko/ltg0eKn2TyxgaMdcM9+DlRcwJ9HjiIV4epKSTzRX4DFYaM9kbliBvAa3ChKvYgL7/HnFp6ZscUm9sOaNZVINgYVDtTTRiVp9jei7z8EmWqu2Pi7mAFIsByRo7lCv1A9suH1SBSivY1SlY7GgckWEOrM/LFoLqJ6OTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BMzayiYy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2021c03c13aso41650345ad.1
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 07:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724767522; x=1725372322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5qJTnZjOreTXNoRQ3dJJNm0CwfPUW8ZSubflsY8WkEM=;
        b=BMzayiYyF83ZaTdQXehlLSzL6OTzpoALJijvtnnY87oV1ja8rmarVxMKue0qXuFzUQ
         J1d1Fwzw0OEs9Kxv7EWduXrq9QCEx++yiC1Awg0O7bKm6qZcF5w0wBB7FuFC8SLsxEeV
         qqJIbBmA9JJq3Rfm6w5WzkxFs4LWXIeg6xTwMmC0vepM3EZYvxbTBR2nNuu2mfnmExks
         mdBe4st+SubGj2t1w0WU1fVYSB6kqmgS15aU06aDoU/EWzvn7Q1oraXlU0yQfRolaegC
         /Fc/NY7sWKa1osFvVm6B67rZSUW51y0X/wk1peRXaL3NGjJ1toMKjTyon7/iEXnA5PO3
         c2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724767522; x=1725372322;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qJTnZjOreTXNoRQ3dJJNm0CwfPUW8ZSubflsY8WkEM=;
        b=O8FimXwtqiIuK4UaoeXllFMC76PQbxNEe/eYZ8WUoos5HqZJqrSaEM1yoi0nZ6D8qS
         Yspf0omLb2yyjjxX7yKkmUeSR1HAfuoQlypJhc9+ujBoOhw88qSlAXl5IxRTglgfec+C
         A9DRTtgO5DcDVD7cIdb+y+3QRRgXhmEOZFzAVz8k6KfWzdpz5/5pGl0Q5NpmuYGmSgfc
         xlCSY+s8C5W9aZv2Vcuh7aw5ocAQPnXtSyUN9KzRE5QCRTqgJjWevptUlUg7HsVuDviS
         r5M9nl381hOM1pcv1egBYjOQb+r1SmDWdMviE7ojakkEqwpLOsKcC5OTF1K9OvDEtP9N
         2xUw==
X-Forwarded-Encrypted: i=1; AJvYcCX1Bg//zcbFs8y8dpH38R7CgTy26TKClknWwMDk3oT6yDsb71svMBdFOe5jtKknZ1eCrACq4H40aRVk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzit/223C/I9F/s0PAgISNGVVyerC9NLzFdaPSQgv9hPQg0x+IY
	UeLtwTXxWJBbyDDOOAvXvz5QouQJNgg4Hjm2J6yXXCK+kgRl5mNmUVRPdvRWbYc=
X-Google-Smtp-Source: AGHT+IFm2XL/2ZphveppuAq9mcHR6jdAYptkd6D6nqDr+dGyM0ybN3qOfQh1eoUk1CtHCx6AytYDRQ==
X-Received: by 2002:a17:902:d2c6:b0:203:a05d:852c with SMTP id d9443c01a7336-204ddcba477mr56302555ad.2.1724767521835;
        Tue, 27 Aug 2024 07:05:21 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb? ([2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560f569sm83443315ad.220.2024.08.27.07.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 07:05:19 -0700 (PDT)
Message-ID: <80ec4895-43d2-4238-94bd-bbf7dc74875d@linaro.org>
Date: Tue, 27 Aug 2024 11:05:15 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Eric Biggers <ebiggers@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
 <Zs3b4j4T51ATpTB5@J2N7QTR9R3.cambridge.arm.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <Zs3b4j4T51ATpTB5@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/08/24 11:00, Mark Rutland wrote:
> On Mon, Aug 26, 2024 at 06:10:40PM +0000, Adhemerval Zanella wrote:
>> Hook up the generic vDSO implementation to the aarch64 vDSO data page.
>> The _vdso_rng_data required data is placed within the _vdso_data vvar
>> page, by using a offset larger than the vdso_data
>> (__VDSO_RND_DATA_OFFSET).
>>
>> The vDSO function requires a ChaCha20 implementation that does not
>> write to the stack, and that can do an entire ChaCha20 permutation.
>> The one provided is based on the current chacha-neon-core.S and uses NEON
>> on the permute operation.
> 
> Is there a fallback for when NEON isn't present? The kernel supports
> some (deeply embedded) implementations where NEON is not present, and 
> AFAICT this will UNDEF on those machines.
> 
> Mark.

Not right know, in this case I think it better to just do something similar
to Loongarch and fallback to the syscall. I will add this on the next version.

> 
>> Signed-off-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
>> ---
>>  arch/arm64/Kconfig                         |   1 +
>>  arch/arm64/include/asm/vdso/getrandom.h    |  50 +++++++
>>  arch/arm64/include/asm/vdso/vsyscall.h     |   9 ++
>>  arch/arm64/kernel/vdso/Makefile            |   7 +-
>>  arch/arm64/kernel/vdso/vdso.lds.S          |   4 +
>>  arch/arm64/kernel/vdso/vgetrandom-chacha.S | 153 +++++++++++++++++++++
>>  arch/arm64/kernel/vdso/vgetrandom.c        |  13 ++
>>  tools/testing/selftests/vDSO/Makefile      |   4 +-
>>  8 files changed, 238 insertions(+), 3 deletions(-)
>>  create mode 100644 arch/arm64/include/asm/vdso/getrandom.h
>>  create mode 100644 arch/arm64/kernel/vdso/vgetrandom-chacha.S
>>  create mode 100644 arch/arm64/kernel/vdso/vgetrandom.c
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index b3fc891f1544..e3f4c5bf0661 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -237,6 +237,7 @@ config ARM64
>>  	select HAVE_KPROBES
>>  	select HAVE_KRETPROBES
>>  	select HAVE_GENERIC_VDSO
>> +	select VDSO_GETRANDOM
>>  	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
>>  	select IRQ_DOMAIN
>>  	select IRQ_FORCED_THREADING
>> diff --git a/arch/arm64/include/asm/vdso/getrandom.h b/arch/arm64/include/asm/vdso/getrandom.h
>> new file mode 100644
>> index 000000000000..6e2b136813ca
>> --- /dev/null
>> +++ b/arch/arm64/include/asm/vdso/getrandom.h
>> @@ -0,0 +1,50 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __ASM_VDSO_GETRANDOM_H
>> +#define __ASM_VDSO_GETRANDOM_H
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <asm/unistd.h>
>> +#include <vdso/datapage.h>
>> +
>> +/**
>> + * getrandom_syscall - Invoke the getrandom() syscall.
>> + * @buffer:	Destination buffer to fill with random bytes.
>> + * @len:	Size of @buffer in bytes.
>> + * @flags:	Zero or more GRND_* flags.
>> + * Returns:	The number of random bytes written to @buffer, or a negative value indicating an error.
>> + */
>> +static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
>> +{
>> +	register long int x8 asm ("x8") = __NR_getrandom;
>> +	register long int x0 asm ("x0") = (long int) buffer;
>> +	register long int x1 asm ("x1") = (long int) len;
>> +	register long int x2 asm ("x2") = (long int) flags;
>> +
>> +	asm ("svc 0" : "=r"(x0) : "r"(x8), "0"(x0), "r"(x1), "r"(x2));
>> +
>> +	return x0;
>> +}
>> +
>> +static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
>> +{
>> +	return &_vdso_rng_data;
>> +}
>> +
>> +/**
>> + * __arch_chacha20_blocks_nostack - Generate ChaCha20 stream without using the stack.
>> + * @dst_bytes:	Destination buffer to hold @nblocks * 64 bytes of output.
>> + * @key:	32-byte input key.
>> + * @counter:	8-byte counter, read on input and updated on return.
>> + * @nblocks:	Number of blocks to generate.
>> + *
>> + * Generates a given positive number of blocks of ChaCha20 output with nonce=0, and does not write
>> + * to any stack or memory outside of the parameters passed to it, in order to mitigate stack data
>> + * leaking into forked child processes.
>> + */
>> +extern void __arch_chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks);
>> +
>> +#endif /* !__ASSEMBLY__ */
>> +
>> +#endif /* __ASM_VDSO_GETRANDOM_H */
>> diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
>> index f94b1457c117..7ddb2bc3b57b 100644
>> --- a/arch/arm64/include/asm/vdso/vsyscall.h
>> +++ b/arch/arm64/include/asm/vdso/vsyscall.h
>> @@ -2,6 +2,8 @@
>>  #ifndef __ASM_VDSO_VSYSCALL_H
>>  #define __ASM_VDSO_VSYSCALL_H
>>  
>> +#define __VDSO_RND_DATA_OFFSET  480
>> +
>>  #ifndef __ASSEMBLY__
>>  
>>  #include <linux/timekeeper_internal.h>
>> @@ -21,6 +23,13 @@ struct vdso_data *__arm64_get_k_vdso_data(void)
>>  }
>>  #define __arch_get_k_vdso_data __arm64_get_k_vdso_data
>>  
>> +static __always_inline
>> +struct vdso_rng_data *__arm64_get_k_vdso_rnd_data(void)
>> +{
>> +	return (void *)__arm64_get_k_vdso_data() + __VDSO_RND_DATA_OFFSET;
>> +}
>> +#define __arch_get_k_vdso_rng_data __arm64_get_k_vdso_rnd_data
>> +
>>  static __always_inline
>>  void __arm64_update_vsyscall(struct vdso_data *vdata, struct timekeeper *tk)
>>  {
>> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
>> index d11da6461278..37dad3bb953a 100644
>> --- a/arch/arm64/kernel/vdso/Makefile
>> +++ b/arch/arm64/kernel/vdso/Makefile
>> @@ -9,7 +9,7 @@
>>  # Include the generic Makefile to check the built vdso.
>>  include $(srctree)/lib/vdso/Makefile
>>  
>> -obj-vdso := vgettimeofday.o note.o sigreturn.o
>> +obj-vdso := vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-chacha.o
>>  
>>  # Build rules
>>  targets := $(obj-vdso) vdso.so vdso.so.dbg
>> @@ -40,8 +40,13 @@ CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
>>  				$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
>>  				$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
>>  				-Wmissing-prototypes -Wmissing-declarations
>> +CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
>> +			     $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
>> +			     $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
>> +			     -Wmissing-prototypes -Wmissing-declarations
>>  
>>  CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -fasynchronous-unwind-tables
>> +CFLAGS_vgetrandom.o = -O2 -mcmodel=tiny -fasynchronous-unwind-tables
>>  
>>  ifneq ($(c-gettimeofday-y),)
>>    CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
>> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
>> index 45354f2ddf70..f8dbcece20e2 100644
>> --- a/arch/arm64/kernel/vdso/vdso.lds.S
>> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
>> @@ -12,6 +12,8 @@
>>  #include <asm/page.h>
>>  #include <asm/vdso.h>
>>  #include <asm-generic/vmlinux.lds.h>
>> +#include <vdso/datapage.h>
>> +#include <asm/vdso/vsyscall.h>
>>  
>>  OUTPUT_FORMAT("elf64-littleaarch64", "elf64-bigaarch64", "elf64-littleaarch64")
>>  OUTPUT_ARCH(aarch64)
>> @@ -19,6 +21,7 @@ OUTPUT_ARCH(aarch64)
>>  SECTIONS
>>  {
>>  	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
>> +	PROVIDE(_vdso_rng_data = _vdso_data + __VDSO_RND_DATA_OFFSET);
>>  #ifdef CONFIG_TIME_NS
>>  	PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
>>  #endif
>> @@ -102,6 +105,7 @@ VERSION
>>  		__kernel_gettimeofday;
>>  		__kernel_clock_gettime;
>>  		__kernel_clock_getres;
>> +		__kernel_getrandom;
>>  	local: *;
>>  	};
>>  }
>> diff --git a/arch/arm64/kernel/vdso/vgetrandom-chacha.S b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
>> new file mode 100644
>> index 000000000000..3fb9715dd6f0
>> --- /dev/null
>> +++ b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
>> @@ -0,0 +1,153 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/cache.h>
>> +
>> +	.text
>> +
>> +/*
>> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
>> + * number of blocks of output with nonnce 0, taking an input key and 8-bytes
>> + * counter.  Importantly does not spill to the stack.
>> + *
>> + * void __arch_chacha20_blocks_nostack(uint8_t *dst_bytes,
>> + *				       const uint8_t *key,
>> + * 				       uint32_t *counter,
>> + *				       size_t nblocks)
>> + *
>> + * 	x0: output bytes
>> + *	x1: 32-byte key input
>> + *	x2: 8-byte counter input/output
>> + *	x3: number of 64-byte block to write to output
>> + */
>> +SYM_FUNC_START(__arch_chacha20_blocks_nostack)
>> +
>> +	/* v0 = "expand 32-byte k" */
>> +	adr_l		x8, CTES
>> +	ld1		{v5.4s}, [x8]
>> +	/* v1,v2 = key */
>> +	ld1		{ v6.4s, v7.4s }, [x1]
>> +	/* v3 = counter || zero noonce  */
>> +	ldr		d8, [x2]
>> +
>> +	adr_l		x8, ONE
>> +	ldr		q13, [x8]
>> +
>> +	adr_l		x10, ROT8
>> +	ld1		{v12.4s}, [x10]
>> +.Lblock:
>> +	/* copy state to auxiliary vectors for the final add after the permute.  */
>> +	mov		v0.16b, v5.16b
>> +	mov		v1.16b, v6.16b
>> +	mov		v2.16b, v7.16b
>> +	mov		v3.16b, v8.16b
>> +
>> +	mov		w4, 20
>> +.Lpermute:
>> +	/*
>> +	 * Permute one 64-byte block where the state matrix is stored in the four NEON
>> +	 * registers v0-v3.  It performs matrix operations on four words in parallel,
>> +	 * but requires shuffling to rearrange the words after each round.
>> +	 */
>> +
>> +.Ldoubleround:
>> +	/* x0 += x1, x3 = rotl32(x3 ^ x0, 16) */
>> +	add		v0.4s, v0.4s, v1.4s
>> +	eor		v3.16b, v3.16b, v0.16b
>> +	rev32		v3.8h, v3.8h
>> +
>> +	/* x2 += x3, x1 = rotl32(x1 ^ x2, 12) */
>> +	add		v2.4s, v2.4s, v3.4s
>> +	eor		v4.16b, v1.16b, v2.16b
>> +	shl		v1.4s, v4.4s, #12
>> +	sri		v1.4s, v4.4s, #20
>> +
>> +	/* x0 += x1, x3 = rotl32(x3 ^ x0, 8) */
>> +	add		v0.4s, v0.4s, v1.4s
>> +	eor		v3.16b, v3.16b, v0.16b
>> +	tbl		v3.16b, {v3.16b}, v12.16b
>> +
>> +	/* x2 += x3, x1 = rotl32(x1 ^ x2, 7) */
>> +	add		v2.4s, v2.4s, v3.4s
>> +	eor		v4.16b, v1.16b, v2.16b
>> +	shl		v1.4s, v4.4s, #7
>> +	sri		v1.4s, v4.4s, #25
>> +
>> +	/* x1 = shuffle32(x1, MASK(0, 3, 2, 1)) */
>> +	ext		v1.16b, v1.16b, v1.16b, #4
>> +	/* x2 = shuffle32(x2, MASK(1, 0, 3, 2)) */
>> +	ext		v2.16b, v2.16b, v2.16b, #8
>> +	/* x3 = shuffle32(x3, MASK(2, 1, 0, 3)) */
>> +	ext		v3.16b, v3.16b, v3.16b, #12
>> +
>> +	/* x0 += x1, x3 = rotl32(x3 ^ x0, 16) */
>> +	add		v0.4s, v0.4s, v1.4s
>> +	eor		v3.16b, v3.16b, v0.16b
>> +	rev32		v3.8h, v3.8h
>> +
>> +	/* x2 += x3, x1 = rotl32(x1 ^ x2, 12) */
>> +	add		v2.4s, v2.4s, v3.4s
>> +	eor		v4.16b, v1.16b, v2.16b
>> +	shl		v1.4s, v4.4s, #12
>> +	sri		v1.4s, v4.4s, #20
>> +
>> +	/* x0 += x1, x3 = rotl32(x3 ^ x0, 8) */
>> +	add		v0.4s, v0.4s, v1.4s
>> +	eor		v3.16b, v3.16b, v0.16b
>> +	tbl		v3.16b, {v3.16b}, v12.16b
>> +
>> +	/* x2 += x3, x1 = rotl32(x1 ^ x2, 7) */
>> +	add		v2.4s, v2.4s, v3.4s
>> +	eor		v4.16b, v1.16b, v2.16b
>> +	shl		v1.4s, v4.4s, #7
>> +	sri		v1.4s, v4.4s, #25
>> +
>> +	/* x1 = shuffle32(x1, MASK(2, 1, 0, 3)) */
>> +	ext		v1.16b, v1.16b, v1.16b, #12
>> +	/* x2 = shuffle32(x2, MASK(1, 0, 3, 2)) */
>> +	ext		v2.16b, v2.16b, v2.16b, #8
>> +	/* x3 = shuffle32(x3, MASK(0, 3, 2, 1)) */
>> +	ext		v3.16b, v3.16b, v3.16b, #4
>> +
>> +	subs		w4, w4, #2
>> +	b.ne		.Ldoubleround
>> +
>> +	/* output0 = state0 + v0 */
>> +	add		v0.4s, v0.4s, v5.4s
>> +	/* output1 = state1 + v1 */
>> +	add		v1.4s, v1.4s, v6.4s
>> +	/* output2 = state2 + v2 */
>> +	add		v2.4s, v2.4s, v7.4s
>> +	/* output2 = state3 + v3 */
>> +	add		v3.4s, v3.4s, v8.4s
>> +	st1		{ v0.4s - v3.4s }, [x0]
>> +
>> +	/* ++copy3.counter */
>> +	add		d8, d8, d13
>> +
>> +	/* output += 64, --nblocks */
>> +	add		x0, x0, 64
>> +	subs		x3, x3, #1
>> +	b.ne		.Lblock
>> +
>> +	/* counter = copy3.counter */
>> +	str		d8, [x2]
>> +
>> +	/* Zero out the potentially sensitive regs, in case nothing uses these again. */
>> +	eor		v0.16b, v0.16b, v0.16b
>> +	eor		v1.16b, v1.16b, v1.16b
>> +	eor		v2.16b, v2.16b, v2.16b
>> +	eor		v3.16b, v3.16b, v3.16b
>> +	eor		v6.16b, v6.16b, v6.16b
>> +	eor		v7.16b, v7.16b, v7.16b
>> +	ret
>> +SYM_FUNC_END(__arch_chacha20_blocks_nostack)
>> +
>> +        .section        ".rodata", "a", %progbits
>> +        .align          L1_CACHE_SHIFT
>> +
>> +CTES:	.word		1634760805, 857760878, 	2036477234, 1797285236
>> +ONE:    .xword		1, 0
>> +ROT8:	.word		0x02010003, 0x06050407, 0x0a09080b, 0x0e0d0c0f
>> +
>> +emit_aarch64_feature_1_and
>> diff --git a/arch/arm64/kernel/vdso/vgetrandom.c b/arch/arm64/kernel/vdso/vgetrandom.c
>> new file mode 100644
>> index 000000000000..b6d6f4db3a98
>> --- /dev/null
>> +++ b/arch/arm64/kernel/vdso/vgetrandom.c
>> @@ -0,0 +1,13 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +#include <linux/types.h>
>> +#include <linux/mm.h>
>> +
>> +#include "../../../../lib/vdso/getrandom.c"
>> +
>> +ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len);
>> +
>> +ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)
>> +{
>> +	return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);
>> +}
>> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
>> index 10ffdda3f2fa..f07ea679a4cc 100644
>> --- a/tools/testing/selftests/vDSO/Makefile
>> +++ b/tools/testing/selftests/vDSO/Makefile
>> @@ -1,6 +1,6 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  uname_M := $(shell uname -m 2>/dev/null || echo not)
>> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/)
>>  SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
>>  
>>  TEST_GEN_PROGS := vdso_test_gettimeofday
>> @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>>  TEST_GEN_PROGS += vdso_standalone_test_x86
>>  endif
>>  TEST_GEN_PROGS += vdso_test_correctness
>> -ifeq ($(uname_M),x86_64)
>> +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))
>>  TEST_GEN_PROGS += vdso_test_getrandom
>>  ifneq ($(SODIUM),)
>>  TEST_GEN_PROGS += vdso_test_chacha
>> -- 
>> 2.43.0
>>
>>

