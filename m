Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5BA17E1B5
	for <lists+linux-arch@lfdr.de>; Mon,  9 Mar 2020 14:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCINxZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Mar 2020 09:53:25 -0400
Received: from foss.arm.com ([217.140.110.172]:52694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgCINxZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Mar 2020 09:53:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 700CD30E;
        Mon,  9 Mar 2020 06:53:24 -0700 (PDT)
Received: from [10.1.195.53] (e123572-lin.cambridge.arm.com [10.1.195.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75DB73F67D;
        Mon,  9 Mar 2020 06:53:22 -0700 (PDT)
Subject: Re: [PATCH v2 16/19] arm64: mte: Allow user control of the tag check
 mode via prctl()
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
 <20200226180526.3272848-17-catalin.marinas@arm.com>
From:   Kevin Brodsky <kevin.brodsky@arm.com>
Message-ID: <726c4184-ff15-b78c-9364-a81b76000107@arm.com>
Date:   Mon, 9 Mar 2020 13:53:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200226180526.3272848-17-catalin.marinas@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 26/02/2020 18:05, Catalin Marinas wrote:
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
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>
> Notes:
>      v2:
>      - Handle SCTLR_EL1_TCF0_NONE explicitly for consistency with PR_MTE_TCF_NONE.
>      - Fix SCTLR_EL1 register setting in flush_mte_state() (thanks to Peter
>        Collingbourne).
>      - Added ISB to update_sctlr_el1_tcf0() since, with the latest
>        architecture update/fix, the TCF0 field is used by the uaccess
>        routines.
>
>   arch/arm64/include/asm/mte.h       | 10 +++++
>   arch/arm64/include/asm/processor.h |  3 ++
>   arch/arm64/kernel/mte.c            | 71 ++++++++++++++++++++++++++++++
>   arch/arm64/kernel/process.c        | 19 ++++++--
>   include/uapi/linux/prctl.h         |  6 +++
>   5 files changed, 106 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 0d7f7ca07ee6..3dc0a7977124 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -12,6 +12,8 @@ int mte_memcmp_pages(const void *page1_addr, const void *page2_addr);
>   #ifdef CONFIG_ARM64_MTE
>   void flush_mte_state(void);
>   void mte_thread_switch(struct task_struct *next);
> +long set_mte_ctrl(unsigned long arg);
> +long get_mte_ctrl(void);
>   #else
>   static inline void flush_mte_state(void)
>   {
> @@ -19,6 +21,14 @@ static inline void flush_mte_state(void)
>   static inline void mte_thread_switch(struct task_struct *next)
>   {
>   }
> +static inline long set_mte_ctrl(unsigned long arg)
> +{
> +	return 0;
> +}
> +static inline long get_mte_ctrl(void)
> +{
> +	return 0;
> +}
>   #endif
>   
>   #endif /* __ASSEMBLY__ */
> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
> index 5ba63204d078..91aa270afc7d 100644
> --- a/arch/arm64/include/asm/processor.h
> +++ b/arch/arm64/include/asm/processor.h
> @@ -148,6 +148,9 @@ struct thread_struct {
>   #ifdef CONFIG_ARM64_PTR_AUTH
>   	struct ptrauth_keys	keys_user;
>   #endif
> +#ifdef CONFIG_ARM64_MTE
> +	u64			sctlr_tcf0;
> +#endif
>   };
>   
>   static inline void arch_thread_struct_whitelist(unsigned long *offset,
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 0c2c900fa01c..4b926d779940 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -3,12 +3,34 @@
>    * Copyright (C) 2020 ARM Ltd.
>    */
>   
> +#include <linux/prctl.h>
> +#include <linux/sched.h>
>   #include <linux/thread_info.h>
>   
>   #include <asm/cpufeature.h>
>   #include <asm/mte.h>
>   #include <asm/sysreg.h>
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
> @@ -16,6 +38,8 @@ void flush_mte_state(void)
>   
>   	/* clear any pending asynchronous tag fault */
>   	clear_thread_flag(TIF_MTE_ASYNC_FAULT);
> +	/* disable tag checking */
> +	set_sctlr_el1_tcf0(0);

For consistency: set_sctlr_el1_tcf0(SCTLR_EL1_TCF0_NONE);

Kevin

>   }
>   
>   void mte_thread_switch(struct task_struct *next)
> @@ -34,4 +58,51 @@ void mte_thread_switch(struct task_struct *next)
>   		set_thread_flag(TIF_MTE_ASYNC_FAULT);
>   		write_sysreg_s(0, SYS_TFSRE0_EL1);
>   	}
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
> index 1b732150f51a..b3c8cd64b88a 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -578,9 +578,15 @@ static unsigned int tagged_addr_disabled;
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
> @@ -590,6 +596,9 @@ long set_tagged_addr_ctrl(unsigned long arg)
>   	if (arg & PR_TAGGED_ADDR_ENABLE && tagged_addr_disabled)
>   		return -EINVAL;
>   
> +	if (set_mte_ctrl(arg) != 0)
> +		return -EINVAL;
> +
>   	update_thread_flag(TIF_TAGGED_ADDR, arg & PR_TAGGED_ADDR_ENABLE);
>   
>   	return 0;
> @@ -597,13 +606,17 @@ long set_tagged_addr_ctrl(unsigned long arg)
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

