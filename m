Return-Path: <linux-arch+bounces-6651-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30CA9604CA
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 10:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABAB92814AC
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 08:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEDB199392;
	Tue, 27 Aug 2024 08:46:27 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B846719755A;
	Tue, 27 Aug 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748387; cv=none; b=hp8iJJQWoHrWWHVtWhWgWOaTanfQ4P2vbq5KffKVDJwF/wkcYUpdvk75EEQcGAU/nvHLCz/DwTfxFWpTLLcyaVjY1NtdHr++U7omJnTMjuyf+YbGlhXb2qwCRESdWfxxb3ZlyZGRS8nrbLF9CmPptrpzmibLsNiGBe1FWCBobws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748387; c=relaxed/simple;
	bh=TPLT3vvRAZxT23wj6dkwAi7NSu5Fi6ZCokm6CugQ2I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iqpN00Sm8IqQHtXb7Wk7dy2S9e5IA/GRI8frp2hz4LeJk6BwFTV9zFubJ0LvaMx2+fyFogCT6PiOTVDZ1Js7jMPIy+Q4OJo6v8M+LlyqKPovLDxNrNsPUArhh+KSRJtOVefm1lPqKsJliCuQ+n6XmS2s/fHIHUdMPDFVTKGk6VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WtLk64rD9z9sRr;
	Tue, 27 Aug 2024 10:46:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i5nqJfxeDQXd; Tue, 27 Aug 2024 10:46:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WtLk63Vlrz9sPd;
	Tue, 27 Aug 2024 10:46:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 636F38B77B;
	Tue, 27 Aug 2024 10:46:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id mPefEagid0UV; Tue, 27 Aug 2024 10:46:22 +0200 (CEST)
Received: from [192.168.233.149] (PO19727.IDSI0.si.c-s.fr [192.168.233.149])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C0E308B763;
	Tue, 27 Aug 2024 10:46:21 +0200 (CEST)
Message-ID: <397f9865-c4ad-44be-91ab-9764fe3aeb89@csgroup.eu>
Date: Tue, 27 Aug 2024 10:46:21 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aarch64: vdso: Wire up getrandom() vDSO implementation
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Eric Biggers <ebiggers@kernel.org>
References: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20240826181059.111536-1-adhemerval.zanella@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/08/2024 à 20:10, Adhemerval Zanella a écrit :
> Hook up the generic vDSO implementation to the aarch64 vDSO data page.
> The _vdso_rng_data required data is placed within the _vdso_data vvar
> page, by using a offset larger than the vdso_data
> (__VDSO_RND_DATA_OFFSET).
> 
> The vDSO function requires a ChaCha20 implementation that does not
> write to the stack, and that can do an entire ChaCha20 permutation.
> The one provided is based on the current chacha-neon-core.S and uses NEON
> on the permute operation.
> 
> Signed-off-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
> ---
>   arch/arm64/Kconfig                         |   1 +
>   arch/arm64/include/asm/vdso/getrandom.h    |  50 +++++++
>   arch/arm64/include/asm/vdso/vsyscall.h     |   9 ++
>   arch/arm64/kernel/vdso/Makefile            |   7 +-
>   arch/arm64/kernel/vdso/vdso.lds.S          |   4 +
>   arch/arm64/kernel/vdso/vgetrandom-chacha.S | 153 +++++++++++++++++++++
>   arch/arm64/kernel/vdso/vgetrandom.c        |  13 ++
>   tools/testing/selftests/vDSO/Makefile      |   4 +-
>   8 files changed, 238 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm64/include/asm/vdso/getrandom.h
>   create mode 100644 arch/arm64/kernel/vdso/vgetrandom-chacha.S
>   create mode 100644 arch/arm64/kernel/vdso/vgetrandom.c

Were you able to use selftests ? I think you are missing the symbolic 
link to vdso directory (assuming you are using latest master branch from 
https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git)

> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b3fc891f1544..e3f4c5bf0661 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -237,6 +237,7 @@ config ARM64
>   	select HAVE_KPROBES
>   	select HAVE_KRETPROBES
>   	select HAVE_GENERIC_VDSO
> +	select VDSO_GETRANDOM

You don't keep things in alphabetical here order on ARM64 ?

>   	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
>   	select IRQ_DOMAIN
>   	select IRQ_FORCED_THREADING
> diff --git a/arch/arm64/include/asm/vdso/getrandom.h b/arch/arm64/include/asm/vdso/getrandom.h
> new file mode 100644
> index 000000000000..6e2b136813ca
> --- /dev/null
> +++ b/arch/arm64/include/asm/vdso/getrandom.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_VDSO_GETRANDOM_H
> +#define __ASM_VDSO_GETRANDOM_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <asm/unistd.h>
> +#include <vdso/datapage.h>
> +
> +/**
> + * getrandom_syscall - Invoke the getrandom() syscall.
> + * @buffer:	Destination buffer to fill with random bytes.
> + * @len:	Size of @buffer in bytes.
> + * @flags:	Zero or more GRND_* flags.
> + * Returns:	The number of random bytes written to @buffer, or a negative value indicating an error.
> + */
> +static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
> +{
> +	register long int x8 asm ("x8") = __NR_getrandom;
> +	register long int x0 asm ("x0") = (long int) buffer;
> +	register long int x1 asm ("x1") = (long int) len;
> +	register long int x2 asm ("x2") = (long int) flags;
> +
> +	asm ("svc 0" : "=r"(x0) : "r"(x8), "0"(x0), "r"(x1), "r"(x2));
> +
> +	return x0;
> +}
> +
> +static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
> +{
> +	return &_vdso_rng_data;
> +}
> +
> +/**
> + * __arch_chacha20_blocks_nostack - Generate ChaCha20 stream without using the stack.
> + * @dst_bytes:	Destination buffer to hold @nblocks * 64 bytes of output.
> + * @key:	32-byte input key.
> + * @counter:	8-byte counter, read on input and updated on return.
> + * @nblocks:	Number of blocks to generate.
> + *
> + * Generates a given positive number of blocks of ChaCha20 output with nonce=0, and does not write
> + * to any stack or memory outside of the parameters passed to it, in order to mitigate stack data
> + * leaking into forked child processes.
> + */
> +extern void __arch_chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks);

For Jason: We all redefine this prototype, should we have it in a 
central place, or do you expect some architecture to provide some static 
inline for it ?

> +
> +#endif /* !__ASSEMBLY__ */
> +
> +#endif /* __ASM_VDSO_GETRANDOM_H */
> diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
> index f94b1457c117..7ddb2bc3b57b 100644
> --- a/arch/arm64/include/asm/vdso/vsyscall.h
> +++ b/arch/arm64/include/asm/vdso/vsyscall.h
> @@ -2,6 +2,8 @@
>   #ifndef __ASM_VDSO_VSYSCALL_H
>   #define __ASM_VDSO_VSYSCALL_H
>   
> +#define __VDSO_RND_DATA_OFFSET  480
> +

How is this offset calculated or defined ? What happens if the other 
structures grow ? Could you use some sizeof(something) instead of 
something from asm-offsets if you also need it in ASM ?

