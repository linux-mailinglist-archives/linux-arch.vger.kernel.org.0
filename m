Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF87478C5B
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 14:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhLQNcT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 08:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbhLQNcT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Dec 2021 08:32:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05530C061574;
        Fri, 17 Dec 2021 05:32:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 900C1621CB;
        Fri, 17 Dec 2021 13:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020BDC36AE9;
        Fri, 17 Dec 2021 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639747938;
        bh=KZBW/rMRU7rbSYZKD21VWSmK7jy1zknvA7ySAbpvyQM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K7WCtPVY0A9VZOZe2jFkFkse710KUy20VqS6w1h1n9n8Cz2Z6W5jOpdqsIo+9uh7F
         hhHwTrSSW3dUtB6+eYe4spSYjDPwfAzce/Fd0GfR7dS5hFTCsrccn+rM0dKGF9c5Ad
         z703Jm0mlj/S7YVKsW1Zd/a4o+859BtRaboRVnjd87jzUPkK5B3M9KVpjILNXfbZlX
         4KJpM+yUrsv29ZO108a+5+jTqLFWUFDNfJ6kiXtnMmy5lrRsaXvL13Hv32pqkfPV9j
         HlGR9A0a+vLjmLolOJ8nhcYeccIsLg+Turp9M+igViBJR2qknRo6pbz1Qx/TDS9/1u
         JtPlQpg3PmLnA==
Received: by mail-wm1-f47.google.com with SMTP id o29so1621517wms.2;
        Fri, 17 Dec 2021 05:32:17 -0800 (PST)
X-Gm-Message-State: AOAM5303Qh35AobgfC+lVzv2JNHvXyWvyOlRlT7v68+vkGr/H2+WGt8l
        Zz8RdxoIPbHee+RN7taHZZHzyA066Wubt+8AaPQ=
X-Google-Smtp-Source: ABdhPJyN5DNEhvLGFTImA30gbFFS/WJp4c3OYiR9lFPuHGjDZB9fpOGTxL15fXeiP02eK+er19UnuH/joPbaDKx/YH8=
X-Received: by 2002:a7b:c198:: with SMTP id y24mr7343815wmi.1.1639747936299;
 Fri, 17 Dec 2021 05:32:16 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com>
 <CAK8P3a1D5DzmNGsEPQomkyMCmMrtD6pQ11JRMh78vbY53edp-Q@mail.gmail.com>
 <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
 <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com> <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
 <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com> <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
 <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com> <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
 <dd2d49ef-3154-3c87-67b9-c134567ba947@huawei.com> <CAK8P3a3KTaa-AwCOjhaASMx63B3DUBZCZe6RKWk-=Qu7xr_ijQ@mail.gmail.com>
 <47744c7bce7b7bb37edee7f249d61dc57ac1fbc5.camel@linux.ibm.com>
In-Reply-To: <47744c7bce7b7bb37edee7f249d61dc57ac1fbc5.camel@linux.ibm.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 17 Dec 2021 14:32:00 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2eZ25PLSqEf_wmGs912WK8xRMuQHik2yAKj-WRQnDuRg@mail.gmail.com>
Message-ID: <CAK8P3a2eZ25PLSqEf_wmGs912WK8xRMuQHik2yAKj-WRQnDuRg@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     John Garry <john.garry@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 17, 2021 at 2:19 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
>
> I've had some time to look into this a bit. As a refreshed starting
> point I have rebased Arnd's patch to v5.16-rc5. Since I'm not sure how
> to handle authorship and it's very early I haven't sent it as RFC but
> it's available as a patch from my GitHub here:
> https://gist.github.com/niklas88/a08fe76bdf9f5798500fccea6583e275
>
> I have incorporated the following findings from this thread already:
>
> - Added HAS_IOPORT to arch Kconfigs
> - Added "config LEGACY_PCI" to drivers/pci/Kconfig
> - Fixed CONFIG_HAS_IOPORT typo in asm-generic/io.h
> - Removed LEGACY_PCI dependency of i2c-i801.
>   Which is also used in current gen Intel platforms
>   and depends on x86 anyway.
>
> I have tested this on s390 with HAS_IOPORT=n and allyesconfig as well
> as running it with defconfig. I've also been using it on my Ryzen 3990X
> workstation with LEGACY_PCI=n for a few days. I do get about 60 MiB
> fewer modules compared with a similar config of v5.15.8. Hard to say
> which other systems might miss things of course.
>
> I have not yet worked on the discussed IOPORT_NATIVE flag. Mostly I'm
> wondering two things. For one it feels like that could be a separate
> change on top since HAS_IOPORT + LEGACY_PCI is already quite big.
> Secondly I'm wondering about good ways of identifying such drivers and
> how much this overlaps with the ISA config flag.
>
> I'd of course appreciate feedback. If you agree this is still
> worthwhile to persue I'd think the next step would be trying to
> refactor this into more manageable patches.

Thanks a lot for restarting this work! I think this all looks reasonable
(a lot was my original patch anyway, so of course I think that ;)), but
it would be good to split it up into multiple patches.

The CONFIG_LEGACY_PCI should take care of a lot of it, and I
think that can be a single patch. I'd expand the Kconfig description
to explain that this also covers PCIe devices that use the legacy
I/O space even if they do not have a PCIe-to-PCI bridge in them.

The introduction of CONFIG_HAS_IOPORT, plus selecting it from
the respective architectures makes sense as another patch, but
I would make that separate from the #ifdef and 'depends on'
changes to individual subsystems or drivers, as they are
better reviewed separately.

        Arnd
