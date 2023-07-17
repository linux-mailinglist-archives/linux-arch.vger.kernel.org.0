Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28777560CE
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jul 2023 12:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjGQKpn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jul 2023 06:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGQKpm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jul 2023 06:45:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB4D11C;
        Mon, 17 Jul 2023 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=QwEVqapqGt5c5zaKWTZ1oqQBp+aqsZVTLEsdAj1XcXc=; b=KfCbhY1d2N38BQhLoS0cjcwf70
        APYBflKw7faaRf0xF+22LOt7LWcTL6BiIZJbP9gsvGlUvD233G9fYmlEDCEQ05UmZ6bdE5eWhKDwY
        wq8T1q++Ytsc/QON+PEtavQh4vGyYUNP5/MG+owXZijRVskGujtyBQP79W3sVA9/En1sJktXXP+U/
        2kKcc/v+WP+dF9wwC7K49GtNC+JpS7LOoVXmXZwe8c71u/paZkipy6WfF91+0uk0KuHMFbdKXF3NF
        Ma2l6FPIAAHR/FoQ9bjQA2odhvAdkxVis6y1BprdTbUeHLfcLkx+KDOGvJ59XhOQwce8VRdfC2lip
        UMFlIyZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qLLj4-0095fw-0L;
        Mon, 17 Jul 2023 10:45:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B49930020C;
        Mon, 17 Jul 2023 12:45:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 667FE2463D7EF; Mon, 17 Jul 2023 12:45:08 +0200 (CEST)
Date:   Mon, 17 Jul 2023 12:45:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, mark.rutland@arm.com, bjorn@kernel.org,
        palmer@dabbelt.com, bjorn@rivosinc.com, daniel.thompson@linaro.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, stable@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: entry: Fixup do_trap_break from kernel side
Message-ID: <20230717104508.GF4253@hirez.programming.kicks-ass.net>
References: <20230702025708.784106-1-guoren@kernel.org>
 <20230704164003.GB83892@hirez.programming.kicks-ass.net>
 <CAJF2gTTc0Gyo=K-0dCW6wu7q=Wq34hgTB69qJ7VSF_KAgKhavA@mail.gmail.com>
 <20230710080152.GA3028865@hirez.programming.kicks-ass.net>
 <CAJF2gTTt23iSDG_m4ihPhXhYDrz3Xnih=KGLx_ayBLbzPqaTaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTTt23iSDG_m4ihPhXhYDrz3Xnih=KGLx_ayBLbzPqaTaQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 17, 2023 at 07:33:25AM +0800, Guo Ren wrote:
> On Mon, Jul 10, 2023 at 4:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sun, Jul 09, 2023 at 10:30:22AM +0800, Guo Ren wrote:
> > > On Wed, Jul 5, 2023 at 12:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Sat, Jul 01, 2023 at 10:57:07PM -0400, guoren@kernel.org wrote:
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > >
> > > > > The irqentry_nmi_enter/exit would force the current context into in_interrupt.
> > > > > That would trigger the kernel to dead panic, but the kdb still needs "ebreak" to
> > > > > debug the kernel.
> > > > >
> > > > > Move irqentry_nmi_enter/exit to exception_enter/exit could correct handle_break
> > > > > of the kernel side.
> > > >
> > > > This doesn't explain much if anything :/
> > > >
> > > > I'm confused (probably because I don't know RISC-V very well), what's
> > > > EBREAK and how does it happen?
> > > EBREAK is just an instruction of riscv which would rise breakpoint exception.
> > >
> > >
> > > >
> > > > Specifically, if EBREAK can happen inside an local_irq_disable() region,
> > > > then the below change is actively wrong. Any exception/interrupt that
> > > > can happen while local_irq_disable() must be treated like an NMI.
> > > When the ebreak happend out of local_irq_disable region, but
> > > __nmi_enter forces handle_break() into in_interupt() state. So how
> >
> > And why is that a problem? I think I'm missing something fundamental
> > here...
> The irqentry_nmi_enter() would force the current context to get
> in_interrupt=true, although ebreak happens in the context which is
> in_interrupt=false.
> A lot of checking codes, such as:
>         if (in_interrupt())
>                 panic("Fatal exception in interrupt");

Why would you do that?!?

Are you're trying to differentiate between an exception and an
interrupt?

You *could* have ebreak in an interrupt, right? So why panic the machine
if that happens?

> It would make the kernel panic, but we don't panic; we want back to the shell.
> eg:
> echo BUG > /sys/kernel/debug/provoke-crash/DIRECT



