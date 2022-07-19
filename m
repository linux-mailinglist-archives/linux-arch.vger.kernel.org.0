Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF6257A068
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jul 2022 16:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiGSOF0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jul 2022 10:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiGSOE4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 10:04:56 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65150643F;
        Tue, 19 Jul 2022 06:18:36 -0700 (PDT)
Received: from mail-yb1-f170.google.com ([209.85.219.170]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M4KFF-1oE46M0Qq1-000ODC; Tue, 19 Jul 2022 15:18:35 +0200
Received: by mail-yb1-f170.google.com with SMTP id j67so3792601ybb.3;
        Tue, 19 Jul 2022 06:18:34 -0700 (PDT)
X-Gm-Message-State: AJIora+Ln0DM5rLJQh6Z2mZo2QKV84RRscnpXoCcMKargdVnDqJVW0cE
        o3tLkld5Udhdw57vb0/Sg0Hw9rJAeGrCeTlcrhw=
X-Google-Smtp-Source: AGRyM1sj2ZRWajYGSg8uf4g3MyEJ6xSd//jFiMZ2PQtMebEv5Hsb8H9cSwLXrU5Amq5R5Ua/8gA/pnz1fLkON0xIlXo=
X-Received: by 2002:a25:6706:0:b0:670:8d4d:7832 with SMTP id
 b6-20020a256706000000b006708d4d7832mr812105ybc.106.1658236713658; Tue, 19 Jul
 2022 06:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220717033453.2896843-1-shorne@gmail.com> <20220717033453.2896843-3-shorne@gmail.com>
 <YtTjeEnKr8f8z4JS@infradead.org> <CAK8P3a1KJe4K5g1z-Faoxc9NhXqjCUWxnvk2HPxsj2wzG_iDbg@mail.gmail.com>
 <CAAfxs740yz1vJmtFHOPTXT6fqi0+37SR_OhoGsONe4mx_21+_g@mail.gmail.com>
 <CAK8P3a1Mo9+-t21rkP8SDnPrmbj3-uuVPtmHbeUerAevxN3TNw@mail.gmail.com>
 <YtaNvpE7AA/4eV1I@antec> <CAK8P3a2UTND+F83k2uQ+f=o1GWV=oa5coshy8Hy+cKHUGuNzEg@mail.gmail.com>
 <YtaiSEAnMhVqR4HS@antec> <YtasKiPrkFlBXZvh@antec>
In-Reply-To: <YtasKiPrkFlBXZvh@antec>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jul 2022 15:18:17 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0wraTmA6aEF+XJ0RyZV=LSrZ2uPvQmvdw=Pe=nktyGjQ@mail.gmail.com>
Message-ID: <CAK8P3a0wraTmA6aEF+XJ0RyZV=LSrZ2uPvQmvdw=Pe=nktyGjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
To:     Stafford Horne <shorne@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:JReNJ9TYqYW1jG6zuflAcJYsrp8I3rPMcDbRtNPOKoS2FAa86k6
 OxpXUiNMAdh4Ky+6PWw9PG8aDaUih9cykdTd5priqmosuvWf7BDjjsz8kU3OwqD3OOdXiYj
 LoSu7WWtVpiGM0bo6/n1WJ4jbcurAyqvrjiI7gQOpain4yPLtL+6Vw8DxpqOJBjIsfQuBum
 tYSTxLQODl4yLkXRKUq0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z6KeR9UUFvA=:t+hxNbe8GOzxAp5FaaiHSz
 2P0eAqogTjA364gKUdh58byK4qEVqtCsINoYeHcwDWyo/Z8R+vDlllPZ7dtsNzUe5ULDS6sIR
 byNXURRPPmw4aH8dDneeyh109l8Z/FgQyqcYwqmnqCil/p0NT/wSnoMceblb22JXBn8y34sxC
 TiBf2ZH5aZbUBwFvWKGm+aZA5X6/2Q20psvNbFXTtEjMrCgxnlNkUJ71Ohvv+EVLC0SrKNAlv
 Gj0HKR3RLZou7xTBbMJlzCG12yQdQAnUhiGTmntN9UdlsiT5ExjI9tv8PsYpC7ARJB89lWb9w
 6O1TGAfzFh8mjeg/4ykqTD3Lh/yyX9ggoaLyu4Y6+K2AWRQhDtXmZeMRde68EARxa/wBBa/bp
 G75reux/Gd69IjIVq0tm1F36LyvJHF+YCmHW1FdXUCG8JWFJSU/6Wm81Y7qHPu6qiWl2O9tlj
 a9djNZ1Uv9ajTfWr9Mr8JX9hUOsZ/k30PnBIrCvjPLUH3Q6yDA21osLjWRTljAvfdLRHfuTEO
 6ilkNOkSR4Rk4/QgUIAheoQVOHpAprRZY8QHYLoz5nZXb9H3JiLmQDOxE09Kyg3azykNMIZvL
 Sf2gRdEeOefvfn9xLoeg28grFYBxv9IwtL/z7eeNMUG+foc/eRiOqTUYaG+7Skswh3X6izmQX
 RSxvYa1FDpZtLDUhrQuLpdBZygsyfIYXJ5PwK015FvobQ99UGof0FTM+DCrE0IGpYQmaNB7Sq
 vODWY9ScGTPNvfHbkaGLDaYzOCSNZoUt3kJ19g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 19, 2022 at 3:05 PM Stafford Horne <shorne@gmail.com> wrote:
> On Tue, Jul 19, 2022 at 09:23:36PM +0900, Stafford Horne wrote:
> > On Tue, Jul 19, 2022 at 01:55:03PM +0200, Arnd Bergmann wrote:

>
> And this is the result, I will get this into the series and create a v4 tomorrow
> if no issues.

Looks good to me, just one detail:

> diff --git a/include/linux/isa-dma.h b/include/linux/isa-dma.h
> new file mode 100644
> index 000000000000..9514f0949fa1
> --- /dev/null
> +++ b/include/linux/isa-dma.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __LINUX_ISA_DMA_H
> +#define __LINUX_ISA_DMA_H
> +
> +#if defined(CONFIG_PCI) && defined(CONFIG_X86_32)
> +extern int isa_dma_bridge_buggy;
> +#else
> +#define isa_dma_bridge_buggy   (0)
> +#endif
> +
> +#endif /* __LINUX_ISA_DMA_H */

I would make this file #include <asm/dma.h> as a step towards making
linux/isa-dma.h the official replacement for it in the driver api.

Including asm/dma.h from a driver is already a bit awkward, since we
are generally moving towards including only linux/*.h type headers, and
the dma.h name is too generic for something that is completely obsolete.

        Arnd
