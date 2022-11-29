Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FBD63B905
	for <lists+linux-arch@lfdr.de>; Tue, 29 Nov 2022 05:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiK2EPm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 28 Nov 2022 23:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbiK2EPl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Nov 2022 23:15:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91D54EC0F;
        Mon, 28 Nov 2022 20:15:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38C7BB81178;
        Tue, 29 Nov 2022 04:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4F6C433C1;
        Tue, 29 Nov 2022 04:15:34 +0000 (UTC)
Date:   Mon, 28 Nov 2022 23:15:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH 3/3] compiler: inline does not imply notrace
Message-ID: <20221128231532.40210855@gandalf.local.home>
In-Reply-To: <4BDE3655-CCC3-412B-9DDB-226485113706@vmware.com>
References: <20221122195329.252654-1-namit@vmware.com>
        <20221122195329.252654-4-namit@vmware.com>
        <de999ab8-78ff-44f7-aacc-68561897c6e2@app.fastmail.com>
        <B764D38F-470D-4022-A818-73814F442473@vmware.com>
        <4BDE3655-CCC3-412B-9DDB-226485113706@vmware.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 29 Nov 2022 02:36:22 +0000
Nadav Amit <namit@vmware.com> wrote:

> On Nov 22, 2022, at 12:51 PM, Nadav Amit <namit@vmware.com> wrote:
> 
> > But more importantly, the current “inline”->”notrace” solution just papers
> > over missing “notrace” annotations. Anyone can remove the “inline” at any
> > given moment since there is no direct (or indirect) relationship between
> > “inline” and “notrace”. It seems to me all random and bound to fail at some
> > point.  
> 
> Peter, Steven, (and others),
> 
> Beyond the issues that are addressed in this patch-set, I encountered one
> more, which reiterates the fact that the heuristics of marking “inline”
> functions as “notrace” is not good enough.
> 
> Before I send a patch, I would like to get your feedback. I include a splat
> below. It appeaers the execution might get stuck since some functions that
> can be used for function tracing can be traced themselves.
> 
> For example, __kernel_text_address() and unwind_get_return_address() are
> traceable. I think that we need to disallow the tracing of all functions
> that are called directly and indirectly from function_stack_trace_call()
> (i.e., they are in the dynamic extent of function_stack_trace_call).

How did this happen. It should be able to handle recursion:

static void
function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
			  struct ftrace_ops *op, struct ftrace_regs *fregs)
{
	struct trace_array *tr = op->private;
	struct trace_array_cpu *data;
	unsigned long flags;
	long disabled;
	int cpu;
	unsigned int trace_ctx;

	if (unlikely(!tr->function_enabled))
		return;

	/*
	 * Need to use raw, since this must be called before the
	 * recursive protection is performed.
	 */
	local_irq_save(flags);
	cpu = raw_smp_processor_id();
	data = per_cpu_ptr(tr->array_buffer.data, cpu);
	disabled = atomic_inc_return(&data->disabled);

	if (likely(disabled == 1)) { <<<---- This stops recursion

		trace_ctx = tracing_gen_ctx_flags(flags);
		trace_function(tr, ip, parent_ip, trace_ctx);
		__trace_stack(tr, trace_ctx, STACK_SKIP);
	}

	atomic_dec(&data->disabled);
	local_irq_restore(flags);
}

Each of the stack trace functions may recurse back into this function, but
it will not recurse further. How did it crash?

-- Steve


