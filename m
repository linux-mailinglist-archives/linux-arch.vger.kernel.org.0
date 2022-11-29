Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D2463C350
	for <lists+linux-arch@lfdr.de>; Tue, 29 Nov 2022 16:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiK2PGy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Tue, 29 Nov 2022 10:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiK2PGx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Nov 2022 10:06:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFA2421A6;
        Tue, 29 Nov 2022 07:06:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15186617A0;
        Tue, 29 Nov 2022 15:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7237EC433D6;
        Tue, 29 Nov 2022 15:06:49 +0000 (UTC)
Date:   Tue, 29 Nov 2022 10:06:47 -0500
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
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] compiler: inline does not imply notrace
Message-ID: <20221129100647.4957579e@gandalf.local.home>
In-Reply-To: <2CFF9131-48E9-44D3-93CA-976C47106092@vmware.com>
References: <20221122195329.252654-1-namit@vmware.com>
        <20221122195329.252654-4-namit@vmware.com>
        <de999ab8-78ff-44f7-aacc-68561897c6e2@app.fastmail.com>
        <B764D38F-470D-4022-A818-73814F442473@vmware.com>
        <4BDE3655-CCC3-412B-9DDB-226485113706@vmware.com>
        <20221128231532.40210855@gandalf.local.home>
        <2CFF9131-48E9-44D3-93CA-976C47106092@vmware.com>
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

On Tue, 29 Nov 2022 04:25:38 +0000
Nadav Amit <namit@vmware.com> wrote:


> I will need to further debug it, but this issue does not occur every time.
> 
> The kernel didn’t crash exactly - it’s more of a deadlock. I have lockdep
> enabled, so it is not a deadlock that lockdep knows. Could it be that
> somehow things just slowed down due to IPIs and mostly-disabled IRQs? I have
> no idea. I would need to recreate the scenario. 

You have lockdep enabled and you are running function tracing with stack
trace on? So you are doing a stack trace on *every* function that is traced?

I don't think you hit a deadlock, I think you hit a live lock. You could
possibly slow the system down so much that when an interrupt finishes it's
time for it to be triggered again, and you never make forward progress.

> 
> For the record, I tried to saved some details in the previous email. It was
> kind of hard to understand what’s going on on the other cores, since the
> trace of other cores was interleaved. I extract the parts from that I think
> the refer to the another CPU (yes, the output is really slow, as seen in the
> timestamps):
> 
> [531413.923628] Code: 00 00 31 c0 eb f1 0f 1f 80 00 00 00 00 e8 1b 2e 16 3e 55 48 89 e5 c6 07 00 0f 1f 00 f7 c6 00 02 00 00 74 06 fb 0f 1f 44 00 00 <bf> 01 00 00 00 e8 99 da f1 fe 65 8b 05 f2 99 d7 7d 85 c0 74 02 5d
> 
> All code
> ========
> 0: 00 00 add %al,(%rax)
> 2: 31 c0 xor %eax,%eax
> 4: eb f1 jmp 0xfffffffffffffff7
> 6: 0f 1f 80 00 00 00 00 nopl 0x0(%rax)
> d: e8 1b 2e 16 3e call 0x3e162e2d
> 12: 55 push %rbp
> 13: 48 89 e5 mov %rsp,%rbp
> 16: c6 07 00 movb $0x0,(%rdi)
> 19: 0f 1f 00 nopl (%rax)
> 1c: f7 c6 00 02 00 00 test $0x200,%esi
> 22: 74 06 je 0x2a
> 24: fb sti 
> 25: 0f 1f 44 00 00 nopl 0x0(%rax,%rax,1)
> 2a:* bf 01 00 00 00 mov $0x1,%edi <-- trapping instruction
> 2f: e8 99 da f1 fe call 0xfffffffffef1dacd
> 34: 65 8b 05 f2 99 d7 7d mov %gs:0x7dd799f2(%rip),%eax # 0x7dd79a2d
> 3b: 85 c0 test %eax,%eax
> 3d: 74 02 je 0x41
> 3f: 5d pop %rbp
> 
> Code starting with the faulting instruction
> ===========================================
> 0: bf 01 00 00 00 mov $0x1,%edi
> 5: e8 99 da f1 fe call 0xfffffffffef1daa3
> a: 65 8b 05 f2 99 d7 7d mov %gs:0x7dd799f2(%rip),%eax # 0x7dd79a03
> 11: 85 c0 test %eax,%eax
> 13: 74 02 je 0x17
> 15: 5d pop %rbp
> 
> [531414.066765] RSP: 0018:ffffc9000c9a77d8 EFLAGS: 00000206
> [531414.077943] RIP: 0010:smp_call_function_many_cond (kernel/smp.c:443 kernel/smp.c:988) 
> [531416.987351] on_each_cpu_cond_mask (kernel/smp.c:1155) 
> [531416.205862] ? text_poke_memset (arch/x86/kernel/alternative.c:1296) 
> [531416.681294] ? text_poke_memset (arch/x86/kernel/alternative.c:1296) 
> [531417.468443] text_poke_bp_batch (arch/x86/kernel/alternative.c:1553) 
> [531418.939923] arch_ftrace_update_trampoline (arch/x86/kernel/ftrace.c:500)
> [531419.882055] ? ftrace_no_pid_write (kernel/trace/ftrace.c:7864) 
> [531420.510376] ftrace_update_pid_func (kernel/trace/ftrace.c:374 (discriminator 1))
> [531420.784703] ftrace_pid_open (kernel/trace/ftrace.c:2918 kernel/trace/ftrace.c:2932 kernel/trace/ftrace.c:7725 kernel/trace/ftrace.c:7835 kernel/trace/ftrace.c:7865) 
> [531421.851294] vfs_open (fs/open.c:1017)
> 
> 
> 

Do you have an issue with normal function tracing, and not tracing every
function.

I should also add this, because it detects recursion faster than the
atomic_inc_return() does.

-- Steve

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 9f1bfbe105e8..93ec756dc24b 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -221,12 +221,18 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 	struct trace_array_cpu *data;
 	unsigned long flags;
 	long disabled;
+	int bit;
 	int cpu;
 	unsigned int trace_ctx;
 
 	if (unlikely(!tr->function_enabled))
 		return;
 
+	/* Faster than atomic_inc_return() */
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0)
+		return;
+
 	/*
 	 * Need to use raw, since this must be called before the
 	 * recursive protection is performed.
@@ -244,6 +250,7 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	atomic_dec(&data->disabled);
 	local_irq_restore(flags);
+	ftrace_test_recursion_unlock(bit);
 }
 
 static inline bool is_repeat_check(struct trace_array *tr,
