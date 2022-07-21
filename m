Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C04957D678
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 00:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbiGUWFj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jul 2022 18:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiGUWFi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jul 2022 18:05:38 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ECB54642;
        Thu, 21 Jul 2022 15:05:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y9so2927524pff.12;
        Thu, 21 Jul 2022 15:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y05qOXaISg5b5cePrR6f95SnWWn5ZLoSf0WhccEFMxc=;
        b=nNnaDJLAX2ldtXUDnqFoB2asA98UwfumeRoo7G5H5Y6iYqwXQdjhedmSMzHLUeIgoT
         h7bFWvH0y5GmH+jBASfY2Hd3Jnm2bNRbIpVLFaGFN7Nyj3y6HSgXM+pCGz6cCSqZMsiZ
         7N/4CfDAQgcKjCGQGGhsNZTUV53/1hUwtBrvkFuAi95qUVoxQ4ZOude9xLX+vB3YTYsK
         V/0IPqS9EHsk2PQd7Wfmqun/jRC+TPr1T1VmC6oZv4SFlyA0sagiA4nt+dULYWcLpUnl
         WFj1GywCLHzL4U/ehwktB8F24U6y4WBcsVpsT7p+NdnfoJR/7sqTmmbF21wM3i3Mqvbh
         AaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y05qOXaISg5b5cePrR6f95SnWWn5ZLoSf0WhccEFMxc=;
        b=vIs6513qNZKgYIo9CSaxjpM9jdkfuJxw557UDeXMLXPtVV6WgLFPphoPR06opQUrIn
         OjVb7XoV829d2sBbbTGqGIty6ufjp1GCkJp8T4OpiVSCEm/KejX4Am8CA0BD1c7hMI2h
         TPprl3yy0cgzwCEIpv4SB5CfHCHXyeNCOwtFDVtgJQeKNk/+0gtq2E3Lnjj3rBd/E3nN
         RrJ4RUznj47bhhtZUSijbeEcauvYzu8xODP5Ygkk/ODO8vnMGymtfJTNXZcLxDGqUl95
         I8g4+Xwj6JgXgytOPNCJgJb0DoqLdlD8EtQO1Ruc7GDeSjvgnQaNJyqXHGvB6+IbYvR2
         BTeQ==
X-Gm-Message-State: AJIora94eb9dxZ76lXS1y7s5DEb32rExhknVt48wbQs19PPFj+nAEERW
        0pUHuvAndSn82/oDqB88IqQ=
X-Google-Smtp-Source: AGRyM1u+eqoFm4876gMFLzZFNfZyFDr1xS9hGetab9jTuWfaEOH08h9swQhz05Slhr6cqjMb/onsBQ==
X-Received: by 2002:a63:f107:0:b0:41a:996c:d03b with SMTP id f7-20020a63f107000000b0041a996cd03bmr434248pgi.228.1658441136840;
        Thu, 21 Jul 2022 15:05:36 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a8b8a00b001ef87123615sm1881188pjn.37.2022.07.21.15.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:05:36 -0700 (PDT)
Date:   Fri, 22 Jul 2022 07:05:34 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        catalin.marinas@arm.com, Will Deacon <will@kernel.org>,
        guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-um@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
Message-ID: <YtnNrkH9UJYreU5M@antec>
References: <20220718004114.3925745-3-shorne@gmail.com>
 <mhng-3ae42214-abe0-4fad-9fa9-8f19809fa4d9@palmer-mbp2014>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-3ae42214-abe0-4fad-9fa9-8f19809fa4d9@palmer-mbp2014>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 19, 2022 at 08:58:39AM -0700, Palmer Dabbelt wrote:
