Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A385A4D1F96
	for <lists+linux-arch@lfdr.de>; Tue,  8 Mar 2022 19:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbiCHSCa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Mar 2022 13:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiCHSC3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2022 13:02:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A36104EF43
        for <linux-arch@vger.kernel.org>; Tue,  8 Mar 2022 10:01:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 659831516;
        Tue,  8 Mar 2022 10:01:32 -0800 (PST)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04C773FA45;
        Tue,  8 Mar 2022 10:01:31 -0800 (PST)
Message-ID: <59fc8a58-5013-606b-f544-8277cda18e50@arm.com>
Date:   Tue, 8 Mar 2022 12:01:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v11 2/2] arm64: Enable BTI for main executable as well as
 the interpreter
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
References: <20220308132240.1697784-1-broonie@kernel.org>
 <20220308132240.1697784-3-broonie@kernel.org>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20220308132240.1697784-3-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 3/8/22 07:22, Mark Brown wrote:
> Currently for dynamically linked ELF executables we only enable BTI for
> the interpreter, expecting the interpreter to do this for the main
> executable. This is a bit inconsistent since we do map main executable and
> is causing issues with systemd's MemoryDenyWriteExecute feature which is
> implemented using a seccomp filter which prevents setting PROT_EXEC on
> already mapped memory and lacks the context to be able to detect that
> memory is already mapped with PROT_EXEC.
> 
> Resolve this by adding a sysctl abi.bti_main which causes the kernel to
> checking the BTI property for the main executable and enable BTI if it
> is present when doing the initial mapping. This sysctl is disabled by
> default.

This seems less than ideal, maybe the default can be flipped with a 
CONFIG option?

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>   arch/arm64/include/asm/elf.h | 15 ++++++++---
>   arch/arm64/kernel/process.c  | 52 +++++++++++++++++++++++++++---------
>   2 files changed, 51 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 5cc002376abe..c4aa60db76a4 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -251,12 +251,21 @@ struct arch_elf_state {
>   	int flags;
>   };
>   
> -#define ARM64_ELF_BTI		(1 << 0)
> +#define ARM64_ELF_INTERP_BTI		(1 << 0)
> +#define ARM64_ELF_EXEC_BTI		(1 << 1)
>   
>   #define INIT_ARCH_ELF_STATE {			\
>   	.flags = 0,				\
>   }
>   
> +static inline int arm64_elf_bti_flag(bool is_interp)
> +{
> +	if (is_interp)
> +		return ARM64_ELF_INTERP_BTI;
> +	else
> +		return ARM64_ELF_EXEC_BTI;
> +}
> +
>   static inline int arch_parse_elf_property(u32 type, const void *data,
>   					  size_t datasz, bool compat,
>   					  bool has_interp, bool is_interp,
> @@ -272,9 +281,9 @@ static inline int arch_parse_elf_property(u32 type, const void *data,
>   		if (datasz != sizeof(*p))
>   			return -ENOEXEC;
>   
> -		if (system_supports_bti() && has_interp == is_interp &&
> +		if (system_supports_bti() &&
>   		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI))
> -			arch->flags |= ARM64_ELF_BTI;
> +			arch->flags |= arm64_elf_bti_flag(is_interp);
>   	}
>   
>   	return 0;
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 5369e649fa79..82aaf361fa17 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -701,23 +701,49 @@ core_initcall(tagged_addr_init);
>   #endif	/* CONFIG_ARM64_TAGGED_ADDR_ABI */
>   
>   #ifdef CONFIG_BINFMT_ELF
> +static unsigned int bti_main;
> +
>   int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
>   			 bool has_interp, bool is_interp)
>   {
> -	/*
> -	 * For dynamically linked executables the interpreter is
> -	 * responsible for setting PROT_BTI on everything except
> -	 * itself.
> -	 */
> -	if (is_interp != has_interp)
> -		return prot;
> -
> -	if (!(state->flags & ARM64_ELF_BTI))
> -		return prot;
> -
> -	if (prot & PROT_EXEC)
> +	if ((prot & PROT_EXEC) &&
> +	    (is_interp || !has_interp || bti_main) &&
> +	    (state->flags & arm64_elf_bti_flag(is_interp)))
>   		prot |= PROT_BTI;
>   
>   	return prot;
>   }
> -#endif
> +
> +#ifdef CONFIG_ARM64_BTI
> +/*
> + * If this sysctl is enabled then we will apply PROT_BTI to the main
> + * executable as well as the dynamic linker if it has the appropriate
> + * ELF note.  It is disabled by default, in which case we will only
> + * apply PROT_BTI to the dynamic linker or static binaries.
> + */
> +static struct ctl_table bti_main_sysctl_table[] = {
> +	{
> +		.procname	= "bti_main",
> +		.mode		= 0644,
> +		.data		= &bti_main,
> +		.maxlen		= sizeof(int),
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{ }
> +};
> +
> +static int __init bti_main_init(void)
> +{
> +	if (!system_supports_bti())
> +		return 0;
> +
> +	if (!register_sysctl("abi", bti_main_sysctl_table))
> +		return -EINVAL;
> +	return 0;
> +}
> +core_initcall(bti_main_init);
> +#endif /* CONFIG_ARM64_BTI */
> +
> +#endif /* CONFIG_BINFMT_ELF */

