Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D955C436
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbiF1HMa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 03:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbiF1HMY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 03:12:24 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F3275ED;
        Tue, 28 Jun 2022 00:12:23 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 72-20020a9d064e000000b00616c2a174bcso4959937otn.8;
        Tue, 28 Jun 2022 00:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUnjhZMiGNi6v7nsbqYIrss5xtOvLOvLOLR2zcKJEss=;
        b=pwgXE9ASW272OrQ+E7wc+SE/zdC/UVcnYBxOBu2c8vdTxqdsrKMf5etatU5rN3LqV6
         ZTQ6kzJK9wLPj1yQ4YJqXr1lb3LfK2vG9Ulp12Edv/QbzCBd26BalTzHQHCdZqLkAahp
         Fyrpaeb7PU+m+vb9uAwwA8e2T7MENtwY9bwVeFTedGdOjftdyV/f8KCW5ZtyBUjkSA7g
         3MHNcw+JonBdn+oXwBfbufs6tT/FrYbEA25gMxj5awJvYteFd8+DdOpuUAKi0dE/xhg/
         Jkg6qWYGio08y2L0eYGd9VlgYahjZ5EZcs5S8IYVP0a2j5PhSryccgHUlq/LUXuq/fff
         VZuA==
X-Gm-Message-State: AJIora8c9gX1J9zXRtsQgKi6+TqlKZ776WBgEZHA+dS1wAADNOIu1SQO
        ZE6bsbds/9lyBfmFzrSwyjzn+FU9f1oItg==
X-Google-Smtp-Source: AGRyM1s3Qlhtf97/24NjzMU/biTB7w/Oxmese2Z882WPUas3yKevC6g2NAF0plGs77VypkUoeoKfJg==
X-Received: by 2002:a9d:4808:0:b0:616:b002:4516 with SMTP id c8-20020a9d4808000000b00616b0024516mr7571527otf.13.1656400343039;
        Tue, 28 Jun 2022 00:12:23 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id m8-20020a4aab88000000b0041ea640396csm7302713oon.41.2022.06.28.00.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 00:12:22 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id w2-20020a056830110200b00616ce0dfcb2so3828822otq.1;
        Tue, 28 Jun 2022 00:12:22 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr18678075ybb.202.1656399845934; Tue, 28
 Jun 2022 00:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220617125750.728590-1-arnd@kernel.org> <20220617125750.728590-4-arnd@kernel.org>
 <6ba86afe-bf9f-1aca-7af1-d0d348d75ffc@gmail.com> <CAMuHMdVewn0OYA9oJfStk0-+vCKAUou+4Mvd5H2kmrSks1p5jg@mail.gmail.com>
 <b4e5a1c9-e375-63fb-ec7c-abb7384a6d59@gmail.com> <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
In-Reply-To: <9289fd82-285c-035f-5355-4d70ce4f87b0@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Jun 2022 09:03:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
Message-ID: <CAMuHMdXUihTPD9A9hs__Xr2ErfOqkZ5KgCHqm+9HvRf39uS5kA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch/*/: remove CONFIG_VIRT_TO_BUS
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, scsi <linux-scsi@vger.kernel.org>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Michael,

On Tue, Jun 28, 2022 at 5:26 AM Michael Schmitz <schmitzmic@gmail.com> wrote:
> Am 28.06.2022 um 09:12 schrieb Michael Schmitz:
> > On 27/06/22 20:26, Geert Uytterhoeven wrote:
> >> On Sat, Jun 18, 2022 at 3:06 AM Michael Schmitz <schmitzmic@gmail.com>
> >> wrote:
> >>> Am 18.06.2022 um 00:57 schrieb Arnd Bergmann:
> >>>> From: Arnd Bergmann <arnd@arndb.de>
> >>>>
> >>>> All architecture-independent users of virt_to_bus() and bus_to_virt()
> >>>> have been fixed to use the dma mapping interfaces or have been
> >>>> removed now.  This means the definitions on most architectures, and the
> >>>> CONFIG_VIRT_TO_BUS symbol are now obsolete and can be removed.
> >>>>
> >>>> The only exceptions to this are a few network and scsi drivers for m68k
> >>>> Amiga and VME machines and ppc32 Macintosh. These drivers work
> >>>> correctly
> >>>> with the old interfaces and are probably not worth changing.
> >>> The Amiga SCSI drivers are all old WD33C93 ones, and replacing
> >>> virt_to_bus by virt_to_phys in the dma_setup() function there would
> >>> cause no functional change at all.
> >> FTR, the sgiwd93 driver use dma_map_single().
> >
> > Thanks! From what I see, it doesn't have to deal with bounce buffers
> > though?
>
> Leaving the bounce buffer handling in place, and taking a few other
> liberties - this is what converting the easiest case (a3000 SCSI) might
> look like. Any obvious mistakes? The mvme147 driver would be very
> similar to handle (after conversion to a platform device).

Thanks, looks reasonable.

> The driver allocates bounce buffers using kmalloc if it hits an
> unaligned data buffer - can such buffers still even happen these days?

No idea.

> If I understand dma_map_single() correctly, the resulting dma handle
> would be equally misaligned?
>
> To allocate a bounce buffer, would it be OK to use dma_alloc_coherent()
> even though AFAIU memory used for DMA buffers generally isn't consistent
> on m68k?
>
> Thinking ahead to the other two Amiga drivers - I wonder whether
> allocating a static bounce buffer or a DMA pool at driver init is likely
> to succeed if the kernel runs from the low 16 MB RAM chunk? It certainly
> won't succeed if the kernel runs from a higher memory address, so the
> present bounce buffer logic around amiga_chip_alloc() might still need
> to be used here.
>
> Leaves the question whether converting the gvp11 and a2091 drivers is
> actually worth it, if bounce buffers still have to be handled explicitly.

A2091 should be straight-forward, as A3000 is basically A2091 on the
motherboard (comparing the two drivers, looks like someone's been
sprinkling mb()s over the A3000 driver).

I don't have any of these SCSI host adapters (not counting the A590
(~A2091) expansion of the old A500, which is not Linux-capable, and
 hasn't been powered on for 20 years).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
