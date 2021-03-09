Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E958033302F
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 21:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCIUpm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 15:45:42 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53658 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhCIUpl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 15:45:41 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FEB01102BA;
        Tue,  9 Mar 2021 15:45:41 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=EEYwpmFMJz/Z1AgLx4UEkY2a7TY=; b=A+mH1O
        c1PcaW1tSDQA2SKj0RshxFRwew6Dl6KkzQfXji8lCp4h6cs8ybWK27TNIOu1rDiL
        /EL612xfThupmlJ5NUOYIXXzlCb9CoaWJthKQ1d0afMwjplDuO2SPWDeUpcNw+ya
        aJWeXzi14cOgCKnuKCNYaOEuoaMcGP8YZdaqY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 27F411102B9;
        Tue,  9 Mar 2021 15:45:41 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=cuCrynyQbZUCmAFxNmmsDHUNaKl+Dz8eSo9v8dYEUyM=; b=aDbwHVhaCo5zybUV8wvOeYHobRp0AFDA3j1wtDMf38tt1yPMIrdHImpB2oNjdGyyDXlBfgpW6Kkx8izrLUNDzhafMPv7oSYrr1TY2Ga02EUz6ASY5jSFeCr7xUlybEt8oSFTrC8hfMo0Uifl80d0E+FG4hSRLvtfR79gPoeaBv8=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 188A01102B4;
        Tue,  9 Mar 2021 15:45:38 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 4A4E02DA017E;
        Tue,  9 Mar 2021 15:45:36 -0500 (EST)
Date:   Tue, 9 Mar 2021 15:45:36 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] kbuild: re-implement CONFIG_TRIM_UNUSED_KSYMS to
 make it work in one-pass
In-Reply-To: <fb8af488-8137-d628-b1c4-983b9ab153a3@rasmusvillemoes.dk>
Message-ID: <14opoo4p-569n-6860-q71s-9o6qs4451rs4@syhkavp.arg>
References: <20210309151737.345722-1-masahiroy@kernel.org> <20210309151737.345722-4-masahiroy@kernel.org> <354sr3np-67o8-oss9-813s-p2qoro06p4o@syhkavp.arg> <CAK7LNAS97kTsOW_RSy1ZL2P5Q+5Hh05qvE4KwSVkvrhkzb3Shg@mail.gmail.com> <2o2rpn97-79nq-p7s2-nq5-8p83391473r@syhkavp.arg>
 <fb8af488-8137-d628-b1c4-983b9ab153a3@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 67893512-8118-11EB-A838-E43E2BB96649-78420484!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 9 Mar 2021, Rasmus Villemoes wrote:

> On 09/03/2021 20.54, Nicolas Pitre wrote:
> > On Wed, 10 Mar 2021, Masahiro Yamada wrote:
> > 
> 
> >>> I'm not sure I do understand every detail here, especially since it is
> >>> so far away from the version that I originally contributed. But the
> >>> concept looks good.
> >>>
> >>> I still think that there is no way around a recursive approach to get
> >>> the maximum effect with LTO, but given that true LTO still isn't applied
> >>> to mainline after all those years, the recursive approach brings
> >>> nothing. Maybe that could be revisited if true LTO ever makes it into
> >>> mainline, and the desire to reduce the binary size is still relevant
> >>> enough to justify it.
> >>
> >> Hmm, I am confused.
> >>
> >> Does this patch change the behavior in the
> >> combination with the "true LTO"?
> >>
> >> Please let me borrow this sentence from your article:
> >> "But what LTO does is more like getting rid of branches that simply
> >> float in the air without being connected to anything or which have
> >> become loose due to optimization."
> >> (https://lwn.net/Articles/746780/)
> >>
> >> This patch throws unneeded EXPORT_SYMBOL metadata
> >> into the /DISCARD/ section of the linker script.
> >>
> >> The approach is different (preprocessor vs linker), but
> >> we will still get the same result; the unneeded
> >> EXPORT_SYMBOLs are disconnected from the main trunk.
> >>
> >> Then, the true LTO will remove branches floating in the air,
> >> right?
> >>
> >> So, what will be lost by this patch?
> > 
> > Let's say you have this in module_foo:
> > 
> > int foo(int x)
> > {
> > 	return 2 + bar(x);
> > }
> > EXPORT_SYMBOL(foo);
> > 
> > And module_bar:
> > 
> > int bar(int y)
> > {
> > 	return 3 * baz(y);
> > }
> > EXPORT_SYMBOL(bar);
> > 
> > And this in the main kernel image:
> > 
> > int baz(int z)
> > {
> > 	return plonk(z);
> > }
> > EXPORT_SYMBOLbaz);
> > 
> > Now we build the kernel and modules. Then we realize that nothing 
> > references symbol "foo". We can trim the "foo" export. But it would be 
> > necessary to recompile module_foo with LTO (especially if there is 
> > some other code in that module) to realize that nothing 
> > references foo() any longer and optimize away the reference to bar(). 
> 
> But, does LTO even do that to modules? Sure, the export metadata for foo
> vanishes, so there's no function pointer reference to foo, but given
> that modules are just -r links, the compiler/linker can't really assume
> that the generated object won't later be linked with something that does
> require foo? At least for the simpler case of --gc-sections, ld docs say:
> 
> '--gc-sections'
> ...
> 
>     This option can be set when doing a partial link (enabled with
>      option '-r').  In this case the root of symbols kept must be
>      explicitly specified either by one of the options '--entry',
>      '--undefined', or '--gc-keep-exported' or by a 'ENTRY' command in
>      the linker script.
> 
> and I would assume that for LTO, --gc-keep-exported would be the only
> sane semantics (keep any external symbol with default visibility).
> 
> Can you point me at a tree/set of LTO patches and a toolchain where the
> previous implementation would actually eventually eliminate bar() from
> module_bar?

All that I readily have is a link to the article I wrote with the 
results I obtained at the time: https://lwn.net/Articles/746780/.
The toolchain and kernel tree are rather old at this point and some 
effort would be required to modernize everything.

I don't remember if there was something special to do LTO on modules. 
Maybe Andi Kleen had something in his patchset for that: 
https://github.com/andikleen/linux-misc/blob/lto-415-2/Documentation/lto-build
He mentions that LTO isn't very effective with modules enabled, but what 
I demonstrated in myarticle is that LTO becomes very effective with or 
without modules as long as CONFIG_TRIM_UNUSED_KSYMS is enabled.

Having CONFIG_TRIM_UNUSED_KSYMS in one pass is likely to still be pretty 
effective even if possibly not not optimal. And maybe people don't 
really care for the missing 10% anyway (I'm just throwing a number in 
the air 
here).


Nicolas
