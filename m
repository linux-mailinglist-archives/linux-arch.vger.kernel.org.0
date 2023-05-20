Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522A170A4E7
	for <lists+linux-arch@lfdr.de>; Sat, 20 May 2023 05:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjETDZM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 23:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjETDZK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 23:25:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA267F3
        for <linux-arch@vger.kernel.org>; Fri, 19 May 2023 20:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684553062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zMy+Lm6/AnuXAoD8DGMohQvJ4uUCnlO+X3DPgsPHT40=;
        b=N3F7o/9QgRh87g0mnkwDR2Noy26uUlm/Ze5FQ1xqFZF0FRUyRZNKFANk8m4FW986Bfd/ZY
        130PxttK0+mfoL1UEb0mlS5PIKXO/S96DLhbuHGZwOvmGW87gKDL/EWK6fLGAgZz6MS0t8
        5L3Q9mYGUm94rNazpM6ty96qgaKsS9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-64-VvqZzU0IMWyKg-wYVTYykg-1; Fri, 19 May 2023 23:24:17 -0400
X-MC-Unique: VvqZzU0IMWyKg-wYVTYykg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABE7885A5A8;
        Sat, 20 May 2023 03:24:16 +0000 (UTC)
Received: from localhost (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 262942166B25;
        Sat, 20 May 2023 03:24:14 +0000 (UTC)
Date:   Sat, 20 May 2023 11:24:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, linux-arch@vger.kernel.org,
        arnd@arndb.de, Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH v4] mips: add <asm-generic/io.h> including
Message-ID: <ZGg9W3qQAez38SI3@MiWiFi-R3L-srv>
References: <20230519195135.79600-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519195135.79600-1-jiaxun.yang@flygoat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 05/19/23 at 08:51pm, Jiaxun Yang wrote:
> With the adding, some default ioremap_xx methods defined in
> asm-generic/io.h can be used. E.g the default ioremap_uc() returning
> NULL.
> 
> We also massaged various headers to avoid nested includes.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> [jiaxun.yang@flygoat.com: Massage more headers, fix ioport defines]
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: linux-mips@vger.kernel.org
> ---
> Tested against qemu malta 34Kf, boston I6500, Loongson64, hopefully
> everything is fine now.

Thanks a lot for fixing this, Jiaxun.

