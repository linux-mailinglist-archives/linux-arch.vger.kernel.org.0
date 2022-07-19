Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8617A57A0E3
	for <lists+linux-arch@lfdr.de>; Tue, 19 Jul 2022 16:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiGSOMQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 Jul 2022 10:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238024AbiGSOMC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 19 Jul 2022 10:12:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5945720C;
        Tue, 19 Jul 2022 06:33:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q41-20020a17090a1b2c00b001f2043c727aso1477284pjq.1;
        Tue, 19 Jul 2022 06:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gq2qxu4tTCNdzYLjjggHvDXAaB2s/OnX5S80d1QYkSQ=;
        b=Lk4L/aYkRyKZZ37rXnThkj/S+iHNwOUqTGA928Y2CtUFrSgRa7PdcsYAX/OO3pnG4l
         cRtBcxAtV5plRTM1azRyTzwd4kYIgWPO1dqCRV0isud69pVYsJvKYQRoXUrGoWHKsTDd
         zFRbtrT8Ebr7W9JBOwQb2yMhCOm0mBRH/jWitZwYyZHjNFET8+Mc2qHma6W0QtY42cBr
         VyZHPeH2u3B+jcKuSAU6wIGOvUWLg/qKkh2BOnrCLn6zm5Vg2EqJTfCEzmanGiuDMcv2
         r9uvWSFzeVS9c9OXzw+UcWN2nDriDcbQOif4OSIr7hCW21K7CHbM+464cSW/XjrwSOi8
         FIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gq2qxu4tTCNdzYLjjggHvDXAaB2s/OnX5S80d1QYkSQ=;
        b=fm2teIviZPjBrkDhc2ONy3VhT0zQ42+xTvDrIPB3CMEh55vQWJGkcxwSo8zqO1uD0C
         1dpQD3DN2PUlBKeaIMLEPDBLvsVp+/EhfreLQOxCe7k3kHdKxtV8X4zPW1sQoTZ1iTWo
         1x5unG3YsfQXJ0Fu5B07B24h5cZeab9lxQZqMU3IPUkbTLYOnXefgv5nOzJG1+0grAcv
         2ZvRcI/RHE5GOT/0wNIbUmlrNvnq68v3zzRYJoUvsRAdwWcM9hIoGa792gYnJ4J+eS7k
         ymO3qQaApmrAfcyl7BH4d3mRcC4fFP07TjhfQAhV7XTIy/qKZefaL1qNLZiI7CHeEXy5
         yw5w==
X-Gm-Message-State: AJIora9Bjt7KHMcWO7WP0fgckuNtAQUiYHz56mWnIytRa0frifUzcDEa
        0JCfWP5/x/B7G+vRatZmL2M=
X-Google-Smtp-Source: AGRyM1ufAcy9+0qGF+PMepx23ZSZ4uoBR0c029afe7Mu0be8OvKFq0+uoKSlPzwuI0s85UsLCN8U9g==
X-Received: by 2002:a17:90a:bc8c:b0:1ef:91ca:1c24 with SMTP id x12-20020a17090abc8c00b001ef91ca1c24mr44620254pjr.81.1658237634812;
        Tue, 19 Jul 2022 06:33:54 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902cf0b00b0016c06a10861sm11551154plg.74.2022.07.19.06.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 06:33:54 -0700 (PDT)
Date:   Tue, 19 Jul 2022 22:33:52 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
Subject: Re: [PATCH v2 2/2] asm-generic: Add new pci.h and use it
Message-ID: <YtaywBinmYuMUOoI@antec>
References: <20220717033453.2896843-3-shorne@gmail.com>
 <YtTjeEnKr8f8z4JS@infradead.org>
 <CAK8P3a1KJe4K5g1z-Faoxc9NhXqjCUWxnvk2HPxsj2wzG_iDbg@mail.gmail.com>
 <CAAfxs740yz1vJmtFHOPTXT6fqi0+37SR_OhoGsONe4mx_21+_g@mail.gmail.com>
 <CAK8P3a1Mo9+-t21rkP8SDnPrmbj3-uuVPtmHbeUerAevxN3TNw@mail.gmail.com>
 <YtaNvpE7AA/4eV1I@antec>
 <CAK8P3a2UTND+F83k2uQ+f=o1GWV=oa5coshy8Hy+cKHUGuNzEg@mail.gmail.com>
 <YtaiSEAnMhVqR4HS@antec>
 <YtasKiPrkFlBXZvh@antec>
 <CAK8P3a0wraTmA6aEF+XJ0RyZV=LSrZ2uPvQmvdw=Pe=nktyGjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0wraTmA6aEF+XJ0RyZV=LSrZ2uPvQmvdw=Pe=nktyGjQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 19, 2022 at 03:18:17PM +0200, Arnd Bergmann wrote:
> On Tue, Jul 19, 2022 at 3:05 PM Stafford Horne <shorne@gmail.com> wrote:
> > On Tue, Jul 19, 2022 at 09:23:36PM +0900, Stafford Horne wrote:
> > > On Tue, Jul 19, 2022 at 01:55:03PM +0200, Arnd Bergmann wrote:
> 
> >
> > And this is the result, I will get this into the series and create a v4 tomorrow
> > if no issues.
> 
> Looks good to me, just one detail:
> 
> > diff --git a/include/linux/isa-dma.h b/include/linux/isa-dma.h
> > new file mode 100644
> > index 000000000000..9514f0949fa1
> > --- /dev/null
> > +++ b/include/linux/isa-dma.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __LINUX_ISA_DMA_H
> > +#define __LINUX_ISA_DMA_H
> > +
> > +#if defined(CONFIG_PCI) && defined(CONFIG_X86_32)
> > +extern int isa_dma_bridge_buggy;
> > +#else
> > +#define isa_dma_bridge_buggy   (0)
> > +#endif
> > +
> > +#endif /* __LINUX_ISA_DMA_H */
> 
> I would make this file #include <asm/dma.h> as a step towards making
> linux/isa-dma.h the official replacement for it in the driver api.
> 
> Including asm/dma.h from a driver is already a bit awkward, since we
> are generally moving towards including only linux/*.h type headers, and
> the dma.h name is too generic for something that is completely obsolete.

OK, that makes sense.  Then I can remove the asm/dma.h include from:
 - drivers/comedi/drivers/comedi_isadma.c
 - sound/core/isadma.c

-Stafford
