Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C89E55D88B
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiF1HIg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 03:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiF1HIf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 03:08:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4A0B4A0;
        Tue, 28 Jun 2022 00:08:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A4E9B81CD2;
        Tue, 28 Jun 2022 07:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5220EC341D0;
        Tue, 28 Jun 2022 07:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656400112;
        bh=Dm+i1ahm5JO1Y0z9h4uqTDK4kJt3Abm9W7KKXWn4iRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qC+UQmphl8Hd+1T1U0QD9tDpqj4RMtyFkgyHY4s5qIB7gRI+xS50dQLQF60N4d53a
         pt8nrB+n/0dsGBpX9rzm604Cauhg2V1pGMdOs9Z8ftj1edDPVWFevjoguG98IqrTXI
         ivqLmEwSVJigzb4BvjUY8SyP2jqcLYvPGrfQt0+Lb4o5OGtjK05l74oqdAtZe6v+RV
         EiZUgKYNvTN+ggir5o2MPXO4/eJKq2WsfCAQvCsHp1NxR2fH/lMZBuGL6JAF9vspsB
         biRI4WdoUfZ8vhFQRuwocB5PEe84qldt+0c/fmHu+92iK9/LCneqYIva5kjHPnQFrz
         CH1QITDOJFbvA==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-318889e6a2cso107031767b3.1;
        Tue, 28 Jun 2022 00:08:32 -0700 (PDT)
X-Gm-Message-State: AJIora8MiVwDMPyfVFDg50UsNzIa8HEXJj852LRFNF2XK4Bl+jtVzBSX
        IkfkG7HMbEQJR83rL6kkMQu46XNHYTFUCNfeJ4o=
X-Google-Smtp-Source: AGRyM1vKbt5VKtzdC4XgmSFOrmSiRmjlG5/FEc3iJTDP+CtgJE9woQ9uDs2lLsQ8604dHCHHG6u5L7MmI7NPb3gwZE4=
X-Received: by 2002:a81:1d43:0:b0:318:638d:2ca with SMTP id
 d64-20020a811d43000000b00318638d02camr20536106ywd.135.1656400111255; Tue, 28
 Jun 2022 00:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org> <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com> <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com> <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
In-Reply-To: <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 28 Jun 2022 09:08:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com>
Message-ID: <CAK8P3a1ivqYB38c_QTjG8e85ZBnCB6HEa-6LR1HDc8shG1Pwmw@mail.gmail.com>
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
        Michael Ellerman <mpe@ellerman.id.au>
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

On Tue, Jun 28, 2022 at 5:25 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 28.06.2022 um 09:12 schrieb Michael Schmitz:
>
> Leaving the bounce buffer handling in place, and taking a few other
> liberties - this is what converting the easiest case (a3000 SCSI) might
> look like. Any obvious mistakes? The mvme147 driver would be very
> similar to handle (after conversion to a platform device).
>
> The driver allocates bounce buffers using kmalloc if it hits an
> unaligned data buffer - can such buffers still even happen these days?
> If I understand dma_map_single() correctly, the resulting dma handle
> would be equally misaligned?
>
> To allocate a bounce buffer, would it be OK to use dma_alloc_coherent()
> even though AFAIU memory used for DMA buffers generally isn't consistent
> on m68k?

I think it makes sense to skip the bounce buffering as you do here:
the only standardized way we have for integrating that part is to
use the swiotlb infrastructure, but as you mentioned earlier that
part is probably too resource-heavy here for Amiga.

I see two other problems with your patch though:

a) you still duplicate the cache handling: the cache_clear()/cache_push()
is supposed to already be done by dma_map_single() when the device
is not cache-coherent.

b) The bounce buffer is never mapped here, instead you have the
virt_to_phys() here, which is not the same. I think you need to map
the pointer that actually gets passed down to the device after deciding
to use a bouce buffer or not.

     Arnd
