Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9074457D740
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 01:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiGUXHK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jul 2022 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiGUXHJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jul 2022 19:07:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5F78E4E2;
        Thu, 21 Jul 2022 16:07:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 049AD61E9A;
        Thu, 21 Jul 2022 23:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C124C341D5;
        Thu, 21 Jul 2022 23:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658444826;
        bh=jny5j4zsShg38DT8VGi3vSOk3kBZqJAgJB0dTAkbAM8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nyc7n95JFn+3L1ST5AObOHZL18EMNAMKKmlqEzmQ0x2W5l3SEuMQVXIJKB8x/PE43
         d9tVFWtdjxHd3BaFaPjYNZFeXVgOFPwd45Q48VOVPGuy6oPi7iOS7mKtj5E/Arv6lf
         mgpJxPiIK7TFoMot81cQo31c4CSItHkgW8BgIm9VjN68zF7Uohg5vFT0QbbmlJw7An
         gY9M4hfStxnI1ajwOuZorbl9ksVc4yOr4AUeQM9cY8w7LsHAFe9mCyD1JsVq1DfWnh
         lzgCvDODE+QD/PLNwxpiBXDImxIulyzVg7Ktyz69/H9lAwukc0b8xX2u29JGoE5Koy
         14eNLCQBcUq6Q==
Received: by mail-vs1-f53.google.com with SMTP id 66so137757vse.4;
        Thu, 21 Jul 2022 16:07:06 -0700 (PDT)
X-Gm-Message-State: AJIora9M0ipi+rT11n6aS0g1Fi9APmYeSihpz8/UKstw5E/MPmrz4sNK
        m9OhPny2THPYb92VGi2he4KDGH8RWD/rA2U4Hw==
X-Google-Smtp-Source: AGRyM1uBjCs+U2ymdUUsIXY05CrE+y/S2OAXKRtreP892HegrpbMmcbIq9jcywXUQ+NGl5aZo/092d9bZO+U+t4nOVM=
X-Received: by 2002:a67:c18e:0:b0:357:5fc3:45d7 with SMTP id
 h14-20020a67c18e000000b003575fc345d7mr235416vsj.53.1658444825112; Thu, 21 Jul
 2022 16:07:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220718004114.3925745-3-shorne@gmail.com> <mhng-3ae42214-abe0-4fad-9fa9-8f19809fa4d9@palmer-mbp2014>
In-Reply-To: <mhng-3ae42214-abe0-4fad-9fa9-8f19809fa4d9@palmer-mbp2014>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 21 Jul 2022 17:06:52 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com>
Message-ID: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Stafford Horne <shorne@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-um@lists.infradead.org, PCI <linux-pci@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 19, 2022 at 9:59 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
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
> >  #define PCIBIOS_MIN_IO               0x1000
> > -#define PCIBIOS_MIN_MEM              0
> >
> >  /*
> >   * Set to 1 if the kernel should re-assign all PCI bus numbers
> > @@ -18,9 +17,6 @@
> >       (pci_has_flag(PCI_REASSIGN_ALL_BUS))
> >
> >  #define arch_can_pci_mmap_wc() 1
> > -#define ARCH_GENERIC_PCI_MMAP_RESOURCE       1
> > -
> > -extern int isa_dma_bridge_buggy;
> >
> >  #ifdef CONFIG_PCI
> >  static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> > @@ -28,11 +24,9 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> >       /* no legacy IRQ on arm64 */
> >       return -ENODEV;
> >  }
> > -
> > -static inline int pci_proc_domain(struct pci_bus *bus)
> > -{
> > -     return 1;
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
> > -#define PCIBIOS_MIN_IO               0
> > -#define PCIBIOS_MIN_MEM              0
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
> > -     /* no legacy IRQ on csky */
> > -     return -ENODEV;
> > -}
> > -
> > -static inline int pci_proc_domain(struct pci_bus *bus)
> > -{
> > -     /* always show the domain in /proc */
> > -     return 1;
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
> > -#define PCIBIOS_MIN_IO               0
> > -#define PCIBIOS_MIN_MEM              0
>
> My for-next changes these in bb356ddb78b2 ("RISC-V: PCI: Avoid handing
> out address 0 to devices").  Do you mind either splitting out the
> arch/riscv bits or having this in via some sort of shared tag?

Shouldn't the values not matter here if the IO and mem resources are
described in the DT (and don't use 0)? The values of 4 and 16 look
odd.

Rob
