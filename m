Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4563632139
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 12:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiKULt6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 06:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiKULtz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 06:49:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF74E24BF1;
        Mon, 21 Nov 2022 03:49:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B30CB80ED4;
        Mon, 21 Nov 2022 11:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17690C43470;
        Mon, 21 Nov 2022 11:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669031389;
        bh=5vI8JvevhgIDvxPX1gOwtUjLBTg3B81ycpocNkF8FV4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gyo6N+ViiZeQM5Bni27qRcz04CNVFXHRibzQsxrNpHzQMMfTxeOND7ewL4ze7+l7S
         FohgPU350VQQ97VXzMgW4Z3aIrrIutlWJxE9FGHRuXY3fZeqehoN6UOBWra3MyzqqP
         uvN63hFWSavY5v59uz2+Dq+90CetNIPLY4cRBU2HDSTGXrfEtqRcdzHJ5BIESsvbsa
         3Fp3qPk3Z+qMwZRymFsYoh8ThphGgvnPgHVjSEmDQ4/lsdleodeG50F6Xsm0mxq3ft
         ivJCuXKhOs1Xspc1kHO9O9Yz93IiFvBfJPbdiyVgsHZHxYeTHlN6OqQ0yXupPlnVxg
         g+5D/ma2CWviw==
Received: by mail-ej1-f44.google.com with SMTP id f18so27946723ejz.5;
        Mon, 21 Nov 2022 03:49:48 -0800 (PST)
X-Gm-Message-State: ANoB5pmoP35RffD0plU+l4XfRu/i24EpyEDIBtuQX2HycoFoWkVpvhbL
        v1ncGlZ1xz5kaeH/RJ+YPWVBpfTqj4HCymTi9pM=
X-Google-Smtp-Source: AA0mqf7IGdpPka84hURv/SGsDGL0UCuUHm7NY7HOxN5XXdgeYhsAILSPcgdgIVHyRUMbB0cJPJfCAD28dQd87hV0gh0=
X-Received: by 2002:a17:906:4a8a:b0:7ad:bc84:2f23 with SMTP id
 x10-20020a1709064a8a00b007adbc842f23mr15741203eju.262.1669031387277; Mon, 21
 Nov 2022 03:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20221109064937.3643993-1-guoren@kernel.org> <20221109064937.3643993-3-guoren@kernel.org>
 <CAJF2gTREDPrr7z-78P5MZavwQZhrgZ8+MoS07agzPMqvf86ipA@mail.gmail.com>
In-Reply-To: <CAJF2gTREDPrr7z-78P5MZavwQZhrgZ8+MoS07agzPMqvf86ipA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 21 Nov 2022 19:49:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT-WQMFttHDPq69mL=xdT+AuvzfHML90iX2eT1noyuUnw@mail.gmail.com>
Message-ID: <CAJF2gTT-WQMFttHDPq69mL=xdT+AuvzfHML90iX2eT1noyuUnw@mail.gmail.com>
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

