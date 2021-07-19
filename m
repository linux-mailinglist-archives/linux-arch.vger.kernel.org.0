Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E01F3CD188
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 12:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbhGSJZq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 05:25:46 -0400
Received: from foss.arm.com ([217.140.110.172]:54428 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235609AbhGSJZq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jul 2021 05:25:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1DE0E6D;
        Mon, 19 Jul 2021 03:06:26 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C15763F73D;
        Mon, 19 Jul 2021 03:06:24 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:05:08 +0100
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
Subject: Re: [PATCH v4 2/4] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <20210719100507.GU4187@arm.com>
References: <20210712115259.29547-1-broonie@kernel.org>
 <20210712115259.29547-3-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712115259.29547-3-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 12, 2021 at 12:52:57PM +0100, Mark Brown wrote:
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
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/elf.h | 14 ++++++++++----
>  arch/arm64/kernel/process.c  | 23 +++++++++++------------
>  2 files changed, 21 insertions(+), 16 deletions(-)
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

Can this just be

	arch->flags |= arm64_elf_bti_flag(is_interp);

if the helper is moved to this header?


> +		}
>  	}
>  
>  	return 0;
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index c8989b999250..5a6c3b198bd3 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -683,21 +683,20 @@ core_initcall(tagged_addr_init);
>  #endif	/* CONFIG_ARM64_TAGGED_ADDR_ABI */
>  
>  #ifdef CONFIG_BINFMT_ELF
> -int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
> -			 bool has_interp, bool is_interp)
> +static inline int arm64_elf_bti_flag(bool is_interp)
>  {
> -	/*
> -	 * For dynamically linked executables the interpreter is
> -	 * responsible for setting PROT_BTI on everything except
> -	 * itself.
> -	 */
> -	if (is_interp != has_interp)
> -		return prot;
> +	if (is_interp)
> +		return ARM64_ELF_INTERP_BTI;
> +	else
> +		return ARM64_ELF_EXEC_BTI;
> +}
>  
> -	if (!(state->flags & ARM64_ELF_BTI))
> -		return prot;
>  
> -	if (prot & PROT_EXEC)
> +int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
> +			 bool has_interp, bool is_interp)
> +{
> +	if ((prot & PROT_EXEC) &&
> +	    (state->flags & arm64_elf_bti_flag(is_interp)))

Preferably with the above change (but if not, I'll live without):

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

>  		prot |= PROT_BTI;
>  
>  	return prot;
> -- 
