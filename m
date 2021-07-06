Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA683BCB67
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 13:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhGFLJt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 07:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGFLJs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 07:09:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9A0C061574
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8UwjBoRsP54IHzBu4BK01GPMpoutaNdnTEfiXlxKQwA=; b=jXMGn1yIoF/UYmrbVkINwtsCqc
        WxxvLp5PhVzjmWKWgHOjDcLnI/ON14cBiZQF0pTUxvX60UJQ+2BkeIKn11CheR9kjYaE1cuBTLVdG
        qL0SObxi5LdbUxapT9kXG+LdixcXsO/mzs7O499DC1DTTFfGKOA0KfbKvbLyhtRzWhfnNjFWQMZo5
        BdH6iKtLRVLL4WAmGLOh/mjIH4+mmW3Fpclq/qTzjm6QnsTbf1LsPKU/CFKaB7vGYferd1QJI6rb0
        J2TYWlb310JzrN8qjVXr5xPx6X7qrhDzHuX+h0CXmquPYiZdIVWOIG4tBQtk7ZYsFouLewDl1jti9
        kKA/8+/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0iun-00F1cs-Es; Tue, 06 Jul 2021 11:06:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EB89E300056;
        Tue,  6 Jul 2021 13:06:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D267E200843AD; Tue,  6 Jul 2021 13:06:56 +0200 (CEST)
Date:   Tue, 6 Jul 2021 13:06:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 06/19] LoongArch: Add exception/interrupt handling
Message-ID: <YOQ5UBa0xYf7kAjg@hirez.programming.kicks-ass.net>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-7-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706041820.1536502-7-chenhuacai@loongson.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 06, 2021 at 12:18:07PM +0800, Huacai Chen wrote:
> +	.align	5	/* 32 byte rollback region */
> +SYM_FUNC_START(__arch_cpu_idle)
> +	/* start of rollback region */
> +	LONG_L	t0, tp, TI_FLAGS
> +	nop
> +	andi	t0, t0, _TIF_NEED_RESCHED
> +	bnez	t0, 1f
> +	nop
> +	nop
> +	nop
> +	idle	0
> +	/* end of rollback region */
> +1:
> +	jirl	zero, ra, 0
> +SYM_FUNC_END(__arch_cpu_idle)

> +/*
> + * Common Vectored Interrupt
> + * Complete the register saves and invoke the do_vi() handler
> + */
> +SYM_FUNC_START(except_vec_vi_handler)
> +	la	t1, __arch_cpu_idle
> +	LONG_L  t0, sp, PT_EPC
> +	/* 32 byte rollback region */
> +	ori	t0, t0, 0x1f
> +	xori	t0, t0, 0x1f
> +	bne	t0, t1, 1f
> +	LONG_S  t0, sp, PT_EPC

Seriously, you're having your interrupt handler recover from the idle
race? On a *new* architecture?

> +1:	SAVE_TEMP
> +	SAVE_STATIC
> +	CLI
> +
> +	LONG_L		s0, tp, TI_REGS
> +	LONG_S		sp, tp, TI_REGS
> +
> +	move		s1, sp /* Preserve sp */
> +
> +	/* Get IRQ stack for this CPU */
> +	la		t1, irq_stack
> +	LONG_ADDU	t1, t1, x0
> +	LONG_L		t0, t1, 0
> +
> +	/* Check if already on IRQ stack */
> +	PTR_LI		t1, ~(_THREAD_SIZE-1)
> +	and		t1, t1, sp
> +	beq		t0, t1, 2f
> +
> +	/* Switch to IRQ stack */
> +	li.w		t1, _IRQ_STACK_START
> +	PTR_ADDU	sp, t0, t1
> +
> +	/* Save task's sp on IRQ stack so that unwinding can follow it */
> +	LONG_S		s1, sp, 0
> +2:	la		t0, do_vi
> +	jirl		ra, t0, 0
> +
> +	move		sp, s1 /* Restore sp */
> +	la		t0, ret_from_irq
> +	jirl    	zero, t0, 0
> +SYM_FUNC_END(except_vec_vi_handler)


