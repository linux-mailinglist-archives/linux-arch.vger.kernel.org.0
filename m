Return-Path: <linux-arch+bounces-6667-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04023960D27
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 16:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793B81F22686
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 14:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700C11C4EF9;
	Tue, 27 Aug 2024 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIuMkapE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8322573466
	for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767649; cv=none; b=Q6ihLXLSQeWJ5CJCClSZi44EDXgs018Z59+TrPRl/D/c/HL1PmkDMFCQRayFA3FYQw90Ki/2XZR+pTY/JL7HskwPi/8eUB8hYLnK4/6wau7Tpe4e2Xpc15g1avAC+z/ncfRdV/BSllAIrVUKXWeavCz9Gl5hfxFZN4DpgE6nwvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767649; c=relaxed/simple;
	bh=K9lgvZpWgHyZfOmspvVq64PEIHpt0SbtQcTFhjLn10A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f0k/s2LzIdgLIDieB16fo/wiidtoZaaoXoF7Ct8jVhCEdFqfkJZxd1MSzz7rmVCbbF5SKg/jGyabjSlnH4fHdrOTV4/McVfs0wOGZf0n+vh42E9GsCpUXPaVyffnnWPtiL09CW2T67mvw+urDbTwQRXFo/kg4Llt1iUDUWGC394=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PIuMkapE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2021a99af5eso50184555ad.1
        for <linux-arch@vger.kernel.org>; Tue, 27 Aug 2024 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724767646; x=1725372446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TDm5a7OlR/7U6ykT+0Jq6tWrOVlgFNdpji+7rba+NPs=;
        b=PIuMkapEejcJIhueS/NlQHQ2P072C/TClFILc6N7hRJyplVhp6lSCobkLAG8Ezcouq
         tmnpUJRsnnG6IA1ftTwoEYWEkwUQOLZpaKb5uoxVle8NWrMUo7b18g6+CVXPTAwl2Qyh
         fgTTSKYPZNx+R6sUovGm2ssBGMXQWyrIrJBI0lmYNDocmQRYuaPtu/HrzmwIGHWlVMI9
         Kx92jZXPLzUaDAQcgMFe7aMAwmljy/oRT9Rkz2Vb7uaLby6L48szlLHdfbDZqoIFlWgV
         T+feOUlY2LFRPNYKG++seMuvNQiqVv+gFTWYokrra2G5dtqzp80Pam5tZz/h8ikO8wgr
         vXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724767646; x=1725372446;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDm5a7OlR/7U6ykT+0Jq6tWrOVlgFNdpji+7rba+NPs=;
        b=hVxkxmDxoM8/sxInVSoNwn1Z1A5VAvD/WBZM1J3wVFH6NCglUxC9oI+Ie9ZU+cvVfU
         LSvDjblbJIMO5GpxEQCioXTWwuALOPomb8wdWYByMP4ALNNtUMYNg26aDTNc2G+sCilz
         nS2qeot6UpWgl8IbohYCEfTkcDMejwIuqnoNDcA8kgsr1jyMAKEnWJ7Dq4eHItWja3fJ
         RCbqNJf1anl6OBj9wDgd4YbqRPVpjQESZbRYeafqmMMJZyCpWgJ8T1KPk7HySH4EFV37
         NUnyzCWuavH6lKJFrMo2AYnKkNObje/WgnpS+KNeCN+1RxZZLapNDh11xNQQia3Rz48r
         69vA==
X-Forwarded-Encrypted: i=1; AJvYcCU8z/rAkLtIZSn1JiL01uZRZYXyMUx+Q0b63lVl3w5sCNWrWjcZnGJkY0nMAS1tgtOsoamfH0kteK/R@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6DSRyrf0DsGOLfz/RK/fqs9UmquXZ1ubTaLpVpXvKdsMIFTIc
	ATf3DbWXiuRXl/QPk8mwxbk8gFAMnnFQsfu67zM2UDgKhBpNjA+k/kNWAdYpIqY=
