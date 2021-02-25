Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C23193256A3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Feb 2021 20:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhBYT16 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Feb 2021 14:27:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54574 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhBYTZh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2021 14:25:37 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D580B0DA2;
        Thu, 25 Feb 2021 14:24:47 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=uSGDWbeu4QMXFL3jz4yLuixZbF0=; b=tXx7qX
        BARdHwAJ75iVXzgZlY6u4vpDfGdSZ6r5bPhjtks4bGNrErpsxE8fj2AyvWEqCuIb
        4d3jL41jhETZ4N7zRJeVZV+J3J0D86r5cyMRB/yhLlhUfKiH1q5prStUh74QR3w3
        XPCvDl1iVEbJtRBA/1rq+K6rgVJ1g8drG0nCU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 921DEB0DA1;
        Thu, 25 Feb 2021 14:24:47 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=Ysam7wogkyEXkA86e6mQ/AkpZlWP1KiBxHidywtJQ1U=; b=fe30QbMoPbpvOPzZjlkywaicUYMfC2C4XrgufMymzkfdY8ANd6Kns/Obkc/IjnZJ8EqmuA30/aPhWzVPKbeLATRRRZ7wI2KgmBFVB/fEXDco209bZHneRrIbFO3A2Lg2cVaengsq2mJ7GzPBEewFFANRVg24I6SOsRya7lwi2YE=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 088CFB0DA0;
        Thu, 25 Feb 2021 14:24:47 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 12C962DA0082;
        Thu, 25 Feb 2021 14:24:46 -0500 (EST)
Date:   Thu, 25 Feb 2021 14:24:45 -0500 (EST)
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
In-Reply-To: <CAK7LNAQeL7jQt1RJjLbU7MUj7XGAwEAhtTvMocQw85uJj9NA9g@mail.gmail.com>
Message-ID: <46506ns0-1477-n7nq-9qq4-9pn48634oq4@syhkavp.arg>
References: <20210225160247.2959903-1-masahiroy@kernel.org> <r3584n3-sq21-qo49-9sp5-r3qp6o611s55@syhkavp.arg> <CAK7LNAQeL7jQt1RJjLbU7MUj7XGAwEAhtTvMocQw85uJj9NA9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 1F1ECEFE-779F-11EB-BCD7-D152C8D8090B-78420484!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 26 Feb 2021, Masahiro Yamada wrote:

> On Fri, Feb 26, 2021 at 2:20 AM Nicolas Pitre <nico@fluxnic.net> wrote:
> >
> > On Fri, 26 Feb 2021, Masahiro Yamada wrote:
> >
> > >
> > > Now CONFIG_TRIM_UNUSED_KSYMS is revived, but Linus is still unhappy
> > > about the build speed.
> > >
> > > I re-implemented this feature, and the build time cost is now
> > > almost unnoticeable level.
> > >
> > > I hope this makes Linus happy.
> >
> > :-)
> >
> > I'm surprised to see that Linus is using this feature. When disabled
> > (the default) this should have had no impact on the build time.
> 
> Linus is not using this feature, but does build tests.
> After pulling the module subsystem pull request in this merge window,
> CONFIG_TRIM_UNUSED_KSYMS was enabled by allmodconfig.

If CONFIG_TRIM_UNUSED_KSYMS is enabled then build time willincrease. 
That comes with the feature.

> > This feature provides a nice security advantage by significantly
> > reducing the kernel input surface. And people are using that also to
> > better what third party vendor can and cannot do with a distro kernel,
> > etc. But that's not the reason why I implemented this feature in the
> > first place.
> >
> > My primary goal was to efficiently reduce the kernel binary size using
> > LTO even with kernel modules enabled.
> 
> 
> Clang LTO landed in this MW.
> 
> Do you think it will reduce the kernel binary size?
> No, opposite.

LTO ought to reduce binary size. It is rather broken otherwise.
Having a global view before optimizing allows for the compiler to do 
project wide constant propagation and dead code elimination.

> CONFIG_LTO_CLANG cannot trim any code even if it
> is obviously unused.
> Hence, it never reduces the kernel binary size.
> Rather, it produces a bigger kernel.

Then what's the point?

> The reason is Clang LTO was implemented against
> relocatable ELF (vmlinux.o) .

That's not true LTO then.

> I pointed out this flaw in the review process, but
> it was dismissed.
> 
> This is the main reason why I did not give any Ack
> (but it was merged via Kees Cook's tree).

> So, the help text of this option should be revised:
> 
>           This option allows for unused exported symbols to be dropped from
>           the build. In turn, this provides the compiler more opportunities
>           (especially when using LTO) for optimizing the code and reducing
>           binary size.  This might have some security advantages as well.
> 
> Clang LTO is opposite to your expectation.

Then Clang LTO is a misnomer. That is the option to revise not this one.

> > Each EXPORT_SYMBOL() created a
> > symbol dependency that prevented LTO from optimizing out the related
> > code even though a tiny fraction of those exported symbols were needed.
> >
> > The idea behind the recursion was to catch those cases where disabling
> > an exported symbol within a module would optimize out references to more
> > exported symbols that, in turn, could be disabled and possibly trigger
> > yet more code elimination. There is no way that can be achieved without
> > extra compiler passes in a recursive manner.
> 
> I do not understand.
> 
> Modules are relocatable ELF.
> Clang LTO cannot eliminate any code.
> GCC LTO does not work with relocatable ELF
> in the first place.

I don't think I follow you here. What relocatable ELF has to do with LTO?

I've successfully used gcc LTO on the kernel quite a while ago.

For a reference about binary size reduction with LTO and 
CONFIG_TRIM_UNUSED_KSYMS please read this article:

https://lwn.net/Articles/746780/


Nicolas
