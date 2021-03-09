Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F09332F5E
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 20:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCITzH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 14:55:07 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54761 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhCITyn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 14:54:43 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24EB010FC46;
        Tue,  9 Mar 2021 14:54:39 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=X+fpNI8wAlkIa8HtAWVTCKgtpeE=; b=iacdaa
        5PYicBLXi17pnea2k5IilYO/Vv1DKW+EcKyyySDNpWStg54Ck69G/cheD2dHcIs2
        dOWEceDwXePBE9bn37aWbJ91q8620m34ID6XAC5FeEvuxAr20ftAf0x9UvdEfVD2
        Mq8HWHRLBefVnyv/QifM2OpfmpEQkB2L6Ut3w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D34E10FC45;
        Tue,  9 Mar 2021 14:54:39 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=vSzFF6Zn+X6Rkesi42r5jvmugdfCQY8l70418EqnA4A=; b=xmowcB275hUF94JmHoIlyB39htqV+cHBWygkkz+5VuQ9gIaNunjARaC/ZSb6t7XLCuffioT8gTX6HH2YYOiKjh+0GdCCKLHZTydLcVSpS5vvnfJuH9xgV0Kvenz6EhfgU/XCBV4MPV2S8PIythFnw9FS6H2GYLA7PM4SnKFbelk=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EF6C010FC42;
        Tue,  9 Mar 2021 14:54:35 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 295DE2DA017E;
        Tue,  9 Mar 2021 14:54:34 -0500 (EST)
Date:   Tue, 9 Mar 2021 14:54:33 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] kbuild: re-implement CONFIG_TRIM_UNUSED_KSYMS to
 make it work in one-pass
In-Reply-To: <CAK7LNAS97kTsOW_RSy1ZL2P5Q+5Hh05qvE4KwSVkvrhkzb3Shg@mail.gmail.com>
Message-ID: <2o2rpn97-79nq-p7s2-nq5-8p83391473r@syhkavp.arg>
References: <20210309151737.345722-1-masahiroy@kernel.org> <20210309151737.345722-4-masahiroy@kernel.org> <354sr3np-67o8-oss9-813s-p2qoro06p4o@syhkavp.arg> <CAK7LNAS97kTsOW_RSy1ZL2P5Q+5Hh05qvE4KwSVkvrhkzb3Shg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 465EC48A-8111-11EB-AAD6-E43E2BB96649-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 10 Mar 2021, Masahiro Yamada wrote:

> On Wed, Mar 10, 2021 at 2:36 AM Nicolas Pitre <nico@fluxnic.net> wrote:
> >
> > On Wed, 10 Mar 2021, Masahiro Yamada wrote:
> >
> > > Commit a555bdd0c58c ("Kbuild: enable TRIM_UNUSED_KSYMS again, with some
> > > guarding") re-enabled this feature, but Linus is still unhappy about
> > > the build time.
> > >
> > > The reason of the slowness is the recursion - this basically works in
> > > two loops.
> > >
> > > In the first loop, Kbuild builds the entire tree based on the temporary
> > > autoksyms.h, which contains macro defines to control whether their
> > > corresponding EXPORT_SYMBOL() is enabled or not, and also gathers all
> > > symbols required by modules. After the tree traverse, Kbuild updates
> > > autoksyms.h and triggers the second loop to rebuild source files whose
> > > EXPORT_SYMBOL() needs flipping.
> > >
> > > This commit re-implements CONFIG_TRIM_UNUSED_KSYMS to make it work in
> > > one pass. In the new design, unneeded EXPORT_SYMBOL() instances are
> > > trimmed by the linker instead of the preprocessor.
> > >
> > > After the tree traverse, a linker script snippet <generated/keep-ksyms.h>
> > > is generated. It feeds the list of necessary sections to vmlinus.lds.S
> > > and modules.lds.S. The other sections fall into /DISCARD/.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > I'm not sure I do understand every detail here, especially since it is
> > so far away from the version that I originally contributed. But the
> > concept looks good.
> >
> > I still think that there is no way around a recursive approach to get
> > the maximum effect with LTO, but given that true LTO still isn't applied
> > to mainline after all those years, the recursive approach brings
> > nothing. Maybe that could be revisited if true LTO ever makes it into
> > mainline, and the desire to reduce the binary size is still relevant
> > enough to justify it.
> 
> Hmm, I am confused.
> 
> Does this patch change the behavior in the
> combination with the "true LTO"?
> 
> Please let me borrow this sentence from your article:
> "But what LTO does is more like getting rid of branches that simply
> float in the air without being connected to anything or which have
> become loose due to optimization."
> (https://lwn.net/Articles/746780/)
> 
> This patch throws unneeded EXPORT_SYMBOL metadata
> into the /DISCARD/ section of the linker script.
> 
> The approach is different (preprocessor vs linker), but
> we will still get the same result; the unneeded
> EXPORT_SYMBOLs are disconnected from the main trunk.
> 
> Then, the true LTO will remove branches floating in the air,
> right?
> 
> So, what will be lost by this patch?

Let's say you have this in module_foo:

int foo(int x)
{
	return 2 + bar(x);
}
EXPORT_SYMBOL(foo);

And module_bar:

int bar(int y)
{
	return 3 * baz(y);
}
EXPORT_SYMBOL(bar);

And this in the main kernel image:

int baz(int z)
{
	return plonk(z);
}
EXPORT_SYMBOLbaz);

Now we build the kernel and modules. Then we realize that nothing 
references symbol "foo". We can trim the "foo" export. But it would be 
necessary to recompile module_foo with LTO (especially if there is 
some other code in that module) to realize that nothing 
references foo() any longer and optimize away the reference to bar(). 
With another round, we now realize that the "bar" export is no longer 
necessary. But that will require another compile round to optimize away 
the reference to baz(). And then a final compilation round with 
LTO to possibly optimize plonk() out of the kernel.

I don't see how you can propagate all this chain reaction with only one 
pass.


Nicolas
