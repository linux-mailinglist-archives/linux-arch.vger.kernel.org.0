Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0436C1B5F0A
	for <lists+linux-arch@lfdr.de>; Thu, 23 Apr 2020 17:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgDWPYB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Apr 2020 11:24:01 -0400
Received: from foss.arm.com ([217.140.110.172]:42208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbgDWPYA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Apr 2020 11:24:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9B7531B;
        Thu, 23 Apr 2020 08:23:59 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80EE13F6CF;
        Thu, 23 Apr 2020 08:23:58 -0700 (PDT)
Date:   Thu, 23 Apr 2020 16:23:52 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 18/23] arm64: mte: Restore the GCR_EL1 register after
 a suspend
Message-ID: <20200423152352.GA21616@e121166-lin.cambridge.arm.com>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-19-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421142603.3894-19-catalin.marinas@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 21, 2020 at 03:25:58PM +0100, Catalin Marinas wrote:
> The CPU resume/suspend routines only take care of the common system
> registers. Restore GCR_EL1 in addition via the __cpu_suspend_exit()
> function.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> ---
> 
> Notes:
>     New in v3.
> 
>  arch/arm64/include/asm/mte.h | 4 ++++
>  arch/arm64/kernel/mte.c      | 8 ++++++++
>  arch/arm64/kernel/suspend.c  | 4 ++++
>  3 files changed, 16 insertions(+)

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> index 3dc0a7977124..22eb3e06f311 100644
> --- a/arch/arm64/include/asm/mte.h
> +++ b/arch/arm64/include/asm/mte.h
> @@ -12,6 +12,7 @@ int mte_memcmp_pages(const void *page1_addr, const void *page2_addr);
>  #ifdef CONFIG_ARM64_MTE
>  void flush_mte_state(void);
>  void mte_thread_switch(struct task_struct *next);
> +void mte_suspend_exit(void);
>  long set_mte_ctrl(unsigned long arg);
>  long get_mte_ctrl(void);
>  #else
> @@ -21,6 +22,9 @@ static inline void flush_mte_state(void)
>  static inline void mte_thread_switch(struct task_struct *next)
>  {
>  }
> +static inline void mte_suspend_exit(void)
> +{
> +}
>  static inline long set_mte_ctrl(unsigned long arg)
>  {
>  	return 0;
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 212b9fac294d..fa4a4196b248 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -76,6 +76,14 @@ void mte_thread_switch(struct task_struct *next)
>  	update_gcr_el1_excl(next->thread.gcr_incl);
>  }
>  
> +void mte_suspend_exit(void)
> +{
> +	if (!system_supports_mte())
> +		return;
> +
> +	update_gcr_el1_excl(current->thread.gcr_incl);
> +}
> +
>  long set_mte_ctrl(unsigned long arg)
>  {
>  	u64 tcf0;
> diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
> index 9405d1b7f4b0..1d405b73d009 100644
> --- a/arch/arm64/kernel/suspend.c
> +++ b/arch/arm64/kernel/suspend.c
> @@ -9,6 +9,7 @@
>  #include <asm/daifflags.h>
>  #include <asm/debug-monitors.h>
>  #include <asm/exec.h>
> +#include <asm/mte.h>
>  #include <asm/pgtable.h>
>  #include <asm/memory.h>
>  #include <asm/mmu_context.h>
> @@ -74,6 +75,9 @@ void notrace __cpu_suspend_exit(void)
>  	 */
>  	if (arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE)
>  		arm64_set_ssbd_mitigation(false);
> +
> +	/* Restore additional MTE-specific configuration */
> +	mte_suspend_exit();
>  }
>  
>  /*
