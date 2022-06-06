Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D50253EA1A
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jun 2022 19:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240181AbiFFPAm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jun 2022 11:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbiFFPAh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2022 11:00:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E7F3202E0;
        Mon,  6 Jun 2022 08:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 113B3B81A7D;
        Mon,  6 Jun 2022 15:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C323AC3411C;
        Mon,  6 Jun 2022 15:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654527633;
        bh=tFvHiguChguydwXgPPk94DDRc3Gna/VqX+wPqkO+GTs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JA16jqbQeuWcQ2BdBv+Na1yw2Fsv4ZNsgyX0Rir5y0HP5v8ayb+DbcrlkdEodaQHA
         p5mVtsR0j5VssOuJq1SuTacSyYnh9FuWA7MuF+LpD4B/1NPTEyhQEMmpNVLQQcrRkm
         U2oDsmygP0mrNelWLqRVw+a46FbnSUaK6OXCijFA2qXWJTMua6Yk019a2K1ckpmqw6
         r3a9iBGJ/qoKmfY5S0H8iPxHqsHuzCugiFQwVIbANF//xPXt1pHymPJGdfeCGSHFC8
         2jWVp9Out3KIzaXURE3QhE/Hlijm7XMMwmZKLO4AZsYhWDtxtBR5/CLwG39yZO+OFL
         rj3ILMq9jcjfg==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-30c1c9b9b6cso145534197b3.13;
        Mon, 06 Jun 2022 08:00:33 -0700 (PDT)
X-Gm-Message-State: AOAM531X2ycY+QdFep2znvfDFXOHKkr0uVcHvUqbMu6HWKPsn3bM8y6k
        V+C3ufxUQxX2XIbSEZcDyYFYPupVVm+IVJ5MREk=
X-Google-Smtp-Source: ABdhPJyPD1+vFTL7zI7MOAWlVQpzZfCC/ogYQOnb9fs+BnJ9OUYDclIzyORrk2d04n90LZcBaiPMBu6CLlPqCKGn2dQ=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr26970693ywk.209.1654527628777; Mon, 06
 Jun 2022 08:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220606084109.4108188-1-arnd@kernel.org> <20220606084109.4108188-6-arnd@kernel.org>
 <alpine.DEB.2.21.2206061057060.19680@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2206061057060.19680@angie.orcam.me.uk>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 6 Jun 2022 17:00:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0pqQHMucGgZDcLpoWMhoyU5yppXK=8y4Wsn0QL7=uD0g@mail.gmail.com>
Message-ID: <CAK8P3a0pqQHMucGgZDcLpoWMhoyU5yppXK=8y4Wsn0QL7=uD0g@mail.gmail.com>
Subject: Re: [PATCH 5/6] scsi: remove stale BusLogic driver
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Matt Wang <wwentao@vmware.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 6, 2022 at 12:40 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> On Mon, 6 Jun 2022, Arnd Bergmann wrote:
>
> > This was in turn fixed in commit 56f396146af2 ("scsi: BusLogic: Fix
> > 64-bit system enumeration error for Buslogic"), 8 years later.
> >
> > The fact that this was found at all is an indication that there are
> > users, and it seems that Maciej, Matt and Khalid all have access to
> > this hardware, but if it took eight years to find the problem,
> > it's likely that nobody actually relies on it.
>
>  Umm, I use it with a 32-bit system, so it would be quite an issue for me
> to discover a problem with 64-bit configurations.  And I quite rely on
> this system for various stuff too!

Ok, good to know.

> > Remove it as part of the global virt_to_bus()/bus_to_virt() removal.
> > If anyone is still interested in keeping this driver, the alternative
> > is to stop it from using bus_to_virt(), possibly along the lines of
> > how dpt_i2o gets around the same issue.
>
>  Thanks for the pointer and for cc-ing me.  Please refrain from removing
> the driver at least for this release cycle and let me fix it.

Sure, no problem. It looks like I forgot to actually Cc you on the series
as I had meant to, glad it reached you anyway.

> It should be easy to mimic what I did for the defza driver: all bus addresses in
> the DMA API come associated with virtual addresses, so it is just a matter of
> recording those somewhere for later use rather than trying to mess up with
> bus addresses to figure out a reverse mapping.

I looked at the defza driver and that one appears simpler to me, as you
can look up the virtual address from an index, but it's possible I missed
what you do here. I meant specifically the calculation added by commit
67af2b060e02 ("[SCSI] dpt_i2o: move from virt_to_bus/bus_to_virt
to dma_alloc_coherent") in the dpt_i2o driver that can be used to
compute the virtual address. If something simpler works as well, that
is of course better.

        Arnd
