Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7DAF32F7
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2019 16:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfKGP3L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Nov 2019 10:29:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36120 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbfKGP3L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Nov 2019 10:29:11 -0500
Received: by mail-pg1-f196.google.com with SMTP id k13so2346425pgh.3
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 07:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=GbyQkvm+sFQYWlS225S4dt9u2BPPAVTJsInNrOBU2Cw=;
        b=SSYfx+6GZDmDgcSY10ocXoeqy0hvmi6reeDxEoQaAK6GCZCK9w+PzQYApeYqiY++fk
         M+tQGD6vS51dQQe5tSz4jCiUaKguLT3oFupheS96jDMwxARnNuu5nNZUNPYkSKlItpwK
         n4+KCfywaoq2TS79EdF/7PydD1molSI6AAqvO/ZGgE+4pWfhiWmrteTgHV+/1VZacN6J
         zh92pqeL/VUD/D36NRtWMaA8VYTT6RbLnYEFFgWWP9sKvvMOqYEQ/LHSUZ0Ljg+bM2jc
         Hn0SXz5up/lwM0AnUXb3mkKmK/jhJDw/2Q6Q9tWDOGqA0rMh1HezGItuGNAqqcrUeFp+
         45ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=GbyQkvm+sFQYWlS225S4dt9u2BPPAVTJsInNrOBU2Cw=;
        b=Tvct8FZgZwbVeaWNwcGttd7YEjIlWkzYzhF6NKuWnBcvwdeIpHSVIJddAbtT+aT2a8
         qJzmK7RdA463RL3Vq5b2ydumeEwkjkVafbgxZQt3Ody5L0V2xlrY+gjAUYlzOOXvgekz
         sFp6wTNMlPlmS+mpZGOswsv+IjyrW8+lMa3L9KNFZNeNdTN60mFHMhtiGKPbYL5cAgRI
         yf4ncwjdSkHivirezGIU8dJkEt+4XRrW+TvmfzldFmIxbWEc6RyZj434xBJ+okm37O7x
         gkAZpWCSixogorQQ54mjiPral2cCrzH9QsF2oiUGsp1rGEHyHSOM2QdhiRu11TBDG8rg
         i/7Q==
X-Gm-Message-State: APjAAAXYLHPdm3r4a9Saom+I4BtkLl5YG6Xe6D46QTKzhMt+1YKDlLBB
        W8dlD91uvX8ps4+mcctS6x1Ksg==
X-Google-Smtp-Source: APXvYqxZWuyJcE77KhdsPjm9nF9Fuj8aALe30eqgmntG5XGTW6TdluM2Ry7yVUPEvnD0qYzDHJsYjQ==
X-Received: by 2002:a63:d504:: with SMTP id c4mr5032823pgg.75.1573140549240;
        Thu, 07 Nov 2019 07:29:09 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m15sm3002721pgv.58.2019.11.07.07.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 07:29:08 -0800 (PST)
Date:   Thu, 07 Nov 2019 07:29:08 -0800 (PST)
X-Google-Original-Date: Wed, 06 Nov 2019 10:43:22 PST (-0800)
Subject:     Re: [PATCH 12/21] arch: rely on asm-generic/io.h for default ioremap_* definitions
In-Reply-To: <20191029064834.23438-13-hch@lst.de>
CC:     Arnd Bergmann <arnd@arndb.de>, guoren@kernel.org, monstr@monstr.eu,
        green.hu@gmail.com, deanbo422@gmail.com, gxt@pku.edu.cn,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-fd2a8aae-e87e-44dd-9416-57bb380955d9@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 28 Oct 2019 23:48:25 PDT (-0700), Christoph Hellwig wrote:
