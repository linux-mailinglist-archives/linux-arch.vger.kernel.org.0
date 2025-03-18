Return-Path: <linux-arch+bounces-10936-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 741F6A67E13
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 21:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9C517B494
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 20:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736B20CCF8;
	Tue, 18 Mar 2025 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmmQG2jQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C451DC9B4;
	Tue, 18 Mar 2025 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742330354; cv=none; b=ArfR+PXEzuWGFFZxU5FuyEUM78GwMMu/u7MUkhh3tjgi6fkJxXs3DEX4Od5UZyOPoize+QhZIl/6o+h+anCYmyZo+wZZPOgC5o14pDsiuyeY/QY5G51/0A5WMGY1z/Jb4ItfdYCND1oSvfWAlGs3GadsQs+TLLaOFs87shPEeKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742330354; c=relaxed/simple;
	bh=qOyqx98uYZaxnz8iL9sLUntJPSrsmCPx493u7R+Lnjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOGtwWVAyFSuJjMA599/Rs32b7i3xyAsVVJR5MsODFj+tIted+V5+BnCoSbDC2mlYg134CQQwe/KE9TURCQvtLCqYcH1L1DcJo8YzBSE68k6BDq+/xjTrJlK11wj1De91x+nW+NjUUw7njUl9KPuOu9b3icxqG6tGv3DE2buToQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmmQG2jQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B08C4CEDD;
	Tue, 18 Mar 2025 20:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742330354;
	bh=qOyqx98uYZaxnz8iL9sLUntJPSrsmCPx493u7R+Lnjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmmQG2jQTeVh/Wo0UkAwvIfRQMT2BJv/NcHjMw9/oC0Ydce8fyHd1L+aw+8KMafl3
	 daX59WrcnM3SoKrzxsQacaGdCwHn7j0cgltFaXcG0FWxhVFtnkslrkuZDIzDoRzRx4
	 IjWJucl8viLRZjB6jNb8ziUAEg2ZashS5lFUm9KOgrzWbB46qr5FlcAk0+otns60zv
	 zhA+c7L2jF0UYcCtQPFuEa7cxrT2KfcgPaV1RSsgFeoXx2cdHyoL6Za5yJerW6sxM+
	 ny/JMURbcz1jhTP1rnK9+tp3IAUvGeP8ZRwA/QKlgFzadPDgO1TfdclmN0zu740gQG
	 fWnpzczIdmTNw==
Date: Tue, 18 Mar 2025 13:39:06 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Julian Vetter <julian@outer-limits.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Subject: Re: [PATCH 5/6] mips: drop GENERIC_IOMAP wrapper
Message-ID: <20250318203906.GA4089579@ax162>
References: <20250315105907.1275012-1-arnd@kernel.org>
 <20250315105907.1275012-6-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315105907.1275012-6-arnd@kernel.org>

Hi Arnd,

