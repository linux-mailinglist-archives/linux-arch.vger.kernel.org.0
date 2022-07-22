Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F6457EA52
	for <lists+linux-arch@lfdr.de>; Sat, 23 Jul 2022 01:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiGVXi3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 19:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGVXi2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 19:38:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3418C8E5;
        Fri, 22 Jul 2022 16:38:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65158B82B1C;
        Fri, 22 Jul 2022 23:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EC5C341CA;
        Fri, 22 Jul 2022 23:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658533104;
        bh=McSqP94KWRevQHkCeK9y2ojZI5ZwfWiMyOnTof4VG6A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t4UyYJRPp5zbDSHqtRxl8U+SV4WCw4HHtixAgeOLizMQOyqbVMYjovNXDlBQSX3YL
         cLdbIqr72MCf3qgl3QujY6RwW6QefDiBEwjm8aFsGqTZhPA4iAzcJp6/+4QLt0rDfo
         CrBP4V3XLc7VytO5u+Ll2kW77y2qSmQjgjAACq83G2SIcpWyWdc2XC4vacgDD+ZKpy
         8VuCjBGynrbCtWJeJ4Va0vVIwvn4HcAeJgK4KUpTYpJTNEYPNVe5K9yboKGl9tc1pY
         f9E/ufRQU7k0IjMVgeoKz+M/yVELq5EfrNme6lqU0PZpVwOQATy/HAvGSWAoGM/srS
         S1XsmVSOWtqQA==
Date:   Fri, 22 Jul 2022 18:38:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pierre Morel <pmorel@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Nick Child <nick.child@ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 1/4] PCI: Remove pci_get_legacy_ide_irq and
 asm-generic/pci.h
Message-ID: <20220722233821.GA1979844@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722214944.831438-2-shorne@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jul 23, 2022 at 06:49:41AM +0900, Stafford Horne wrote:
> The definition of the pci header function pci_get_legacy_ide_irq is only
> used in platforms that support PNP.  So many of the architecutres where
> it is defined do not use it.  This also means we can remove
> asm-generic/pci.h as all it provides is a definition of
> pci_get_legacy_ide_irq.
> 
> Where referenced, replace the usage of pci_get_legacy_ide_irq with the
> libata.h macros ATA_PRIMARY_IRQ and ATA_SECONDARY_IRQ which provide the
> same functionality.  This allows removing pci_get_legacy_ide_irq from
> headers where it is no longer used.
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

I applied all 4 patches in this series to pci/header-cleanup-immutable
for v5.20.

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/header-cleanup-immutable

