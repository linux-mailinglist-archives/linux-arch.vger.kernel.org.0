Return-Path: <linux-arch+bounces-6846-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D0F9660F8
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 13:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA811F26094
	for <lists+linux-arch@lfdr.de>; Fri, 30 Aug 2024 11:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2CE192D86;
	Fri, 30 Aug 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUP3cNtv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7348516EB42;
	Fri, 30 Aug 2024 11:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018416; cv=none; b=fpU2y6EzcVuQVilS1ww0/BJ8B023hul1EoU3sO9dlkiQ5RwCNy4CmiR/Yx8wSdhKVESZ+wAUZoF8i2bWTqyBrpY6ufPcw9aTBtGdHuZPlHULb4nQlnkBj8UY2UjlAtDIPJDvWuXk8YTlBBX0mXNETx687f00WCFQVUudOzGJxxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018416; c=relaxed/simple;
	bh=2lUeWspGgAucZpchR/saBa93aR3n5RRxVgjybjC6n5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcPWN82eCsf0gQqgBTVJev08tqgfHNxfPZG2fKp+QC3YosgNJ4S35gAHhnde56nrxAXqWdnmefOgM9Cu6L8RSrFRiu9S/raa45f4p2b7nvnPHuCIAmJjkTR1NSLlPmWnDvqoaYJRmbGOdGh5PopOQOGi9Vp+Ey4i7ijpEbgDBPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUP3cNtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D67C4CEC2;
	Fri, 30 Aug 2024 11:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725018416;
	bh=2lUeWspGgAucZpchR/saBa93aR3n5RRxVgjybjC6n5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mUP3cNtv/Gr2QyViycy87GFpMi+z6031pfNdAPkrpo5zX/m9bFITD61MbY8SjklUd
	 HImkEJeTgWFiOry03z9Xk3gDRhcbnkZhWfWlYYjF2DOiRZvaKGiO59a1AAofkRotpE
	 uFpRjxTJBSsqQ+0yBBKY74EtMe+Sq19o7F4TaxsUP2pzo00Yqu76OVnHCZ8akuM+4O
	 EqByjOkXrUAIwE6NinFX0NZbnOJrqIYbfmdn+CE1AonkopVUA3G41y81QlOlOkE1LF
	 LFWPKWqbi5Fk5knFgBiy/bDkX1ayYiydvLstFSDEAHnifHrScMWL/EO6spKNgR1NOf
	 LEEfvfiSmlLDQ==
Date: Fri, 30 Aug 2024 12:46:45 +0100
From: Will Deacon <will@kernel.org>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, ardb@kernel.org
Subject: Re: [PATCH v2] aarch64: vdso: Wire up getrandom() vDSO implementation
Message-ID: <20240830114645.GA8219@willie-the-truck>
References: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829201728.2825-1-adhemerval.zanella@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 29, 2024 at 08:17:14PM +0000, Adhemerval Zanella wrote:
> Hook up the generic vDSO implementation to the aarch64 vDSO data page.
> The _vdso_rng_data required data is placed within the _vdso_data vvar
> page, by using a offset larger than the vdso_data.
> 
> The vDSO function requires a ChaCha20 implementation that does not
> write to the stack, and that can do an entire ChaCha20 permutation.
> The one provided is based on the current chacha-neon-core.S and uses NEON
> on the permute operation. The fallback for chips that do not support
> NEON issues the syscall.
> 
> This also passes the vdso_test_chacha test along with
> vdso_test_getrandom. The vdso_test_getrandom bench-single result on
> Neoverse-N1 shows:
> 
>    vdso: 25000000 times in 0.746506464 seconds
>    libc: 25000000 times in 8.849179444 seconds
> syscall: 25000000 times in 8.818726425 seconds
> 
> Changes from v1:
> - Fixed style issues and typos.
> - Added fallback for systems without NEON support.
> - Avoid use of non-volatile vector registers in neon chacha20.
> - Use c-getrandom-y for vgetrandom.c.
> - Fixed TIMENS vdso_rnd_data access.
> 
> Signed-off-by: Adhemerval Zanella <adhemerval.zanella@linaro.org>
> ---
>  arch/arm64/Kconfig                         |   1 +
>  arch/arm64/include/asm/vdso.h              |   6 +
>  arch/arm64/include/asm/vdso/getrandom.h    |  49 ++++++
>  arch/arm64/include/asm/vdso/vsyscall.h     |  10 ++
>  arch/arm64/kernel/vdso.c                   |   6 -
>  arch/arm64/kernel/vdso/Makefile            |  11 +-
>  arch/arm64/kernel/vdso/vdso                |   1 +
>  arch/arm64/kernel/vdso/vdso.lds.S          |   4 +
>  arch/arm64/kernel/vdso/vgetrandom-chacha.S | 168 +++++++++++++++++++++
>  arch/arm64/kernel/vdso/vgetrandom.c        |  15 ++
>  lib/vdso/getrandom.c                       |   1 +
>  tools/arch/arm64/vdso                      |   1 +
>  tools/include/linux/compiler.h             |   4 +
>  tools/testing/selftests/vDSO/Makefile      |   5 +-

