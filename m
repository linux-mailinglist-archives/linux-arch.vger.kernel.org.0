Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDF459AA83
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 03:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245491AbiHTBfd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 21:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245489AbiHTBfc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 21:35:32 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F364ED3EF1;
        Fri, 19 Aug 2022 18:35:30 -0700 (PDT)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkOBbOgBjaXUFAA--.25913S3;
        Sat, 20 Aug 2022 09:35:26 +0800 (CST)
Subject: Re: [PATCH 1/9] LoongArch/ftrace: Add basic support
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn
References: <20220819081403.7143-1-zhangqing@loongson.cn>
 <20220819081403.7143-2-zhangqing@loongson.cn>
 <20220819132509.127a1353@gandalf.local.home>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <4b422c01-d8a1-8543-9f06-25a955f3686d@loongson.cn>
Date:   Sat, 20 Aug 2022 09:35:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220819132509.127a1353@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxkOBbOgBjaXUFAA--.25913S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1fAFyxCr1UKr4rAFy8uFg_yoW5Jr1fpr
        yrAanFgay7tF4Ykr4I9wn8AryYqrn3J340kws5KrySkFn8Jrs3Gry2yr4DKrZ3J3WUAr9a
        va4xWrWfG3yav37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfUoPEfUUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2022/8/20 上午1:25, Steven Rostedt wrote:
> On Fri, 19 Aug 2022 16:13:55 +0800
> Qing Zhang <zhangqing@loongson.cn> wrote:
> 
>> +#define MCOUNT_STACK_SIZE	(2 * SZREG)
>> +#define MCOUNT_S0_OFFSET	(0)
>> +#define MCOUNT_RA_OFFSET	(SZREG)
>> +
>> +	.macro MCOUNT_SAVE_REGS
>> +	PTR_ADDI sp, sp, -MCOUNT_STACK_SIZE
>> +	PTR_S	s0, sp, MCOUNT_S0_OFFSET
>> +	PTR_S	ra, sp, MCOUNT_RA_OFFSET
>> +	move	s0, a0
>> +	.endm
>> +
>> +	.macro MCOUNT_RESTORE_REGS
>> +	move	a0, s0
>> +	PTR_L	ra, sp, MCOUNT_RA_OFFSET
>> +	PTR_L	s0, sp, MCOUNT_S0_OFFSET
>> +	PTR_ADDI sp, sp, MCOUNT_STACK_SIZE
>> +	.endm
>> +
>> +
>> +SYM_FUNC_START(_mcount)
>> +	la	t1, ftrace_stub
>> +	la	t2, ftrace_trace_function	/* Prepare t2 for (1) */
>> +	PTR_L	t2, t2, 0
>> +	beq	t1, t2, fgraph_trace
>> +
>> +	MCOUNT_SAVE_REGS
>> +
>> +	move	a0, ra				/* arg0: self return address */
>> +	move	a1, s0				/* arg1: parent's return address */
>> +	jirl	ra, t2, 0			/* (1) call *ftrace_trace_function */
>> +
>> +	MCOUNT_RESTORE_REGS
> 
> You know, if you can implement CONFIG_FTRACE_WITH_ARGS, where the default
> function callback gets a ftrace_regs pointer (that only holds what is
> needed for the arguments of the function as well as the stack pointer),
> then you could also implement function graph on top of that, and remove the
> need for the below "fgraph_trace" trampoline.
> 
> I'd really would like all architectures to go that way. Also, the
> CONFIG_FTRACE_WITH_ARGS is all you need for live kernel patching.
> 
Hi, Steve
I will add the implementation of CONFIG_FTRACE_WITH_ARGS in v2.

Thanks,
- Qing
> -- Steve
> 
> 
>> +
>> +fgraph_trace:
>> +#ifdef	CONFIG_FUNCTION_GRAPH_TRACER
>> +	la	t1, ftrace_stub
>> +	la	t3, ftrace_graph_return
>> +	PTR_L	t3, t3, 0
>> +	bne	t1, t3, ftrace_graph_caller
>> +	la	t1, ftrace_graph_entry_stub
>> +	la	t3, ftrace_graph_entry
>> +	PTR_L	t3, t3, 0
>> +	bne	t1, t3, ftrace_graph_caller
>> +#endif
>> +
>> +	.globl ftrace_stub
>> +ftrace_stub:
>> +	jirl	zero, ra, 0
>> +SYM_FUNC_END(_mcount)
>> +EXPORT_SYMBOL(_mcount)
>> +
>> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
>> +SYM_FUNC_START(ftrace_graph_caller)
>> +	MCOUNT_SAVE_REGS
>> +
>> +	PTR_ADDI	a0, ra, -4			/* arg0: Callsite self return addr */
>> +	PTR_ADDI	a1, sp, MCOUNT_STACK_SIZE	/* arg1: Callsite sp */
>> +	move	a2, s0					/* arg2: Callsite parent ra */
>> +	bl	prepare_ftrace_return
>> +
>> +	MCOUNT_RESTORE_REGS
>> +	jirl	zero, ra, 0
>> +SYM_FUNC_END(ftrace_graph_caller)