> On Sun, 17 Jul 2022 17:41:14 PDT (-0700), shorne@gmail.com wrote:
> > The asm/pci.h used for many newer architectures share similar
> > definitions.  Move the common parts to asm-generic/pci.h to allow for
> > sharing code.
> > 
> > Two things to note are:
> > 
> >  - isa_dma_bridge_buggy, traditionally this is defined in asm/dma.h but
> >    these architectures avoid creating that file and add the definition
> >    to asm/pci.h.
> >  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
> >    undefine it after including asm-generic/pci.h.  Why doesn't csky
> >    define it?
> >  - pci_get_legacy_ide_irq, This function is only used on architectures
> >    that support PNP.  It is only maintained for arm64, in other
> >    architectures it is removed.
> > 
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > ---
> > Second note on isa_dma_bridge_buggy, this is set on x86 but it it also set in
> > pci/quirks.c.  We discussed limiting it only to x86 though as its a general
> > quick triggered by pci ids I think it will be more tricky than we thought so I
> > will leave as is.  It might be nice to move it out of asm/dma.h and into
> > asm/pci.h though.
> > 
> > Since v2:
> >  - Nothing
> > Since v1:
> >  - Remove definition of pci_get_legacy_ide_irq
> > 
> >  arch/arm64/include/asm/pci.h | 12 +++---------
> >  arch/csky/include/asm/pci.h  | 24 ++++--------------------
> >  arch/riscv/include/asm/pci.h | 25 +++----------------------
> >  arch/um/include/asm/pci.h    | 24 ++----------------------
> >  include/asm-generic/pci.h    | 36 ++++++++++++++++++++++++++++++++++++
> >  5 files changed, 48 insertions(+), 73 deletions(-)
> >  create mode 100644 include/asm-generic/pci.h
> > 
> > diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> > index b33ca260e3c9..1180e83712f5 100644
> > --- a/arch/arm64/include/asm/pci.h
> > +++ b/arch/arm64/include/asm/pci.h
> > @@ -9,7 +9,6 @@
> >  #include <asm/io.h>
> > 
> >  #define PCIBIOS_MIN_IO		0x1000
> > -#define PCIBIOS_MIN_MEM		0
> > 
> >  /*
> >   * Set to 1 if the kernel should re-assign all PCI bus numbers
> > @@ -18,9 +17,6 @@
> >  	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
> > 
> >  #define arch_can_pci_mmap_wc() 1
> > -#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
> > -
> > -extern int isa_dma_bridge_buggy;
> > 
> >  #ifdef CONFIG_PCI
> >  static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> > @@ -28,11 +24,9 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> >  	/* no legacy IRQ on arm64 */
> >  	return -ENODEV;
> >  }
> > -
> > -static inline int pci_proc_domain(struct pci_bus *bus)
> > -{
> > -	return 1;
> > -}
> >  #endif  /* CONFIG_PCI */
> > 
> > +/* Generic PCI */
> > +#include <asm-generic/pci.h>
> > +
> >  #endif  /* __ASM_PCI_H */
> > diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
> > index ebc765b1f78b..44866c1ad461 100644
> > --- a/arch/csky/include/asm/pci.h
> > +++ b/arch/csky/include/asm/pci.h
> > @@ -9,26 +9,10 @@
> > 
> >  #include <asm/io.h>
> > 
> > -#define PCIBIOS_MIN_IO		0
> > -#define PCIBIOS_MIN_MEM		0
> > +/* Generic PCI */
> > +#include <asm-generic/pci.h>
> > 
> > -/* C-SKY shim does not initialize PCI bus */
> > -#define pcibios_assign_all_busses() 1
> > -
> > -extern int isa_dma_bridge_buggy;
> > -
> > -#ifdef CONFIG_PCI
> > -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> > -{
> > -	/* no legacy IRQ on csky */
> > -	return -ENODEV;
> > -}
> > -
> > -static inline int pci_proc_domain(struct pci_bus *bus)
> > -{
> > -	/* always show the domain in /proc */
> > -	return 1;
> > -}
> > -#endif  /* CONFIG_PCI */
> > +/* csky doesn't use generic pci resource mapping */
> > +#undef ARCH_GENERIC_PCI_MMAP_RESOURCE
> > 
> >  #endif  /* __ASM_CSKY_PCI_H */
> > diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
> > index 7fd52a30e605..12ce8150cfb0 100644
> > --- a/arch/riscv/include/asm/pci.h
> > +++ b/arch/riscv/include/asm/pci.h
> > @@ -12,29 +12,7 @@
> > 
> >  #include <asm/io.h>
> > 
> > -#define PCIBIOS_MIN_IO		0
> > -#define PCIBIOS_MIN_MEM		0
> 
> My for-next changes these in bb356ddb78b2 ("RISC-V: PCI: Avoid handing out
> address 0 to devices").  Do you mind either splitting out the arch/riscv
> bits or having this in via some sort of shared tag?

Hi Palmer,

I replied last on my phone but since it produces HTML multi-part email it got
rejected from a few places and I am not sure if you saw my reply.

It might be a bit hard to separate out the architecture specific bits as it
requires a bit of coordination with the asm-generic/pci.h move.

Some options:
  1 I can produce a tag for you to merge into your for-next.
  2 I can skip touching riscv at all in this patch and you can take care of it
    in a future patch.
  3 I could cherry pick your change bb356ddb78b2 ("RISC-V: PCI: Avoid handing out
    address 0 to devices") to my for-next branch.  It should help avoid conflict.

Seeing that I am still doing small updates here and there I am not sure when I
will be ablt to create a stable tag.  So maybe 3 would work best?

-Stafford