> Various architectures that use asm-generic/io.h still defined their
> own default versions of ioremap_nocache, ioremap_wt and ioremap_wc
> that point back to plain ioremap directly or indirectly.  Remove these
> definitions and rely on asm-generic/io.h instead.  For this to work
> the backup ioremap_* defintions needs to be changed to purely cpp
> macros instea of inlines to cover for architectures like openrisc
> that only define ioremap after including <asm-generic/io.h>.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/include/asm/io.h        |  4 ----
>  arch/arm/include/asm/io.h        |  1 -
>  arch/arm64/include/asm/io.h      |  2 --
>  arch/csky/include/asm/io.h       |  1 -
>  arch/ia64/include/asm/io.h       |  1 -
>  arch/microblaze/include/asm/io.h |  3 ---
>  arch/nios2/include/asm/io.h      |  4 ----
>  arch/openrisc/include/asm/io.h   |  1 -
>  arch/riscv/include/asm/io.h      | 10 ----------
>  arch/s390/include/asm/io.h       |  4 ----
>  arch/x86/include/asm/io.h        |  1 -
>  arch/xtensa/include/asm/io.h     |  4 ----
>  include/asm-generic/io.h         | 18 +++---------------
>  13 files changed, 3 insertions(+), 51 deletions(-)
>
> diff --git a/arch/arc/include/asm/io.h b/arch/arc/include/asm/io.h
> index 72f7929736f8..8f777d6441a5 100644
> --- a/arch/arc/include/asm/io.h
> +++ b/arch/arc/include/asm/io.h
> @@ -34,10 +34,6 @@ static inline void ioport_unmap(void __iomem *addr)
>
>  extern void iounmap(const void __iomem *addr);
>
> -#define ioremap_nocache(phy, sz)	ioremap(phy, sz)
> -#define ioremap_wc(phy, sz)		ioremap(phy, sz)
> -#define ioremap_wt(phy, sz)		ioremap(phy, sz)
> -
>  /*
>   * io{read,write}{16,32}be() macros
>   */
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index 924f9dd502ed..aefdabdbeb84 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -392,7 +392,6 @@ static inline void memcpy_toio(volatile void __iomem *to, const void *from,
>   */
>  void __iomem *ioremap(resource_size_t res_cookie, size_t size);
>  #define ioremap ioremap
> -#define ioremap_nocache ioremap
>
>  /*
>   * Do not use ioremap_cache for mapping memory. Use memremap instead.
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 323cb306bd28..4e531f57147d 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -167,9 +167,7 @@ extern void iounmap(volatile void __iomem *addr);
>  extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
>
>  #define ioremap(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
> -#define ioremap_nocache(addr, size)	__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
>  #define ioremap_wc(addr, size)		__ioremap((addr), (size), __pgprot(PROT_NORMAL_NC))
> -#define ioremap_wt(addr, size)		__ioremap((addr), (size), __pgprot(PROT_DEVICE_nGnRE))
>
>  /*
>   * PCI configuration space mapping function.
> diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
> index 80d071e2567f..a4b9fb616faa 100644
> --- a/arch/csky/include/asm/io.h
> +++ b/arch/csky/include/asm/io.h
> @@ -42,7 +42,6 @@ extern void iounmap(void *addr);
>
>  #define ioremap(addr, size)		__ioremap((addr), (size), pgprot_noncached(PAGE_KERNEL))
>  #define ioremap_wc(addr, size)		__ioremap((addr), (size), pgprot_writecombine(PAGE_KERNEL))
> -#define ioremap_nocache(addr, size)	ioremap((addr), (size))
>  #define ioremap_cache			ioremap_cache
>
>  #include <asm-generic/io.h>
> diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
> index fec9df9609ed..3d666a11a2de 100644
> --- a/arch/ia64/include/asm/io.h
> +++ b/arch/ia64/include/asm/io.h
> @@ -263,7 +263,6 @@ static inline void __iomem * ioremap_cache (unsigned long phys_addr, unsigned lo
>  	return ioremap(phys_addr, size);
>  }
>  #define ioremap ioremap
> -#define ioremap_nocache ioremap
>  #define ioremap_cache ioremap_cache
>  #define ioremap_uc ioremap_uc
>  #define iounmap iounmap
> diff --git a/arch/microblaze/include/asm/io.h b/arch/microblaze/include/asm/io.h
> index 86c95b2a1ce1..d33c61737b8b 100644
> --- a/arch/microblaze/include/asm/io.h
> +++ b/arch/microblaze/include/asm/io.h
> @@ -39,9 +39,6 @@ extern resource_size_t isa_mem_base;
>  extern void iounmap(volatile void __iomem *addr);
>
>  extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
> -#define ioremap_nocache(addr, size)		ioremap((addr), (size))
> -#define ioremap_wc(addr, size)			ioremap((addr), (size))
> -#define ioremap_wt(addr, size)			ioremap((addr), (size))
>
>  #endif /* CONFIG_MMU */
>
> diff --git a/arch/nios2/include/asm/io.h b/arch/nios2/include/asm/io.h
> index 74ab34aa6731..d108937c321e 100644
> --- a/arch/nios2/include/asm/io.h
> +++ b/arch/nios2/include/asm/io.h
> @@ -33,10 +33,6 @@ static inline void iounmap(void __iomem *addr)
>  	__iounmap(addr);
>  }
>
> -#define ioremap_nocache ioremap
> -#define ioremap_wc ioremap
> -#define ioremap_wt ioremap
> -
>  /* Pages to physical address... */
>  #define page_to_phys(page)	virt_to_phys(page_to_virt(page))
>
> diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
> index 5b81a96ab85e..e18f038b2a6d 100644
> --- a/arch/openrisc/include/asm/io.h
> +++ b/arch/openrisc/include/asm/io.h
> @@ -25,7 +25,6 @@
>  #define PIO_OFFSET		0
>  #define PIO_MASK		0
>
> -#define ioremap_nocache ioremap
>  #include <asm-generic/io.h>
>  #include <asm/pgtable.h>
>
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index fc1189ad3777..c1de6875cc77 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -15,16 +15,6 @@
>  #include <asm/mmiowb.h>
>
>  extern void __iomem *ioremap(phys_addr_t offset, unsigned long size);
> -
> -/*
> - * The RISC-V ISA doesn't yet specify how to query or modify PMAs, so we can't
> - * change the properties of memory regions.  This should be fixed by the
> - * upcoming platform spec.
> - */
> -#define ioremap_nocache(addr, size) ioremap((addr), (size))
> -#define ioremap_wc(addr, size) ioremap((addr), (size))
> -#define ioremap_wt(addr, size) ioremap((addr), (size))
> -
>  extern void iounmap(volatile void __iomem *addr);
>
>  /* Generic IO read/write.  These perform native-endian accesses. */
> diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
> index ca421614722f..5a16f500515a 100644
> --- a/arch/s390/include/asm/io.h
> +++ b/arch/s390/include/asm/io.h
> @@ -26,10 +26,6 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
>
>  #define IO_SPACE_LIMIT 0
>
> -#define ioremap_nocache(addr, size)	ioremap(addr, size)
> -#define ioremap_wc			ioremap_nocache
> -#define ioremap_wt			ioremap_nocache
> -
>  void __iomem *ioremap(unsigned long offset, unsigned long size);
>  void iounmap(volatile void __iomem *addr);
>
> diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
> index 6b5cc41319a7..9997521fc5cd 100644
> --- a/arch/x86/include/asm/io.h
> +++ b/arch/x86/include/asm/io.h
> @@ -205,7 +205,6 @@ extern void __iomem *ioremap_encrypted(resource_size_t phys_addr, unsigned long
>   */
>  void __iomem *ioremap(resource_size_t offset, unsigned long size);
>  #define ioremap ioremap
> -#define ioremap_nocache ioremap
>
>  extern void iounmap(volatile void __iomem *addr);
>  #define iounmap iounmap
> diff --git a/arch/xtensa/include/asm/io.h b/arch/xtensa/include/asm/io.h
> index 441fb56926a7..54188e69b988 100644
> --- a/arch/xtensa/include/asm/io.h
> +++ b/arch/xtensa/include/asm/io.h
> @@ -52,10 +52,6 @@ static inline void __iomem *ioremap_cache(unsigned long offset,
>  }
>  #define ioremap_cache ioremap_cache
>
> -#define ioremap_nocache ioremap
> -#define ioremap_wc ioremap
> -#define ioremap_wt ioremap
> -
>  static inline void iounmap(volatile void __iomem *addr)
>  {
>  	unsigned long va = (unsigned long) addr;
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 6a5edc23afe2..4e45e1cb6560 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -949,27 +949,15 @@ static inline void iounmap(void __iomem *addr)
>  #endif /* CONFIG_MMU */
>
>  #ifndef ioremap_nocache
> -#define ioremap_nocache ioremap_nocache
> -static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
> -{
> -	return ioremap(offset, size);
> -}
> +#define ioremap_nocache ioremap
>  #endif
>
>  #ifndef ioremap_wc
> -#define ioremap_wc ioremap_wc
> -static inline void __iomem *ioremap_wc(phys_addr_t offset, size_t size)
> -{
> -	return ioremap_nocache(offset, size);
> -}
> +#define ioremap_wc ioremap
>  #endif
>
>  #ifndef ioremap_wt
> -#define ioremap_wt ioremap_wt
> -static inline void __iomem *ioremap_wt(phys_addr_t offset, size_t size)
> -{
> -	return ioremap_nocache(offset, size);
> -}
> +#define ioremap_wt ioremap
>  #endif
>
>  /*

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>
