Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE3A4136CE
	for <lists+linux-arch@lfdr.de>; Tue, 21 Sep 2021 17:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhIUP7n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Sep 2021 11:59:43 -0400
Received: from elvis.franken.de ([193.175.24.41]:36245 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234328AbhIUP7n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Sep 2021 11:59:43 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mSi9l-0007XJ-00; Tue, 21 Sep 2021 17:58:05 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E90A8C1234; Tue, 21 Sep 2021 17:57:08 +0200 (CEST)
Date:   Tue, 21 Sep 2021 17:57:08 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Feiyang Chen <chris.chenfeiyang@gmail.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, arnd@arndb.de,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        chenhuacai@kernel.org, Zhou Yanjie <zhouyu@wanyeetech.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 0/2] MIPS: convert to generic entry
Message-ID: <20210921155708.GA12237@alpha.franken.de>
References: <cover.1631583258.git.chenfeiyang@loongson.cn>
 <3907ec0f-42a0-ff4c-d4ea-63ad2a1516c2@flygoat.com>
 <CACWXhK=YW6Kn9FO1JrU1mP_xxMnEF_ajkD6hou=4rpgR2hOM5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACWXhK=YW6Kn9FO1JrU1mP_xxMnEF_ajkD6hou=4rpgR2hOM5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 14, 2021 at 05:30:14PM +0800, Feiyang Chen wrote:
> On Tue, 14 Sept 2021 at 16:54, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> >
> >
> >
> > 在 2021/9/14 2:50, Feiyang Chen 写道:
> > > Convert MIPS to use the generic entry infrastructure from
> > > kernel/entry/*.
> > >
> > > v2: Use regs->regs[27] to mark whether to restore all registers in
> > > handle_sys and enable IRQ stack.
> > Hi Feiyang,
> >
> > Thanks for your patch, could you please expand how could this improve
> > the performance?
> >
> 
> Hi, Jiaxun,
> 
> We always restore all registers in handle_sys in the v1 of the
> patchset. Since regs->regs[27] is marked where we need to restore all
> registers, now we simply use it as the return value of do_syscall to
> determine whether we can only restore partial registers in handle_sys.

can people, who provided performance numbers for v1 do the same for v2 ?

Thomas,

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
