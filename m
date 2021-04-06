Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A0A355283
	for <lists+linux-arch@lfdr.de>; Tue,  6 Apr 2021 13:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbhDFLmK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Apr 2021 07:42:10 -0400
Received: from foss.arm.com ([217.140.110.172]:41584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232429AbhDFLmJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Apr 2021 07:42:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49CA41042;
        Tue,  6 Apr 2021 04:42:01 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B4B53F73D;
        Tue,  6 Apr 2021 04:41:56 -0700 (PDT)
Date:   Tue, 6 Apr 2021 12:41:53 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
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
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v5 13/18] arm64: use function_nocfi with __pa_symbol
Message-ID: <20210406114153.GD96480@C02TD0UTHF1T.local>
References: <20210401233216.2540591-1-samitolvanen@google.com>
 <20210401233216.2540591-14-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401233216.2540591-14-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 01, 2021 at 04:32:11PM -0700, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function address
> references with the address of the function's CFI jump table
> entry. This means that __pa_symbol(function) returns the physical
> address of the jump table entry, which can lead to address space
> confusion as the jump table points to the function's virtual
> address. Therefore, use the function_nocfi() macro to ensure we are
> always taking the address of the actual function instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/arm64/include/asm/mmu_context.h      | 2 +-
>  arch/arm64/kernel/acpi_parking_protocol.c | 3 ++-
>  arch/arm64/kernel/cpu-reset.h             | 2 +-
>  arch/arm64/kernel/cpufeature.c            | 2 +-
>  arch/arm64/kernel/psci.c                  | 3 ++-
>  arch/arm64/kernel/smp_spin_table.c        | 3 ++-
>  6 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> index bd02e99b1a4c..386b96400a57 100644
> --- a/arch/arm64/include/asm/mmu_context.h
> +++ b/arch/arm64/include/asm/mmu_context.h
> @@ -140,7 +140,7 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
>  		ttbr1 |= TTBR_CNP_BIT;
>  	}
>  
> -	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
> +	replace_phys = (void *)__pa_symbol(function_nocfi(idmap_cpu_replace_ttbr1));
>  
>  	cpu_install_idmap();
>  	replace_phys(ttbr1);
> diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
> index e7c941d8340d..bfeeb5319abf 100644
> --- a/arch/arm64/kernel/acpi_parking_protocol.c
> +++ b/arch/arm64/kernel/acpi_parking_protocol.c
> @@ -99,7 +99,8 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
>  	 * that read this address need to convert this address to the
>  	 * Boot-Loader's endianness before jumping.
>  	 */
> -	writeq_relaxed(__pa_symbol(secondary_entry), &mailbox->entry_point);
> +	writeq_relaxed(__pa_symbol(function_nocfi(secondary_entry)),
> +		       &mailbox->entry_point);
>  	writel_relaxed(cpu_entry->gic_cpu_id, &mailbox->cpu_id);
>  
>  	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
> index ed50e9587ad8..f3adc574f969 100644
> --- a/arch/arm64/kernel/cpu-reset.h
> +++ b/arch/arm64/kernel/cpu-reset.h
> @@ -22,7 +22,7 @@ static inline void __noreturn cpu_soft_restart(unsigned long entry,
>  
>  	unsigned long el2_switch = !is_kernel_in_hyp_mode() &&
>  		is_hyp_mode_available();
> -	restart = (void *)__pa_symbol(__cpu_soft_restart);
> +	restart = (void *)__pa_symbol(function_nocfi(__cpu_soft_restart));
>  
>  	cpu_install_idmap();
>  	restart(el2_switch, entry, arg0, arg1, arg2);
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index e5281e1c8f1d..0b2e0d7b13ec 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1462,7 +1462,7 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
>  	if (arm64_use_ng_mappings)
>  		return;
>  
> -	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
> +	remap_fn = (void *)__pa_symbol(function_nocfi(idmap_kpti_install_ng_mappings));
>  
>  	cpu_install_idmap();
>  	remap_fn(cpu, num_online_cpus(), __pa_symbol(swapper_pg_dir));
> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
> index 62d2bda7adb8..e74bcb57559b 100644
> --- a/arch/arm64/kernel/psci.c
> +++ b/arch/arm64/kernel/psci.c
> @@ -38,7 +38,8 @@ static int __init cpu_psci_cpu_prepare(unsigned int cpu)
>  
>  static int cpu_psci_cpu_boot(unsigned int cpu)
>  {
> -	int err = psci_ops.cpu_on(cpu_logical_map(cpu), __pa_symbol(secondary_entry));
> +	int err = psci_ops.cpu_on(cpu_logical_map(cpu),
> +			__pa_symbol(function_nocfi(secondary_entry)));

Could we use a temporary here, e.g.

	phys_addr_t pa_secondary_entry = __pa_symbol(function_nocfi(secondary_entry));
	int err = psci_ops.cpu_on(cpu_logical_map(cpu), pa_secondary_entry);

>  	if (err)
>  		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
>  
> diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
> index 056772c26098..4c4e36ded4aa 100644
> --- a/arch/arm64/kernel/smp_spin_table.c
> +++ b/arch/arm64/kernel/smp_spin_table.c
> @@ -88,7 +88,8 @@ static int smp_spin_table_cpu_prepare(unsigned int cpu)
>  	 * boot-loader's endianness before jumping. This is mandated by
>  	 * the boot protocol.
>  	 */
> -	writeq_relaxed(__pa_symbol(secondary_holding_pen), release_addr);
> +	writeq_relaxed(__pa_symbol(function_nocfi(secondary_holding_pen)),
> +		       release_addr);

Likewise here? e.g. at the start of the function have:

	phys_addr_t pa_holding_pen = __pa_symbol(function_nocfi(secondary_holding_pen));

... then here have:

	writeq_relaxed(pa_holding_pen, release_addr);

With those:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

>  	__flush_dcache_area((__force void *)release_addr,
>  			    sizeof(*release_addr));
>  
> -- 
> 2.31.0.208.g409f899ff0-goog
> 
