Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC57332DED
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 19:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbhCISMo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 13:12:44 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:20721 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbhCISMY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 13:12:24 -0500
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 129IC3KQ006389;
        Wed, 10 Mar 2021 03:12:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 129IC3KQ006389
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615313524;
        bh=ZUPoUl+tC2lTFpMNgXSXMzOjClyf1MCW12Qo/lD0z2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zhbphs8TIo+Y6zeLOkkcrF42F0Ka9psfSrdVDAtX8MB4EYAhLH0fI2z9TGC2W7TC5
         /sejuYgEdYYPVVUkChm/txlw5fbU0ekUO1J8pKVRDmZhZnGf557oJFI0xRHq5mslfa
         xEu3aSeGvrsf2leHVAnE/1CuSlgsibisArAwUfYj/aA79e7O1faj/Zcv78INtrA0jF
         TeuUkTI1tEBU7wswjaI5q7HMWVzTy4qKTNDbAWAzIpgMgub5v6KrL/bNS+RMT09KCp
         6xaq0yW7iOfkmkzoTcYq1NKv2sAmzUNDGRAPXj5nGzw6un15O2cRuFYJDPeYOJDJsb
         R/BTTOV/H8tJA==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so5646271pjb.0;
        Tue, 09 Mar 2021 10:12:03 -0800 (PST)
X-Gm-Message-State: AOAM530XzaBNtchBD5ScjfP1uvUVXUn2/tSnt5JZH9cEFbOjJgFOMIYb
        BQIczoS1KFBXfrwM/f96GPoI1DuP9VlUWoATrwY=
X-Google-Smtp-Source: ABdhPJzCqaUEZwPYSQuKendomz65iaWonVPdxwyZQKGk2EXnT24LZfVPw0mM6kLgmskLjuAk+pm7VsXBFbGtVXbYLHA=
X-Received: by 2002:a17:90a:dc08:: with SMTP id i8mr5668771pjv.153.1615313522797;
 Tue, 09 Mar 2021 10:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20210309151737.345722-1-masahiroy@kernel.org> <20210309151737.345722-4-masahiroy@kernel.org>
 <354sr3np-67o8-oss9-813s-p2qoro06p4o@syhkavp.arg>
In-Reply-To: <354sr3np-67o8-oss9-813s-p2qoro06p4o@syhkavp.arg>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 10 Mar 2021 03:11:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS97kTsOW_RSy1ZL2P5Q+5Hh05qvE4KwSVkvrhkzb3Shg@mail.gmail.com>
Message-ID: <CAK7LNAS97kTsOW_RSy1ZL2P5Q+5Hh05qvE4KwSVkvrhkzb3Shg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] kbuild: re-implement CONFIG_TRIM_UNUSED_KSYMS to
 make it work in one-pass
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 10, 2021 at 2:36 AM Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Wed, 10 Mar 2021, Masahiro Yamada wrote:
>
> > Commit a555bdd0c58c ("Kbuild: enable TRIM_UNUSED_KSYMS again, with some
> > guarding") re-enabled this feature, but Linus is still unhappy about
> > the build time.
> >
> > The reason of the slowness is the recursion - this basically works in
> > two loops.
> >
> > In the first loop, Kbuild builds the entire tree based on the temporary
> > autoksyms.h, which contains macro defines to control whether their
> > corresponding EXPORT_SYMBOL() is enabled or not, and also gathers all
> > symbols required by modules. After the tree traverse, Kbuild updates
> > autoksyms.h and triggers the second loop to rebuild source files whose
> > EXPORT_SYMBOL() needs flipping.
> >
> > This commit re-implements CONFIG_TRIM_UNUSED_KSYMS to make it work in
> > one pass. In the new design, unneeded EXPORT_SYMBOL() instances are
> > trimmed by the linker instead of the preprocessor.
> >
> > After the tree traverse, a linker script snippet <generated/keep-ksyms.h>
> > is generated. It feeds the list of necessary sections to vmlinus.lds.S
> > and modules.lds.S. The other sections fall into /DISCARD/.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> I'm not sure I do understand every detail here, especially since it is
> so far away from the version that I originally contributed. But the
> concept looks good.
>
> I still think that there is no way around a recursive approach to get
> the maximum effect with LTO, but given that true LTO still isn't applied
> to mainline after all those years, the recursive approach brings
> nothing. Maybe that could be revisited if true LTO ever makes it into
> mainline, and the desire to reduce the binary size is still relevant
> enough to justify it.

Hmm, I am confused.

Does this patch change the behavior in the
combination with the "true LTO"?


Please let me borrow this sentence from your article:
"But what LTO does is more like getting rid of branches that simply
float in the air without being connected to anything or which have
become loose due to optimization."
(https://lwn.net/Articles/746780/)


This patch throws unneeded EXPORT_SYMBOL metadata
into the /DISCARD/ section of the linker script.

The approach is different (preprocessor vs linker), but
we will still get the same result; the unneeded
EXPORT_SYMBOLs are disconnected from the main trunk.

Then, the true LTO will remove branches floating in the air,
right?

So, what will be lost by this patch?



>
> Acked-by: Nicolas Pitre <nico@fluxnic.net>
>
>
> Nicolas



-- 
Best Regards
Masahiro Yamada
