Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD755B04A
	for <lists+linux-arch@lfdr.de>; Sun, 26 Jun 2022 10:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiFZIg2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Jun 2022 04:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiFZIg2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jun 2022 04:36:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77431054B;
        Sun, 26 Jun 2022 01:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 11B25CE0FC4;
        Sun, 26 Jun 2022 08:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41580C341D8;
        Sun, 26 Jun 2022 08:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656232582;
        bh=juR3pWHFZdE8Vf6QGsSTJiJ2f3ZwildJoxwQZWNpG/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f6yc1RaNJwQq5dElIkyuYvUvwHkvBLBi9KqlHP2ZC+oxWcerSMGK3hkxIM7cIAAT/
         TtueQ33cy4/n0Uda61TReBytE65eLfQrezytZmtm7bX//WKI/yOT60iTP49ZEIOPSW
         6z1NOCnw36qsukMeObt289BsjK4np0rxC1P8TL2Fy3MIi0PXPCcxYI0ThEmMrCWGfS
         UrkYBYjapcfJFTuf2LfH5cpnGXFFNt0wE6A6XBDTb085dl806k7RyMDAUO+JHUYTkX
         Au2xvaXvS/pK8PTQWyJuWsS1hRHbV8q3oa+eOltOLdGmLNGlNuBwPHqKBVX/LvLixJ
         OvRvGfKxK4K+w==
Received: by mail-yb1-f174.google.com with SMTP id h187so9569940ybg.0;
        Sun, 26 Jun 2022 01:36:22 -0700 (PDT)
X-Gm-Message-State: AJIora+WE7CBSMpN5yeJ0ShnL/3L5tQrerlTtqlFOGQtN7+wOCgkBfb9
        CrGeHkihKKllOOy0iR/ubsfNxVTQV7l50KK79Pc=
X-Google-Smtp-Source: AGRyM1s9r/oqGpmVzKxZ+US+FaaRE8PSLnvRSxz/eiJkctG/2AzfYvDmvG4YKVmQhXgJnW7ApVihluVitAAeI1SlHhw=
X-Received: by 2002:a25:8b8b:0:b0:669:b37d:f9cd with SMTP id
 j11-20020a258b8b000000b00669b37df9cdmr7722013ybl.394.1656232581073; Sun, 26
 Jun 2022 01:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org> <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com> <CAK8P3a1XfwkTOV7qOs1fTxf4vthNBRXKNu8A5V7TWnHT081NGA@mail.gmail.com>
 <6d1d88ee-1cf6-c735-1e6d-bafd2096e322@gmail.com>
In-Reply-To: <6d1d88ee-1cf6-c735-1e6d-bafd2096e322@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 26 Jun 2022 10:36:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1KKPXr0ews9po_xjmnGYUWf18gBaZYYmnC+DvtxTKLmQ@mail.gmail.com>
Message-ID: <CAK8P3a1KKPXr0ews9po_xjmnGYUWf18gBaZYYmnC+DvtxTKLmQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(On Sun, Jun 26, 2022 at 7:21 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
>  > The same could be done for the two vme drivers (scsi/mvme147.c
> > and ethernet/82596.c), which do the cache management but
> > apparently don't need swiotlb bounce buffering.
> >
> > Rewriting the drivers to modern APIs is of course non-trivial,
> > and if you want a shortcut here, I would suggest introducing
> > platform specific helpers similar to isa_virt_to_bus() and call
> > them amiga_virt_to_bus() and vme_virt_to_bus, respectively.
>
> I don't think Amiga and m68k VME differ at all in that respect, so might
> just call it m68k_virt_to_bus() for now.
>
> > Putting these into a platform specific header file at least helps
> > clarify that both the helper functions and the drivers using them
> > are non-portable.
>
> There are no platform specific header files other than asm/amigahw.h and
> asm/mvme147hw.h, currently only holding register address definitions.
> Would it be OK to add m68k_virt_to_bus() in there if it can't remain in
> asm/virtconvert.h, Geert?

In that case, I would just leave it under the current name and not change
m68k at all. I don't like the m68k_virt_to_bus() name because there is
not anything CPU specific in what it does, and keeping it in a common
header does nothing to prevent it from being used on other platforms
either.

> >> 32bit powerpc is a different matter though.
> >
> > It's similar, but unrelated. The two apple ethernet drivers
> > (bmac and mace) can again either get changed to use the
> > dma-mapping interfaces, or get a custom pmac_virt_to_bus()/
> > pmac_bus_to_virt() helper.
>
> Hmmm - I see Finn had done the DMA API conversion on macmace.c which
> might give some hints on what to do about mace.c ... no idea about
> bmac.c though. And again, haven't got hardware to test, so custom
> helpers is it, then.

Ok.

          Arnd
