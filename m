Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FBB159263
	for <lists+linux-arch@lfdr.de>; Tue, 11 Feb 2020 16:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgBKPAC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Feb 2020 10:00:02 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:59870 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgBKPAC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Feb 2020 10:00:02 -0500
X-Greylist: delayed 75858 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 10:00:00 EST
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 01BExjGY029325;
        Tue, 11 Feb 2020 23:59:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 01BExjGY029325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581433186;
        bh=hROq0o9lHJ1U2TLCvbGvuP+PaSOx9kk2PnxAttc0w9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jx75HfHE3ZrnOuJ9J3z4P9/aY0PCFXz+asYVatNJId47vVkMTwGE2+lj/IazoDP+m
         +8D9w2j1ZfupYBLvzkysIFS7lfLDk05sKN8gIYdyywOXoslk+CFxsc0K00nayKDELR
         1M2L1lEKUel5MtHMMou3K3vEZ5bWTTGgoxpkahK4fAHMgNJubQtOvFxO6WWi3EEQGd
         cifD6XZfR7JD6tLRgsJS7NEqr7VW3rwinVUGH3pxTz4R9K2dSeOT2oUbE1zG1uYiwo
         rs2ZVepq8CQSY02TLP/ci3tyCZ51cUaPz2NfXHejcqzusd1Zw5ivwAZO4vlksQYinr
         2l4PZtE/psBcA==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id b2so2481724vkk.4;
        Tue, 11 Feb 2020 06:59:45 -0800 (PST)
X-Gm-Message-State: APjAAAWucGMtN0Kw+4QtNRmzWwXhxyLufKXjL9eAQEvmnGEeyvGOPD4p
        8H08sTE4SvYIvxMNsK1yWoEkbpFLqlb4gnTIniM=
X-Google-Smtp-Source: APXvYqwaEhkM2LGDystFIroM3uA+deAF+AOLdRSitxDTFjOu34V62IFm0xHv3lwbg6gXEFp4DjWH9vKztbT7+FafnwY=
X-Received: by 2002:a1f:1bc3:: with SMTP id b186mr5042217vkb.96.1581433184417;
 Tue, 11 Feb 2020 06:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20200210175452.5030-1-masahiroy@kernel.org> <20200210143052.1d89f7e26c9bd115d617cc92@linux-foundation.org>
In-Reply-To: <20200210143052.1d89f7e26c9bd115d617cc92@linux-foundation.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 11 Feb 2020 23:59:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZnyj7pynscGtz+hQF2LPvzxW5YjHAOivjYZhT8Yq7VQ@mail.gmail.com>
Message-ID: <CAK7LNARZnyj7pynscGtz+hQF2LPvzxW5YjHAOivjYZhT8Yq7VQ@mail.gmail.com>
Subject: Re: [PATCH] asm-generic: make more kernel-space headers mandatory
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        X86 ML <x86@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andrew,

On Tue, Feb 11, 2020 at 7:30 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 11 Feb 2020 02:54:52 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > Change a header to mandatory-y if both of the following are met:
> >
> > [1] At least one architecture (except um) specifies it as generic-y in
> >     arch/*/include/asm/Kbuild
> >
> > [2] Every architecture (except um) either has its own implementation
> >     (arch/*/include/asm/*.h) or specifies it as generic-y in
> >     arch/*/include/asm/Kbuild
>
> (reads Documentation/kbuild/makefiles.rst to remember what these things
> do).
>
> Why are we making this change?  What's the benefit?


One obvious benefit is the diff stat:

 25 files changed, 52 insertions(+), 557 deletions(-)


It is tedious to list generic-y for each arch
that needs it.

So, mandatory-y works like a fallback default
(by just wrapping asm-generic one)
when arch does not have a specific header implementation.

See the following commits:

def3f7cefe4e81c296090e1722a76551142c227c
a1b39bae16a62ce4aae02d958224f19316d98b24


It is tedious to convert headers one by one,
so I processed by a shell script.


-- 
Best Regards
Masahiro Yamada