> ---
>  arch/mips/include/asm/io.h      | 65 +++++++++++++++++++++++++++++----
>  arch/mips/include/asm/mmiowb.h  |  4 +-
>  arch/mips/include/asm/smp-ops.h |  2 -
>  arch/mips/include/asm/smp.h     |  4 +-
>  arch/mips/kernel/setup.c        |  1 +
>  arch/mips/pci/pci-ip27.c        |  3 ++
>  6 files changed, 64 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index cc28d207a061..8508d01fb75e 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -15,7 +15,6 @@
>  #define ARCH_HAS_IOREMAP_WC
>  
>  #include <linux/compiler.h>
> -#include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/irqflags.h>
>  
> @@ -28,7 +27,6 @@
>  #include <asm-generic/iomap.h>
>  #include <asm/page.h>
>  #include <asm/pgtable-bits.h>
> -#include <asm/processor.h>
>  #include <asm/string.h>
>  #include <mangle-port.h>
>  
> @@ -44,6 +42,11 @@
>  # define __raw_ioswabq(a, x)	(x)
>  # define ____raw_ioswabq(a, x)	(x)
>  
> +# define _ioswabb ioswabb
> +# define _ioswabw ioswabw
> +# define _ioswabl ioswabl
> +# define _ioswabq ioswabq
> +
>  # define __relaxed_ioswabb ioswabb
>  # define __relaxed_ioswabw ioswabw
>  # define __relaxed_ioswabl ioswabl
> @@ -129,6 +132,7 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
>   *     almost all conceivable cases a device driver should not be using
>   *     this function
>   */
> +#define phys_to_virt phys_to_virt
>  static inline void * phys_to_virt(unsigned long address)
>  {
>  	return __va(address);
> @@ -297,9 +301,9 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
>  	return pfx##ioswab##bwlq(__mem, __val);				\
>  }
>  
> -#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, barrier, relax, p)	\
> +#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, barrier, relax)		\
>  									\
> -static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
> +static inline void pfx##out##bwlq(type val, unsigned long port)		\
>  {									\
>  	volatile type *__addr;						\
>  	type __val;							\
> @@ -319,7 +323,7 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
>  	*__addr = __val;						\
>  }									\
>  									\
> -static inline type pfx##in##bwlq##p(unsigned long port)			\
> +static inline type pfx##in##bwlq(unsigned long port)			\
>  {									\
>  	volatile type *__addr;						\
>  	type __val;							\
> @@ -361,11 +365,10 @@ __BUILD_MEMORY_PFX(__mem_, q, u64, 0)
>  #endif
>  
>  #define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
> -	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0,)			\
> -	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0, _p)
> +	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0)
>  
>  #define BUILDIO_IOPORT(bwlq, type)					\
> -	__BUILD_IOPORT_PFX(, bwlq, type)				\
> +	__BUILD_IOPORT_PFX(_, bwlq, type)				\
>  	__BUILD_IOPORT_PFX(__mem_, bwlq, type)
>  
>  BUILDIO_IOPORT(b, u8)
> @@ -481,14 +484,17 @@ BUILDSTRING(l, u32)
>  BUILDSTRING(q, u64)
>  #endif
>  
> +#define memset_io memset_io
>  static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
>  {
>  	memset((void __force *) addr, val, count);
>  }
> +#define memcpy_fromio memcpy_fromio
>  static inline void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
>  {
>  	memcpy(dst, (void __force *) src, count);
>  }
> +#define memcpy_toio memcpy_toio
>  static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
>  {
>  	memcpy((void __force *) dst, src, count);
> @@ -549,6 +555,47 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
>  #define csr_out32(v, a) (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST) = (v))
>  #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST))
>  
> +
> +#define __raw_readb __raw_readb
> +#define __raw_readw __raw_readw
> +#define __raw_readl __raw_readl
> +#define __raw_readq __raw_readq
> +#define __raw_writeb __raw_writeb
> +#define __raw_writew __raw_writew
> +#define __raw_writel __raw_writel
> +#define __raw_writeq __raw_writeq
> +
> +#define readb readb
> +#define readw readw
> +#define readl readl
> +#define writeb writeb
> +#define writew writew
> +#define writel writel
> +
> +#define readsb readsb
> +#define readsw readsw
> +#define readsl readsl
> +#define readsq readsq
> +#define writesb writesb
> +#define writesw writesw
> +#define writesl writesl
> +#define writesq writesq
> +
> +#define _inb _inb
> +#define _inw _inw
> +#define _inl _inl
> +#define insb insb
> +#define insw insw
> +#define insl insl
> +
> +#define _outb _outb
> +#define _outw _outw
> +#define _outl _outl
> +#define outsb outsb
> +#define outsw outsw
> +#define outsl outsl
> +
> +
>  /*
>   * Convert a physical pointer to a virtual kernel pointer for /dev/mem
>   * access
> @@ -557,4 +604,6 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
>  
>  void __ioread64_copy(void *to, const void __iomem *from, size_t count);
>  
> +#include <asm-generic/io.h>
> +
>  #endif /* _ASM_IO_H */
> diff --git a/arch/mips/include/asm/mmiowb.h b/arch/mips/include/asm/mmiowb.h
> index a40824e3ef8e..cf27752fd220 100644
> --- a/arch/mips/include/asm/mmiowb.h
> +++ b/arch/mips/include/asm/mmiowb.h
> @@ -2,9 +2,9 @@
>  #ifndef _ASM_MMIOWB_H
>  #define _ASM_MMIOWB_H
>  
> -#include <asm/io.h>
> +#include <asm/barrier.h>
>  
> -#define mmiowb()	iobarrier_w()
> +#define mmiowb()	wmb()
>  
>  #include <asm-generic/mmiowb.h>
>  
> diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
> index 5719ff49eff1..a6941b7f0cc0 100644
> --- a/arch/mips/include/asm/smp-ops.h
> +++ b/arch/mips/include/asm/smp-ops.h
> @@ -13,8 +13,6 @@
>  
>  #include <linux/errno.h>
>  
> -#include <asm/mips-cps.h>
> -
>  #ifdef CONFIG_SMP
>  
>  #include <linux/cpumask.h>
> diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
> index aab8981bc32c..125c3494a010 100644
> --- a/arch/mips/include/asm/smp.h
> +++ b/arch/mips/include/asm/smp.h
> @@ -11,13 +11,11 @@
>  #ifndef __ASM_SMP_H
>  #define __ASM_SMP_H
>  
> -#include <linux/bitops.h>
> +#include <linux/compiler.h>
>  #include <linux/linkage.h>
> -#include <linux/smp.h>
>  #include <linux/threads.h>
>  #include <linux/cpumask.h>
>  
> -#include <linux/atomic.h>
>  #include <asm/smp-ops.h>
>  
>  extern int smp_num_siblings;
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index febdc5564638..f9f149928e46 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -41,6 +41,7 @@
>  #include <asm/sections.h>
>  #include <asm/setup.h>
>  #include <asm/smp-ops.h>
> +#include <asm/mips-cps.h>
>  #include <asm/prom.h>
>  #include <asm/fw/fw.h>
>  
> diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
> index d85cbf84e41c..973faea61cad 100644
> --- a/arch/mips/pci/pci-ip27.c
> +++ b/arch/mips/pci/pci-ip27.c
> @@ -7,6 +7,9 @@
>   * Copyright (C) 1999, 2000, 04 Ralf Baechle (ralf@linux-mips.org)
>   * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
>   */
> +
> +#include <linux/io.h>
> +
>  #include <asm/sn/addrs.h>
>  #include <asm/sn/types.h>
>  #include <asm/sn/klconfig.h>
> -- 
> 2.39.2 (Apple Git-143)
> 

