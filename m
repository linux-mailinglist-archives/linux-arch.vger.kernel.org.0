Return-Path: <linux-arch+bounces-4569-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E678D24A6
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 21:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428381C26B88
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 19:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBB27317C;
	Tue, 28 May 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZayzUQF/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0875024E;
	Tue, 28 May 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716924673; cv=none; b=t7qFkjh0kGr3YrrPgi0/obv43sA3FRBlKv3O+9g/rQBrCydVY0RJhHmI2pcxu7evrdeZ825hN3q1gDZMDoukfwdIVl0h79jMgyy2gausjz81bPoIe93OZfxvUcDY8TggRcAWzuJZoO8/16ZVbGtV0IUcWDFNz56Z1/tCKxyH6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716924673; c=relaxed/simple;
	bh=ZGRsY2ZQZErkGb3Ve4FDnyIZLkQj3AbizzUfJX7D1JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gig5GqedvCzONmHV6QqQp/UPHfOGDRgBL/ehq9sTlHCBY1aalVeuLdgC4lQoUcSVnTJCBkAmoDw8ruwwHK2l0evsO24V+Nw6jWX/J88QF+CK7x1lZat38M91mvSlGl3zyjE3j6auQAkhfY4kn37qNd5utdd04Xwd4+cwT6GyjkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZayzUQF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057A7C3277B;
	Tue, 28 May 2024 19:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716924673;
	bh=ZGRsY2ZQZErkGb3Ve4FDnyIZLkQj3AbizzUfJX7D1JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZayzUQF/CRwyHEDjHYOegUqd6PFEA3IZd5BZH3OyeQhARI7ku7s8PLJbxIz2x/DFv
	 lQu9iInAWM7uPnIH+KM5mWrQYL37cocZgHQJ5WZDp9fyjWE6y/ca/t/JYB733zosP8
	 mT8ILP083xKJBmeQtllIgtwIiFaCHUAc7DvK2uptb0HfYrG7N3SJy+kttBGHYRLfYi
	 44iNjWoOwcAtxyFKW+iZa3LW8JGIqLxOAFE0p9grtDvqdjj2eIhR1fAvDnwHEepZOy
	 P057DWgxD0WH4PjcKHTf11k/e2jTSFCO8ZRYFazwFlgBkl3lQw0s51mTYc+DkrRs2t
	 YxQgeWrlEYBpQ==
Date: Tue, 28 May 2024 12:31:10 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/7] riscv: Implement cmpxchg8/16() using Zabha
Message-ID: <20240528193110.GA2196855@thelio-3990X>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-3-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528151052.313031-3-alexghiti@rivosinc.com>

Hi Alexandre,

On Tue, May 28, 2024 at 05:10:47PM +0200, Alexandre Ghiti wrote:
> This adds runtime support for Zabha in cmpxchg8/16 operations.
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/Kconfig               | 16 ++++++++++++++++
>  arch/riscv/Makefile              | 10 ++++++++++
>  arch/riscv/include/asm/cmpxchg.h | 26 ++++++++++++++++++++++++--
>  3 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b443def70139..05597719bb1c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -579,6 +579,22 @@ config RISCV_ISA_V_PREEMPTIVE
>  	  preemption. Enabling this config will result in higher memory
>  	  consumption due to the allocation of per-task's kernel Vector context.
>  
> +config TOOLCHAIN_HAS_ZABHA
> +	bool
> +	default y
> +	depends on !64BIT || $(cc-option,-mabi=lp64 -march=rv64ima_zabha)
> +	depends on !32BIT || $(cc-option,-mabi=ilp32 -march=rv32ima_zabha)

This test does not take into account the need for
'-menable-experimental-extensions' and '1p0' in the '-march=' value with
clang 19, so it can never be enabled even if it is available.

I am not really sure how to succinctly account for this though, other
than duplicating and modifying the cc-option checks with a dependency on
either CC_IS_GCC or CC_IS_CLANG. Another option is taking the same
approach as the _SUPPORTS_DYNAMIC_FTRACE symbols and introduce
CLANG_HAS_ZABHA and GCC_HAS_ZABHA? That might not make it too ugly.

I think the ZACAS patch has a similar issue, it just isn't noticeable
with clang 19 but it should be with clang 17 and 18.

> +	depends on AS_HAS_OPTION_ARCH
> +
> +config RISCV_ISA_ZABHA
> +	bool "Zabha extension support for atomic byte/half-word operations"
> +	depends on TOOLCHAIN_HAS_ZABHA
> +	default y
> +	help
> +	  Adds support to use atomic byte/half-word operations in the kernel.
> +
> +	  If you don't know what to do here, say Y.
> +
>  config TOOLCHAIN_HAS_ZACAS
>  	bool
>  	default y
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index d5b60b87998c..f58ac921dece 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -89,6 +89,16 @@ else
>  riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
>  endif
>  
> +# Check if the toolchain supports Zabha
> +ifdef CONFIG_AS_IS_LLVM
> +# Support for experimental Zabha was merged in LLVM 19.
> +KBUILD_CFLAGS += -menable-experimental-extensions
> +KBUILD_AFLAGS += -menable-experimental-extensions
> +riscv-march-y := $(riscv-march-y)_zabha1p0

