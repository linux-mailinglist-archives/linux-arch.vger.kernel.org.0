Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5940A4790B7
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 16:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbhLQP4Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 10:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbhLQP4P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Dec 2021 10:56:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD96DC061574;
        Fri, 17 Dec 2021 07:56:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4606229D;
        Fri, 17 Dec 2021 15:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13FAC36AE1;
        Fri, 17 Dec 2021 15:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639756574;
        bh=aJGSLOLDVZQ4jsbHaydJnZJEiQHbT56U8N8TFU09vpM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=masnrHG+L03rpmbA+aizifZZ7NBeotxg2pGAudbMiSrZI95ppAePqshrrCbG5xJ4t
         BKM3jU6UoEiJbBeaEXNWQrXYuzIQokYiAQoQeokV3xJjoXfvwYKLQ3lbIyYMxgte1D
         lu6YPHYeBcsitoFH0CpT1kbmAM7NBZAiGtq7uKdsTPG7HxADYEH53i8wS3T6q8/bxn
         xfgdTP6l0cyPr5PoAV3ZSOesRrBYEz5u//kuVHq9dzDy1FASepwOVipH6oT+/SeWhw
         rgKL1X4Xx8sZKFQzfcT8K0I2hn65uvqUI8F9LlCmhdo4rjrswDTF1cXK+BSNJyPOHU
         0PU5xQtZ6O2cg==
Received: by mail-wr1-f46.google.com with SMTP id v11so4867947wrw.10;
        Fri, 17 Dec 2021 07:56:14 -0800 (PST)
X-Gm-Message-State: AOAM532b1ZN+SUeC5II5+ijdEdSbLeEYr+JzQH1XK6inh3FR74smJZFT
        NgZPHs5zqYhXRPh/1y0epSsXHqIVEdOMS98ndu0=
X-Google-Smtp-Source: ABdhPJzcVwEAILjoidpzItkyOHn+6QWhp7hZttF+ca01hCIVaSRmevaz8Fi541ZypirYAk0kDkqtzlmA+kdeyY9H0gI=
X-Received: by 2002:adf:f051:: with SMTP id t17mr3088681wro.192.1639756572995;
 Fri, 17 Dec 2021 07:56:12 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2oZ-+qd3Nhpy9VVXCJB3DU5N-y-ta2JpP0t6NHh=GVXw@mail.gmail.com>
 <CAK8P3a0MNbx-iuzW_-=0ab6-TTZzwV-PT_6gAC1Gp5PgYyHcrA@mail.gmail.com>
 <db043b76-880d-5fad-69cf-96abcd9cd34f@huawei.com> <CAK8P3a3HHeP+Gw_k2P7Qtig0OmErf0HN30G22+qHic_uZTh11Q@mail.gmail.com>
 <a74dfb1f-befd-92ce-4c30-233cb08e04d3@huawei.com> <CAK8P3a3B4FCaPPHhzBdpkv0fsjE0jREwGFCdPeHEDHxxRBEjng@mail.gmail.com>
 <5e8dfbd2-a6c0-6d02-53e9-1f29aebcc44e@huawei.com> <CAK8P3a08Zcyx0J4_LGAfU_AtUyEK+XtQJxYBQ52VXfWu8-o8_w@mail.gmail.com>
 <dd2d49ef-3154-3c87-67b9-c134567ba947@huawei.com> <CAK8P3a3KTaa-AwCOjhaASMx63B3DUBZCZe6RKWk-=Qu7xr_ijQ@mail.gmail.com>
 <47744c7bce7b7bb37edee7f249d61dc57ac1fbc5.camel@linux.ibm.com>
 <CAK8P3a2eZ25PLSqEf_wmGs912WK8xRMuQHik2yAKj-WRQnDuRg@mail.gmail.com>
 <849d70bddde1cfcb3ab1163970a148ff447ee94b.camel@linux.ibm.com>
 <53746e42-23a2-049d-9b38-dcfbaaae728f@huawei.com> <CAK8P3a0dnXX7Cx_kJ_yLAoQFCxoM488Ze-L+5v1m0YeyjF4zqw@mail.gmail.com>
 <cd9310ab-6012-a410-2bfc-a2f8dd8d62f9@huawei.com>
In-Reply-To: <cd9310ab-6012-a410-2bfc-a2f8dd8d62f9@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 17 Dec 2021 16:55:56 +0100
X-Gmail-Original-Message-ID: <CAK8P3a23jsT-=v8QDxSZYcj=ujhtBFXjACNLKxQybaThiBsFig@mail.gmail.com>
Message-ID: <CAK8P3a23jsT-=v8QDxSZYcj=ujhtBFXjACNLKxQybaThiBsFig@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] asm-generic: rework PCI I/O space access
To:     John Garry <john.garry@huawei.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Dec 17, 2021 at 4:27 PM John Garry <john.garry@huawei.com> wrote:
> On 17/12/2021 14:32, Arnd Bergmann wrote:
>  From looking at the patch Niklas directed us at, as I understand,
> HAS_IOPORT is to decide whether the arch/platform may support PIO
> accessors - inb et al. And on that basis I am confused why it is not
> selected for arm64. And further compounded by:
>
>   config INDIRECT_PIO
>                 bool "Access I/O in non-MMIO mode"
>                 depends on ARM64
>         +       depends on HAS_IOPORT
>
> If arm64 does not select, then why depend on it?

Right, both arm32 and arm64 need to select HAS_IOPORT.

>  > If you have a better way of finding the affected drivers,
>  > that would be great.
>
> Assuming arm64 should select HAS_IOPORT, I am talking about f71805f as
> an example. According to that patch, this driver additionally depends on
> HAS_IOPORT; however I would rather arm64, like powerpc, should not allow
> that driver to be built at all.

Agreed, I missed these when I looked through the HAS_IOPORT users,
that's why I suggested to split up that part of the patch per subsystem
so they can be inspected more carefully.

My feeling is that in this case we want some other dependency, e.g. a
new CONFIG_LPC. It should actually be possible to use this driver on
any machine with an LPC bus, which would by definition be the primary
I/O space, so it should be possible to load it on Arm64.

         Arnd