> 
> In the lack of a proper automated static analysis tool for the matter, I
> suggest the following solution, but I would like to check that you are ok
> with the granularity of the “notrace” as I propose. Again, note that this is
> not caused by this “inline” patch, but an issue that existed before.
> 
> -- >8 --  
> 
> Author: Nadav Amit <namit@vmware.com>
> Date:   Tue Nov 29 02:25:12 2022 +0000
> 
>     trace: Disable tracing of code called from function_stack_trace_call()
>     
>     Signed-off-by: Nadav Amit <namit@vmware.com>
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index a20a5ebfacd7..185933222d08 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -21,6 +21,10 @@ CFLAGS_REMOVE_ftrace.o = -pg
>  CFLAGS_REMOVE_early_printk.o = -pg
>  CFLAGS_REMOVE_head64.o = -pg
>  CFLAGS_REMOVE_sev.o = -pg
> +CFLAGS_REMOVE_unwind_frame.o = -pg
> +CFLAGS_REMOVE_unwind_guess.o = -pg
> +CFLAGS_REMOVE_unwind_orc.o = -pg
> +CFLAGS_REMOVE_stacktrace.o = -pg
>  endif
>  
>  KASAN_SANITIZE_head$(BITS).o                           := n
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 318789c728d3..d688eab1e1f8 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -19,6 +19,8 @@ obj-$(CONFIG_MULTIUSER) += groups.o
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not trace internal ftrace files
>  CFLAGS_REMOVE_irq_work.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_stacktrace.o = $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_extable.o = $(CC_FLAGS_FTRACE)
>  endif
>  
>  # Prevents flicker of uninteresting __do_softirq()/__local_bh_disable_ip()
> 
> 
> ---
> 
> 
> [531394.447185] sched: RT throttling activated
> [531394.874541] NMI watchdog: Watchdog detected hard LOCKUP on cpu 26
> [531394.874745] Modules linked in: zram
> [531394.875224] CPU: 26 PID: 0 Comm: swapper/26 Not tainted 6.0.0-rc6umem+ #29
> [531394.875426] Hardware name: Cisco Systems Inc UCSC-C220-M5SX/UCSC-C220-M5SX, BIOS C220M5.4.0.1i.0.0522190226 05/22/2019
> [531394.875623] RIP: 0010:poke_int3_handler (arch/x86/kernel/alternative.c:1435) 
> [531394.875903] Code: 45 01 48 8b 0d c8 0a 45 01 49 8d 70 ff 83 f8 01 7f 1c 48 63 39 31 c0 48 81 c7 00 00 00 81 48 39 fe 74 3c f0 ff 0d b3 0a 45 01 <c3> 31 c0 c3 49 89 ca 49 89 c1 49 d1 e9 4c 89 c9 48 c1 e1 04 4c 01
> All code
> ========
>    0:	45 01 48 8b          	add    %r9d,-0x75(%r8)
>    4:	0d c8 0a 45 01       	or     $0x1450ac8,%eax
>    9:	49 8d 70 ff          	lea    -0x1(%r8),%rsi
>    d:	83 f8 01             	cmp    $0x1,%eax
>   10:	7f 1c                	jg     0x2e
>   12:	48 63 39             	movslq (%rcx),%rdi
>   15:	31 c0                	xor    %eax,%eax
>   17:	48 81 c7 00 00 00 81 	add    $0xffffffff81000000,%rdi
>   1e:	48 39 fe             	cmp    %rdi,%rsi
>   21:	74 3c                	je     0x5f
>   23:	f0 ff 0d b3 0a 45 01 	lock decl 0x1450ab3(%rip)        # 0x1450add
>   2a:*	c3                   	ret    		<-- trapping instruction
>   2b:	31 c0                	xor    %eax,%eax
>   2d:	c3                   	ret    
>   2e:	49 89 ca             	mov    %rcx,%r10
>   31:	49 89 c1             	mov    %rax,%r9
>   34:	49 d1 e9             	shr    %r9
>   37:	4c 89 c9             	mov    %r9,%rcx
>   3a:	48 c1 e1 04          	shl    $0x4,%rcx
>   3e:	4c                   	rex.WR
>   3f:	01                   	.byte 0x1
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	c3                   	ret    
>    1:	31 c0                	xor    %eax,%eax
>    3:	c3                   	ret    
>    4:	49 89 ca             	mov    %rcx,%r10
>    7:	49 89 c1             	mov    %rax,%r9
>    a:	49 d1 e9             	shr    %r9
>    d:	4c 89 c9             	mov    %r9,%rcx
>   10:	48 c1 e1 04          	shl    $0x4,%rcx
>   14:	4c                   	rex.WR
>   15:	01                   	.byte 0x1
> [531394.876031] RSP: 0018:ffffc9000cd387b0 EFLAGS: 00000003
> [531394.876320] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffc9000cd388a8
> [531394.876482] RDX: ffffc9000cd387d8 RSI: ffffffff812ba310 RDI: ffffffffc0409094
> [531394.876652] RBP: ffffc9000cd387c8 R08: ffffffffc0409099 R09: 0000000000000000
> [531394.876782] R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000cd387d8
> [531394.876927] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [531394.877180] FS:  0000000000000000(0000) GS:ffff88afdf900000(0000) knlGS:0000000000000000
> [531394.877371] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [531394.877503] CR2: 00007efd1e47b01c CR3: 0000000006a0a001 CR4: 00000000007706e0
> [531394.877641] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [531394.877822] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [531394.877993] PKRU: 55555554
> [531394.878164] Call Trace:
> [531394.878356]  <IRQ>
> [531394.878573] ? exc_int3 (arch/x86/kernel/traps.c:817) 
> [531394.879306] asm_exc_int3 (./arch/x86/include/asm/idtentry.h:569) 
> [531394.879725] RIP: 0010:function_stack_trace_call (kernel/trace/trace_functions.c:219) 
> [531394.880058] Code: 2b 81 48 c7 c7 e0 e2 33 83 e8 1c fa fd ff 48 c7 c7 80 e6 1c 83 e8 40 61 fe 00 5d c3 cc cc cc cc cc cc cc cc cc cc cc cc cc cc <55> 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 ec 08 4c 8b 62 18 41
> All code
> ========
>    0:	2b 81 48 c7 c7 e0    	sub    -0x1f3838b8(%rcx),%eax
>    6:	e2 33                	loop   0x3b
>    8:	83 e8 1c             	sub    $0x1c,%eax
>    b:	fa                   	cli    
>    c:	fd                   	std    
>    d:	ff 48 c7             	decl   -0x39(%rax)
>   10:	c7 80 e6 1c 83 e8 40 	movl   $0xfe6140,-0x177ce31a(%rax)
>   17:	61 fe 00 
>   1a:	5d                   	pop    %rbp
>   1b:	c3                   	ret    
>   1c:	cc                   	int3   
>   1d:	cc                   	int3   
>   1e:	cc                   	int3   
>   1f:	cc                   	int3   
>   20:	cc                   	int3   
>   21:	cc                   	int3   
>   22:	cc                   	int3   
>   23:	cc                   	int3   
>   24:	cc                   	int3   
>   25:	cc                   	int3   
>   26:	cc                   	int3   
>   27:	cc                   	int3   
>   28:	cc                   	int3   
>   29:	cc                   	int3   
>   2a:*	55                   	push   %rbp		<-- trapping instruction
>   2b:	48 89 e5             	mov    %rsp,%rbp
>   2e:	41 57                	push   %r15
>   30:	41 56                	push   %r14
>   32:	41 55                	push   %r13
>   34:	41 54                	push   %r12
>   36:	53                   	push   %rbx
>   37:	48 83 ec 08          	sub    $0x8,%rsp
>   3b:	4c 8b 62 18          	mov    0x18(%rdx),%r12
>   3f:	41                   	rex.B
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	55                   	push   %rbp
>    1:	48 89 e5             	mov    %rsp,%rbp
>    4:	41 57                	push   %r15
>    6:	41 56                	push   %r14
>    8:	41 55                	push   %r13
>    a:	41 54                	push   %r12
>    c:	53                   	push   %rbx
>    d:	48 83 ec 08          	sub    $0x8,%rsp
>   11:	4c 8b 62 18          	mov    0x18(%rdx),%r12
>   15:	41                   	rex.B
> [531394.880225] RSP: 0018:ffffc9000cd388a8 EFLAGS: 00000082
> [531394.880538] RAX: 0000000000000002 RBX: ffffc9000cd389a8 RCX: ffffc9000cd388b0
> [531394.880702] RDX: ffffffff831cbec0 RSI: ffffffff8111893f RDI: ffffffff811b2c80
> [531394.880884] RBP: ffffc9000cd38958 R08: ffffc900082f7f48 R09: 0000000000000001
> [531394.881055] R10: 0000000000000e00 R11: 0000000000000001 R12: ffffc9000cd38a50
> [531394.881225] R13: 0000000000000000 R14: ffff889846ecc080 R15: 0000000000000004
> [531394.883694] ? unwind_get_return_address (arch/x86/kernel/unwind_frame.c:19 arch/x86/kernel/unwind_frame.c:14) 
> [531394.883984] ? kernel_text_address (kernel/extable.c:78) 
> [531394.885410]  ? 0xffffffffc0409095
> [531394.886432]  ? 0xffffffffc0409099
> [531394.887278]  ? 0xffffffffc0409099
> [531394.889561] ? __trace_stack (kernel/trace/trace.c:3119) 
> [531394.890036] ? __kernel_text_address (kernel/extable.c:78) 
> [531394.891196] __kernel_text_address (kernel/extable.c:78) 
> [531394.891658] unwind_get_return_address (arch/x86/kernel/unwind_frame.c:19 arch/x86/kernel/unwind_frame.c:14) 
> [531394.892112] ? __kernel_text_address (kernel/extable.c:78) 
> [531394.892382] ? unwind_get_return_address (arch/x86/kernel/unwind_frame.c:19 arch/x86/kernel/unwind_frame.c:14) 
> [531394.892789] ? write_profile (kernel/stacktrace.c:83) 
> [531394.893260] arch_stack_walk (arch/x86/kernel/stacktrace.c:26) 
> [531394.895650] ? __trace_stack (kernel/trace/trace.c:3119) 
> [531394.897209] stack_trace_save (kernel/stacktrace.c:123) 
> [531394.898344] __ftrace_trace_stack (kernel/trace/trace.c:3061) 
> [531394.899500] ? rt_mutex_postunlock (kernel/printk/printk.c:2894) 
> [531394.899975] __trace_stack (kernel/trace/trace.c:3119) 
> [531394.901025] function_stack_trace_call (./arch/x86/include/asm/atomic.h:108 ./include/linux/atomic/atomic-instrumented.h:258 kernel/trace/trace_functions.c:245) 
> [531394.901356] ? fbcon_redraw.constprop.0 (drivers/video/fbdev/core/fbcon.c:1661) 
> [531394.902748]  0xffffffffc0409099
> [531394.904289] ? fb_get_color_depth (drivers/video/fbdev/core/fbmem.c:92) 
> [531394.906173] ? console_conditional_schedule (kernel/printk/printk.c:2895) 
> [531394.907244] console_conditional_schedule (kernel/printk/printk.c:2895) 
> [531394.907727] fbcon_redraw.constprop.0 (drivers/video/fbdev/core/fbcon.c:1661) 
> [531394.908200] ? console_conditional_schedule (kernel/printk/printk.c:2895) 
> [531394.908506] ? fbcon_redraw.constprop.0 (drivers/video/fbdev/core/fbcon.c:1661) 
> [531394.911230] fbcon_scroll (drivers/video/fbdev/core/fbcon.c:1838) 
> [531394.912743] con_scroll (drivers/tty/vt/vt.c:630 (discriminator 1)) 
> [531394.914360] lf (drivers/tty/vt/vt.c:1507) 
> [531394.914680] ? lf (drivers/tty/vt/vt.c:1502) 
> [531394.915779] vt_console_print (drivers/tty/vt/vt.c:3126) 
> [531394.918248] console_emit_next_record.constprop.0 (kernel/printk/printk.c:1945 kernel/printk/printk.c:2732) 
> [531394.922365] console_unlock (kernel/printk/printk.c:2794 kernel/printk/printk.c:2861) 
> [531394.924129] vprintk_emit (kernel/printk/printk.c:2272) 
> [531394.925782] vprintk_default (kernel/printk/printk.c:2283) 
> [531394.926306] vprintk (kernel/printk/printk_safe.c:50) 
> [531394.926943] _printk (kernel/printk/printk.c:2296) 
> [531394.929016] perf_duration_warn.cold (kernel/events/core.c:510 kernel/events/core.c:508) 
> [531394.929518] irq_work_single (kernel/irq_work.c:211) 
> [531394.930449] irq_work_run_list (kernel/irq_work.c:241 (discriminator 3)) 
> [531394.931169] irq_work_run (kernel/irq_work.c:253) 
> [531394.931816] __sysvec_irq_work (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./arch/x86/include/asm/trace/irq_vectors.h:64 arch/x86/kernel/irq_work.c:23) 
> [531394.932259] sysvec_irq_work (arch/x86/kernel/irq_work.c:17 (discriminator 14)) 
> [531394.932660]  </IRQ>
> [531394.932854]  <TASK>
> [531394.933607] asm_sysvec_irq_work (./arch/x86/include/asm/idtentry.h:675)
> 
> 
> 
> 
> 

