Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078174036E3
	for <lists+linux-arch@lfdr.de>; Wed,  8 Sep 2021 11:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348770AbhIHJaF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Sep 2021 05:30:05 -0400
Received: from elvis.franken.de ([193.175.24.41]:43016 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234476AbhIHJ3v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Sep 2021 05:29:51 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mNtsf-0006P0-00; Wed, 08 Sep 2021 11:28:33 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 42B00C0A9D; Wed,  8 Sep 2021 10:51:50 +0200 (CEST)
Date:   Wed, 8 Sep 2021 10:51:50 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     =?utf-8?B?6ZmI6aOe5oms?= <chris.chenfeiyang@gmail.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, arnd@arndb.de,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        chenhuacai@kernel.org, Yanteng Si <siyanteng@loongson.cn>
Subject: Re: [PATCH 1/2] mips: convert syscall to generic entry
Message-ID: <20210908085150.GA5622@alpha.franken.de>
References: <cover.1630929519.git.chenfeiyang@loongson.cn>
 <ec14e242a73227bf5314bbc1b585919500e6fbc7.1630929519.git.chenfeiyang@loongson.cn>
 <59feb382-a4ab-c94e-8f71-10ad0c0ceceb@flygoat.com>
 <CACWXhKnA24KuJo33+OitPQVRRd3g_05DWRC2Dsnm7w8hVyKjNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACWXhKnA24KuJo33+OitPQVRRd3g_05DWRC2Dsnm7w8hVyKjNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Sep 08, 2021 at 10:08:47AM +0800, 陈飞扬 wrote:
> On Tue, 7 Sept 2021 at 21:49, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> >
> >
> > 在 2021/9/7 14:16, FreeFlyingSheep 写道:
> > > From: Feiyang Chen <chenfeiyang@loongson.cn>
> > >
> > > Convert mips syscall to use the generic entry infrastructure from
> > > kernel/entry/*.
> > >
> > > There are a few special things on mips:
> > >
> > > - There is one type of syscall on mips32 (scall32-o32) and three types
> > > of syscalls on mips64 (scall64-o32, scall64-n32 and scall64-n64). Now
> > > convert to C code to handle different types of syscalls.
> > >
> > > - For some special syscalls (e.g. fork, clone, clone3 and sysmips),
> > > save_static_function() wrapper is used to save static registers. Now
> > > SAVE_STATIC is used in handle_sys before calling do_syscall(), so the
> > > save_static_function() wrapper can be removed.
> > >
> > > - For sigreturn/rt_sigreturn and sysmips, inline assembly is used to
> > > jump to syscall_exit directly for skipping setting the error flag and
> > > restoring all registers. Now use regs->regs[27] to mark whether to
> > > handle the error flag and always restore all registers in handle_sys,
> > > so these functions can return normally as other architecture.
> >
> > Hmm, that would give us overhead of register context on these syscalls.
> >
> > I guess it's worthy?
> >
> 
> Hi, Jiaxun,
> 
> Saving and restoring registers against different system calls can be
> difficult due to the use of generic entry.
> To avoid a lot of duplicate code, I think the overhead is worth it.

could you please provide numbers for that ? This code still runs
on low end MIPS CPUs for which overhead might mean a different
ballpark than some highend Loongson CPUs.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
