Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FE023C015
	for <lists+linux-arch@lfdr.de>; Tue,  4 Aug 2020 21:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgHDTer (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Aug 2020 15:34:47 -0400
Received: from foss.arm.com ([217.140.110.172]:48932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgHDTer (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 4 Aug 2020 15:34:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 840C230E;
        Tue,  4 Aug 2020 12:34:46 -0700 (PDT)
Received: from [192.168.178.44] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF8FA3F71F;
        Tue,  4 Aug 2020 12:34:44 -0700 (PDT)
Subject: Re: [PATCH v7 18/29] arm64: mte: Allow user control of the tag check
 mode via prctl()
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-19-catalin.marinas@arm.com>
From:   Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <9342a080-9450-c01a-54a0-9ddebfe45613@arm.com>
Date:   Tue, 4 Aug 2020 20:34:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200715170844.30064-19-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 15/07/2020 18:08, Catalin Marinas wrote:
> By default, even if PROT_MTE is set on a memory range, there is no tag
> check fault reporting (SIGSEGV). Introduce a set of option to the
> exiting prctl(PR_SET_TAGGED_ADDR_CTRL) to allow user control of the tag
> check fault mode:
>
>    PR_MTE_TCF_NONE  - no reporting (default)
>    PR_MTE_TCF_SYNC  - synchronous tag check fault reporting
>    PR_MTE_TCF_ASYNC - asynchronous tag check fault reporting
>
> These options translate into the corresponding SCTLR_EL1.TCF0 bitfield,
> context-switched by the kernel. Note that uaccess done by the kernel is
> not checked and cannot be configured by the user.

The last sentence is outdated, it should probably say that uaccess is only checked in 
in synchronous mode.

Kevin

> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> ---
>
> Notes:
>      v3:
>      - Use SCTLR_EL1_TCF0_NONE instead of 0 for consistency.
>      - Move mte_thread_switch() in this patch from an earlier one. In
>        addition, it is called after the dsb() in __switch_to() so that any
>        asynchronous tag check faults have been registered in the TFSR_EL1
>        registers (to be added with the in-kernel MTE support.
>      
>      v2:
>      - Handle SCTLR_EL1_TCF0_NONE explicitly for consistency with PR_MTE_TCF_NONE.
>      - Fix SCTLR_EL1 register setting in flush_mte_state() (thanks to Peter
>        Collingbourne).
>      - Added ISB to update_sctlr_el1_tcf0() since, with the latest
>        architecture update/fix, the TCF0 field is used by the uaccess
>        routines.
>
>   arch/arm64/include/asm/mte.h       | 14 ++++++
>   arch/arm64/include/asm/processor.h |  3 ++
>   arch/arm64/kernel/mte.c            | 77 ++++++++++++++++++++++++++++++
>   arch/arm64/kernel/process.c        | 26 ++++++++--
>   include/uapi/linux/prctl.h         |  6 +++
>   5 files changed, 123 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index b2577eee62c2..df2efbc9f8f1 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -21,6 +21,9 @@ void mte_clear_page_tags(void *addr);
>   void mte_sync_tags(pte_t *ptep, pte_t pte);
>   void mte_copy_page_tags(void *kto, const void *kfrom);
>   void flush_mte_state(void);
> +void mte_thread_switch(struct task_struct *next);
> +long set_mte_ctrl(unsigned long arg);
> +long get_mte_ctrl(void);
>   
>   #else
>   
> @@ -36,6 +39,17 @@ static inline void mte_copy_page_tags(void *kto, const void *kfrom)
>   static inline void flush_mte_state(void)
>   {
>   }
> +static inline void mte_thread_switch(struct task_struct *next)
> +{
> +}
> +static inline long set_mte_ctrl(unsigned long arg)
> +{
> +	return 0;
> +}
> +static inline long get_mte_ctrl(void)
> +{
> +	return 0;
> +}
>   
>   #endif
>   
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 240fe5e5b720..80e7f0573309 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -151,6 +151,9 @@ struct thread_struct {
>   	struct ptrauth_keys_user	keys_user;
>   	struct ptrauth_keys_kernel	keys_kernel;
>   #endif
> +#ifdef CONFIG_ARM64_MTE
> +	u64			sctlr_tcf0;
> +#endif
>   };
>   
>   static inline void arch_thread_struct_whitelist(unsigned long *offset,
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 5f54fd140610..375483a1f573 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -5,6 +5,8 @@
>   
>   #include <linux/bitops.h>
>   #include <linux/mm.h>
> +#include <linux/prctl.h>
> +#include <linux/sched.h>
>   #include <linux/string.h>
>   #include <linux/thread_info.h>
>   
> @@ -49,6 +51,26 @@ int memcmp_pages(struct page *page1, struct page *page2)
>   	return ret;
>   }
>   
> +static void update_sctlr_el1_tcf0(u64 tcf0)
> +{
> +	/* ISB required for the kernel uaccess routines */
> +	sysreg_clear_set(sctlr_el1, SCTLR_EL1_TCF0_MASK, tcf0);
> +	isb();
> +}
> +
> +static void set_sctlr_el1_tcf0(u64 tcf0)
> +{
> +	/*
> +	 * mte_thread_switch() checks current->thread.sctlr_tcf0 as an
> +	 * optimisation. Disable preemption so that it does not see
> +	 * the variable update before the SCTLR_EL1.TCF0 one.
> +	 */
> +	preempt_disable();
> +	current->thread.sctlr_tcf0 = tcf0;
> +	update_sctlr_el1_tcf0(tcf0);
> +	preempt_enable();
> +}
> +
>   void flush_mte_state(void)
>   {
>   	if (!system_supports_mte())
> @@ -58,4 +80,59 @@ void flush_mte_state(void)
>   	dsb(ish);
>   	write_sysreg_s(0, SYS_TFSRE0_EL1);
>   	clear_thread_flag(TIF_MTE_ASYNC_FAULT);
> +	/* disable tag checking */
> +	set_sctlr_el1_tcf0(SCTLR_EL1_TCF0_NONE);
> +}
> +
> +void mte_thread_switch(struct task_struct *next)
> +{
> +	if (!system_supports_mte())
> +		return;
> +
> +	/* avoid expensive SCTLR_EL1 accesses if no change */
> +	if (current->thread.sctlr_tcf0 != next->thread.sctlr_tcf0)
> +		update_sctlr_el1_tcf0(next->thread.sctlr_tcf0);
> +}
> +
> +long set_mte_ctrl(unsigned long arg)
> +{
> +	u64 tcf0;
> +
> +	if (!system_supports_mte())
> +		return 0;
> +
> +	switch (arg & PR_MTE_TCF_MASK) {
> +	case PR_MTE_TCF_NONE:
> +		tcf0 = SCTLR_EL1_TCF0_NONE;
> +		break;
> +	case PR_MTE_TCF_SYNC:
> +		tcf0 = SCTLR_EL1_TCF0_SYNC;
> +		break;
> +	case PR_MTE_TCF_ASYNC:
> +		tcf0 = SCTLR_EL1_TCF0_ASYNC;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	set_sctlr_el1_tcf0(tcf0);
> +
> +	return 0;
> +}
> +
> +long get_mte_ctrl(void)
> +{
> +	if (!system_supports_mte())
> +		return 0;
> +
> +	switch (current->thread.sctlr_tcf0) {
> +	case SCTLR_EL1_TCF0_NONE:
> +		return PR_MTE_TCF_NONE;
> +	case SCTLR_EL1_TCF0_SYNC:
> +		return PR_MTE_TCF_SYNC;
> +	case SCTLR_EL1_TCF0_ASYNC:
> +		return PR_MTE_TCF_ASYNC;
> +	}
> +
> +	return 0;
>   }
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 695705d1f8e5..d19ce8053a03 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -544,6 +544,13 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
>   	 */
>   	dsb(ish);
>   
> +	/*
> +	 * MTE thread switching must happen after the DSB above to ensure that
> +	 * any asynchronous tag check faults have been logged in the TFSR*_EL1
> +	 * registers.
> +	 */
> +	mte_thread_switch(next);
> +
>   	/* the actual thread switch */
>   	last = cpu_switch_to(prev, next);
>   
> @@ -603,9 +610,15 @@ static unsigned int tagged_addr_disabled;
>   
>   long set_tagged_addr_ctrl(unsigned long arg)
>   {
> +	unsigned long valid_mask = PR_TAGGED_ADDR_ENABLE;
> +
>   	if (is_compat_task())
>   		return -EINVAL;
> -	if (arg & ~PR_TAGGED_ADDR_ENABLE)
> +
> +	if (system_supports_mte())
> +		valid_mask |= PR_MTE_TCF_MASK;
> +
> +	if (arg & ~valid_mask)
>   		return -EINVAL;
>   
>   	/*
> @@ -615,6 +628,9 @@ long set_tagged_addr_ctrl(unsigned long arg)
>   	if (arg & PR_TAGGED_ADDR_ENABLE && tagged_addr_disabled)
>   		return -EINVAL;
>   
> +	if (set_mte_ctrl(arg) != 0)
> +		return -EINVAL;
> +
>   	update_thread_flag(TIF_TAGGED_ADDR, arg & PR_TAGGED_ADDR_ENABLE);
>   
>   	return 0;
> @@ -622,13 +638,17 @@ long set_tagged_addr_ctrl(unsigned long arg)
>   
>   long get_tagged_addr_ctrl(void)
>   {
> +	long ret = 0;
> +
>   	if (is_compat_task())
>   		return -EINVAL;
>   
>   	if (test_thread_flag(TIF_TAGGED_ADDR))
> -		return PR_TAGGED_ADDR_ENABLE;
> +		ret = PR_TAGGED_ADDR_ENABLE;
>   
> -	return 0;
> +	ret |= get_mte_ctrl();
> +
> +	return ret;
>   }
>   
>   /*
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 07b4f8131e36..2390ab324afa 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -233,6 +233,12 @@ struct prctl_mm_map {
>   #define PR_SET_TAGGED_ADDR_CTRL		55
>   #define PR_GET_TAGGED_ADDR_CTRL		56
>   # define PR_TAGGED_ADDR_ENABLE		(1UL << 0)
> +/* MTE tag check fault modes */
> +# define PR_MTE_TCF_SHIFT		1
> +# define PR_MTE_TCF_NONE		(0UL << PR_MTE_TCF_SHIFT)
> +# define PR_MTE_TCF_SYNC		(1UL << PR_MTE_TCF_SHIFT)
> +# define PR_MTE_TCF_ASYNC		(2UL << PR_MTE_TCF_SHIFT)
> +# define PR_MTE_TCF_MASK		(3UL << PR_MTE_TCF_SHIFT)
>   
>   /* Control reclaim behavior when allocating memory */
>   #define PR_SET_IO_FLUSHER		57

