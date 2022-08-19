Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEFC59A409
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 20:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354813AbiHSRv6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Aug 2022 13:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354825AbiHSRvo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2022 13:51:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E704B79;
        Fri, 19 Aug 2022 10:24:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EBF76170E;
        Fri, 19 Aug 2022 17:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04697C433D6;
        Fri, 19 Aug 2022 17:24:56 +0000 (UTC)
Date:   Fri, 19 Aug 2022 13:25:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn
Subject: Re: [PATCH 1/9] LoongArch/ftrace: Add basic support
Message-ID: <20220819132509.127a1353@gandalf.local.home>
In-Reply-To: <20220819081403.7143-2-zhangqing@loongson.cn>
References: <20220819081403.7143-1-zhangqing@loongson.cn>
        <20220819081403.7143-2-zhangqing@loongson.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 19 Aug 2022 16:13:55 +0800
Qing Zhang <zhangqing@loongson.cn> wrote:

> +#define MCOUNT_STACK_SIZE	(2 * SZREG)
> +#define MCOUNT_S0_OFFSET	(0)
> +#define MCOUNT_RA_OFFSET	(SZREG)
> +
> +	.macro MCOUNT_SAVE_REGS
> +	PTR_ADDI sp, sp, -MCOUNT_STACK_SIZE
> +	PTR_S	s0, sp, MCOUNT_S0_OFFSET
> +	PTR_S	ra, sp, MCOUNT_RA_OFFSET
> +	move	s0, a0
> +	.endm
> +
> +	.macro MCOUNT_RESTORE_REGS
> +	move	a0, s0
> +	PTR_L	ra, sp, MCOUNT_RA_OFFSET
> +	PTR_L	s0, sp, MCOUNT_S0_OFFSET
> +	PTR_ADDI sp, sp, MCOUNT_STACK_SIZE
> +	.endm
> +
> +
> +SYM_FUNC_START(_mcount)
> +	la	t1, ftrace_stub
> +	la	t2, ftrace_trace_function	/* Prepare t2 for (1) */
> +	PTR_L	t2, t2, 0
> +	beq	t1, t2, fgraph_trace
> +
> +	MCOUNT_SAVE_REGS
> +
> +	move	a0, ra				/* arg0: self return address */
> +	move	a1, s0				/* arg1: parent's return address */
> +	jirl	ra, t2, 0			/* (1) call *ftrace_trace_function */
> +
> +	MCOUNT_RESTORE_REGS

You know, if you can implement CONFIG_FTRACE_WITH_ARGS, where the default
function callback gets a ftrace_regs pointer (that only holds what is
needed for the arguments of the function as well as the stack pointer),
then you could also implement function graph on top of that, and remove the
need for the below "fgraph_trace" trampoline.

I'd really would like all architectures to go that way. Also, the
CONFIG_FTRACE_WITH_ARGS is all you need for live kernel patching.

-- Steve


> +
> +fgraph_trace:
> +#ifdef	CONFIG_FUNCTION_GRAPH_TRACER
> +	la	t1, ftrace_stub
> +	la	t3, ftrace_graph_return
> +	PTR_L	t3, t3, 0
> +	bne	t1, t3, ftrace_graph_caller
> +	la	t1, ftrace_graph_entry_stub
> +	la	t3, ftrace_graph_entry
> +	PTR_L	t3, t3, 0
> +	bne	t1, t3, ftrace_graph_caller
> +#endif
> +
> +	.globl ftrace_stub
> +ftrace_stub:
> +	jirl	zero, ra, 0
> +SYM_FUNC_END(_mcount)
> +EXPORT_SYMBOL(_mcount)
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +SYM_FUNC_START(ftrace_graph_caller)
> +	MCOUNT_SAVE_REGS
> +
> +	PTR_ADDI	a0, ra, -4			/* arg0: Callsite self return addr */
> +	PTR_ADDI	a1, sp, MCOUNT_STACK_SIZE	/* arg1: Callsite sp */
> +	move	a2, s0					/* arg2: Callsite parent ra */
> +	bl	prepare_ftrace_return
> +
> +	MCOUNT_RESTORE_REGS
> +	jirl	zero, ra, 0
> +SYM_FUNC_END(ftrace_graph_caller)
