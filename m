Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BF6643B92
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 03:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiLFC76 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Dec 2022 21:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbiLFC75 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2022 21:59:57 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE61022512
        for <linux-arch@vger.kernel.org>; Mon,  5 Dec 2022 18:59:55 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d82so4545715pfd.11
        for <linux-arch@vger.kernel.org>; Mon, 05 Dec 2022 18:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab8kuhVwWTBvpOQiwmZyZf7s/mXfT6Eb6o4hLBwr+lA=;
        b=j3OwCgaUTPUnSnJm1D1l4qBt9ksLQcUh9+GXI2ojHU4oLznI58uDGTbMbaqHLYeKOB
         b39jczj9xPwTDKzd+FzbnRqZZc6Kt1iW2gWP7K40KQoWfcqMTaV7WGxfhvkM5lUfJuoM
         Wx8Qvb6APgb019OoOY55DzpFX4qKfpnZg2yIAZzNMvWv1AxYudjso7bC8StfUF0nMX2X
         xlycpOvHqF9xd90EJ1CFj4cchlK+kBn7WbTmnOD1LKS73DiJ4CTOXRcujO3Ym64nNShF
         j1KIvpCqjs6m8HyUyLFD9CpJ8PPdd1/frfxMRClmYoCFRAbVBjsd1/V93YQRR8Ri7A2E
         I7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ab8kuhVwWTBvpOQiwmZyZf7s/mXfT6Eb6o4hLBwr+lA=;
        b=TJoWVAf+Cp4UXSaTopaZ8sA72d17wreaSyfrU1e+wTGBQwGhgPx0JD9XTbo7pxreae
         bROpee77cNWYIfD/PVTL5lWaOz5Z53fUAGnql9G6cVzhpdELSVb6yrK5mWdVrYQcYe+8
         6WyvFoQJN1LWHGgMuWf91GcWBh3BhDpEpRvd63mlsl8vzEfG/S8KJMFQVTXDIuyP9RC/
         c3qp+sgPnxjyjU5p86qngfd9Ef0hr5Ndhj3cfS6Ky3VEPh4ozL3oUE8qjt7xeKXg9UUr
         zUat7E67lz5/wnjOG8UuJUpK7xnH+oZHiZBvi9hlC8BWp1q+uhrdfy4nWOSy8KW94jQ5
         XlSg==
X-Gm-Message-State: ANoB5plrETqrwXkdYq4Kjl2xC1pdsIslst0Co2Buos0crH+7StBDQ02v
        8eSSeHseSvyH8Z81g3ylOEsYZQ==
X-Google-Smtp-Source: AA0mqf7nBW/XSqL1hFLVew1yQGXP58mypOtMBKCP9dWT4lMGpXwdTP8yFORF24iK462nhcxrbKhJnw==
X-Received: by 2002:a63:f962:0:b0:477:1bb8:bbf4 with SMTP id q34-20020a63f962000000b004771bb8bbf4mr59094188pgk.19.1670295594913;
        Mon, 05 Dec 2022 18:59:54 -0800 (PST)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709027e0b00b0018957322953sm11250715plm.45.2022.12.05.18.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 18:59:54 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:59:54 -0800 (PST)
X-Google-Original-Date: Mon, 05 Dec 2022 18:59:29 PST (-0800)
Subject:     Re: [PATCH 2/2] riscv: stacktrace: Make walk_stackframe cross pt_regs frame
In-Reply-To: <20221109064937.3643993-3-guoren@kernel.org>
CC:     anup@brainfault.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        peterz@infradead.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org, keescook@chromium.org,
        paulmck@kernel.org, frederic@kernel.org, nsaenzju@redhat.com,
        changbin.du@intel.com, vincent.chen@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@linux.alibaba.com, guoren@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org
Message-ID: <mhng-c6cdc161-cab9-4d2d-acaa-ed81f87c14f3@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 08 Nov 2022 22:49:37 PST (-0800), guoren@kernel.org wrote:
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
>  	andi t0, t0, _TIF_SYSCALL_WORK
>  	bnez t0, handle_syscall_trace_exit
>
> -ret_from_exception:
> +ENTRY(ret_from_exception)

This at least needs an END(), but it should also be converted over to 
some non-function entry flavor.  I converted it over to 
SYM_CODE_START_NOALIGN(), with the cooresponding SYM_CODE_END(), and put 
it on for-next.

>  	REG_L s0, PT_STATUS(sp)
>  	csrc CSR_STATUS, SR_IE
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
>  			     bool (*fn)(void *, unsigned long), void *arg)
>  {
> @@ -59,6 +61,13 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  			fp = frame->fp;
>  			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
>  						   &frame->ra);
> +			if (pc == (unsigned long)ret_from_exception) {
> +				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
> +					break;
> +
> +				pc = ((struct pt_regs *)sp)->epc;
> +				fp = ((struct pt_regs *)sp)->s0;
> +			}
>  		}
>
>  	}
