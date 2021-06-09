Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D9E3A191F
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 17:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbhFIPUu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 11:20:50 -0400
Received: from foss.arm.com ([217.140.110.172]:34304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230427AbhFIPUV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jun 2021 11:20:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C596011FB;
        Wed,  9 Jun 2021 08:18:25 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74D153F73D;
        Wed,  9 Jun 2021 08:18:24 -0700 (PDT)
Date:   Wed, 9 Jun 2021 16:17:24 +0100
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
Subject: Re: [PATCH v2 3/3] elf: Remove has_interp property from
 arch_adjust_elf_prot()
Message-ID: <20210609151724.GM4187@arm.com>
References: <20210604112450.13344-1-broonie@kernel.org>
 <20210604112450.13344-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604112450.13344-4-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 12:24:50PM +0100, Mark Brown wrote:
> Since we have added an is_interp flag to arch_parse_elf_property() we can
> drop the has_interp flag from arch_elf_adjust_prot(), the only user was
> the arm64 code which no longer needs it and any future users will be able
> to use arch_parse_elf_properties() to determine if an interpreter is in
> use.

So far so good, but can we also drop the has_interp argument from
arch_parse_elf_properties()?

Cross-check with Yu-Cheng Yu's series, but I don't see this being used
any more (except for passthrough in binfmt_elf.c).

Since we are treating the interpreter and main executable orthogonally
to each other now, I don't think we should need a has_interp argument to
pass knowledge between the interpreter and executable handling phases
here.

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/process.c | 2 +-
>  fs/binfmt_elf.c             | 2 +-
>  include/linux/elf.h         | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index f7fff4a4c99f..e51c4aa7e048 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -742,7 +742,7 @@ asmlinkage void __sched arm64_preempt_schedule_irq(void)
>  
>  #ifdef CONFIG_BINFMT_ELF
>  int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
> -			 bool has_interp, bool is_interp)
> +			 bool is_interp)
>  {
>  	if (prot & PROT_EXEC) {
>  		if (state->flags & ARM64_ELF_INTERP_BTI && is_interp)
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 253ca9969345..1aba4e50e651 100644
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

[...]

Otherwise, looks reasonable.

Cheers
---Dave
