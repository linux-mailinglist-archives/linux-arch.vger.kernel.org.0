Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF2B3A191E
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 17:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhFIPUr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 11:20:47 -0400
Received: from foss.arm.com ([217.140.110.172]:34286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239442AbhFIPUK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jun 2021 11:20:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C4DBD6E;
        Wed,  9 Jun 2021 08:18:15 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F01B63F73D;
        Wed,  9 Jun 2021 08:18:13 -0700 (PDT)
Date:   Wed, 9 Jun 2021 16:17:13 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v2 2/3] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <20210609151713.GL4187@arm.com>
References: <20210604112450.13344-1-broonie@kernel.org>
 <20210604112450.13344-3-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604112450.13344-3-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 12:24:49PM +0100, Mark Brown wrote:
> Currently for dynamically linked ELF executables we only enable BTI for
> the interpreter, expecting the interpreter to do this for the main
> executable. This is a bit inconsistent since we do map main executable and
> is causing issues with systemd's MemoryDenyWriteExecute feature which is
> implemented using a seccomp filter which prevents setting PROT_EXEC on
> already mapped memory and lacks the context to be able to detect that
> memory is already mapped with PROT_EXEC.
> 
> Resolve this by checking the BTI property for the main executable and
> enabling BTI if it is present when doing the initial mapping. This does
> mean that we may get more code with BTI enabled if running on a system
> without BTI support in the dynamic linker, this is expected to be a safe
> configuration and testing seems to confirm that. It also reduces the
> flexibility userspace has to disable BTI but it is expected that for cases
> where there are problems which require BTI to be disabled it is more likely
> that it will need to be disabled on a system level.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/include/asm/elf.h | 14 ++++++++++----
>  arch/arm64/kernel/process.c  | 18 ++++++------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index a488a1329b16..9f86dbce2680 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -253,7 +253,8 @@ struct arch_elf_state {
>  	int flags;
>  };
>  
> -#define ARM64_ELF_BTI		(1 << 0)
> +#define ARM64_ELF_INTERP_BTI		(1 << 0)
> +#define ARM64_ELF_EXEC_BTI		(1 << 1)
>  
>  #define INIT_ARCH_ELF_STATE {			\
>  	.flags = 0,				\
> @@ -274,9 +275,14 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
>  		if (datasz != sizeof(*p))
>  			return -ENOEXEC;
>  
> -		if (system_supports_bti() && has_interp == is_interp &&
> -		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI))
> -			arch->flags |= ARM64_ELF_BTI;
> +		if (system_supports_bti() &&
> +		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)) {
> +			if (is_interp) {
> +				arch->flags |= ARM64_ELF_INTERP_BTI;
> +			} else {
> +				arch->flags |= ARM64_ELF_EXEC_BTI;
> +			}

Nit: surplus curlies? (coding-style.rst does actually say to drop them
when all branches of an if are single-statement one-liners -- I had
presumed I was just being pedantic...)

> +		}
>  	}
>  
>  	return 0;
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index b4bb67f17a2c..f7fff4a4c99f 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -744,19 +744,13 @@ asmlinkage void __sched arm64_preempt_schedule_irq(void)
>  int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
>  			 bool has_interp, bool is_interp)
>  {
> -	/*
> -	 * For dynamically linked executables the interpreter is
> -	 * responsible for setting PROT_BTI on everything except
> -	 * itself.
> -	 */
> -	if (is_interp != has_interp)
> -		return prot;
> +	if (prot & PROT_EXEC) {
> +		if (state->flags & ARM64_ELF_INTERP_BTI && is_interp)
> +			prot |= PROT_BTI;
>  
> -	if (!(state->flags & ARM64_ELF_BTI))
> -		return prot;
> -
> -	if (prot & PROT_EXEC)
> -		prot |= PROT_BTI;
> +		if (state->flags & ARM64_ELF_EXEC_BTI && !is_interp)
> +			prot |= PROT_BTI;
> +	}

Is it worth adding () around the bitwise-& expressions?  I'm always a
little uneasy about the operator precedence of binary &, although
without looking it up I think you're correct.

Also, due to symmetry between arch_elf_adjust_prot() and
arch_parse_elf_properties() here, could we have something like

	static inline int arm64_elf_bti_flag(bool is_interp)
	{
		if (is_interp)
			return ARM64_ELF_INTERP_BTI;
		else
			return ARM64_ELF_EXEC_BTI;
	}

and then have code like

	if (state->flags & arm64_elf_bti_flag(is_interp))
		prot |= PROT_BTI;

here (with analogous code in arch_elf_adjust_prot()).

Feel free to adopt if this appeals to you, otherwise I'm also fine with
your version.)

Either way, these comments are all pretty much cosmetic, and my
Reviewed-by stands.

Cheers
---Dave
