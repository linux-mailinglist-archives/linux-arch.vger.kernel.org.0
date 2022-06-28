Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8821555F0A9
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 23:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiF1Vzi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiF1Vzh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 17:55:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35E21AF1A;
        Tue, 28 Jun 2022 14:55:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E70E618C7;
        Tue, 28 Jun 2022 21:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E13C341CD;
        Tue, 28 Jun 2022 21:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656453335;
        bh=Ih9a5Om/MmEIX4v6ClfaGsYY95Thx/a8Y6asrG6fwXg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b9uS1y9zZH5shNehIU788hla2D3cqHzEuOf4ntBz7MxqozEJwfWJnE7Ks7x80vJUW
         8kv3pqmsjiCee09PX0yvTGcEx2Cut7rd5VUEPi1Ok/r71Li89UIa9lEeJs5lir3L9G
         dn4sMp8EjadD8vyN158bB9WMKMo5ug00j2hr3Rw0LFCkWa1OVhmADFgMiyWCAjhqeq
         2pPGkYfNIcwUIJa/2IbGbgiBIvXriXV6e543WcMEwsN7/jAf15mGlk3t/07+apGlTT
         9sZR5rPOipfKd8HT5ntaMBYuQG73aLI/777pK3YIaE2zifWvCB2udwOFws1KKx4vlJ
         kWfB059WXYR2A==
Received: by mail-yb1-f177.google.com with SMTP id i7so24496795ybe.11;
        Tue, 28 Jun 2022 14:55:35 -0700 (PDT)
X-Gm-Message-State: AJIora/FxTrjp0wIzxv6CQDTIDEof8qJpvgfGJARNat5PBxKqZStB2k0
        Eb7uLbyCYFvIS7xTc9tMDmlYP486ikdYzdZjPfw=
X-Google-Smtp-Source: AGRyM1tb4BjbkpD5w5tudBkGYRK/cIE8Bb7XiI/EYhHGbLLjj5dThHoetSIfSlMkV4AlJod7kkGZlzoBKXhTY7DLP7I=
X-Received: by 2002:a05:6902:120f:b0:668:2228:9627 with SMTP id
 s15-20020a056902120f00b0066822289627mr22801646ybu.134.1656453334640; Tue, 28
 Jun 2022 14:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org> <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com> <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com> <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
 <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com> <b1edec96-ccb2-49d6-323b-1abc0dc37a50@gmail.com>
In-Reply-To: <b1edec96-ccb2-49d6-323b-1abc0dc37a50@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 28 Jun 2022 23:55:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2jvFQBvKfdR5ivDBECN5tEej6Ja4=7Loze646hrQ5wzg@mail.gmail.com>
Message-ID: <CAK8P3a2jvFQBvKfdR5ivDBECN5tEej6Ja4=7Loze646hrQ5wzg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Matt Wang <wwentao@vmware.com>,
        Miquel van Smoorenburg <mikevs@xs4all.net>,
        Mark Salyzyn <salyzyn@android.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 28, 2022 at 11:38 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
> On 28/06/22 19:08, Arnd Bergmann wrote:
> > I see two other problems with your patch though:
> >
> > a) you still duplicate the cache handling: the cache_clear()/cache_push()
> > is supposed to already be done by dma_map_single() when the device
> > is not cache-coherent.
>
> That's one of the 'liberties' I alluded to. The reason I left these in
> is that I'm none too certain what device feature the DMA API uses to
> decide a device isn't cache-coherent. If it's dev->coherent_dma_mask,
> the way I set up the device in the a3000 driver should leave the
> coherent mask unchanged. For the Zorro drivers, devices are set up to
> use the same storage to store normal and coherent masks - something we
> most likely want to change. I need to think about the ramifications of
> that.
>
> Note that zorro_esp.c uses dma_sync_single_for_device() and uses a 32
> bit coherent DMA mask which does work OK. I might  ask Adrian to test a
> change to only set dev->dma_mask, and drop the
> dma_sync_single_for_device() calls if there's any doubt on this aspect.

The "coherent_mask" is independent of the cache flushing. On some
architectures, a device can indicate whether it needs cache management
or not to guarantee coherency, but on m68k it appears that we always
assume it does, see arch/m68k/kernel/dma.c

> > b) The bounce buffer is never mapped here, instead you have the
> > virt_to_phys() here, which is not the same. I think you need to map
> > the pointer that actually gets passed down to the device after deciding
> > to use a bouce buffer or not.
>
> I hadn't realized that I can map the bounce buffer just as it's done for
> the SCp data buffer. Should have been obvious, but I'm still learning
> about the DMA API.
>
> I've updated the patch now, will re-send as part of a complete series
> once done.

I suppose you can just drop the bounce buffer if this just comes
from kmalloc().

       Arnd
