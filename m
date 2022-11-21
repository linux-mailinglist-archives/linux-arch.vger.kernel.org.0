Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2297631D7D
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 10:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiKUJyq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 04:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiKUJxx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 04:53:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBC593;
        Mon, 21 Nov 2022 01:53:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A67460F75;
        Mon, 21 Nov 2022 09:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED89C433C1;
        Mon, 21 Nov 2022 09:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669024422;
        bh=YOu3n64Tj7XKfjexEDDMs01w9nySaXbJautW19RY7rk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EkYKBEv/JLMpETaD3fmit9KxL9w0cetRO8GDNkvFJuUPMCKe/pz5emv3c7b3XziuC
         O4+U2B8TKt7pUlz2ACWLgGwUvyN1/cD66CLfOpEVfBLdoAdtuMG6JswDZlM0vHOKbN
         fOy1LLDp0N7OCW/sMIUGAW+Ac67ez0t5Y/OJJbCtnTZe+uz1OOAh+MWs/suHqIUybs
         fi3rBBDlKCDJCpWOxBHhhpcAu+DkO5fdJDkXZrjc6Zgxtd8Wq411B2Ym7p8Jfsfa2P
         6AhLItAhgB5Dn9V4tpu+K+fCcK20A4whHREwB4V8n0MalguF80S9Euk+yPnlMhHvy0
         yaTWF5gJuE5Eg==
Received: by mail-ej1-f49.google.com with SMTP id gv23so27240385ejb.3;
        Mon, 21 Nov 2022 01:53:42 -0800 (PST)
X-Gm-Message-State: ANoB5pkDq6FfClLYK9IxPDUm46ul4RhTALaxt3QwY2bImJVnxLNKQPZO
        7V0RXFJPI6k/zqq4m6+W6tqRJbbn0bV6KQtJCK8=
X-Google-Smtp-Source: AA0mqf5gjyu2O31/o45ixHAU9CeNugJbqJmGKGzyyhNGh5D1oUhTne5cGDqJ4XF7f1It7xERrf5JNYGAQNOS2JGDxew=
X-Received: by 2002:a17:906:19d7:b0:7b2:b782:e1df with SMTP id
 h23-20020a17090619d700b007b2b782e1dfmr10699627ejd.308.1669024420821; Mon, 21
 Nov 2022 01:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20221109064937.3643993-1-guoren@kernel.org> <20221109064937.3643993-3-guoren@kernel.org>
In-Reply-To: <20221109064937.3643993-3-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 21 Nov 2022 17:53:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTREDPrr7z-78P5MZavwQZhrgZ8+MoS07agzPMqvf86ipA@mail.gmail.com>
Message-ID: <CAJF2gTREDPrr7z-78P5MZavwQZhrgZ8+MoS07agzPMqvf86ipA@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: stacktrace: Make walk_stackframe cross pt_regs frame
To:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, peterz@infradead.org,
        arnd@arndb.de, linux-arch@vger.kernel.org, keescook@chromium.org,
        paulmck@kernel.org, frederic@kernel.org, nsaenzju@redhat.com,
        changbin.du@intel.com, vincent.chen@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 9, 2022 at 2:50 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The current walk_stackframe with FRAME_POINTER would stop unwinding at
