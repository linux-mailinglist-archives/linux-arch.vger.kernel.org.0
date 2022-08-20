Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24B859AA87
	for <lists+linux-arch@lfdr.de>; Sat, 20 Aug 2022 03:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiHTBir (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 21:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243750AbiHTBiq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 21:38:46 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 291F639BA8;
        Fri, 19 Aug 2022 18:38:43 -0700 (PDT)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkOAcOwBjCHYFAA--.25921S3;
        Sat, 20 Aug 2022 09:38:38 +0800 (CST)
Subject: Re: [PATCH 1/9] LoongArch/ftrace: Add basic support
To:     Steven Rostedt <rostedt@goodmis.org>,
        Qing Zhang <zhangqing@loongson.cn>
References: <20220819081403.7143-1-zhangqing@loongson.cn>
 <20220819081403.7143-2-zhangqing@loongson.cn>
 <20220819132509.127a1353@gandalf.local.home>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <246779c0-b834-16a6-ec68-c06d8f9a375d@loongson.cn>
Date:   Sat, 20 Aug 2022 09:38:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220819132509.127a1353@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxkOAcOwBjCHYFAA--.25921S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCF4xJw4Uur4fGFWxXFWUArb_yoW5WryDpr
        yrJanrKa1UtF4a9r4I9wn8Aryaqws3J340krZYgryfCF1DJrs3Cry2yr4DKr93Jw1UCr92
        9340grWfG34av37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 08/20/2022 01:25 AM, Steven Rostedt wrote:

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
> You know, if you can implement CONFIG_FTRACE_WITH_ARGS, where the default
> function callback gets a ftrace_regs pointer (that only holds what is
> needed for the arguments of the function as well as the stack pointer),
> then you could also implement function graph on top of that, and remove the
> need for the below "fgraph_trace" trampoline.
>
> I'd really would like all architectures to go that way. Also, the
> CONFIG_FTRACE_WITH_ARGS is all you need for live kernel patching.
Hi, Steve,

I think we have implemented CONFIG_FTRACE_WITH_ARGS in dynamic ftrace
in the [Patch3/9]. But, for non dynamic ftrace, it is hardly to
implement it. Because the LoongArch compiler gcc treats mount as a
really call, like 'call _mcount(__builtin_return_address(0))'. That
means, they decrease stack, save args to callee saved regs and may
do some optimization before calling mcount. It is difficult to find the
original args and apply changes from tracers.

Thanks,
Jinyang

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