This block should have some dependency on CONFIG_TOOLCHAIN_HAS_ZABHA as
well right? Otherwise, the build breaks with LLVM toolchains that do not
support zabha, like LLVM 18.1.x:

  clang: error: invalid arch name 'rv64imac_zihintpause_zacas1p0_zabha1p0', unsupported version number 1.0 for extension 'zabha'

I think the zacas patch has the same bug.

I think that it would be good to consolidate the adding of
'-menable-experimental-extensions' to the compiler and assembler flags
to perhaps having a hidden symbol like CONFIG_EXPERIMENTAL_EXTENSIONS
that is selected by any extension that is experimental for the
particular toolchain version.

config EXPERIMENTAL_EXTENSIONS
    bool

config TOOLCHAIN_HAS_ZABHA
    def_bool y
    select EXPERIMENTAL_EXETNSIONS if CC_IS_CLANG
    ...

config TOOLCHAIN_HAS_ZACAS
    def_bool_y
    # ZACAS was experimental until Clang 19: https://github.com/llvm/llvm-project/commit/95aab69c109adf29e183090c25dc95c773215746
    select EXPERIMENTAL_EXETNSIONS if CC_IS_CLANG && CLANG_VERSION < 190000
    ...

Then in the Makefile:

ifdef CONFIG_EXPERIMENTAL_EXTENSIONS
KBUILD_AFLAGS += -menable-experimental-extensions
KBUILD_CFLAGS += -menable-experimental-extensions
endif

> +else
> +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) := $(riscv-march-y)_zabha
> +endif
> +
>  # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
>  # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
>  KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> index 1c50b4821ac8..65de9771078e 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -103,8 +103,14 @@
>   * indicated by comparing RETURN with OLD.
>   */
>  
> -#define __arch_cmpxchg_masked(sc_sfx, prepend, append, r, p, o, n)	\
> +#define __arch_cmpxchg_masked(sc_sfx, cas_sfx, prepend, append, r, p, o, n)	\
>  ({									\
> +	__label__ zabha, end;						\
> +									\
> +	asm goto(ALTERNATIVE("nop", "j %[zabha]", 0,			\
> +			     RISCV_ISA_EXT_ZABHA, 1)			\
> +			: : : : zabha);					\
> +									\
>  	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
>  	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
>  	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
> @@ -131,6 +137,17 @@
>  		: "memory");						\
>  									\
>  	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
> +	goto end;							\
> +									\
> +zabha:									\
> +	__asm__ __volatile__ (						\
> +		prepend							\
> +		"	amocas" cas_sfx " %0, %z2, %1\n"		\

This should probably have some dependency on CONFIG_RISCV_ISA_ZABHA? I get the
following with GCC 13.2.0:

  include/linux/atomic/atomic-arch-fallback.h: Assembler messages:
  include/linux/atomic/atomic-arch-fallback.h:2108: Error: unrecognized opcode `amocas.w a4,a3,0(s1)'

> +		append							\
> +		: "+&r" (r), "+A" (*(p))				\
> +		: "rJ" (n)						\
> +		: "memory");						\
> +end:									\

I get a lot of warnings from this statement and the one added by the
previous patch for zacas, which is a C23 extension:

  include/linux/atomic/atomic-arch-fallback.h:4234:9: warning: label at end of compound statement is a C23 extension [-Wc23-extensions]
  include/linux/atomic/atomic-arch-fallback.h:89:29: note: expanded from macro 'raw_cmpxchg_relaxed'
     89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
        |                             ^
  arch/riscv/include/asm/cmpxchg.h:219:2: note: expanded from macro 'arch_cmpxchg_relaxed'
    219 |         _arch_cmpxchg((ptr), (o), (n), "", "", "")
        |         ^
  arch/riscv/include/asm/cmpxchg.h:200:3: note: expanded from macro '_arch_cmpxchg'
    200 |                 __arch_cmpxchg_masked(sc_sfx, ".h" sc_sfx,              \
        |                 ^
  arch/riscv/include/asm/cmpxchg.h:150:14: note: expanded from macro '__arch_cmpxchg_masked'
    150 | end:                                                                    \
        |                                                                         ^

This resolves it:

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index ba3ffc2fcdd0..57aa4a554278 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -147,7 +147,7 @@ zabha:									\
 		: "+&r" (r), "+A" (*(p))				\
 		: "rJ" (n)						\
 		: "memory");						\
-end:									\
+end:;									\
 })
 
 #define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
@@ -180,7 +180,7 @@ zacas:									\
 		: "+&r" (r), "+A" (*(p))				\
 		: "rJ" (n)						\
 		: "memory");						\
-end:									\
+end:;									\
 })
 
 #define _arch_cmpxchg(ptr, old, new, sc_sfx, prepend, append)		\

>  })
>  
>  #define __arch_cmpxchg(lr_sfx, sc_cas_sfx, prepend, append, r, p, co, o, n)	\
> @@ -175,8 +192,13 @@ end:									\
>  									\
>  	switch (sizeof(*__ptr)) {					\
>  	case 1:								\
> +		__arch_cmpxchg_masked(sc_sfx, ".b" sc_sfx,		\
> +					prepend, append,		\
> +					__ret, __ptr, __old, __new);    \
> +		break;							\
>  	case 2:								\
> -		__arch_cmpxchg_masked(sc_sfx, prepend, append,		\
> +		__arch_cmpxchg_masked(sc_sfx, ".h" sc_sfx,		\
> +					prepend, append,		\
>  					__ret, __ptr, __old, __new);	\
>  		break;							\
>  	case 4:								\
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

