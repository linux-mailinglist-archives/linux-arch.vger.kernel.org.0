Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB283552D4
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 13:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbhDFLyS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 07:54:18 -0400
Received: from foss.arm.com ([217.140.110.172]:41848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343558AbhDFLyN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Apr 2021 07:54:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACB70113E;
        Tue,  6 Apr 2021 04:54:05 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F9E23F73D;
        Tue,  6 Apr 2021 04:54:00 -0700 (PDT)
Date:   Tue, 6 Apr 2021 12:53:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ardb@kernel.org
Subject: Re: [PATCH v5 14/18] arm64: add __nocfi to functions that jump to a
 physical address
Message-ID: <20210406115357.GE96480@C02TD0UTHF1T.local>
References: <20210401233216.2540591-1-samitolvanen@google.com>
 <20210401233216.2540591-15-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401233216.2540591-15-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[adding Ard for EFI runtime services bits]

On Thu, Apr 01, 2021 at 04:32:12PM -0700, Sami Tolvanen wrote:
> Disable CFI checking for functions that switch to linear mapping and
> make an indirect call to a physical address, since the compiler only
> understands virtual addresses and the CFI check for such indirect calls
> would always fail.

What does physical vs virtual have to do with this? Does the address
actually matter, or is this just a general thing that when calling an
assembly function we won't have a trampoline that the caller expects?

I wonder if we need to do something with asmlinkage here, perhaps?

I didn't spot anything in the seriues handling EFI runtime services
calls, and I strongly suspect we need to do something for those, unless
they're handled implicitly by something else.

> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/include/asm/mmu_context.h | 2 +-
>  arch/arm64/kernel/cpu-reset.h        | 8 ++++----
>  arch/arm64/kernel/cpufeature.c       | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index 386b96400a57..d3cef9133539 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -119,7 +119,7 @@ static inline void cpu_install_idmap(void)
>   * Atomically replaces the active TTBR1_EL1 PGD with a new VA-compatible PGD,
>   * avoiding the possibility of conflicting TLB entries being allocated.
>   */
> -static inline void cpu_replace_ttbr1(pgd_t *pgdp)
> +static inline void __nocfi cpu_replace_ttbr1(pgd_t *pgdp)

Given these are inlines, what's the effect when these are inlined into a
function that would normally use CFI? Does CFI get supressed for the
whole function, or just the bit that got inlined?

Is there an attribute that we could place on a function pointer to tell
the compiler to not check calls via that pointer? If that existed we'd
be able to scope this much more tightly.

Thanks,
Mark.

>  {
>  	typedef void (ttbr_replace_func)(phys_addr_t);
>  	extern ttbr_replace_func idmap_cpu_replace_ttbr1;
> diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
> index f3adc574f969..9a7b1262ef17 100644
> --- a/arch/arm64/kernel/cpu-reset.h
> +++ b/arch/arm64/kernel/cpu-reset.h
> @@ -13,10 +13,10 @@
>  void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
>  	unsigned long arg0, unsigned long arg1, unsigned long arg2);
>  
> -static inline void __noreturn cpu_soft_restart(unsigned long entry,
> -					       unsigned long arg0,
> -					       unsigned long arg1,
> -					       unsigned long arg2)
> +static inline void __noreturn __nocfi cpu_soft_restart(unsigned long entry,
> +						       unsigned long arg0,
> +						       unsigned long arg1,
> +						       unsigned long arg2)
>  {
>  	typeof(__cpu_soft_restart) *restart;
>  
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 0b2e0d7b13ec..c2f94a5206e0 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1445,7 +1445,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  }
>  
>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
> -static void
> +static void __nocfi
>  kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
>  {
>  	typedef void (kpti_remap_fn)(int, int, phys_addr_t);
> -- 
> 2.31.0.208.g409f899ff0-goog
> 