> ret_from_exception:
>   BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1518
>   in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: init
>   CPU: 0 PID: 1 Comm: init Not tainted 5.10.113-00021-g15c15974895c-dirty #192
>   Call Trace:
>   [<ffffffe0002038c8>] walk_stackframe+0x0/0xee
>   [<ffffffe000aecf48>] show_stack+0x32/0x4a
>   [<ffffffe000af1618>] dump_stack_lvl+0x72/0x8e
>   [<ffffffe000af1648>] dump_stack+0x14/0x1c
>   [<ffffffe000239ad2>] ___might_sleep+0x12e/0x138
>   [<ffffffe000239aec>] __might_sleep+0x10/0x18
>   [<ffffffe000afe3fe>] down_read+0x22/0xa4
>   [<ffffffe000207588>] do_page_fault+0xb0/0x2fe
>   [<ffffffe000201b80>] ret_from_exception+0x0/0xc
>
> The optimization would help walk_stackframe cross the pt_regs frame and
> get more backtrace of debug info:
>   BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1518
>   in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: init
>   CPU: 0 PID: 1 Comm: init Not tainted 5.10.113-00021-g15c15974895c-dirty #192
>   Call Trace:
>   [<ffffffe0002038c8>] walk_stackframe+0x0/0xee
>   [<ffffffe000aecf48>] show_stack+0x32/0x4a
>   [<ffffffe000af1618>] dump_stack_lvl+0x72/0x8e
>   [<ffffffe000af1648>] dump_stack+0x14/0x1c
>   [<ffffffe000239ad2>] ___might_sleep+0x12e/0x138
>   [<ffffffe000239aec>] __might_sleep+0x10/0x18
>   [<ffffffe000afe3fe>] down_read+0x22/0xa4
>   [<ffffffe000207588>] do_page_fault+0xb0/0x2fe
>   [<ffffffe000201b80>] ret_from_exception+0x0/0xc
>   [<ffffffe000613c06>] riscv_intc_irq+0x1a/0x72
>   [<ffffffe000201b80>] ret_from_exception+0x0/0xc
>   [<ffffffe00033f44a>] vma_link+0x54/0x160
>   [<ffffffe000341d7a>] mmap_region+0x2cc/0x4d0
>   [<ffffffe000342256>] do_mmap+0x2d8/0x3ac
>   [<ffffffe000326318>] vm_mmap_pgoff+0x70/0xb8
>   [<ffffffe00032638a>] vm_mmap+0x2a/0x36
>   [<ffffffe0003cfdde>] elf_map+0x72/0x84
>   [<ffffffe0003d05f8>] load_elf_binary+0x69a/0xec8
>   [<ffffffe000376240>] bprm_execve+0x246/0x53a
>   [<ffffffe00037786c>] kernel_execve+0xe8/0x124
>   [<ffffffe000aecdf2>] run_init_process+0xfa/0x10c
>   [<ffffffe000aece16>] try_to_run_init_process+0x12/0x3c
>   [<ffffffe000afa920>] kernel_init+0xb4/0xf8
>   [<ffffffe000201b80>] ret_from_exception+0x0/0xc
>
> Here is the error injection test code for the above output:
>  drivers/irqchip/irq-riscv-intc.c:
>  static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
>  {
>         unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
> +       u32 tmp; __get_user(tmp, (u32 *)0);
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: Changbin Du <changbin.du@intel.com>
> ---
>  arch/riscv/kernel/entry.S      | 2 +-
>  arch/riscv/kernel/stacktrace.c | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index b9eda3fcbd6d..329cf51fcd4d 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -248,7 +248,7 @@ ret_from_syscall_rejected:
>         andi t0, t0, _TIF_SYSCALL_WORK
>         bnez t0, handle_syscall_trace_exit
>
> -ret_from_exception:
> +ENTRY(ret_from_exception)
>         REG_L s0, PT_STATUS(sp)
>         csrc CSR_STATUS, SR_IE
>  #ifdef CONFIG_TRACE_IRQFLAGS
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index bcfe9eb55f80..75c8dd64fc48 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -16,6 +16,8 @@
>
>  #ifdef CONFIG_FRAME_POINTER
>
> +extern asmlinkage void ret_from_exception(void);
> +
>  void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>                              bool (*fn)(void *, unsigned long), void *arg)
>  {
> @@ -59,6 +61,13 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>                         fp = frame->fp;
>                         pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
>                                                    &frame->ra);
> +                       if (pc == (unsigned long) ret_from_exception) {
I forgot ret_from_syscall because I tested it on the generic_entry
series base. I would merge this patch into the generic_entry series as
an optimization.

> +                               if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
> +                                       break;
> +
> +                               pc = ((struct pt_regs *)sp)->epc;
> +                               fp = ((struct pt_regs *)sp)->s0;
> +                       }
>                 }
>
>         }
> --
> 2.36.1
>


-- 
Best Regards
 Guo Ren
