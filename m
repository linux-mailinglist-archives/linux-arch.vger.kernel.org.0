Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54825BDE4E
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 09:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiITHet (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Sep 2022 03:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiITHer (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Sep 2022 03:34:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72AB10FDD;
        Tue, 20 Sep 2022 00:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bwp3TfVF0adZpLn21kQXNkoTzUy9veurfPjQU2GYvjk=; b=Z0sMnkPTrsekS/SUZXC5zw87D2
        Kj338wFcpy5PSbB/Fs6FhwerPnlwXUdDR63UKHYRqGY1NmBmgBE315JnTvDbBSZJkE7m+9U+HQgjF
        MvoXCIyvAleAMKleur0F9XYo797hUvrdAhlVOJAVh1mGYEjKVvxvKbCzO+8b0FzQlHzcjh6MBwSy6
        7FTjk4XWBoyqiGleG3TYIwTyxCycqlvuXo1L8A0JtWoq9FPmu8fWxzI5JmcQFR63SIs62c+cQT3Sv
        NvgdRPtluvBvNpapeyy1/UenUEPNXzBwGRgov04CsN8AYQjfnhoc4W2C6/FTeMJt/gOK728zJ/M6p
        vrtNLXtQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaXlv-005M0e-7v; Tue, 20 Sep 2022 07:34:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95156300212;
        Tue, 20 Sep 2022 09:34:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77BA92BB3E533; Tue, 20 Sep 2022 09:34:19 +0200 (CEST)
Date:   Tue, 20 Sep 2022 09:34:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>, keescook@chromium.org
Subject: Re: [PATCH V5 08/11] riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
Message-ID: <Yyls+xIUsLCIa7pj@hirez.programming.kicks-ass.net>
References: <20220918155246.1203293-1-guoren@kernel.org>
 <20220918155246.1203293-9-guoren@kernel.org>
 <Yyhyap+Xi3UtV+T0@hirez.programming.kicks-ass.net>
 <CAJF2gTS9rFTndZXvDG+XNOOEwZYC_Hbu9TOO_F+4gQo1mRF2bQ@mail.gmail.com>
 <Yylrd77Eh9v7OKLj@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yylrd77Eh9v7OKLj@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 20, 2022 at 09:27:51AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 20, 2022 at 02:08:55PM +0800, Guo Ren wrote:
> > On Mon, Sep 19, 2022 at 9:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Sun, Sep 18, 2022 at 11:52:43AM -0400, guoren@kernel.org wrote:
> > >
> > > > +ENTRY(call_on_stack)
> > > > +     /* Create a frame record to save our ra and fp */
> > > > +     addi    sp, sp, -RISCV_SZPTR
> > > > +     REG_S   ra, (sp)
> > > > +     addi    sp, sp, -RISCV_SZPTR
> > > > +     REG_S   fp, (sp)
> > > > +
> > > > +     /* Save sp in fp */
> > > > +     move    fp, sp
> > > > +
> > > > +     /* Move to the new stack and call the function there */
> > > > +     li      a3, IRQ_STACK_SIZE
> > > > +     add     sp, a1, a3
> > > > +     jalr    a2
> > > > +
> > > > +     /*
> > > > +      * Restore sp from prev fp, and fp, ra from the frame
> > > > +      */
> > > > +     move    sp, fp
> > > > +     REG_L   fp, (sp)
> > > > +     addi    sp, sp, RISCV_SZPTR
> > > > +     REG_L   ra, (sp)
> > > > +     addi    sp, sp, RISCV_SZPTR
> > > > +     ret
> > > > +ENDPROC(call_on_stack)
> > >
> > > IIRC x86_64 moved away from a stack-switch function like this because it
> > > presents a convenient exploit gadget.
> > I found:
> > https://lore.kernel.org/all/20210204204903.350275743@linutronix.de/
> > 
> >   - The fact that the stack switching code ended up being an easy to find
> >     exploit gadget.
> > 
> > What's the exploit gadget? Do you have a ref link? Thx.
> 
> Sadly no, I do not. Kees might. But basically it boils down to this
> function taking both a stack pointer and a function pointer as
> arguments (@a1 and @a2 resp. if I'm not reading this wrong).
> 
> If an attacker can call this with arguments of its choice then it gains
> full control of subsequent execution.

If you inline it the hope is that the function pointers go away or at
least the encompassing function doesn't have quite such a 'convenient'
signature to hijack control flow.
