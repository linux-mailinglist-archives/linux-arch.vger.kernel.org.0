Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EB357D718
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 00:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiGUWxO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Jul 2022 18:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiGUWxN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jul 2022 18:53:13 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36507E82D
        for <linux-arch@vger.kernel.org>; Thu, 21 Jul 2022 15:53:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so2717994pjl.0
        for <linux-arch@vger.kernel.org>; Thu, 21 Jul 2022 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=OdHxhDLWx9WG8mHbYev4aWkSSHwaBBLRnpm2kKlMDcw=;
        b=tP3yiJQp5Dy41n0tJFQKrM/9B5oLwt7fU8kModaq7uZp7yKdhz6sHGUjZFPCyDMjlM
         r3Bdyt/jHF0FAoyVr+ba35Fo82qtNo/Qsb5PYWYjaV4CpgBdbUu1toHdrPIYcFVgFsMI
         EBftvgjQe/yIi0gPy0yljglHJo2lNju1kXn05bs4b3VazrUNtRzV4tlbsF7VYSpsKbJ/
         iJQvKowGnjL0BSqt1x20U9kpaFmMdfG0u1y6lq4e25bw7YWQbek9IoZdHzesbBhQLPqS
         Xic+Xr5PY7V2AoPkQL4gpbt9G/vJQAbRcFljI58fH9divOxh1VNp7XLA0tDjPt9LbKs3
         4R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=OdHxhDLWx9WG8mHbYev4aWkSSHwaBBLRnpm2kKlMDcw=;
        b=p4If8LvCThh2a1QsJyOGjYaOm+10XBXg5k8Tx9a5kbj4Xn9ZCWKtw8bFJsaick4kjo
         WKlF/Ew044PPSt7SFUtsILlMxSJzeB+aGTTmkXxJIj+AGrXmdjPb8GbThd/rLgVxe5tu
         Qdw/B4Mbfw27VN0QFg4/Ob1B6yhoDJ3KIGS+9fwHtc4Ofigt03/aNBviOwOwkARA+nan
         0jqs3XjLyZYuTmuI29cfRuBh4frckFoLllVbeEnUAQsGft1E88SGvpvNxz7f5f7p6T7f
         HJHLgnuVEcVXEvRRiG/AHXvbq/FSFVlPV1NciQyTggCC0uX3rdiszzxctNlG8fPkSxha
         QJkg==
X-Gm-Message-State: AJIora+xZ6z3sgGiOGQaVBkyb6Q6Toq7Gxog2jkdL9CkNP4sI/NPUN5e
        01gzhT31rLazLdHhTnp9vYcY0w==
X-Google-Smtp-Source: AGRyM1sNOd4rSRLr/yIF40jwUmoga02TNaaJTR/6clatLb4XIuD1cw+cWv0cAfzU4APaRXVLN02/vw==
X-Received: by 2002:a17:902:db0f:b0:16d:1cfa:1bfc with SMTP id m15-20020a170902db0f00b0016d1cfa1bfcmr545876plx.82.1658443991052;
        Thu, 21 Jul 2022 15:53:11 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902f60300b0016bdea07b9esm2197378plg.190.2022.07.21.15.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 15:53:10 -0700 (PDT)
