Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5453CD189
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 12:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhGSJZz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 05:25:55 -0400
Received: from foss.arm.com ([217.140.110.172]:54444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235609AbhGSJZy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jul 2021 05:25:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A46146D;
        Mon, 19 Jul 2021 03:06:34 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53A513F73D;
        Mon, 19 Jul 2021 03:06:33 -0700 (PDT)
Date:   Mon, 19 Jul 2021 11:05:16 +0100
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
Subject: Re: [PATCH v4 3/4] elf: Remove has_interp property from
 arch_adjust_elf_prot()
Message-ID: <20210719100516.GV4187@arm.com>
References: <20210712115259.29547-1-broonie@kernel.org>
 <20210712115259.29547-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712115259.29547-4-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 12, 2021 at 12:52:58PM +0100, Mark Brown wrote:
> Since we have added an is_interp flag to arch_parse_elf_property() we can
> drop the has_interp flag from arch_elf_adjust_prot(), the only user was
> the arm64 code which no longer needs it and any future users will be able
> to use arch_parse_elf_properties() to determine if an interpreter is in
> use.

Reviewed-By: Dave Martin <Dave.Martin@arm.com>

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Tested-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/process.c | 2 +-
>  fs/binfmt_elf.c             | 2 +-
>  include/linux/elf.h         | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 5a6c3b198bd3..992d827b37b0 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -693,7 +693,7 @@ static inline int arm64_elf_bti_flag(bool is_interp)
>  
>  
>  int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
> -			 bool has_interp, bool is_interp)
> +			 bool is_interp)
>  {
>  	if ((prot & PROT_EXEC) &&
>  	    (state->flags & arm64_elf_bti_flag(is_interp)))
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 81e151a57df2..ae8094d42480 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -580,7 +580,7 @@ static inline int make_prot(u32 p_flags, struct arch_elf_state *arch_state,
>  	if (p_flags & PF_X)
>  		prot |= PROT_EXEC;
>  
> -	return arch_elf_adjust_prot(prot, arch_state, has_interp, is_interp);
> +	return arch_elf_adjust_prot(prot, arch_state, is_interp);
>  }
>  
>  /* This is much more generalized than the library routine read function,
> diff --git a/include/linux/elf.h b/include/linux/elf.h
> index 1c45ecf29147..d8392531899d 100644
> --- a/include/linux/elf.h
> +++ b/include/linux/elf.h
> @@ -101,11 +101,11 @@ extern int arch_parse_elf_property(u32 type, const void *data, size_t datasz,
>  
>  #ifdef CONFIG_ARCH_HAVE_ELF_PROT
>  int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
> -			 bool has_interp, bool is_interp);
> +			 bool is_interp);
>  #else
>  static inline int arch_elf_adjust_prot(int prot,
>  				       const struct arch_elf_state *state,
> -				       bool has_interp, bool is_interp)
> +				       bool is_interp)
>  {
>  	return prot;
>  }
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
