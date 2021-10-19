Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72B743311F
	for <lists+linux-arch@lfdr.de>; Tue, 19 Oct 2021 10:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhJSIfi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Oct 2021 04:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJSIfi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Oct 2021 04:35:38 -0400
X-Greylist: delayed 46841 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Oct 2021 01:33:25 PDT
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5EEEC06161C;
        Tue, 19 Oct 2021 01:33:25 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 42E8F92009C; Tue, 19 Oct 2021 10:33:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 3BA1F92009B;
        Tue, 19 Oct 2021 10:33:24 +0200 (CEST)
Date:   Tue, 19 Oct 2021 10:33:24 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Feiyang Chen <chris.chenfeiyang@gmail.com>
cc:     Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, arnd@arndb.de,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        chenhuacai@kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 0/2] MIPS: convert to generic entry
In-Reply-To: <CACWXhK=Au5qc96NBQObHnLAL+4wNMqo6apvK5-572Hohs8OrYQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2110191004440.31442@angie.orcam.me.uk>
References: <cover.1631583258.git.chenfeiyang@loongson.cn> <3907ec0f-42a0-ff4c-d4ea-63ad2a1516c2@flygoat.com> <CACWXhK=YW6Kn9FO1JrU1mP_xxMnEF_ajkD6hou=4rpgR2hOM5w@mail.gmail.com> <20210921155708.GA12237@alpha.franken.de> <ef429f0f-7cc9-2625-3700-47dc459ee681@wanyeetech.com>
 <8a6f5c78-62c0-5d58-1386-dabfcacc112a@wanyeetech.com> <alpine.DEB.2.21.2110182128090.31442@angie.orcam.me.uk> <CACWXhK=Au5qc96NBQObHnLAL+4wNMqo6apvK5-572Hohs8OrYQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 19 Oct 2021, Feiyang Chen wrote:

> > > Score Without Patches  Score With Patches  Performance Change SoC Model
> > >        105.9                102.1              -3.6%  JZ4775
> > >        132.4                124.1              -6.3%  JZ4780(SMP off)
> > >        170.2                155.7             -8.5%  JZ4780(SMP on)
> > >        101.3                 91.5              -9.7%  X1000E
> > >        187.1                179.4              -4.1%  X1830
> > >        324.9                314.3              -3.3%  X2000(SMT off)
> > >        394.6                373.9              -5.2%  X2000(SMT off)
> > >
> > >
> > > Compared with the V1 version, there are some improvements, but the performance
> > > loss is still a bit obvious
> >
> >  The MIPS port of Linux has always had the pride of having a particularly
> > low syscall overhead and I'd rather we didn't lose this quality.
> 
> Hi, Maciej,
> 
> 1. The current trend is to use generic code, so I think this work is
> worth it, even if there is some performance loss.

 Well, a trend is not a proper justification on its own for existing code, 
and mature one for that matter, that works.  Surely it might be for an 
entirely new port, but the MIPS port is not exactly one.

> 2. We tested the performance on 5.15-rc1~rc5 and the performance
> loss on JZ4780 (SMP off) is not so obvious (about -3%).

 I've seen teams work hard to improve performance by less than 3%, so 
depending on how you look at it the loss is not necessarily small, even if 
not abysmal.  And I find the figure of almost 10% cited for another system 
even more worrisome.  Also you've written the figures are from UnixBench, 
which I suppose measures some kind of an average across various workloads.  
Can you elaborate on the methodology used by that benchmark?

 Can you tell me what the performance loss is for a cheap syscall such as 
`getuid'?  That would indicate how much is actually lost in the invocation 
overhead.

 With that amount known, would you be able to indicate where exactly the 
performance is getting lost in generic code?  Can it be improved?

  Maciej
