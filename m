Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB8D331FC7
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 08:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCIH3d (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 02:29:33 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:22497 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhCIH3O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 02:29:14 -0500
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 1297Sxeb026341;
        Tue, 9 Mar 2021 16:28:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 1297Sxeb026341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615274939;
        bh=5RVgblDEnJ8sCOM9YnkG8SGXNv1I7gmzT6pa1Pe14aQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OPT7Q9CfYbcgiwWTDfWZsKS5tYvIbADIZjWAgHAqse9zJDbp3qSjiD4p4PsnWcKfe
         0o4uGzfI/nNd8ghRRwBWPFMwCkzlf6lbWAyCNatK02Q5yBv92i+9jHh9l+BE9QUbTc
         2Mid4TQlyKfAtqDVw2RXftNM2k5U8PgAuOsheNNE0c5e/cxQokaf3ebwrOMsEsFfZt
         EqJPRxhQgnRXCAQzVNdblkTfF1BVakdONSf6EYcaa7qOoEPtAoaq7ozZhzv6fkejL3
         SBA/e51aXMgQXH1fVTjKDgc/YgxL3m46Oylzl9zC6j+jlRgmCCy4zgLA8w3t/QHuC+
         IYmjDnLxtrTEA==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id jx13so420761pjb.1;
        Mon, 08 Mar 2021 23:28:59 -0800 (PST)
X-Gm-Message-State: AOAM531y0Xq7lq9b9KyaDpIElWdwPc7PcHwnUEoKORr4+K1x6to92vhL
        rbCEH6fGPkOmUDqSaADcDhp2+IvfrQBNGbF8EWU=
X-Google-Smtp-Source: ABdhPJzVFmI8CIQ5OCxBOcBO8d+CIVkQ4rorhUymhDAWnVJ4symEm4wfO8f95eeFjdPyiMofT3peeT2NueZjbmFY8s4=
X-Received: by 2002:a17:90a:3b0e:: with SMTP id d14mr3357691pjc.198.1615274938565;
 Mon, 08 Mar 2021 23:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20210225160247.2959903-1-masahiroy@kernel.org>
 <r3584n3-sq21-qo49-9sp5-r3qp6o611s55@syhkavp.arg> <CAK7LNAQeL7jQt1RJjLbU7MUj7XGAwEAhtTvMocQw85uJj9NA9g@mail.gmail.com>
 <46506ns0-1477-n7nq-9qq4-9pn48634oq4@syhkavp.arg>
In-Reply-To: <46506ns0-1477-n7nq-9qq4-9pn48634oq4@syhkavp.arg>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 9 Mar 2021 16:28:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNATw9tLZ7sgPhK5TcsQnYW6_O25JOqxGA_wm4rN+Hi0SLg@mail.gmail.com>
Message-ID: <CAK7LNATw9tLZ7sgPhK5TcsQnYW6_O25JOqxGA_wm4rN+Hi0SLg@mail.gmail.com>
Subject: Re: [PATCH 0/4] kbuild: build speed improvment of CONFIG_TRIM_UNUSED_KSYMS
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 26, 2021 at 4:24 AM Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Fri, 26 Feb 2021, Masahiro Yamada wrote:
>
> > On Fri, Feb 26, 2021 at 2:20 AM Nicolas Pitre <nico@fluxnic.net> wrote:
> > >
> > > On Fri, 26 Feb 2021, Masahiro Yamada wrote:
> > >
> > > >
> > > > Now CONFIG_TRIM_UNUSED_KSYMS is revived, but Linus is still unhappy
> > > > about the build speed.
> > > >
> > > > I re-implemented this feature, and the build time cost is now
> > > > almost unnoticeable level.
> > > >
> > > > I hope this makes Linus happy.
> > >
> > > :-)
> > >
> > > I'm surprised to see that Linus is using this feature. When disabled
> > > (the default) this should have had no impact on the build time.
> >
> > Linus is not using this feature, but does build tests.
> > After pulling the module subsystem pull request in this merge window,
> > CONFIG_TRIM_UNUSED_KSYMS was enabled by allmodconfig.
>
> If CONFIG_TRIM_UNUSED_KSYMS is enabled then build time willincrease.
> That comes with the feature.


This patch set intends to change this.
TRIM_UNUSED_KSYMS will build without additional cost,
like LD_DEAD_CODE_DATA_ELIMINATION.



