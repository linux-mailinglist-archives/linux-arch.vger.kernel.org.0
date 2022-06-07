Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553ED53F9FE
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jun 2022 11:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239815AbiFGJky (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jun 2022 05:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiFGJkx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jun 2022 05:40:53 -0400
X-Greylist: delayed 1850 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 02:40:52 PDT
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03690CEBA8;
        Tue,  7 Jun 2022 02:40:51 -0700 (PDT)
Received: from [209.85.167.51] (port=37853 helo=mail-lf1-f51.google.com)
        by mailhub-cam-d.mythic-beasts.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martyn@welchs.me.uk>)
        id 1nyVE1-003zlp-WA; Tue, 07 Jun 2022 10:10:10 +0100
Received: by mail-lf1-f51.google.com with SMTP id h23so27287734lfe.4;
        Tue, 07 Jun 2022 02:10:00 -0700 (PDT)
X-Gm-Message-State: AOAM532IEu8m6h76Q3U0jyT9u2nSVPrti0oQ/VpwLjzu5g3xaKE+2MSU
        +djjrWk6VeKBuI71qAAjdtM1jskWQQie0p1QjAM=
X-Google-Smtp-Source: ABdhPJyULPIdIsKuXm4CBLs/lpx9OuZtHR1zOwsK0gfemBq6DPfmp1b12GD3NCSmZN55f3UVzaaZOjEGtnFIMz9tvoo=
X-Received: by 2002:a05:6512:13a1:b0:448:887e:da38 with SMTP id
 p33-20020a05651213a100b00448887eda38mr18154426lfa.298.1654593000256; Tue, 07
 Jun 2022 02:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220606084109.4108188-1-arnd@kernel.org> <Yp3ID86TBFxl7qyL@kroah.com>
In-Reply-To: <Yp3ID86TBFxl7qyL@kroah.com>
From:   Martyn Welch <martyn@welchs.me.uk>
Date:   Tue, 7 Jun 2022 10:09:49 +0100
X-Gmail-Original-Message-ID: <CAEccXecB=rkZ1Kejmzcfay6qMMVo7Kb7SovSq+Xs1zWMnJOxnQ@mail.gmail.com>
Message-ID: <CAEccXecB=rkZ1Kejmzcfay6qMMVo7Kb7SovSq+Xs1zWMnJOxnQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] phase out CONFIG_VIRT_TO_BUS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        Khalid Aziz <khalid@gonehiking.org>,
        linux-scsi@vger.kernel.org,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-parisc@vger.kernel.org, Denis Efremov <efremov@linux.com>
Content-Type: text/plain; charset="UTF-8"
X-BlackCat-Spam-Score: 14
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 6 Jun 2022 at 10:25, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jun 06, 2022 at 10:41:03AM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The virt_to_bus/bus_to_virt interface has been deprecated for
> > decades. After Jakub Kicinski put a lot of work into cleaning out the
> > network drivers using them, there are only a couple of other drivers
> > left, which can all be removed or otherwise cleaned up, to remove the
> > old interface for good.
> >
> > Any out of tree drivers using virt_to_bus() should be converted to
> > using the dma-mapping interfaces, typically dma_alloc_coherent()
> > or dma_map_single()).
> >
> > There are a few m68k and ppc32 specific drivers that keep using the
> > interfaces, but these are all guarded with architecture-specific
> > Kconfig dependencies, and are not actually broken.
> >
> > There are still a number of drivers that are using virt_to_phys()
> > and phys_to_virt() in place of dma-mapping operations, and these
> > are often broken, but they are out of scope for this series.
>
> I'll take patches 1 and 2 right now through my staging tree if that's
> ok.
>

Hi,

I'd love to say that I could fix this stuff up, however I've lacked access to
suitable hardware for a long time now and don't foresee that changing any
time soon...

Martyn

> thanks,
>
> greg k-h
>
