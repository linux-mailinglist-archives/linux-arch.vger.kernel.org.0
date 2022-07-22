Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E10357E482
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiGVQgx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 12:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiGVQgw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 12:36:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E1FCE07;
        Fri, 22 Jul 2022 09:36:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E5E5B8296D;
        Fri, 22 Jul 2022 16:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DE9C341C6;
        Fri, 22 Jul 2022 16:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658507809;
        bh=QvtylitPgJHwkxI60rDk7regVvGnoYVxaRSt9ICAKf8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M9j0uO4MFq5+QCSs2pbVtqQWQmZs1G2CVcSlFU0B4BO5nLLTRWQTeaLDVwU2HTcgK
         z26a+WHYUdxvbvcNjuus/MoA0JCW4yb7yCUbtEIt5wresfDTgZOYgD8Laow8HhuSMl
         XAgYGWLa94FkEX9wTUiRhvRwJFIJ9JiroNvWgS8Vp8sTaOgz8JUwKl86aCZenIJNLB
         rWJm0pwPhW7D+fGnd4PBT205otGTSJKxj5BGj2Tm9U+RH6xVlB1Y+/+v6CDiR0kuch
         aelv4xSHjqlj7PcJTJ0Gw2x5PESHVvI7Xvqa8Dfr97kVf3v+HJosBh+zvfr+p640H9
         7htZpi5MKFmig==
Received: by mail-vs1-f49.google.com with SMTP id k129so4807326vsk.2;
        Fri, 22 Jul 2022 09:36:49 -0700 (PDT)
X-Gm-Message-State: AJIora8nA98O9oVGOsBb7L9XbVZv8NHiokgUHkJNl+2/IHFtwg1i5ojF
        FH4vYhLeeR8Jrce300IV53p6sn/M7I/3EWqkfQ==
X-Google-Smtp-Source: AGRyM1uWhGX+etc+342QMYfQjmA2giDXHKBGiyzp4++TdSmI/uchUQLzp2Q6hnGpgIxXHKzp2ZVUKAJRo7p2eytPGXw=
X-Received: by 2002:a67:c088:0:b0:358:bb1:fdf7 with SMTP id
 x8-20020a67c088000000b003580bb1fdf7mr292345vsi.85.1658507808011; Fri, 22 Jul
 2022 09:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com>
 <mhng-7e3146ca-79b8-4e16-98a9-e354fb6d03ba@palmer-mbp2014>
In-Reply-To: <mhng-7e3146ca-79b8-4e16-98a9-e354fb6d03ba@palmer-mbp2014>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Jul 2022 10:36:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJHZEcnJi+UHQbYWVoy1okQjHSc9T377P1q8oOJnHBWFw@mail.gmail.com>
Message-ID: <CAL_JsqJHZEcnJi+UHQbYWVoy1okQjHSc9T377P1q8oOJnHBWFw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, macro@orcam.me.uk,
        Stafford Horne <shorne@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
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

