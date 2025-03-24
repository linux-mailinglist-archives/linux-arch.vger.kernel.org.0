Return-Path: <linux-arch+bounces-11053-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDCBA6D2D5
	for <lists+linux-arch@lfdr.de>; Mon, 24 Mar 2025 02:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98C727A35A6
	for <lists+linux-arch@lfdr.de>; Mon, 24 Mar 2025 01:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3664946C;
	Mon, 24 Mar 2025 01:33:45 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F3A2E3385;
	Mon, 24 Mar 2025 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742780025; cv=none; b=tOuK2KQtz2eHEIvn/TPU8arRy5py3rmmum2/GYN8scLXq7TiH0mIOZsALb6GF138RMtYPOrpkymuHPQsNDNPBSTAgMWGLKAdrJR2kjH1yHZZSEtFoqcdo/t3rI6tL3dMhyXOg/F7IHrHe2wrHjpsyTFGfgJjVy8DtUc9FAEQ+ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742780025; c=relaxed/simple;
	bh=VGEc0Z9zeQ9L4OTr2B3d9j2OWbZhoYVYcPoTxzvg5VA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mk4V8OS/ixnk+C9UPy1rhRzMclCe5t50S8vue0rO+Ns5L4A6CqpS+BThe1rQYwqgBGwMNSlgqWaNIUfi7yVSDg6lHpoVLXw/Sq4a+JWWLNCTfDVWExsBdBOEywlUHqM/FGjbLrfl/zegUJ8zY2znmllAQIh1D/N2MeuD16JEN4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6601C4CEE2;
	Mon, 24 Mar 2025 01:33:38 +0000 (UTC)
Message-ID: <64f226e5-7931-40ba-878a-a28688da82fd@linux-m68k.org>
Date: Mon, 24 Mar 2025 11:33:35 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] m68k/nommu: stop using GENERIC_IOMAP
To: Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Julian Vetter <julian@outer-limits.org>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
References: <20250315105907.1275012-1-arnd@kernel.org>
 <20250315105907.1275012-7-arnd@kernel.org>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20250315105907.1275012-7-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnd,

On 15/3/25 20:59, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is no need to go through the GENERIC_IOMAP wrapper for PIO on
> nommu platforms, since these always come from PCI I/O space that is
> itself memory mapped.
> 
> Instead, the generic ioport_map() can just return the MMIO location
> of the ports directly by applying the PCI_IO_PA offset, while
> ioread32/iowrite32 trivially turn into readl/writel as they do
> on most other architectures.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

With this applied this fails to build for me:

   UPD     include/generated/utsversion.h
   CC      init/version-timestamp.o
   LD      vmlinux
m68k-linux-uclibc-ld: drivers/pci/quirks.o: in function `quirk_switchtec_ntb_dma_alias':
quirks.c:(.text+0x23e4): undefined reference to `pci_iomap'
m68k-linux-uclibc-ld: quirks.c:(.text+0x24fe): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: drivers/pci/quirks.o: in function `disable_igfx_irq':
quirks.c:(.text+0x32f4): undefined reference to `pci_iomap'
m68k-linux-uclibc-ld: quirks.c:(.text+0x3348): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: quirks.c:(.text+0x338a): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: quirks.c:(.text+0x33d2): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: drivers/pci/quirks.o: in function `reset_ivb_igd':
quirks.c:(.text+0x3502): undefined reference to `pci_iomap'
m68k-linux-uclibc-ld: quirks.c:(.text+0x3658): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: quirks.c:(.text+0x3682): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: drivers/pci/quirks.o: in function `reset_hinic_vf_dev':
quirks.c:(.text+0x3844): undefined reference to `pci_iomap'
m68k-linux-uclibc-ld: quirks.c:(.text+0x39fc): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: quirks.c:(.text+0x3a86): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: quirks.c:(.text+0x3ab4): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: drivers/pci/quirks.o: in function `quirk_reset_lenovo_thinkpad_p50_nvgpu':
quirks.c:(.text+0x3cf6): undefined reference to `pci_iomap'
m68k-linux-uclibc-ld: drivers/pci/quirks.o: in function `nvme_disable_and_flr':
quirks.c:(.text+0x3e32): undefined reference to `pci_iomap'
m68k-linux-uclibc-ld: quirks.c:(.text+0x3eac): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: quirks.c:(.text+0x3fc0): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: drivers/pci/devres.o: in function `pcim_addr_resource_release':
devres.c:(.text+0x414): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: devres.c:(.text+0x420): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: drivers/pci/devres.o: in function `pcim_iomap':
devres.c:(.text+0x524): undefined reference to `pci_iomap'
m68k-linux-uclibc-ld: devres.c:(.text+0x576): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: drivers/pci/devres.o: in function `pcim_iomap_range':
devres.c:(.text+0x980): undefined reference to `pci_iomap_range'
m68k-linux-uclibc-ld: drivers/pci/devres.o: in function `pcim_iomap_region':
devres.c:(.text+0xc0e): undefined reference to `pci_iomap'
m68k-linux-uclibc-ld: drivers/net/ethernet/intel/e100.o: in function `e100_remove':
e100.c:(.text+0x1fe6): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: drivers/net/ethernet/intel/e100.o: in function `e100_probe':
e100.c:(.text+0x362a): undefined reference to `pci_iomap'
m68k-linux-uclibc-ld: e100.c:(.text+0x381c): undefined reference to `pci_iounmap'
m68k-linux-uclibc-ld: e100.c:(.text+0x3928): undefined reference to `pci_iounmap'
make[2]: *** [scripts/Makefile.vmlinux:77: vmlinux] Error 1
make[1]: *** [/home/gerg/accelerated-linux.lkml/linux/Makefile:1231: vmlinux] Error 2
make: *** [Makefile:251: __sub-make] Error 2

FWIW this was a m5475evb_defconfig with CONFIG_MMU disabled.

Regards
Greg



> ---
>   arch/m68k/Kconfig             | 2 +-
>   arch/m68k/include/asm/io_no.h | 4 ----
>   2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index b2ed0308c0ea..b50c275fa94d 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -18,7 +18,7 @@ config M68K
>   	select DMA_DIRECT_REMAP if M68K_NONCOHERENT_DMA && !COLDFIRE
>   	select GENERIC_ATOMIC64
>   	select GENERIC_CPU_DEVICES
> -	select GENERIC_IOMAP if HAS_IOPORT
> +	select GENERIC_IOMAP if HAS_IOPORT && MMU
>   	select GENERIC_IRQ_SHOW
>   	select GENERIC_LIB_ASHLDI3
>   	select GENERIC_LIB_ASHRDI3
> diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
> index 2c96e8480173..516371d5587a 100644
> --- a/arch/m68k/include/asm/io_no.h
> +++ b/arch/m68k/include/asm/io_no.h
> @@ -123,10 +123,6 @@ static inline void writel(u32 value, volatile void __iomem *addr)
>   #define PCI_IO_SIZE	0x00010000		/* 64k */
>   #define PCI_IO_MASK	(PCI_IO_SIZE - 1)
>   
> -#define HAVE_ARCH_PIO_SIZE
> -#define PIO_OFFSET	0
> -#define PIO_MASK	0xffff
> -#define PIO_RESERVED	0x10000
>   #define PCI_IOBASE	((void __iomem *) PCI_IO_PA)
>   #define PCI_SPACE_LIMIT	PCI_IO_MASK
>   #endif /* CONFIG_PCI */