Date:   Thu, 21 Jul 2022 15:53:10 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Jul 2022 15:53:09 PDT (-0700)
Subject:     Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
In-Reply-To: <YtnNrkH9UJYreU5M@antec>
CC:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        Will Deacon <will@kernel.org>, guoren@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-um@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     shorne@gmail.com, Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-97127945-353c-4d1b-8bd8-eaf6ac139f79@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 21 Jul 2022 15:05:34 PDT (-0700), shorne@gmail.com wrote:
> On Tue, Jul 19, 2022 at 08:58:39AM -0700, Palmer Dabbelt wrote:
>> On Sun, 17 Jul 2022 17:41:14 PDT (-0700), shorne@gmail.com wrote:
>> > The asm/pci.h used for many newer architectures share similar
>> > definitions.  Move the common parts to asm-generic/pci.h to allow for
>> > sharing code.
>> >
>> > Two things to note are:
>> >
>> >  - isa_dma_bridge_buggy, traditionally this is defined in asm/dma.h but
>> >    these architectures avoid creating that file and add the definition
>> >    to asm/pci.h.
>> >  - ARCH_GENERIC_PCI_MMAP_RESOURCE, csky does not define this so we
>> >    undefine it after including asm-generic/pci.h.  Why doesn't csky
>> >    define it?
>> >  - pci_get_legacy_ide_irq, This function is only used on architectures
>> >    that support PNP.  It is only maintained for arm64, in other
>> >    architectures it is removed.
>> >
>> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> > Link: https://lore.kernel.org/lkml/CAK8P3a0JmPeczfmMBE__vn=Jbvf=nkbpVaZCycyv40pZNCJJXQ@mail.gmail.com/
>> > Signed-off-by: Stafford Horne <shorne@gmail.com>
>> > ---
>> > Second note on isa_dma_bridge_buggy, this is set on x86 but it it also set in
>> > pci/quirks.c.  We discussed limiting it only to x86 though as its a general
>> > quick triggered by pci ids I think it will be more tricky than we thought so I
>> > will leave as is.  It might be nice to move it out of asm/dma.h and into
>> > asm/pci.h though.
>> >
>> > Since v2:
>> >  - Nothing
>> > Since v1:
>> >  - Remove definition of pci_get_legacy_ide_irq
>> >
>> >  arch/arm64/include/asm/pci.h | 12 +++---------
>> >  arch/csky/include/asm/pci.h  | 24 ++++--------------------
>> >  arch/riscv/include/asm/pci.h | 25 +++----------------------
>> >  arch/um/include/asm/pci.h    | 24 ++----------------------
>> >  include/asm-generic/pci.h    | 36 ++++++++++++++++++++++++++++++++++++
>> >  5 files changed, 48 insertions(+), 73 deletions(-)
>> >  create mode 100644 include/asm-generic/pci.h
>> >
>> > diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
>> > index b33ca260e3c9..1180e83712f5 100644
>> > --- a/arch/arm64/include/asm/pci.h
>> > +++ b/arch/arm64/include/asm/pci.h
>> > @@ -9,7 +9,6 @@
>> >  #include <asm/io.h>
>> >
>> >  #define PCIBIOS_MIN_IO		0x1000
>> > -#define PCIBIOS_MIN_MEM		0
>> >
>> >  /*
>> >   * Set to 1 if the kernel should re-assign all PCI bus numbers
>> > @@ -18,9 +17,6 @@
>> >  	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
>> >
>> >  #define arch_can_pci_mmap_wc() 1
>> > -#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
>> > -
>> > -extern int isa_dma_bridge_buggy;
>> >
>> >  #ifdef CONFIG_PCI
>> >  static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>> > @@ -28,11 +24,9 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>> >  	/* no legacy IRQ on arm64 */
>> >  	return -ENODEV;
>> >  }
>> > -
>> > -static inline int pci_proc_domain(struct pci_bus *bus)
>> > -{
>> > -	return 1;
>> > -}
>> >  #endif  /* CONFIG_PCI */
>> >
>> > +/* Generic PCI */
>> > +#include <asm-generic/pci.h>
>> > +
>> >  #endif  /* __ASM_PCI_H */
>> > diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
>> > index ebc765b1f78b..44866c1ad461 100644
>> > --- a/arch/csky/include/asm/pci.h
>> > +++ b/arch/csky/include/asm/pci.h
>> > @@ -9,26 +9,10 @@
>> >
>> >  #include <asm/io.h>
>> >
>> > -#define PCIBIOS_MIN_IO		0
>> > -#define PCIBIOS_MIN_MEM		0
>> > +/* Generic PCI */
>> > +#include <asm-generic/pci.h>
>> >
>> > -/* C-SKY shim does not initialize PCI bus */
>> > -#define pcibios_assign_all_busses() 1
>> > -
>> > -extern int isa_dma_bridge_buggy;
>> > -
>> > -#ifdef CONFIG_PCI
>> > -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>> > -{
>> > -	/* no legacy IRQ on csky */
>> > -	return -ENODEV;
>> > -}
>> > -
>> > -static inline int pci_proc_domain(struct pci_bus *bus)
>> > -{
>> > -	/* always show the domain in /proc */
>> > -	return 1;
>> > -}
>> > -#endif  /* CONFIG_PCI */
>> > +/* csky doesn't use generic pci resource mapping */
>> > +#undef ARCH_GENERIC_PCI_MMAP_RESOURCE
>> >
>> >  #endif  /* __ASM_CSKY_PCI_H */
>> > diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
>> > index 7fd52a30e605..12ce8150cfb0 100644
>> > --- a/arch/riscv/include/asm/pci.h
>> > +++ b/arch/riscv/include/asm/pci.h
>> > @@ -12,29 +12,7 @@
>> >
>> >  #include <asm/io.h>
>> >
>> > -#define PCIBIOS_MIN_IO		0
>> > -#define PCIBIOS_MIN_MEM		0
>>
>> My for-next changes these in bb356ddb78b2 ("RISC-V: PCI: Avoid handing out
>> address 0 to devices").  Do you mind either splitting out the arch/riscv
>> bits or having this in via some sort of shared tag?
>
> Hi Palmer,
>
> I replied last on my phone but since it produces HTML multi-part email it got
> rejected from a few places and I am not sure if you saw my reply.
>
> It might be a bit hard to separate out the architecture specific bits as it
> requires a bit of coordination with the asm-generic/pci.h move.
>
> Some options:
>   1 I can produce a tag for you to merge into your for-next.
>   2 I can skip touching riscv at all in this patch and you can take care of it
>     in a future patch.
>   3 I could cherry pick your change bb356ddb78b2 ("RISC-V: PCI: Avoid handing out
>     address 0 to devices") to my for-next branch.  It should help avoid conflict.
>
> Seeing that I am still doing small updates here and there I am not sure when I
> will be ablt to create a stable tag.  So maybe 3 would work best?

If you cherry pick it then we're going to both end up with the patch, 
which IMO is worse than the conflict (and the patch is pretty far back, 
so I don't really want to rebase everything this late).

Since this isn't in yet, would it be OK just landing it as a single 
patch on top of 5.19-rc1 that gets merged into whatever tree it ends up 
in (ie, yours or Arnd's)?  Then as long as the commit is stable when it 
lands in for-next I can just merge it down to my tree and sort out the 
conflict from there.

If that's not possible then I think the best bet is to just drop the 
RISC-V diff, I can deal with it when the rest lands in Linus' tree.

> -Stafford