>   #ifndef __ASSEMBLY__
>   
>   #include <linux/timekeeper_internal.h>
> @@ -21,6 +23,13 @@ struct vdso_data *__arm64_get_k_vdso_data(void)
>   }
>   #define __arch_get_k_vdso_data __arm64_get_k_vdso_data
>   
> +static __always_inline
> +struct vdso_rng_data *__arm64_get_k_vdso_rnd_data(void)
> +{
> +	return (void *)__arm64_get_k_vdso_data() + __VDSO_RND_DATA_OFFSET;
> +}
> +#define __arch_get_k_vdso_rng_data __arm64_get_k_vdso_rnd_data
> +
>   static __always_inline
>   void __arm64_update_vsyscall(struct vdso_data *vdata, struct timekeeper *tk)
>   {
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index d11da6461278..37dad3bb953a 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -9,7 +9,7 @@
>   # Include the generic Makefile to check the built vdso.
>   include $(srctree)/lib/vdso/Makefile
>   
> -obj-vdso := vgettimeofday.o note.o sigreturn.o
> +obj-vdso := vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-chacha.o
>   
>   # Build rules
>   targets := $(obj-vdso) vdso.so vdso.so.dbg
> @@ -40,8 +40,13 @@ CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
>   				$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
>   				$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
>   				-Wmissing-prototypes -Wmissing-declarations
> +CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
> +			     $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
> +			     $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
> +			     -Wmissing-prototypes -Wmissing-declarations
>   
>   CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -fasynchronous-unwind-tables
> +CFLAGS_vgetrandom.o = -O2 -mcmodel=tiny -fasynchronous-unwind-tables
>   
>   ifneq ($(c-gettimeofday-y),)
>     CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> index 45354f2ddf70..f8dbcece20e2 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> @@ -12,6 +12,8 @@
>   #include <asm/page.h>
>   #include <asm/vdso.h>
>   #include <asm-generic/vmlinux.lds.h>
> +#include <vdso/datapage.h>
> +#include <asm/vdso/vsyscall.h>
>   
>   OUTPUT_FORMAT("elf64-littleaarch64", "elf64-bigaarch64", "elf64-littleaarch64")
>   OUTPUT_ARCH(aarch64)
> @@ -19,6 +21,7 @@ OUTPUT_ARCH(aarch64)
>   SECTIONS
>   {
>   	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
> +	PROVIDE(_vdso_rng_data = _vdso_data + __VDSO_RND_DATA_OFFSET);
>   #ifdef CONFIG_TIME_NS
>   	PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
>   #endif
> @@ -102,6 +105,7 @@ VERSION
>   		__kernel_gettimeofday;
>   		__kernel_clock_gettime;
>   		__kernel_clock_getres;
> +		__kernel_getrandom;
>   	local: *;
>   	};
>   }
> diff --git a/arch/arm64/kernel/vdso/vgetrandom-chacha.S b/arch/arm64/kernel/vdso/vgetrandom-chacha.S

[skipped ASM as I have not spoken ARM asm since I was at school in the 90's]

> diff --git a/arch/arm64/kernel/vdso/vgetrandom.c b/arch/arm64/kernel/vdso/vgetrandom.c
> new file mode 100644
> index 000000000000..b6d6f4db3a98
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso/vgetrandom.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +
> +#include "../../../../lib/vdso/getrandom.c"

For gettimeofday ARM64 uses c-gettimeofday-y in the Makefile instead.

You should do the same with c-getrandom-y

> +
> +ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len);
> +
> +ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)
> +{
> +	return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);
> +}
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index 10ffdda3f2fa..f07ea679a4cc 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   uname_M := $(shell uname -m 2>/dev/null || echo not)
> -ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/ -e s/aarch64.*/arm64/)

>   SODIUM := $(shell pkg-config --libs libsodium 2>/dev/null)
>   
>   TEST_GEN_PROGS := vdso_test_gettimeofday
> @@ -11,7 +11,7 @@ ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
>   TEST_GEN_PROGS += vdso_standalone_test_x86
>   endif
>   TEST_GEN_PROGS += vdso_test_correctness
> -ifeq ($(uname_M),x86_64)
> +ifeq ($(uname_M), $(filter x86_64 aarch64, $(uname_M)))

Does that work for you when you cross-compile ? For powerpc when I cross 
compile I still get the x86_64 from uname_M here, which is unexpected.

>   TEST_GEN_PROGS += vdso_test_getrandom
>   ifneq ($(SODIUM),)
>   TEST_GEN_PROGS += vdso_test_chacha

Christophe

