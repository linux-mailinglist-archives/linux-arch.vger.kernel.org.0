Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE83B332C8C
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 17:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhCIQtk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 11:49:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60073 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhCIQtW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 11:49:22 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EB70310E553;
        Tue,  9 Mar 2021 11:49:21 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=E9MbVhkCmutKtFD9vVxlmwEupRk=; b=Yk3Pi9
        1SFIOhGT3sSWmMbjxqA5ZMQyKQFY1oWiO24BJGbPSB99w1xgdGp96GU32Wahwx6T
        BkkYoma5knMqWUF8+oqPjEBJVfnqq/pG95nIgVG76gj+OVhrEk29ht267lXwAESJ
        MIC7+e0K/cNuI90tEznAio7HtOl3zNVgO3ceo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E0BC910E552;
        Tue,  9 Mar 2021 11:49:21 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=Jl2Ko8laId4g9IMRvYTHhzlWdkRni9KCBszZL0sGFkw=; b=YN+D0sNW7Ti9vvXGiEMY2f7x+FKgbmmOXrSH5qZzLqWOwsraknJf0Uew9TLvQbW5Dcp0WVoQFvetL/xHerPu7Tfg3wmFjsK5w8scZr2z4mcJPHssl7aI/eohxQA8c0vSvrf1Q0M03dmnUtEpuN/Lsxp7gu6MA/gmsfhJzfJsDO8=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9A0FC10E54D;
        Tue,  9 Mar 2021 11:49:18 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id DBCBD2DA017E;
        Tue,  9 Mar 2021 11:49:16 -0500 (EST)
Date:   Tue, 9 Mar 2021 11:49:16 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 0/4] kbuild: build speed improvment of
 CONFIG_TRIM_UNUSED_KSYMS
In-Reply-To: <CAK7LNATw9tLZ7sgPhK5TcsQnYW6_O25JOqxGA_wm4rN+Hi0SLg@mail.gmail.com>
Message-ID: <8552376s-o19r-3775-6917-p8oq181oosq6@syhkavp.arg>
References: <20210225160247.2959903-1-masahiroy@kernel.org> <r3584n3-sq21-qo49-9sp5-r3qp6o611s55@syhkavp.arg> <CAK7LNAQeL7jQt1RJjLbU7MUj7XGAwEAhtTvMocQw85uJj9NA9g@mail.gmail.com> <46506ns0-1477-n7nq-9qq4-9pn48634oq4@syhkavp.arg>
 <CAK7LNATw9tLZ7sgPhK5TcsQnYW6_O25JOqxGA_wm4rN+Hi0SLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 63E9F066-80F7-11EB-A106-E43E2BB96649-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 9 Mar 2021, Masahiro Yamada wrote:

> On Fri, Feb 26, 2021 at 4:24 AM Nicolas Pitre <nico@fluxnic.net> wrote:
> >
> > If CONFIG_TRIM_UNUSED_KSYMS is enabled then build time willincrease.
> > That comes with the feature.
> 
> This patch set intends to change this.
> TRIM_UNUSED_KSYMS will build without additional cost,
> like LD_DEAD_CODE_DATA_ELIMINATION.

OK... I do see how you're going about it.

> > > Modules are relocatable ELF.
> > > Clang LTO cannot eliminate any code.
> > > GCC LTO does not work with relocatable ELF
> > > in the first place.
> >
> > I don't think I follow you here. What relocatable ELF has to do with LTO?
> 
> What is important is,
> GCC LTO is the feature of gcc, not binutils.
> That is, LD_FINAL is $(CC).

Exact.

> GCC LTO can be implemented for the final link stage
> by using $(CC) as the linker driver.
> Then, it can determine which code is unreachable.
> In other words, GCC LTO works only when building
> the final executable.

Yes. And it does so by filling .o files with its intermediate code 
representation and not ELF code.

> On the other hand, a relocatable ELF is created
> by $(LD) -r by combining some objects together.
> The relocatable ELF can be fed to another $(LD) -r,
> or the final link stage.

You still can create relocatable ELF using LTO. But LTO stops there. 
From that point on, .o files will no longer contain data that LTO can 
use if you further combine those object files together. But until that 
point, LTO is still usable.

> As I said above, modules are created by $(LD) -r.
> It is not possible to implement GCC LTO for modules.

If I remember correctly (that was a while ago) the problem with LTO and 
the kernel had to do with the fact that avery subdirectory was gathering 
object files in built-in.o using ld -r. At some point we switched to 
gathering object files into built-in.a files where no linking is taking 
place. The real linking happens in vmlinux.o where LTO may now do its 
magic.

The same is true for modules. Compiling foo_module.c into foo_module.o 
will create a .o file with LTO data rather than executable code. But 
when you create the final .o for the module then LTO takes place and 
produce the relocatable ELF executable.

> > I've successfully used gcc LTO on the kernel quite a while ago.
> >
> > For a reference about binary size reduction with LTO and
> > CONFIG_TRIM_UNUSED_KSYMS please read this article:
> >
> > https://lwn.net/Articles/746780/
> 
> Thanks for the great articles.
> 
> Just for curiosity, I think you used GCC LTO from
> Andy's GitHub.

Right. I provided the reference in the preceding article:
https://lwn.net/Articles/744507/ 

> In the article, you took stm32_defconfig as an example,
> but ARM does not select ARCH_SUPPORTS_LTO.
> 
> Did you add some local hacks to make LTO work
> for ARM?

Of course. This article was written in 2017 and no LTO support at all 
was in mainline back then. But, besides adding CONFIG_LTO, very little 
was needed to make it compile, and I did upstream most changes such as 
commit 75fea300d7, commit a85b2257a5, commit 5d48417592, commit 
19c233b79d, etc.

> I tried the lto-5.8.1 branch, but
> I did not even succeed in building x86 + LTO.

My latest working LTO branch (i.e. last time I worked on it) is much 
older than that.

Maybe people aren't very excited about LTO because it makes the time to 
recompiling the kernel many times longer because gcc does its 
optimization passes on the whole kernel even if you modify a single 
file.


Nicolas
