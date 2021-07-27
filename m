Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0733D7841
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 16:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhG0ONC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 10:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbhG0ONB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 10:13:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CBAC061798
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 07:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VnK52OWYi84+uO266Vk3zzmCHEf63b7EE1GA3SbnZ98=; b=n+4ImEHWH4j3Vxly/qqLXnyOid
        AqduGSypjaToKFYior6+O2rN50YOt/pUyEdfJq1QqIAWlR56JA73HR28bFN0v8qaf5QiI7dFYwk9p
        H1j/SEkr2oAJw8QflLFeEp/5mkAR5+NrimKjqjGmqZWMSG49pUZdxQ1l/4Jgb3sojOts+VpUweZhm
        3qxnk/XfSlvi4Xft2Gdo2IcP31MnGyuCCUt8xrlOI9rvIjli3gCkOwEK9U/396SFOs8x/EYZqG7ii
        55QbiJ5KR800S4Uthdauuaqoyg39Nv86svpkZMkQCKG6BsfV6z2zLpKwsTkq4LJYbTrDgk/w2ewhe
        cnP6HchA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8Nmc-00F5Ot-1J; Tue, 27 Jul 2021 14:10:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0798B300233;
        Tue, 27 Jul 2021 16:10:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C54D921398335; Tue, 27 Jul 2021 16:10:07 +0200 (CEST)
Date:   Tue, 27 Jul 2021 16:10:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 06/19] LoongArch: Add exception/interrupt handling
Message-ID: <YQATv/MahhrKUu8Z@hirez.programming.kicks-ass.net>
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-7-chenhuacai@loongson.cn>
 <YOQ5UBa0xYf7kAjg@hirez.programming.kicks-ass.net>
 <1625665981.7hbs7yesxx.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625665981.7hbs7yesxx.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 07, 2021 at 11:56:37PM +1000, Nicholas Piggin wrote:
> Excerpts from Peter Zijlstra's message of July 6, 2021 9:06 pm:
> > On Tue, Jul 06, 2021 at 12:18:07PM +0800, Huacai Chen wrote:
> >> +	.align	5	/* 32 byte rollback region */
> >> +SYM_FUNC_START(__arch_cpu_idle)
> >> +	/* start of rollback region */
> >> +	LONG_L	t0, tp, TI_FLAGS
> >> +	nop
> >> +	andi	t0, t0, _TIF_NEED_RESCHED
> >> +	bnez	t0, 1f
> >> +	nop
> >> +	nop
> >> +	nop
> >> +	idle	0
> >> +	/* end of rollback region */
> >> +1:
> >> +	jirl	zero, ra, 0
> >> +SYM_FUNC_END(__arch_cpu_idle)
> > 
> >> +/*
> >> + * Common Vectored Interrupt
> >> + * Complete the register saves and invoke the do_vi() handler
> >> + */
> >> +SYM_FUNC_START(except_vec_vi_handler)
> >> +	la	t1, __arch_cpu_idle
> >> +	LONG_L  t0, sp, PT_EPC
> >> +	/* 32 byte rollback region */
> >> +	ori	t0, t0, 0x1f
> >> +	xori	t0, t0, 0x1f
> >> +	bne	t0, t1, 1f
> >> +	LONG_S  t0, sp, PT_EPC
> > 
> > Seriously, you're having your interrupt handler recover from the idle
> > race? On a *new* architecture?
> 
> It's heavily derived from MIPS (does that make the wholesale replacement 
> of arch/mips copyright headers a bit questionable?).
> 
> I don't think it's such a bad trick though -- restartable sequences 
> before they were cool. It can let you save an irq disable in some
> cases (depending on the arch of course).

In this case you're making *every* interrupt slower. Simply adding a new
idle instruction, one that can be called with interrupts disabled and
will terminate on a pending interrupt, would've solved the issues much
nicer and reclaimed the cycles spend on this restart trick.