> ---
>  arch/alpha/include/asm/pci.h   |  6 ------
>  arch/arm/include/asm/pci.h     |  5 -----
>  arch/arm64/include/asm/pci.h   |  6 ------
>  arch/csky/include/asm/pci.h    |  6 ------
>  arch/ia64/include/asm/pci.h    |  6 ------
>  arch/m68k/include/asm/pci.h    |  2 --
>  arch/mips/include/asm/pci.h    |  6 ------
>  arch/parisc/include/asm/pci.h  |  5 -----
>  arch/powerpc/include/asm/pci.h |  1 -
>  arch/riscv/include/asm/pci.h   |  6 ------
>  arch/s390/include/asm/pci.h    |  1 -
>  arch/sh/include/asm/pci.h      |  6 ------
>  arch/sparc/include/asm/pci.h   |  9 ---------
>  arch/um/include/asm/pci.h      |  8 --------
>  arch/x86/include/asm/pci.h     |  3 ---
>  arch/xtensa/include/asm/pci.h  |  3 ---
>  drivers/pnp/resource.c         |  5 +++--
>  include/asm-generic/pci.h      | 17 -----------------
>  18 files changed, 3 insertions(+), 98 deletions(-)
>  delete mode 100644 include/asm-generic/pci.h
> 
> diff --git a/arch/alpha/include/asm/pci.h b/arch/alpha/include/asm/pci.h
> index cf6bc1e64d66..6312656279d7 100644
> --- a/arch/alpha/include/asm/pci.h
> +++ b/arch/alpha/include/asm/pci.h
> @@ -56,12 +56,6 @@ struct pci_controller {
>  
>  /* IOMMU controls.  */
>  
> -/* TODO: integrate with include/asm-generic/pci.h ? */
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	return channel ? 15 : 14;
> -}
> -
>  #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index
>  
>  static inline int pci_proc_domain(struct pci_bus *bus)
> diff --git a/arch/arm/include/asm/pci.h b/arch/arm/include/asm/pci.h
> index 68e6f25784a4..5916b88d4c94 100644
> --- a/arch/arm/include/asm/pci.h
> +++ b/arch/arm/include/asm/pci.h
> @@ -22,11 +22,6 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  #define HAVE_PCI_MMAP
>  #define ARCH_GENERIC_PCI_MMAP_RESOURCE
>  
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	return channel ? 15 : 14;
> -}
> -
>  extern void pcibios_report_status(unsigned int status_mask, int warn);
>  
>  #endif /* __KERNEL__ */
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index b33ca260e3c9..0aebc3488c32 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -23,12 +23,6 @@
>  extern int isa_dma_bridge_buggy;
>  
>  #ifdef CONFIG_PCI
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	/* no legacy IRQ on arm64 */
> -	return -ENODEV;
> -}
> -
>  static inline int pci_proc_domain(struct pci_bus *bus)
>  {
>  	return 1;
> diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
> index ebc765b1f78b..0535f1aaae38 100644
> --- a/arch/csky/include/asm/pci.h
> +++ b/arch/csky/include/asm/pci.h
> @@ -18,12 +18,6 @@
>  extern int isa_dma_bridge_buggy;
>  
>  #ifdef CONFIG_PCI
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	/* no legacy IRQ on csky */
> -	return -ENODEV;
> -}
> -
>  static inline int pci_proc_domain(struct pci_bus *bus)
>  {
>  	/* always show the domain in /proc */
> diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.h
> index 8c163d1d0189..fa8f545c24c9 100644
> --- a/arch/ia64/include/asm/pci.h
> +++ b/arch/ia64/include/asm/pci.h
> @@ -63,10 +63,4 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  	return (pci_domain_nr(bus) != 0);
>  }
>  
> -#define HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	return channel ? isa_irq_to_vector(15) : isa_irq_to_vector(14);
> -}
> -
>  #endif /* _ASM_IA64_PCI_H */
> diff --git a/arch/m68k/include/asm/pci.h b/arch/m68k/include/asm/pci.h
> index 5a4bc223743b..ccdfa0dc8413 100644
> --- a/arch/m68k/include/asm/pci.h
> +++ b/arch/m68k/include/asm/pci.h
> @@ -2,8 +2,6 @@
>  #ifndef _ASM_M68K_PCI_H
>  #define _ASM_M68K_PCI_H
>  
> -#include <asm-generic/pci.h>
> -
>  #define	pcibios_assign_all_busses()	1
>  
>  #define	PCIBIOS_MIN_IO		0x00000100
> diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
> index 9ffc8192adae..3fd6e22c108b 100644
> --- a/arch/mips/include/asm/pci.h
> +++ b/arch/mips/include/asm/pci.h
> @@ -139,10 +139,4 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  /* Do platform specific device initialization at pci_enable_device() time */
>  extern int pcibios_plat_dev_init(struct pci_dev *dev);
>  
> -/* Chances are this interrupt is wired PC-style ...  */
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	return channel ? 15 : 14;
> -}
> -
>  #endif /* _ASM_PCI_H */
> diff --git a/arch/parisc/include/asm/pci.h b/arch/parisc/include/asm/pci.h
> index f14465b84de4..127ed5021ae3 100644
> --- a/arch/parisc/include/asm/pci.h
> +++ b/arch/parisc/include/asm/pci.h
> @@ -162,11 +162,6 @@ extern void pcibios_init_bridge(struct pci_dev *);
>  #define PCIBIOS_MIN_IO          0x10
>  #define PCIBIOS_MIN_MEM         0x1000 /* NBPG - but pci/setup-res.c dies */
>  
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	return channel ? 15 : 14;
> -}
> -
>  #define HAVE_PCI_MMAP
>  #define ARCH_GENERIC_PCI_MMAP_RESOURCE
>  
> diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
> index 915d6ee4b40a..f9da506751bb 100644
> --- a/arch/powerpc/include/asm/pci.h
> +++ b/arch/powerpc/include/asm/pci.h
> @@ -39,7 +39,6 @@
>  #define pcibios_assign_all_busses() \
>  	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
>  
> -#define HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
>  static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>  {
>  	if (ppc_md.pci_get_legacy_ide_irq)
> diff --git a/arch/riscv/include/asm/pci.h b/arch/riscv/include/asm/pci.h
> index 7fd52a30e605..a7b8f0d0df7f 100644
> --- a/arch/riscv/include/asm/pci.h
> +++ b/arch/riscv/include/asm/pci.h
> @@ -23,12 +23,6 @@
>  extern int isa_dma_bridge_buggy;
>  
>  #ifdef CONFIG_PCI
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	/* no legacy IRQ on risc-v */
> -	return -ENODEV;
> -}
> -
>  static inline int pci_proc_domain(struct pci_bus *bus)
>  {
>  	/* always show the domain in /proc */
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index fdb9745ee998..5889ddcbc374 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -6,7 +6,6 @@
>  #include <linux/mutex.h>
>  #include <linux/iommu.h>
>  #include <linux/pci_hotplug.h>
> -#include <asm-generic/pci.h>
>  #include <asm/pci_clp.h>
>  #include <asm/pci_debug.h>
>  #include <asm/sclp.h>
> diff --git a/arch/sh/include/asm/pci.h b/arch/sh/include/asm/pci.h
> index ad22e88c6657..54c30126ea17 100644
> --- a/arch/sh/include/asm/pci.h
> +++ b/arch/sh/include/asm/pci.h
> @@ -88,10 +88,4 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  	return hose->need_domain_info;
>  }
>  
> -/* Chances are this interrupt is wired PC-style ...  */
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	return channel ? 15 : 14;
> -}
> -
>  #endif /* __ASM_SH_PCI_H */
> diff --git a/arch/sparc/include/asm/pci.h b/arch/sparc/include/asm/pci.h
> index 4deddf430e5d..0c58f65bd172 100644
> --- a/arch/sparc/include/asm/pci.h
> +++ b/arch/sparc/include/asm/pci.h
> @@ -40,13 +40,4 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  #define get_pci_unmapped_area get_fb_unmapped_area
>  #endif /* CONFIG_SPARC64 */
>  
> -#if defined(CONFIG_SPARC64) || defined(CONFIG_LEON_PCI)
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	return PCI_IRQ_NONE;
> -}
> -#else
> -#include <asm-generic/pci.h>
> -#endif
> -
>  #endif /* ___ASM_SPARC_PCI_H */
> diff --git a/arch/um/include/asm/pci.h b/arch/um/include/asm/pci.h
> index da13fd5519ef..26b96c02ef61 100644
> --- a/arch/um/include/asm/pci.h
> +++ b/arch/um/include/asm/pci.h
> @@ -11,14 +11,6 @@
>  
>  extern int isa_dma_bridge_buggy;
>  
> -#ifdef CONFIG_PCI
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	/* no legacy IRQs */
> -	return -ENODEV;
> -}
> -#endif
> -
>  #ifdef CONFIG_PCI_DOMAINS
>  static inline int pci_proc_domain(struct pci_bus *bus)
>  {
> diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
> index f3fd5928bcbb..736793d65bcb 100644
> --- a/arch/x86/include/asm/pci.h
> +++ b/arch/x86/include/asm/pci.h
> @@ -105,9 +105,6 @@ static inline void early_quirks(void) { }
>  
>  extern void pci_iommu_alloc(void);
>  
> -/* generic pci stuff */
> -#include <asm-generic/pci.h>
> -
>  #ifdef CONFIG_NUMA
>  /* Returns the node based on pci bus */
>  static inline int __pcibus_to_node(const struct pci_bus *bus)
> diff --git a/arch/xtensa/include/asm/pci.h b/arch/xtensa/include/asm/pci.h
> index 8e2b48a268db..b56de9635b6c 100644
> --- a/arch/xtensa/include/asm/pci.h
> +++ b/arch/xtensa/include/asm/pci.h
> @@ -43,7 +43,4 @@
>  #define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
>  #define arch_can_pci_mmap_io()		1
>  
> -/* Generic PCI */
> -#include <asm-generic/pci.h>
> -
>  #endif	/* _XTENSA_PCI_H */
> diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
> index 2fa0f7d55259..8f7695624c8c 100644
> --- a/drivers/pnp/resource.c
> +++ b/drivers/pnp/resource.c
> @@ -17,6 +17,7 @@
>  #include <asm/dma.h>
>  #include <asm/irq.h>
>  #include <linux/pci.h>
> +#include <linux/libata.h>
>  #include <linux/ioport.h>
>  #include <linux/init.h>
>  
> @@ -322,8 +323,8 @@ static int pci_dev_uses_irq(struct pnp_dev *pnp, struct pci_dev *pci,
>  		 * treat the compatibility IRQs as busy.
>  		 */
>  		if ((progif & 0x5) != 0x5)
> -			if (pci_get_legacy_ide_irq(pci, 0) == irq ||
> -			    pci_get_legacy_ide_irq(pci, 1) == irq) {
> +			if (ATA_PRIMARY_IRQ(pci) == irq ||
> +			    ATA_SECONDARY_IRQ(pci) == irq) {
>  				pnp_dbg(&pnp->dev, "  legacy IDE device %s "
>  					"using irq %d\n", pci_name(pci), irq);
>  				return 1;
> diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
> deleted file mode 100644
> index 6bb3cd3d695a..000000000000
> --- a/include/asm-generic/pci.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * linux/include/asm-generic/pci.h
> - *
> - *  Copyright (C) 2003 Russell King
> - */
> -#ifndef _ASM_GENERIC_PCI_H
> -#define _ASM_GENERIC_PCI_H
> -
> -#ifndef HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
> -static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
> -{
> -	return channel ? 15 : 14;
> -}
> -#endif /* HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ */
> -
> -#endif /* _ASM_GENERIC_PCI_H */
> -- 
> 2.36.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