Please can you split the tools/ changes into a separate patch?

>  14 files changed, 273 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm64/include/asm/vdso/getrandom.h
>  create mode 120000 arch/arm64/kernel/vdso/vdso
>  create mode 100644 arch/arm64/kernel/vdso/vgetrandom-chacha.S
>  create mode 100644 arch/arm64/kernel/vdso/vgetrandom.c
>  create mode 120000 tools/arch/arm64/vdso
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index a2f8ff354ca6..7f7424d1b3b8 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -262,6 +262,7 @@ config ARM64
>  	select TRACE_IRQFLAGS_NMI_SUPPORT
>  	select HAVE_SOFTIRQ_ON_OWN_STACK
>  	select USER_STACKTRACE_SUPPORT
> +	select VDSO_GETRANDOM
>  	help
>  	  ARM 64-bit (AArch64) Linux support.
>  
> diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
> index 4305995c8f82..18407b757c95 100644
> --- a/arch/arm64/include/asm/vdso.h
> +++ b/arch/arm64/include/asm/vdso.h
> @@ -16,6 +16,12 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +enum vvar_pages {
> +	VVAR_DATA_PAGE_OFFSET,
> +	VVAR_TIMENS_PAGE_OFFSET,
> +	VVAR_NR_PAGES,
> +};
> +
>  #include <generated/vdso-offsets.h>
>  
>  #define VDSO_SYMBOL(base, name)						   \
> diff --git a/arch/arm64/include/asm/vdso/getrandom.h b/arch/arm64/include/asm/vdso/getrandom.h
> new file mode 100644
> index 000000000000..fca66ba49d4c
> --- /dev/null
> +++ b/arch/arm64/include/asm/vdso/getrandom.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_VDSO_GETRANDOM_H
> +#define __ASM_VDSO_GETRANDOM_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <asm/vdso.h>
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
> +static __always_inline ssize_t getrandom_syscall(void *_buffer, size_t _len, unsigned int _flags)
> +{
> +	register void *buffer asm ("x0") = _buffer;
> +	register size_t len asm ("x1") = _len;
> +	register unsigned int flags asm ("x2") = _flags;
> +	register long ret asm ("x0");
> +	register long nr asm ("x8") = __NR_getrandom;
> +
> +	asm volatile(
> +	"       svc #0\n"
> +	: "=r" (ret)
> +	: "r" (buffer), "r" (len), "r" (flags), "r" (nr)
> +	: "memory");
> +
> +	return ret;
> +}
> +
> +static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
> +{
> +	/*
> +	 * If a task belongs to a time namespace then a namespace the real
> +	 * VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET.
> +	 */

This comment doesn't make sense.

> +	if (IS_ENABLED(CONFIG_TIME_NS) && _vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
> +		return (void*)&_vdso_rng_data + VVAR_TIMENS_PAGE_OFFSET * PAGE_SIZE;
> +	return &_vdso_rng_data;
> +}
> +
> +#endif /* !__ASSEMBLY__ */
> +
> +#endif /* __ASM_VDSO_GETRANDOM_H */
> diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/vdso/vsyscall.h
> index f94b1457c117..2a87f0e1b144 100644
> --- a/arch/arm64/include/asm/vdso/vsyscall.h
> +++ b/arch/arm64/include/asm/vdso/vsyscall.h
> @@ -2,8 +2,11 @@
>  #ifndef __ASM_VDSO_VSYSCALL_H
>  #define __ASM_VDSO_VSYSCALL_H
>  
> +#define __VDSO_RND_DATA_OFFSET  480

Why 480?

> +
>  #ifndef __ASSEMBLY__
>  
> +#include <asm/vdso.h>
>  #include <linux/timekeeper_internal.h>
>  #include <vdso/datapage.h>
>  
> @@ -21,6 +24,13 @@ struct vdso_data *__arm64_get_k_vdso_data(void)
>  }
>  #define __arch_get_k_vdso_data __arm64_get_k_vdso_data
>  
> +static __always_inline
> +struct vdso_rng_data *__arm64_get_k_vdso_rnd_data(void)
> +{
> +	return (void*)vdso_data + __VDSO_RND_DATA_OFFSET;
> +}
> +#define __arch_get_k_vdso_rng_data __arm64_get_k_vdso_rnd_data
> +
>  static __always_inline
>  void __arm64_update_vsyscall(struct vdso_data *vdata, struct timekeeper *tk)
>  {
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 89b6e7840002..706c9c3a7a50 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -34,12 +34,6 @@ enum vdso_abi {
>  	VDSO_ABI_AA32,
>  };
>  
> -enum vvar_pages {
> -	VVAR_DATA_PAGE_OFFSET,
> -	VVAR_TIMENS_PAGE_OFFSET,
> -	VVAR_NR_PAGES,
> -};
> -
>  struct vdso_abi_info {
>  	const char *name;
>  	const char *vdso_code_start;
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index d11da6461278..50246a38d6bd 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -9,7 +9,7 @@
>  # Include the generic Makefile to check the built vdso.
>  include $(srctree)/lib/vdso/Makefile
>  
> -obj-vdso := vgettimeofday.o note.o sigreturn.o
> +obj-vdso := vgettimeofday.o note.o sigreturn.o vgetrandom.o vgetrandom-chacha.o
>  
>  # Build rules
>  targets := $(obj-vdso) vdso.so vdso.so.dbg
> @@ -40,13 +40,22 @@ CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
>  				$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
>  				$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
>  				-Wmissing-prototypes -Wmissing-declarations
> +CFLAGS_REMOVE_vgetrandom.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
> +			     $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
> +			     $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
> +			     -Wmissing-prototypes -Wmissing-declarations
>  
>  CFLAGS_vgettimeofday.o = -O2 -mcmodel=tiny -fasynchronous-unwind-tables
> +CFLAGS_vgetrandom.o = -O2 -mcmodel=tiny -fasynchronous-unwind-tables

You're using identical CFLAGS_ and CFLAGS_REMOVE_ definitions for
vgettimeofdat.o and vgetrandom.o. Please refactor this so that they use
common definitions.

> diff --git a/arch/arm64/kernel/vdso/vdso b/arch/arm64/kernel/vdso/vdso
> new file mode 120000
> index 000000000000..233c7a26f6e5
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso/vdso
> @@ -0,0 +1 @@
> +../../../arch/arm64/kernel/vdso
> \ No newline at end of file
> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
> index 45354f2ddf70..f204a9ddc833 100644
> --- a/arch/arm64/kernel/vdso/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> @@ -11,7 +11,9 @@
>  #include <linux/const.h>
>  #include <asm/page.h>
>  #include <asm/vdso.h>
> +#include <asm/vdso/vsyscall.h>
>  #include <asm-generic/vmlinux.lds.h>
> +#include <vdso/datapage.h>
>  
>  OUTPUT_FORMAT("elf64-littleaarch64", "elf64-bigaarch64", "elf64-littleaarch64")
>  OUTPUT_ARCH(aarch64)
> @@ -19,6 +21,7 @@ OUTPUT_ARCH(aarch64)
>  SECTIONS
>  {
>  	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
> +	PROVIDE(_vdso_rng_data = _vdso_data + __VDSO_RND_DATA_OFFSET);
>  #ifdef CONFIG_TIME_NS
>  	PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
>  #endif
> @@ -102,6 +105,7 @@ VERSION
>  		__kernel_gettimeofday;
>  		__kernel_clock_gettime;
>  		__kernel_clock_getres;
> +		__kernel_getrandom;
>  	local: *;
>  	};
>  }
> diff --git a/arch/arm64/kernel/vdso/vgetrandom-chacha.S b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> new file mode 100644
> index 000000000000..9ebf12a09c65
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso/vgetrandom-chacha.S
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/linkage.h>
> +#include <asm/cache.h>
> +#include <asm/assembler.h>
> +
> +	.text
> +
> +#define state0		v0
> +#define state1		v1
> +#define state2		v2
> +#define state3		v3
> +#define copy0		v4
> +#define copy1		v5
> +#define copy2		v6
> +#define copy3		v7
> +#define copy3_d		d7
> +#define one_d		d16
> +#define one_q		q16
> +#define tmp		v17
> +#define rot8		v18
> +
> +/*
> + * ARM64 ChaCha20 implementation meant for vDSO.  Produces a given positive
> + * number of blocks of output with nonce 0, taking an input key and 8-bytes
> + * counter.  Importantly does not spill to the stack.
> + *
> + * void __arch_chacha20_blocks_nostack(uint8_t *dst_bytes,
> + *				       const uint8_t *key,
> + * 				       uint32_t *counter,
> + *				       size_t nblocks)
> + *
> + * 	x0: output bytes
> + *	x1: 32-byte key input
> + *	x2: 8-byte counter input/output
> + *	x3: number of 64-byte block to write to output
> + */
> +SYM_FUNC_START(__arch_chacha20_blocks_nostack)

Is there any way we can reuse the existing code in
crypto/chacha-neon-core.S for this? It looks to my untrained eye like
this is an arbitrarily different implementation to what we already have.

> +	/* copy0 = "expand 32-byte k" */
> +	adr_l		x8, CTES
> +	ld1		{copy0.4s}, [x8]
> +	/* copy1,copy2 = key */
> +	ld1		{ copy1.4s, copy2.4s }, [x1]
> +	/* copy3 = counter || zero nonce  */
> +	ldr		copy3_d, [x2]
> +
> +	adr_l		x8, ONE
> +	ldr		one_q, [x8]
> +
> +	adr_l		x10, ROT8
> +	ld1		{rot8.4s}, [x10]
> +.Lblock:
> +	/* copy state to auxiliary vectors for the final add after the permute.  */
> +	mov		state0.16b, copy0.16b
> +	mov		state1.16b, copy1.16b
> +	mov		state2.16b, copy2.16b
> +	mov		state3.16b, copy3.16b
> +
> +	mov		w4, 20
> +.Lpermute:
> +	/*
> +	 * Permute one 64-byte block where the state matrix is stored in the four NEON
> +	 * registers state0-state3.  It performs matrix operations on four words in parallel,
> +	 * but requires shuffling to rearrange the words after each round.
> +	 */
> +
> +.Ldoubleround:
> +	/* state0 += state1, state3 = rotl32(state3 ^ state0, 16) */
> +	add		state0.4s, state0.4s, state1.4s
> +	eor		state3.16b, state3.16b, state0.16b
> +	rev32		state3.8h, state3.8h
> +
> +	/* state2 += state3, state1 = rotl32(state1 ^ state2, 12) */
> +	add		state2.4s, state2.4s, state3.4s
> +	eor		tmp.16b, state1.16b, state2.16b
> +	shl		state1.4s, tmp.4s, #12
> +	sri		state1.4s, tmp.4s, #20
> +
> +	/* state0 += state1, state3 = rotl32(state3 ^ state0, 8) */
> +	add		state0.4s, state0.4s, state1.4s
> +	eor		state3.16b, state3.16b, state0.16b
> +	tbl		state3.16b, {state3.16b}, rot8.16b
> +
> +	/* state2 += state3, state1 = rotl32(state1 ^ state2, 7) */
> +	add		state2.4s, state2.4s, state3.4s
> +	eor		tmp.16b, state1.16b, state2.16b
> +	shl		state1.4s, tmp.4s, #7
> +	sri		state1.4s, tmp.4s, #25
> +
> +	/* state1[0,1,2,3] = state1[1,2,3,0] */
> +	ext		state1.16b, state1.16b, state1.16b, #4
> +	/* state2[0,1,2,3] = state2[2,3,0,1] */
> +	ext		state2.16b, state2.16b, state2.16b, #8
> +	/* state3[0,1,2,3] = state3[1,2,3,0] */
> +	ext		state3.16b, state3.16b, state3.16b, #12
> +
> +	/* state0 += state1, state3 = rotl32(state3 ^ state0, 16) */
> +	add		state0.4s, state0.4s, state1.4s
> +	eor		state3.16b, state3.16b, state0.16b
> +	rev32		state3.8h, state3.8h
> +
> +	/* state2 += state3, state1 = rotl32(state1 ^ state2, 12) */
> +	add		state2.4s, state2.4s, state3.4s
> +	eor		tmp.16b, state1.16b, state2.16b
> +	shl		state1.4s, tmp.4s, #12
> +	sri		state1.4s, tmp.4s, #20
> +
> +	/* state0 += state1, state3 = rotl32(state3 ^ state0, 8) */
> +	add		state0.4s, state0.4s, state1.4s
> +	eor		state3.16b, state3.16b, state0.16b
> +	tbl		state3.16b, {state3.16b}, rot8.16b
> +
> +	/* state2 += state3, state1 = rotl32(state1 ^ state2, 7) */
> +	add		state2.4s, state2.4s, state3.4s
> +	eor		tmp.16b, state1.16b, state2.16b
> +	shl		state1.4s, tmp.4s, #7
> +	sri		state1.4s, tmp.4s, #25
> +
> +	/* state1[0,1,2,3] = state1[3,0,1,2] */
> +	ext		state1.16b, state1.16b, state1.16b, #12
> +	/* state2[0,1,2,3] = state2[2,3,0,1] */
> +	ext		state2.16b, state2.16b, state2.16b, #8
> +	/* state3[0,1,2,3] = state3[1,2,3,0] */
> +	ext		state3.16b, state3.16b, state3.16b, #4
> +
> +	subs		w4, w4, #2
> +	b.ne		.Ldoubleround
> +
> +	/* output0 = state0 + state0 */
> +	add		state0.4s, state0.4s, copy0.4s
> +	/* output1 = state1 + state1 */
> +	add		state1.4s, state1.4s, copy1.4s
> +	/* output2 = state2 + state2 */
> +	add		state2.4s, state2.4s, copy2.4s
> +	/* output2 = state3 + state3 */
> +	add		state3.4s, state3.4s, copy3.4s
> +	st1		{ state0.4s - state3.4s }, [x0]
> +
> +	/* ++copy3.counter */
> +	add		copy3_d, copy3_d, one_d
> +
> +	/* output += 64, --nblocks */
> +	add		x0, x0, 64
> +	subs		x3, x3, #1
> +	b.ne		.Lblock
> +
> +	/* counter = copy3.counter */
> +	str		copy3_d, [x2]
> +
> +	/* Zero out the potentially sensitive regs, in case nothing uses these again. */
> +	eor		state0.16b, state0.16b, state0.16b
> +	eor		state1.16b, state1.16b, state1.16b
> +	eor		state2.16b, state2.16b, state2.16b
> +	eor		state3.16b, state3.16b, state3.16b
> +	eor		copy1.16b, copy1.16b, copy1.16b
> +	eor		copy2.16b, copy2.16b, copy2.16b
> +	ret
> +SYM_FUNC_END(__arch_chacha20_blocks_nostack)
> +
> +        .section        ".rodata", "a", %progbits
> +        .align          L1_CACHE_SHIFT
> +
> +CTES:	.word		1634760805, 857760878, 	2036477234, 1797285236
> +ONE:    .xword		1, 0
> +ROT8:	.word		0x02010003, 0x06050407, 0x0a09080b, 0x0e0d0c0f
> +
> +emit_aarch64_feature_1_and
> diff --git a/arch/arm64/kernel/vdso/vgetrandom.c b/arch/arm64/kernel/vdso/vgetrandom.c
> new file mode 100644
> index 000000000000..0833d25f3121
> --- /dev/null
> +++ b/arch/arm64/kernel/vdso/vgetrandom.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +typeof(__cvdso_getrandom) __kernel_getrandom;
> +
> +ssize_t __kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)
> +{
> +	asm goto (
> +	ALTERNATIVE("b %[fallback]", "nop", RM64_HAS_FPSIMD) : : : : fallback);

"RM64_HAS_FPSIMD". Are you sure you've tested this?

> +	return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);
> +
> +fallback:
> +	if (unlikely(opaque_len == ~0UL && !buffer && !len && !flags))
> +		return -ENOSYS;
> +	return getrandom_syscall(buffer, len, flags);
> +}
> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> index 938ca539aaa6..7c9711248d9b 100644
> --- a/lib/vdso/getrandom.c
> +++ b/lib/vdso/getrandom.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/array_size.h>
>  #include <linux/minmax.h>
> +#include <linux/mm.h>
>  #include <vdso/datapage.h>
>  #include <vdso/getrandom.h>
>  #include <vdso/unaligned.h>

Looks like this should be a separate change?

Will

