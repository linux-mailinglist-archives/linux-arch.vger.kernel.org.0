Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6897B65BCD5
	for <lists+linux-arch@lfdr.de>; Tue,  3 Jan 2023 10:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjACJMJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 3 Jan 2023 04:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjACJMH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Jan 2023 04:12:07 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A529B64EA;
        Tue,  3 Jan 2023 01:12:05 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id DFA53FF80E;
        Tue,  3 Jan 2023 09:11:56 +0000 (UTC)
Message-ID: <36314eb6-e41d-30b9-9ac4-12b88a108b7b@ghiti.fr>
Date:   Tue, 3 Jan 2023 10:11:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH -next V12 3/7] riscv: entry: Add noinstr to prevent
 instrumentation inserted
Content-Language: en-US
To:     guoren@kernel.org, arnd@arndb.de, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, ben@decadent.org.uk, bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
References: <20230103033531.2011112-1-guoren@kernel.org>
 <20230103033531.2011112-4-guoren@kernel.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230103033531.2011112-4-guoren@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Guo,

On 1/3/23 04:35, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Without noinstr the compiler is free to insert instrumentation (think
> all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
> yet ready to run this early in the entry path, for instance it could
> rely on RCU which isn't on yet, or expect lockdep state. (by peterz)
>
> Link: https://lore.kernel.org/linux-riscv/YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net/
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Tested-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>   arch/riscv/kernel/traps.c | 4 ++--
>   arch/riscv/mm/fault.c     | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 549bde5c970a..96ec76c54ff2 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -95,9 +95,9 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
>   }
>   
>   #if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_RISCV_ALTERNATIVE)
> -#define __trap_section		__section(".xip.traps")
> +#define __trap_section __noinstr_section(".xip.traps")
>   #else
> -#define __trap_section
> +#define __trap_section noinstr
>   #endif
>   #define DO_ERROR_INFO(name, signo, code, str)				\
>   asmlinkage __visible __trap_section void name(struct pt_regs *regs)	\
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index d86f7cebd4a7..b26f68eac61c 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -204,7 +204,7 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
>    * This routine handles page faults.  It determines the address and the
>    * problem, and then passes it off to one of the appropriate routines.
>    */
> -asmlinkage void do_page_fault(struct pt_regs *regs)
> +asmlinkage void noinstr do_page_fault(struct pt_regs *regs)


(I dug the archive but can't find the series before v4, so sorry if it 
was already answered)

I think we should not disable the instrumentation of those trap handlers 
as at least profiling them with ftrace would provide valuable 
information (and gcov would be nice too): why do we need to do that? A 
trap very early in the boot process is not recoverable anyway.

And I took a look at other architectures, none of them disables the 
instrumentation on do_page_fault.


>   {
>   	struct task_struct *tsk;
>   	struct vm_area_struct *vma;
