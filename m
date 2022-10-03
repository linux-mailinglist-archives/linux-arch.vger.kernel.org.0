Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F405F2FC8
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 13:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiJCLk7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 07:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJCLk6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 07:40:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 675726389;
        Mon,  3 Oct 2022 04:40:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD7E4139F;
        Mon,  3 Oct 2022 04:41:03 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.80.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7E7E3F73B;
        Mon,  3 Oct 2022 04:40:53 -0700 (PDT)
Date:   Mon, 3 Oct 2022 12:40:50 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, zouyipeng@huawei.com,
        bigeasy@linutronix.de, David.Laight@aculab.com,
        chenzhongjin@huawei.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V6 05/11] riscv: traps: Add noinstr to prevent
 instrumentation inserted
Message-ID: <YzrKQkK4Kfbd7Wik@FVFF77S0Q05N>
References: <20221002012451.2351127-1-guoren@kernel.org>
 <20221002012451.2351127-6-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002012451.2351127-6-guoren@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Oct 01, 2022 at 09:24:45PM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Without noinstr the compiler is free to insert instrumentation (think
> all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
> yet ready to run this early in the entry path, for instance it could
> rely on RCU which isn't on yet, or expect lockdep state. (by peterz)
> 
> Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net/raw
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/kernel/traps.c | 4 ++--
>  arch/riscv/mm/fault.c     | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 635e6ec26938..588e17c386c6 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -92,9 +92,9 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
>  }
>  
>  #if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_RISCV_ALTERNATIVE)
> -#define __trap_section		__section(".xip.traps")
> +#define __trap_section __noinstr_section(".xip.traps")

I assume that for CONFIG_XIP_KERNEL, KPROBES is not possible, and so functions
marked with __trap_section don't need to be excluded from kprobes.

Is that assumption correct, or does something need to be done to inhibit that?

Thanks,
Mark.

>  #else
> -#define __trap_section
> +#define __trap_section noinstr
>  #endif
>  #define DO_ERROR_INFO(name, signo, code, str)				\
>  asmlinkage __visible __trap_section void name(struct pt_regs *regs)	\
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index f2fbd1400b7c..c7829289e806 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -203,7 +203,7 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
>   * This routine handles page faults.  It determines the address and the
>   * problem, and then passes it off to one of the appropriate routines.
>   */
> -asmlinkage void do_page_fault(struct pt_regs *regs)
> +asmlinkage void noinstr do_page_fault(struct pt_regs *regs)
>  {
>  	struct task_struct *tsk;
>  	struct vm_area_struct *vma;
> -- 
> 2.36.1
> 
