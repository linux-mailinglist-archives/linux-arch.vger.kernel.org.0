Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B2E64B0A5
	for <lists+linux-arch@lfdr.de>; Tue, 13 Dec 2022 08:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbiLMH5E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Dec 2022 02:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiLMH5D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2022 02:57:03 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E929915713
        for <linux-arch@vger.kernel.org>; Mon, 12 Dec 2022 23:57:00 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u12so14706009wrr.11
        for <linux-arch@vger.kernel.org>; Mon, 12 Dec 2022 23:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6o0GeZJe7zgU/rQbNGO95bs2olhPXjHiwqfmfQC5R7A=;
        b=YjfllNNB32j4iHz3ehIUDe2K11iAW5NST8YgvWTvel7Ca2tyyrir/QmG3MBaAaF8Dw
         6BGujKvE2jVDfZlXrdKxkY1DRG6uRQwJSR99PkVDPktwI2r+5bEmOEZPkvtqqzX/y/Km
         7bLiFwkST1oDvgcEnyAgZyE3M8xj5oW0SNuWcmUJj87Klox8NRsl+ZfGlF5W2CqUc7tJ
         EjSzNEMA5iTQV3Y10avb0/4Tny9UNW47ZK3PXY06g0DqHjCKbvM8+MqmfV6L2MW6KLcF
         aeTyYXtRmfe1TbZRulomxOZ/4pitudsf5inLeOTbJmc6DWxXN3mHC27OLG/nq4x32j0t
         3UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o0GeZJe7zgU/rQbNGO95bs2olhPXjHiwqfmfQC5R7A=;
        b=BWSrwywH4BX6xtOajXTNwzyk2ZLq/C4Nztg5oikZcg5X500kofjHXwfw0reuA+0J/7
         yX51zQfZ7nhAAK9yVUccrEdq5LR5VSqidDN8KjeMCrT/al4BijV6WphUSD5i60CavuDJ
         YDbAE2CMEM3n6A8FEjCiJ1gMzbN9f9h0yvx1sF9V2G0ZbqCD+jWoSbJE14gLV47zQB1w
         15DellzfEpJ3EaN8e4RXmx8wPkiymI3vqlrsc63/BksOjHVRXpiGHo7/9Ku7jDDF8jLN
         Cf5GIXy0JN1vu1x/sP0IY2CZBhv6YHFje4WeKzpWTPR8ipzyNrFvWFPe96n6JMztUuqT
         eTPg==
X-Gm-Message-State: ANoB5pkLCbPJGE1GaUabR5+uDLIzzow6hO1pXW00CY7E6XvWXXBXuDzZ
        owd6gJoWPk0UNQhOuXBqe2/UAnUWklx84+vgbtOIaw==
X-Google-Smtp-Source: AA0mqf5CAW19crv/THSl7pw+ACF9HjBX2ntNgiivqTeLEk1s3kIsOF+Zmw7LKwen32ZAnBWYGYgoNLW+m979aqJdBe0=
X-Received: by 2002:a5d:504d:0:b0:242:246c:2f89 with SMTP id
 h13-20020a5d504d000000b00242246c2f89mr24102419wrt.108.1670918219475; Mon, 12
 Dec 2022 23:56:59 -0800 (PST)
MIME-Version: 1.0
References: <20221212143102.175065-1-alexghiti@rivosinc.com> <CAL_JsqJz4uf+956oC4BfZGdjb+rfAZqduexLw3=D5HHjtyBC+g@mail.gmail.com>
In-Reply-To: <CAL_JsqJz4uf+956oC4BfZGdjb+rfAZqduexLw3=D5HHjtyBC+g@mail.gmail.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 13 Dec 2022 08:56:48 +0100
Message-ID: <CAHVXubgu_Voet_TPB0z+yec4DG8TP2_nSTDUcQdW2yf20wvP1w@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Use PUD/P4D/PGD pages for the linear mapping
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Rob,


On Mon, Dec 12, 2022 at 6:54 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Mon, Dec 12, 2022 at 8:31 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >
> > During the early page table creation, we used to set the mapping for
> > PAGE_OFFSET to the kernel load address: but the kernel load address is
> > always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PGD
> > pages as this physical address is not aligned on PUD/P4D/PGD size (whereas
> > PAGE_OFFSET is).
> >
> > But actually we don't have to establish this mapping (ie set va_pa_offset)
> > that early in the boot process because:
> >
> > - first, setup_vm installs a temporary kernel mapping and among other
> >   things, discovers the system memory,
> > - then, setup_vm_final creates the final kernel mapping and takes
> >   advantage of the discovered system memory to create the linear
> >   mapping.
> >
> > During the first phase, we don't know the start of the system memory and
> > then until the second phase is finished, we can't use the linear mapping at
> > all and phys_to_virt/virt_to_phys translations must not be used because it
> > would result in a different translation from the 'real' one once the final
> > mapping is installed.
> >
> > So here we simply delay the initialization of va_pa_offset to after the
> > system memory discovery. But to make sure noone uses the linear mapping
> > before, we add some guard in the DEBUG_VIRTUAL config.
> >
> > Finally we can use PUD/P4D/PGD hugepages when possible, which will result
> > in a better TLB utilization.
> >
> > Note that we rely on the firmware to protect itself using PMP.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >
> > v2:
> > - Add a comment on why RISCV64 does not need to set initrd_start/end that
> >   early in the boot process, as asked by Rob
> >
> > Note that this patch is rebased on top of:
> > [PATCH v1 1/1] riscv: mm: call best_map_size many times during linear-mapping
> >
> >  arch/riscv/include/asm/page.h | 16 ++++++++++++++++
> >  arch/riscv/mm/init.c          | 25 +++++++++++++++++++------
> >  arch/riscv/mm/physaddr.c      | 16 ++++++++++++++++
> >  drivers/of/fdt.c              |  7 ++++++-
> >  4 files changed, 57 insertions(+), 7 deletions(-)
>
> [...]
>
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index 7b571a631639..012554445054 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -895,8 +895,13 @@ static void __early_init_dt_declare_initrd(unsigned long start,
> >          * enabled since __va() is called too early. ARM64 does make use
> >          * of phys_initrd_start/phys_initrd_size so we can skip this
> >          * conversion.
> > +        * On RISCV64, the usage of __va() before the linear mapping exists
> > +        * is wrong and RISCV64 rightly calls reserve_initrd_mem after it is
> > +        * available where it actually resets the translation that is done
> > +        * here and re-computes it.
>
> No, I want a single comment that covers both cases (and the next arch
> we add here). Something like this:
>
> __va() is not yet available this early on some platforms. In that
> case, the platform uses phys_initrd_start/phys_initrd_size instead and
> does the VA conversion itself.


I have just sent the v3, thanks for your reviews,

Alex

>
>
> Rob