On Mon, Nov 21, 2022 at 5:53 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Wed, Nov 9, 2022 at 2:50 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The current walk_stackframe with FRAME_POINTER would stop unwinding at
> > ret_from_exception:
> >   BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1518
> >   in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: init
> >   CPU: 0 PID: 1 Comm: init Not tainted 5.10.113-00021-g15c15974895c-dirty #192
> >   Call Trace:
> >   [<ffffffe0002038c8>] walk_stackframe+0x0/0xee
> >   [<ffffffe000aecf48>] show_stack+0x32/0x4a
> >   [<ffffffe000af1618>] dump_stack_lvl+0x72/0x8e
> >   [<ffffffe000af1648>] dump_stack+0x14/0x1c
> >   [<ffffffe000239ad2>] ___might_sleep+0x12e/0x138
> >   [<ffffffe000239aec>] __might_sleep+0x10/0x18
> >   [<ffffffe000afe3fe>] down_read+0x22/0xa4
> >   [<ffffffe000207588>] do_page_fault+0xb0/0x2fe
> >   [<ffffffe000201b80>] ret_from_exception+0x0/0xc
> >
> > The optimization would help walk_stackframe cross the pt_regs frame and
> > get more backtrace of debug info:
> >   BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1518
> >   in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: init
> >   CPU: 0 PID: 1 Comm: init Not tainted 5.10.113-00021-g15c15974895c-dirty #192
> >   Call Trace:
> >   [<ffffffe0002038c8>] walk_stackframe+0x0/0xee
> >   [<ffffffe000aecf48>] show_stack+0x32/0x4a
> >   [<ffffffe000af1618>] dump_stack_lvl+0x72/0x8e
> >   [<ffffffe000af1648>] dump_stack+0x14/0x1c
> >   [<ffffffe000239ad2>] ___might_sleep+0x12e/0x138
> >   [<ffffffe000239aec>] __might_sleep+0x10/0x18
> >   [<ffffffe000afe3fe>] down_read+0x22/0xa4
> >   [<ffffffe000207588>] do_page_fault+0xb0/0x2fe
> >   [<ffffffe000201b80>] ret_from_exception+0x0/0xc
> >   [<ffffffe000613c06>] riscv_intc_irq+0x1a/0x72
> >   [<ffffffe000201b80>] ret_from_exception+0x0/0xc
> >   [<ffffffe00033f44a>] vma_link+0x54/0x160
> >   [<ffffffe000341d7a>] mmap_region+0x2cc/0x4d0
> >   [<ffffffe000342256>] do_mmap+0x2d8/0x3ac
> >   [<ffffffe000326318>] vm_mmap_pgoff+0x70/0xb8
> >   [<ffffffe00032638a>] vm_mmap+0x2a/0x36
> >   [<ffffffe0003cfdde>] elf_map+0x72/0x84
> >   [<ffffffe0003d05f8>] load_elf_binary+0x69a/0xec8
> >   [<ffffffe000376240>] bprm_execve+0x246/0x53a
> >   [<ffffffe00037786c>] kernel_execve+0xe8/0x124
> >   [<ffffffe000aecdf2>] run_init_process+0xfa/0x10c
> >   [<ffffffe000aece16>] try_to_run_init_process+0x12/0x3c
> >   [<ffffffe000afa920>] kernel_init+0xb4/0xf8
> >   [<ffffffe000201b80>] ret_from_exception+0x0/0xc
> >
> > Here is the error injection test code for the above output:
> >  drivers/irqchip/irq-riscv-intc.c:
> >  static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
> >  {
> >         unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
> > +       u32 tmp; __get_user(tmp, (u32 *)0);
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > Cc: Changbin Du <changbin.du@intel.com>
> > ---
> >  arch/riscv/kernel/entry.S      | 2 +-
> >  arch/riscv/kernel/stacktrace.c | 9 +++++++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index b9eda3fcbd6d..329cf51fcd4d 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -248,7 +248,7 @@ ret_from_syscall_rejected:
> >         andi t0, t0, _TIF_SYSCALL_WORK
> >         bnez t0, handle_syscall_trace_exit
> >
> > -ret_from_exception:
> > +ENTRY(ret_from_exception)
> >         REG_L s0, PT_STATUS(sp)
> >         csrc CSR_STATUS, SR_IE
> >  #ifdef CONFIG_TRACE_IRQFLAGS
> > diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> > index bcfe9eb55f80..75c8dd64fc48 100644
> > --- a/arch/riscv/kernel/stacktrace.c
> > +++ b/arch/riscv/kernel/stacktrace.c
> > @@ -16,6 +16,8 @@
> >
> >  #ifdef CONFIG_FRAME_POINTER
> >
> > +extern asmlinkage void ret_from_exception(void);
> > +
> >  void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
> >                              bool (*fn)(void *, unsigned long), void *arg)
> >  {
> > @@ -59,6 +61,13 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
> >                         fp = frame->fp;
> >                         pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
> >                                                    &frame->ra);
> > +                       if (pc == (unsigned long) ret_from_exception) {
> I forgot ret_from_syscall because I tested it on the generic_entry
> series base. I would merge this patch into the generic_entry series as
> an optimization.
No, the patch is correct. The ret_from_syscall is unnecessary because
it's from user space.

>
> > +                               if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
> > +                                       break;
> > +
> > +                               pc = ((struct pt_regs *)sp)->epc;
> > +                               fp = ((struct pt_regs *)sp)->s0;
> > +                       }
> >                 }
> >
> >         }
> > --
> > 2.36.1
> >
>
>
> --
> Best Regards
>  Guo Ren



-- 
Best Regards
 Guo Ren
