Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3459639A4ED
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 17:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFCPnT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 11:43:19 -0400
Received: from foss.arm.com ([217.140.110.172]:44354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhFCPnT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Jun 2021 11:43:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FC8C12FC;
        Thu,  3 Jun 2021 08:41:34 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDA8A3F73D;
        Thu,  3 Jun 2021 08:41:32 -0700 (PDT)
Date:   Thu, 3 Jun 2021 16:40:35 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, libc-alpha@sourceware.org
Subject: Re: [PATCH v1 2/2] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <20210603154034.GH4187@arm.com>
References: <20210521144621.9306-1-broonie@kernel.org>
 <20210521144621.9306-3-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521144621.9306-3-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 21, 2021 at 03:46:21PM +0100, Mark Brown wrote:
> Currently for dynamically linked ELF executables we only enable BTI for
> the interpreter, expecting the interpreter to do this for the main
> executable. This is a bit inconsistent since we do map main executable and
> is causing issues with systemd's MemoryDenyWriteExecute feature which is
> implemented using a seccomp filter which prevents setting PROT_EXEC on
> already mapped memory and lacks the context to be able to detect that
> memory is already mapped with PROT_EXEC.

It's hard to know whether this is an extensibility fail in the
semantics of mprotect() (and so we were wrong to add PROT_BTI there in
line with my original proposal), or whether this is a case of systemd
doing something that is broken by design (if well-intentioned).  Since
there have been wacky arch-specific mprotect flags around for a fair
while I'd be tempted to argue the latter -- but then I am biased.


Anyway, although I'm a bit queasy about the cause of this patch, the
patch itself looks perfectly reasonable.  If nothing else, it makes
sense as a cleanup or optimisation, so that ld.so doesn't have to do a
bunch of mprotect() calls every time it loads a program.

Do we know how libcs will detect that they don't need to do the
mprotect() calls?  Do we need a detection mechanism at all?

Ignoring certain errors from mprotect() when ld.so is trying to set
PROT_BTI on the main executable's code pages is probably a reasonable,
backwards-compatible compromise here, but it seems a bit wasteful.

> Resolve this by checking the BTI property for the main executable and
> enabling BTI if it is present when doing the initial mapping. This does
> mean that we may get more code with BTI enabled if running on a system
> without BTI support in the dynamic linker, this is expected to be a safe
> configuration and testing seems to confirm that. It also reduces the

Ack, plus IIUC the architecture is designed so that everything works
providing that PROT_BTI is never set on non-BTI-aware code pages.  For
BTI-aware code, the sooner we set PROT_BTI the better I guess.

> flexibility userspace has to disable BTI but it is expected that for cases
> where there are problems which require BTI to be disabled it is more likely
> that it will need to be disabled on a system level.

There's no flexibility impact unless MemoryDenyWriteExecute is in force,
right?

Self-modifying programs (JITs etc.) already can't use that IIUC, so
shouldn't be affected.  That seems the main scenario where people are
likely to be twiddling PROT_{EXEC,WRITE,BTI} on existing pages.

If the main binary is marked as supporting BTI but breaks with
PROT_BTI, then that almost certainly means the toolchain, system
libraries or hardware are broken -- so it would be pointless to have an
elegant workaround.  A big global kill switch seems adequate to me.

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/elf.h | 14 ++++++++++----
>  arch/arm64/kernel/process.c  | 18 ++++++------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index c8678a8c36d5..a6e9032b951a 100644
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
> -		if (system_supports_bti() && is_interp &&
> -		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI))
> -			arch->flags |= ARM64_ELF_BTI;
> +		if (system_supports_bti() &&
> +		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)) {
> +			if (is_interp) {

Nit: can we drop the extra curlies?

> +				arch->flags |= ARM64_ELF_INTERP_BTI;
> +			} else {
> +				arch->flags |= ARM64_ELF_EXEC_BTI;
> +			}
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

Merge these ifs together somehow?  I'm happy either way, though.

> +			prot |= PROT_BTI;
> +	}

Since is_interp and has_interp were only needed for this logic in the
first place, I think we can probably drop those, maybe in a subsequent
patch.  Probably better to do it now before too much dust settles on
them.

Again, Cc Yu-cheng Yu if doing that, since it might affect his patches.

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

(though if some of the suggested changes are made elsewhere, this will
probably need a minor respin).

Cheers
---Dave