On Fri, Jul 22, 2022 at 9:27 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Thu, 21 Jul 2022 16:06:52 PDT (-0700), Rob Herring wrote:
> > On Tue, Jul 19, 2022 at 9:59 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >>
> >> On Sun, 17 Jul 2022 17:41:14 PDT (-0700), shorne@gmail.com wrote:
> >> > The asm/pci.h used for many newer architectures share similar
> >> > definitions.  Move the common parts to asm-generic/pci.h to allow for
> >> > sharing code.
> >> >
> >> > Two things to note are:
> >> >
> >> >  - isa_dma_bridge_buggy, traditionally this is defined in asm/dma.h but
> >> >    these architectures avoid creating that file and add the definition
> >> >    to asm/pci.h.
> >> >  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
> >> >    undefine it after including asm-generic/pci.h.  Why doesn't csky
> >> >    define it?
> >> >  - pci_get_legacy_ide_irq, This function is only used on architectures
> >> >    that support PNP.  It is only maintained for arm64, in other
> >> >    architectures it is removed.
> >> >
> >> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> >> > Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
> >> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> >> > ---
> >> > Second note on isa_dma_bridge_buggy, this is set on x86 but it it also set in
> >> > pci/quirks.c.  We discussed limiting it only to x86 though as its a general
> >> > quick triggered by pci ids I think it will be more tricky than we thought so I
> >> > will leave as is.  It might be nice to move it out of asm/dma.h and into
> >> > asm/pci.h though.
> >> >
> >> > Since v2:
> >> >  - Nothing
> >> > Since v1:
> >> >  - Remove definition of pci_get_legacy_ide_irq
> >> >
> >> >  arch/arm64/include/asm/pci.h | 12 +++---------
> >> >  arch/csky/include/asm/pci.h  | 24 ++++--------------------
> >> >  arch/riscv/include/asm/pci.h | 25 +++----------------------
> >> >  arch/um/include/asm/pci.h    | 24 ++----------------------
> >> >  include/asm-generic/pci.h    | 36 ++++++++++++++++++++++++++++++++++++
> >> >  5 files changed, 48 insertions(+), 73 deletions(-)
> >> >  create mode 100644 include/asm-generic/pci.h
> >> >
> >> > diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> >> > index b33ca260e3c9..1180e83712f5 100644
> >> > --- a/arch/arm64/include/asm/pci.h
> >> > +++ b/arch/arm64/include/asm/pci.h
> >> > @@ -9,7 +9,6 @@
> >> >  #include <asm/io.h>
> >> >
> >> >  #define PCIBIOS_MIN_IO               0x1000
> >> > -#define PCIBIOS_MIN_MEM              0
> >> >
> >> >  /*
> >> >   * Set to 1 if the kernel should re-assign all PCI bus numbers
> >> > @@ -18,9 +17,6 @@
> >> >       (pci_has_flag(PCI_REASSIGN_ALL_BUS))
> >> >
> >> >  #define arch_can_pci_mmap_wc() 1
> >> > -#define ARCH_GENERIC_PCI_MMAP_RESOURCE       1
> >> > -
> >> > -extern int isa_dma_bridge_buggy;
> >> >
> >> >  #ifdef CONFIG_PCI
> >> >  static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> >> > @@ -28,11 +24,9 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> >> >       /* no legacy IRQ on arm64 */
> >> >       return -ENODEV;
> >> >  }
> >> > -
> >> > -static inline int pci_proc_domain(struct pci_bus *bus)
> >> > -{
> >> > -     return 1;
> >> > -}
> >> >  #endif  /* CONFIG_PCI */
> >> >
> >> > +/* Generic PCI */
> >> > +#include <asm-generic/pci.h>
> >> > +
> >> >  #endif  /* __ASM_PCI_H */
> >> > diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
> >> > index ebc765b1f78b..44866c1ad461 100644
> >> > --- a/arch/csky/include/asm/pci.h
> >> > +++ b/arch/csky/include/asm/pci.h
> >> > @@ -9,26 +9,10 @@
> >> >
> >> >  #include <asm/io.h>
> >> >
> >> > -#define PCIBIOS_MIN_IO               0
> >> > -#define PCIBIOS_MIN_MEM              0
> >> > +/* Generic PCI */
> >> > +#include <asm-generic/pci.h>
> >> >
> >> > -/* C-SKY shim does not initialize PCI bus */
> >> > -#define pcibios_assign_all_busses() 1
> >> > -
> >> > -extern int isa_dma_bridge_buggy;
> >> > -
> >> > -#ifdef CONFIG_PCI
> >> > -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> >> > -{
> >> > -     /* no legacy IRQ on csky */
> >> > -     return -ENODEV;
> >> > -}
> >> > -
> >> > -static inline int pci_proc_domain(struct pci_bus *bus)
> >> > -{
> >> > -     /* always show the domain in /proc */
> >> > -     return 1;
> >> > -}
> >> > -#endif  /* CONFIG_PCI */
> >> > +/* csky doesn't use generic pci resource mapping */
> >> > +#undef ARCH_GENERIC_PCI_MMAP_RESOURCE
> >> >
> >> >  #endif  /* __ASM_CSKY_PCI_H */
> >> > diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
> >> > index 7fd52a30e605..12ce8150cfb0 100644
> >> > --- a/arch/riscv/include/asm/pci.h
> >> > +++ b/arch/riscv/include/asm/pci.h
> >> > @@ -12,29 +12,7 @@
> >> >
> >> >  #include <asm/io.h>
> >> >
> >> > -#define PCIBIOS_MIN_IO               0
> >> > -#define PCIBIOS_MIN_MEM              0
> >>
> >> My for-next changes these in bb356ddb78b2 ("RISC-V: PCI: Avoid handing
> >> out address 0 to devices").  Do you mind either splitting out the
> >> arch/riscv bits or having this in via some sort of shared tag?
> >
> > Shouldn't the values not matter here if the IO and mem resources are
> > described in the DT (and don't use 0)? The values of 4 and 16 look
> > odd.
>
> The linked thread has a fairly long discussion
> <https://lore.kernel.org/all/alpine.DEB.2.21.2202260044180.25061@angie.orcam.me.uk/>.
> I agree it's odd to have this in arch code: "don't hand out address 0"
> isn't really a RISC-V constraint (ie, we don't have architecture-defined
> limitations on these address spaces) but a constraint that comes from
> the generic port I/O functions and some other related PCI/resource code
> where the value 0 is a sentinel.

If you look at arm32, we have a variable for PCIBIOS_MIN_MEM because
pre-DT what platforms required was all over the place. Nothing using
DT needs to set that variable. And arm64 uses 0 without problems. In
all those platforms, none of them have the same restrictions? So it is
still curious to me how PCIBIOS_MIN_MEM matters for Risc-V.

I/O is different as Arnd said, but I'd imagine we could just set the
min to 4 in the generic header and be done with it.

> Maybe the right thing to do here is actually to make the default
> definitions of these macros non-zero, or to add some sort of ARCH_
> flavor of them and move that non-zero requirement closer to where it
> comes from?  From the look of it any port that uses the generic port I/O
> functions and has 0 for these will be broken in the same way.
>
> That said, I'm not really a PCI guy so maybe Bjorn or Maciej has a
> better idea?

From fu740:
                       ranges = <0x81000000  0x0 0x60080000  0x0
0x60080000 0x0 0x10000>,      /* I/O */
                                 <0x82000000  0x0 0x60090000  0x0
0x60090000 0x0 0xff70000>,    /* mem */
                                 <0x82000000  0x0 0x70000000  0x0
0x70000000 0x0 0x1000000>,    /* mem */
                                 <0xc3000000 0x20 0x00000000 0x20
0x00000000 0x20 0x00000000>;  /* mem prefetchable */

So again, how does one get a 0 address handed out when that's not even
a valid region according to DT? Is there some legacy stuff that
ignores the bridge windows?

Rob