>
> > > This feature provides a nice security advantage by significantly
> > > reducing the kernel input surface. And people are using that also to
> > > better what third party vendor can and cannot do with a distro kernel,
> > > etc. But that's not the reason why I implemented this feature in the
> > > first place.
> > >
> > > My primary goal was to efficiently reduce the kernel binary size using
> > > LTO even with kernel modules enabled.
> >
> >
> > Clang LTO landed in this MW.
> >
> > Do you think it will reduce the kernel binary size?
> > No, opposite.
>
> LTO ought to reduce binary size. It is rather broken otherwise.
> Having a global view before optimizing allows for the compiler to do
> project wide constant propagation and dead code elimination.
>
> > CONFIG_LTO_CLANG cannot trim any code even if it
> > is obviously unused.
> > Hence, it never reduces the kernel binary size.
> > Rather, it produces a bigger kernel.
>
> Then what's the point?


Presumably, reducing the size is not
the main interest for Googlers.


>
> > The reason is Clang LTO was implemented against
> > relocatable ELF (vmlinux.o) .
>
> That's not true LTO then.


This is the same as what I said in the review process.
:-)

https://lore.kernel.org/linux-kbuild/CAK7LNASQPOGohtUyzBM6n54pzpLN35kDXC7VbvWzX8QWUmqq9g@mail.gmail.com/




>
> > I pointed out this flaw in the review process, but
> > it was dismissed.
> >
> > This is the main reason why I did not give any Ack
> > (but it was merged via Kees Cook's tree).
>
> > So, the help text of this option should be revised:
> >
> >           This option allows for unused exported symbols to be dropped from
> >           the build. In turn, this provides the compiler more opportunities
> >           (especially when using LTO) for optimizing the code and reducing
> >           binary size.  This might have some security advantages as well.
> >
> > Clang LTO is opposite to your expectation.
>
> Then Clang LTO is a misnomer. That is the option to revise not this one.
>
> > > Each EXPORT_SYMBOL() created a
> > > symbol dependency that prevented LTO from optimizing out the related
> > > code even though a tiny fraction of those exported symbols were needed.
> > >
> > > The idea behind the recursion was to catch those cases where disabling
> > > an exported symbol within a module would optimize out references to more
> > > exported symbols that, in turn, could be disabled and possibly trigger
> > > yet more code elimination. There is no way that can be achieved without
> > > extra compiler passes in a recursive manner.
> >
> > I do not understand.
> >
> > Modules are relocatable ELF.
> > Clang LTO cannot eliminate any code.
> > GCC LTO does not work with relocatable ELF
> > in the first place.
>
> I don't think I follow you here. What relocatable ELF has to do with LTO?



What is important is,
GCC LTO is the feature of gcc, not binutils.
That is, LD_FINAL is $(CC).

GCC LTO can be implemented for the final link stage
by using $(CC) as the linker driver.
Then, it can determine which code is unreachable.
In other words, GCC LTO works only when building
the final executable.


On the other hand, a relocatable ELF is created
by $(LD) -r by combining some objects together.
The relocatable ELF can be fed to another $(LD) -r,
or the final link stage.


vmlinux is an executable ELF.
modules (*.ko files) are relocatable ELFs.


You can confirm it easily
by using the 'file' command.

masahiro@oscar:~/ref/linux$ file vmlinux
vmlinux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV),
statically linked,
BuildID[sha1]=ee0cef2ff3d9f490e0f5ee1d7e74b19aa167933b, not stripped
masahiro@oscar:~/ref/linux$ file  net/ipv4/netfilter/iptable_nat.ko
net/ipv4/netfilter/iptable_nat.ko: ELF 64-bit LSB relocatable, x86-64,
version 1 (SYSV),
BuildID[sha1]=4829e82f9b9e7fd65be3c19c1cf0e16a7ddf0967, not stripped



Modules are not filled with addresses yet
since we do not know which memory address
the module will be loaded to.
The addresses are resolved at modprobe time.

As I said above, modules are created by $(LD) -r.
It is not possible to implement GCC LTO for modules.



In contrast, Clang LTO is the ability of $(LD).
So, it can be implemented for not only for executable ELFs,
but also for relocated ELFs.
The problem is Clang LTO cannot determine which code is
unreachable if it is implemented for a relocatable ELF,
since it is not a final image.

Did I answer your question?





> I've successfully used gcc LTO on the kernel quite a while ago.
>
> For a reference about binary size reduction with LTO and
> CONFIG_TRIM_UNUSED_KSYMS please read this article:
>
> https://lwn.net/Articles/746780/


Thanks for the great articles.

Just for curiosity, I think you used GCC LTO from
Andy's GitHub.


In the article, you took stm32_defconfig as an example,
but ARM does not select ARCH_SUPPORTS_LTO.

Did you add some local hacks to make LTO work
for ARM?

I tried the lto-5.8.1 branch, but
I did not even succeed in building x86 + LTO.






>
> Nicolas



-- 
Best Regards
Masahiro Yamada