On Sat, Mar 15, 2025 at 11:59:06AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All PIO on MIPS platforms is memory mapped, so there is no benefit in
> the lib/iomap.c wrappers that switch between inb/outb and readb/writeb
> style accessses.
> 
> In fact, the '#define PIO_RESERVED 0' setting completely disables
> the GENERIC_IOMAP functionality, and the '#define PIO_OFFSET
> mips_io_port_base' setting is based on a misunderstanding of what the
> offset is meant to do.
> 
> MIPS started using GENERIC_IOMAP in 2018 with commit b962aeb02205 ("MIPS:
> Use GENERIC_IOMAP") replacing a simple custom implementation of the same
> interfaces, but at the time the asm-generic/io.h version was not usable
> yet. Since the header is now always included, it's now possible to go
> back to the even simpler version.
> 
> Use the normal GENERIC_PCI_IOMAP functionality for all mips platforms
> without the hacky GENERIC_IOMAP, and provide a custom pci_iounmap()
> for the CONFIG_PCI_DRIVERS_LEGACY case to ensure the I/O port base never
> gets unmapped.
> 
> The readsl() prototype needs an extra 'const' keyword to make it
> compatible with the generic ioread32_rep() alias.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/Kconfig          |  2 +-
>  arch/mips/include/asm/io.h | 21 ++++++++-------------
>  arch/mips/lib/iomap-pci.c  |  9 +++++++++
>  3 files changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 1924f2d83932..2a2120a6d852 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -38,7 +38,6 @@ config MIPS
>  	select GENERIC_CMOS_UPDATE
>  	select GENERIC_CPU_AUTOPROBE
>  	select GENERIC_GETTIMEOFDAY
> -	select GENERIC_IOMAP
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_ISA_DMA if EISA
> @@ -47,6 +46,7 @@ config MIPS
>  	select GENERIC_LIB_CMPDI2
>  	select GENERIC_LIB_LSHRDI3
>  	select GENERIC_LIB_UCMPDI2
> +	select GENERIC_PCI_IOMAP
>  	select GENERIC_SCHED_CLOCK if !CAVIUM_OCTEON_SOC
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_IDLE_POLL_SETUP
> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
> index 0bddb568af7c..1fe56d1870a6 100644
> --- a/arch/mips/include/asm/io.h
> +++ b/arch/mips/include/asm/io.h
> @@ -66,17 +66,6 @@ static inline void set_io_port_base(unsigned long base)
>  	mips_io_port_base = base;
>  }
>  
> -/*
> - * Provide the necessary definitions for generic iomap. We make use of
> - * mips_io_port_base for iomap(), but we don't reserve any low addresses for
> - * use with I/O ports.
> - */
> -
> -#define HAVE_ARCH_PIO_SIZE
> -#define PIO_OFFSET	mips_io_port_base
> -#define PIO_MASK	IO_SPACE_LIMIT
> -#define PIO_RESERVED	0x0UL
> -
>  /*
>   * Enforce in-order execution of data I/O.  In the MIPS architecture
>   * these are equivalent to corresponding platform-specific memory
> @@ -397,8 +386,8 @@ static inline void writes##bwlq(volatile void __iomem *mem,		\
>  	}								\
>  }									\
>  									\
> -static inline void reads##bwlq(volatile void __iomem *mem, void *addr,	\
> -			       unsigned int count)			\
> +static inline void reads##bwlq(const volatile void __iomem *mem,	\
> +			       void *addr, unsigned int count)		\
>  {									\
>  	volatile type *__addr = addr;					\
>  									\
> @@ -555,6 +544,12 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
>  
>  void __ioread64_copy(void *to, const void __iomem *from, size_t count);
>  
> +#ifdef CONFIG_PCI_DRIVERS_LEGACY
> +struct pci_dev;
> +void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
> +#define pci_iounmap pci_iounmap
> +#endif
> +
>  #include <asm-generic/io.h>
>  
>  static inline void *isa_bus_to_virt(unsigned long address)
> diff --git a/arch/mips/lib/iomap-pci.c b/arch/mips/lib/iomap-pci.c
> index a9cb28813f0b..2f82c776c6d0 100644
> --- a/arch/mips/lib/iomap-pci.c
> +++ b/arch/mips/lib/iomap-pci.c
> @@ -43,4 +43,13 @@ void __iomem *__pci_ioport_map(struct pci_dev *dev,
>  	return (void __iomem *) (ctrl->io_map_base + port);
>  }
>  
> +void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
> +{
> +	struct pci_controller *ctrl = dev->bus->sysdata;
> +	void __iomem *base = (void __iomem *)ctrl->io_map_base;
> +
> +	if (addr < base || addr > (base + resource_size(ctrl->io_resource)))
> +		iounmap(addr);
> +}
> +
>  #endif /* CONFIG_PCI_DRIVERS_LEGACY */
> -- 
> 2.39.5
> 

This change as commit 976bf3aec388 ("mips: drop GENERIC_IOMAP wrapper") in
-next introduces new instances of -Wnull-pointer-arithmetic when building
certain mips configurations with clang.

  $ make -skj"$(nproc)" ARCH=mips LLVM=1 mrproper malta_defconfig init/main.o
  ...
  In file included from init/main.c:17:
  In file included from include/linux/module.h:17:
  In file included from include/linux/kmod.h:9:
  In file included from include/linux/umh.h:4:
  In file included from include/linux/gfp.h:7:
  In file included from include/linux/mmzone.h:22:
  In file included from include/linux/mm_types.h:5:
  In file included from include/linux/mm_types_task.h:14:
  In file included from arch/mips/include/asm/page.h:181:
  In file included from arch/mips/include/asm/io.h:553:
  include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
   1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
        |                                                   ~~~~~~~~~~ ^
  1 warning generated.

Cheers,
Nathan