X-Google-Smtp-Source: AGHT+IHQDbCLVIzMT09kixbJK36L4yX7rLhWugQTIJdytpmko0/ySpR5JCewS6qB8AN3IQ8VQY5dCQ==
X-Received: by 2002:a17:902:ce92:b0:202:359:9f66 with SMTP id d9443c01a7336-2039e4fbbc8mr197529735ad.54.1724767645460;
        Tue, 27 Aug 2024 07:07:25 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb? ([2804:1b3:a7c3:4c2c:7d73:fa05:8bad:32cb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fd0e91sm84062115ad.309.2024.08.27.07.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 07:07:24 -0700 (PDT)
Message-ID: <f4400864-7bd2-4dc1-975b-52023ee597e5@linaro.org>
Date: Tue, 27 Aug 2024 11:07:20 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Eric Biggers <ebiggers@kernel.org>
References: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
 <397f9865-c4ad-44be-91ab-9764fe3aeb89@csgroup.eu>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <397f9865-c4ad-44be-91ab-9764fe3aeb89@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/08/24 05:46, Christophe Leroy wrote:
> 
> 
> Le 26/08/2024 à 20:10, Adhemerval Zanella a écrit :
>> Hook up the generic vDSO implementation to the aarch64 vDSO data page.
>> The _vdso_rng_data required data is placed within the _vdso_data vvar
>> page, by using a offset larger than the vdso_data
>> (__VDSO_RND_DATA_OFFSET).
>>
>> The vDSO function requires a ChaCha20 implementation that does not
>> write to the stack, and that can do an entire ChaCha20 permutation.
>> The one provided is based on the current chacha-neon-core.S and uses NEON
>> on the permute operation.
>>
>> Signed-off-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
>> ---
>>   arch/arm64/Kconfig                         |   1 +
>>   arch/arm64/include/asm/vdso/getrandom.h    |  50 +++++++
>>   arch/arm64/include/asm/vdso/vsyscall.h     |   9 ++
>>   arch/arm64/kernel/vdso/Makefile            |   7 +-
>>   arch/arm64/kernel/vdso/vdso.lds.S          |   4 +
>>   arch/arm64/kernel/vdso/vgetrandom-chacha.S | 153 +++++++++++++++++++++
>>   arch/arm64/kernel/vdso/vgetrandom.c        |  13 ++
>>   tools/testing/selftests/vDSO/Makefile      |   4 +-
>>   8 files changed, 238 insertions(+), 3 deletions(-)
>>   create mode 100644 arch/arm64/include/asm/vdso/getrandom.h
>>   create mode 100644 arch/arm64/kernel/vdso/vgetrandom-chacha.S
>>   create mode 100644 arch/arm64/kernel/vdso/vgetrandom.c
> 
> Were you able to use selftests ? I think you are missing the symbolic link to vdso directory (assuming you are using latest master branch from https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git)

It is missing indeed, last time I use a old brach that has a different Makefile
machinery and it I could it built more easily.

> 
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index b3fc891f1544..e3f4c5bf0661 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -237,6 +237,7 @@ config ARM64
>>       select HAVE_KPROBES
>>       select HAVE_KRETPROBES
>>       select HAVE_GENERIC_VDSO
>> +    select VDSO_GETRANDOM
> 
> You don't keep things in alphabetical here order on ARM64 ?

It seems to most part, but the file does have some outliers (HAVE_SOFTIRQ_ON_OWN_STACK
for instance).   I moved to the end of the list.

> 
>>       select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
>>       select IRQ_DOMAIN
>>       select IRQ_FORCED_THREADING
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
>> + * @buffer:    Destination buffer to fill with random bytes.
>> + * @len:    Size of @buffer in bytes.
>> + * @flags:    Zero or more GRND_* flags.
>> + * Returns:    The number of random bytes written to @buffer, or a negative value indicating an error.
>> + */
>> +static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
>> +{
>> +    register long int x8 asm ("x8") = __NR_getrandom;
>> +    register long int x0 asm ("x0") = (long int) buffer;
>> +    register long int x1 asm ("x1") = (long int) len;
>> +    register long int x2 asm ("x2") = (long int) flags;
>> +
>> +    asm ("svc 0" : "=r"(x0) : "r"(x8), "0"(x0), "r"(x1), "r"(x2));
>> +
>> +    return x0;
>> +}
>> +
>> +static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
>> +{
>> +    return &_vdso_rng_data;
>> +}
>> +
>> +/**
>> + * __arch_chacha20_blocks_nostack - Generate ChaCha20 stream without using the stack.
>> + * @dst_bytes:    Destination buffer to hold @nblocks * 64 bytes of output.
>> + * @key:    32-byte input key.
>> + * @counter:    8-byte counter, read on input and updated on return.
>> + * @nblocks:    Number of blocks to generate.
>> + *
>> + * Generates a given positive number of blocks of ChaCha20 output with nonce=0, and does not write
>> + * to any stack or memory outside of the parameters passed to it, in order to mitigate stack data
>> + * leaking into forked child processes.
>> + */
>> +extern void __arch_chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks);
> 
> For Jason: We all redefine this prototype, should we have it in a central place, or do you expect some architecture to provide some static inline for it ?
> 
>> +
>> +#endif /* !__ASSEMBLY__ */
>> +
>> +#endif /* __ASM_VDSO_GETRANDOM_H */
>> diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
>> index f94b1457c117..7ddb2bc3b57b 100644
>> --- a/arch/arm64/include/asm/vdso/vsyscall.h
>> +++ b/arch/arm64/include/asm/vdso/vsyscall.h
>> @@ -2,6 +2,8 @@
>>   #ifndef __ASM_VDSO_VSYSCALL_H
>>   #define __ASM_VDSO_VSYSCALL_H
>>   +#define __VDSO_RND_DATA_OFFSET  480
>> +
> 
> How is this offset calculated or defined ? What happens if the other structures grow ? Could you use some sizeof(something) instead of something from asm-offsets if you also need it in ASM ?

That is something I talked to Jason some time ago, since a similar strategy
to use a 'magic' offset is used on x86_64.  Ideally I think the vdso_rnd_data
should be moved to  a common static structure along with _vdso_data, so the
there is no need to come up with magic offset like this.  It seems that the
powerpc does follow this pattern, but other ports no.

However, since each architecture does some specific machinery with the vdso
datapages; it would require some more extensive refactoring on multiple
architectures to get this right.

> 
>>   #ifndef __ASSEMBLY__
>>     #include <linux/timekeeper_internal.h>
>> @@ -21,6 +23,13 @@ struct vdso_data *__arm64_get_k_vdso_data(void)
>>   }
>>   #define __arch_get_k_vdso_data __arm64_get_k_vdso_data
>>   +static __always_inline
>> +struct vdso_rng_data *__arm64_get_k_vdso_rnd_data(void)
>> +{
>> +    return (void *)__arm64_get_k_vdso_data() + __VDSO_RND_DATA_OFFSET;
>> +}
>> +#define __arch_get_k_vdso_rng_data __arm64_get_k_vdso_rnd_data
>> +
>>   static __always_inline
>>   void __arm64_update_vsyscall(struct vdso_data *vdata, struct timekeeper *tk)
>>   {
>> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
>> index d11da6461278..37dad3bb953a 100644
>> --- a/arch/arm64/kernel/vdso/Makefile
>> +++ b/arch/arm64/kernel/vdso/Makefile
>> @@ -9,7 +9,7 @@
>>   # Include the generic Makefile to check the built vdso.
>>   include $(srctree)/lib/vdso/Makefile
>>   -obj-vdso := vgettimeofday.o note.o sigreturn.o
>> +obj-vdso := vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-chacha.o
>>     # Build rules
>>   targets := $(obj-vdso) vdso.so vdso.so.dbg
>> @@ -40,8 +40,13 @@ CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
>>                   $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
>>                   $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
>>                   -Wmissing-prototypes -Wmissing-declarations
>> +CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
>> +                 $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
>> +                 $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
>> +                 -Wmissing-prototypes -Wmissing-declarations
>>     CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -fasynchronous-unwind-tables
>> +CFLAGS_vgetrandom.o = -O2 -mcmodel=tiny -fasynchronous-unwind-tables
>>     ifneq ($(c-gettimeofday-y),)
>>     CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
>> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
>> index 45354f2ddf70..f8dbcece20e2 100644
>> --- a/arch/arm64/kernel/vdso/vdso.lds.S
>> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
>> @@ -12,6 +12,8 @@
>>   #include <asm/page.h>
>>   #include <asm/vdso.h>
>>   #include <asm-generic/vmlinux.lds.h>
>> +#include <vdso/datapage.h>
>> +#include <asm/vdso/vsyscall.h>
>>     OUTPUT_FORMAT("elf64-littleaarch64", "elf64-bigaarch64", "elf64-littleaarch64")
>>   OUTPUT_ARCH(aarch64)
>> @@ -19,6 +21,7 @@ OUTPUT_ARCH(aarch64)
>>   SECTIONS
>>   {
>>       PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
>> +    PROVIDE(_vdso_rng_data = _vdso_data + __VDSO_RND_DATA_OFFSET);
>>   #ifdef CONFIG_TIME_NS
>>       PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
>>   #endif
>> @@ -102,6 +105,7 @@ VERSION
>>           __kernel_gettimeofday;
>>           __kernel_clock_gettime;
>>           __kernel_clock_getres;
>> +        __kernel_getrandom;
>>       local: *;
>>       };
>>   }
>> diff --git a/arch/arm64/kernel/vdso/vgetrandom-chacha.S b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> 
> [skipped ASM as I have not spoken ARM asm since I was at school in the 90's]
> 
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
> 
> For gettimeofday ARM64 uses c-gettimeofday-y in the Makefile instead.
> 
> You should do the same with c-getrandom-y

Ack.

> 
>> +
>> +ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len);
>> +
>> +ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)
>> +{
>> +    return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);
>> +}
>> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
>> index 10ffdda3f2fa..f07ea679a4cc 100644
>> --- a/tools/testing/selftests/vDSO/Makefile
>> +++ b/tools/testing/selftests/vDSO/Makefile
>> @@ -1,6 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   uname_M := $(shell uname -m 2>/dev/null || echo not)
>> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/)
> 
>>   SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
>>     TEST_GEN_PROGS := vdso_test_gettimeofday
>> @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>>   TEST_GEN_PROGS += vdso_standalone_test_x86
>>   endif
>>   TEST_GEN_PROGS += vdso_test_correctness
>> -ifeq ($(uname_M),x86_64)
>> +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))
> 
> Does that work for you when you cross-compile ? For powerpc when I cross compile I still get the x86_64 from uname_M here, which is unexpected.

Right, I haven't test cross-compilation on the selftests so I
am not sure.  I will check it.

> 
>>   TEST_GEN_PROGS += vdso_test_getrandom
>>   ifneq ($(SODIUM),)
>>   TEST_GEN_PROGS += vdso_test_chacha
> 
> Christophe

