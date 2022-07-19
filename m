Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6978F5798D3
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jul 2022 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbiGSLz2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jul 2022 07:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiGSLz1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 07:55:27 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6401EDEFF;
        Tue, 19 Jul 2022 04:55:26 -0700 (PDT)
Received: from mail-yw1-f173.google.com ([209.85.128.173]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MVaQW-1o3yjA289c-00RVvt; Tue, 19 Jul 2022 13:55:24 +0200
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31e47ac84daso37553117b3.0;
        Tue, 19 Jul 2022 04:55:24 -0700 (PDT)
X-Gm-Message-State: AJIora+OrN4rF+EBgBjOj6wqrH5zWQhJPI9CvUVrqZ5j6xLFs57EE5Wz
        q+qCcnQPVJK76f6OobIr+MXYzaHgxonsywgq0Gk=
X-Google-Smtp-Source: AGRyM1t9u7bj2YKjBFpcu5Ozi36BZwukcrSN9A6siyhURYMRnJ74r74VIYyf4LXb/QiwSX6mJLACHGCDSTzuEa0736k=
X-Received: by 2002:a81:d93:0:b0:31c:d32d:4d76 with SMTP id
 141-20020a810d93000000b0031cd32d4d76mr37696610ywn.135.1658231722965; Tue, 19
 Jul 2022 04:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220717033453.2896843-1-shorne@gmail.com> <20220717033453.2896843-3-shorne@gmail.com>
 <YtTjeEnKr8f8z4JS@infradead.org> <CAK8P3a1KJe4K5g1z-Faoxc9NhXqjCUWxnvk2HPxsj2wzG_iDbg@mail.gmail.com>
 <CAAfxs740yz1vJmtFHOPTXT6fqi0+37SR_OhoGsONe4mx_21+_g@mail.gmail.com>
 <CAK8P3a1Mo9+-t21rkP8SDnPrmbj3-uuVPtmHbeUerAevxN3TNw@mail.gmail.com> <YtaNvpE7AA/4eV1I@antec>
In-Reply-To: <YtaNvpE7AA/4eV1I@antec>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Jul 2022 13:55:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2UTND+F83k2uQ+f=o1GWV=oa5coshy8Hy+cKHUGuNzEg@mail.gmail.com>
Message-ID: <CAK8P3a2UTND+F83k2uQ+f=o1GWV=oa5coshy8Hy+cKHUGuNzEg@mail.gmail.com>
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
X-Provags-ID: V03:K1:xVT3a7+XFYjl3aNDopJ4c9/uG1OugMN6LfW+BbJmwYnGwhsqcjo
 Hrrqgnzy+EYQCZ+26WfJrbsgzhnLUqleThuDLqDHpPJIpqNF1IwapLCmwlft0xaCpix0Fip
 VlYxxLv6dcEAuPIsdUrCfjFXSO0/Dhg1qxSbF7CeFR+6s9B3TneKqQYg5ZEXS+FBH7UWiNb
 WhUM+tKmOae14ZpFhNbxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QDvyLEKRtsA=:CXsQgZABn51WAEkcvnFXnf
 a/zDArhVq1SavX1QdOjfdUXUabVULTLDEqygVHP5nsgE5DlNM+J5kNuSH0OCphBUWxuEHkJGP
 l4noU0WMGPm3TAuIzS7Kgpw3EnJqDqlCxzmkZhva/G3Pyb+UfKDJKTCWcD1KhfDviNz2XICus
 NkNHk+g6YCpSdR7AwvJNG59G1QK2syhBmFazYaW5wB23K1JxUWK9ZffujSK5d/xZwrvz1xBRd
 lvB5gdeW/KXd+uYxqhccWEG+5KlfExOTZ3TQ+hf+zM3R2Hl1Drrm+Eunr1YKS3QAHLJbhXosm
 WGSfBZTKiC1OaRhztAA0CLKhH25Tp4TggfmO0D9AjyyaxrRmyki9VdNAuya9OCQGwnNF/LG1z
 hoOD9t3yJ+6cn5vviiaKwkkuwkBjNJHuQsRqE+TxQhgdfhfuWSVU3hY6JJC5ZWzMKaWtFhahx
 PpAA8fHZ8j1m8K2aAJc7r2vJhtzCK1G/ALdLmvuSjqDu9TwoG3yWJrR8QhwwWWWWoLoOMG6on
 ft41vQ7GJTGzg3jGBI3irlcCmz/S1X7deQ99/TcaZXK8nOBtAshB6MaFbmefIIFDFg/xZTR3R
 11L/LcPTMUTteqWf6reiOS4wDluNUT/emSFKRmy9cRdUESkGjvfGBgEirukzjFUMoW85Y6EjR
 3bR85BPvNJTBy7oXFVkjggO6oNimJN8gI9kXvi/cZJSa2mU7H+LjCLIExZZzyNn6t/X/111mn
 0gkWPOeKM0dIeTAU63p0ekP/0rHsGFDTL08ng6/GLs6ajysOcNUGxkG1qltEUbQfl2j7dLB1O
 tBgM4I9avMgSckMyzYsJJ3+u70WNb8gp7VnGAaoU7lRpRZmChpvWsbd/aBMO6hYHj9tKOP4aS
 BPEaZWQKQW0pLVBTBDwQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 19, 2022 at 12:55 PM Stafford Horne <shorne@gmail.com> wrote:

> diff --git a/drivers/comedi/drivers/comedi_isadma.c b/drivers/comedi/drivers/comedi_isadma.c
> index 700982464c53..508421809128 100644
> --- a/drivers/comedi/drivers/comedi_isadma.c
> +++ b/drivers/comedi/drivers/comedi_isadma.c
> @@ -104,8 +104,10 @@ unsigned int comedi_isadma_poll(struct comedi_isadma *dma)
>
>         flags = claim_dma_lock();
>         clear_dma_ff(desc->chan);
> +#ifdef CONFIG_X86_32
>         if (!isa_dma_bridge_buggy)
>                 disable_dma(desc->chan);
> +#endif

There is a logic mistake here: if we are on something other than x86-32,
this always needs to call the disable_dma()/enable_dma().

Not sure how to best express this in a readable way, something like this
would work:

#ifdef CONFIG_X86_32
        if (!isa_dma_bridge_buggy)
#endif
               disable_dma(desc->chan);


or possibly at the start of this file, a

#ifndef CONFIG_X86_32
#define isa_dma_bridge_buggy 0
#endif

Or we could try to keep the generic definition in a global header
like linux/isa-dma.h.

> --- a/sound/core/isadma.c
> +++ b/sound/core/isadma.c
> @@ -73,8 +73,10 @@ unsigned int snd_dma_pointer(unsigned long dma, unsigned int size)
>
>         flags = claim_dma_lock();
>         clear_dma_ff(dma);
> +#ifdef CONFIG_X86_32
>         if (!isa_dma_bridge_buggy)
>                 disable_dma(dma);
> +#endif
>         result = get_dma_residue(dma);
>         /*

Same here.

         Arnd
