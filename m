Return-Path: <linux-arch+bounces-11059-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B37EA6DC1D
	for <lists+linux-arch@lfdr.de>; Mon, 24 Mar 2025 14:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3578F1894419
	for <lists+linux-arch@lfdr.de>; Mon, 24 Mar 2025 13:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B687B25F7B0;
	Mon, 24 Mar 2025 13:50:27 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973914F9FB;
	Mon, 24 Mar 2025 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824227; cv=none; b=HZhiqYp6djhngal4ckJYOI8y/0g0jLhYU07DxdtKT5FqcIMxMe/WwhDJW3kTrlth7b5sSHQsxMDgvJAxVYQBtqMyW/19UsaRA1nXmv0CifTzDACB8QxRL7T566ACBuffXf8cEG+SJD6npyRNeXrN3GwxnFZKNhk9qhTF1QGkIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824227; c=relaxed/simple;
	bh=5DWVH+PYF6T7L8669uq6zv4/kb1H6dDU0ckc3N5uPHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M22MfMyNm5+m6/QAEOKO1Oc4EbQwzJY6LyV9Q7YbWxdzonFDEFEHqxU589CUSjy8AD+nL6mj15CgVN28Ch0XUrT5mw78x/a0mDzHg5qlyWDlqr/5xxcPMRizqMKBI6ow96Uai+pn5e0bIhzZ0o0gYf6MJA1AYuFpBbTa7eHP8zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AE6C4CEDD;
	Mon, 24 Mar 2025 13:50:21 +0000 (UTC)
Message-ID: <9076d00e-c469-4a05-a686-94e3e55c8389@linux-m68k.org>
Date: Mon, 24 Mar 2025 23:50:19 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] m68k/nommu: stop using GENERIC_IOMAP
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
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
 <64f226e5-7931-40ba-878a-a28688da82fd@linux-m68k.org>
 <4a31c6a8-7c99-4d8f-8248-92e0e52b8db6@app.fastmail.com>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <4a31c6a8-7c99-4d8f-8248-92e0e52b8db6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arnd,

On 24/3/25 18:02, Arnd Bergmann wrote:
> On Mon, Mar 24, 2025, at 02:33, Greg Ungerer wrote:
>> Hi Arnd,
>>
>> On 15/3/25 20:59, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> There is no need to go through the GENERIC_IOMAP wrapper for PIO on
>>> nommu platforms, since these always come from PCI I/O space that is
>>> itself memory mapped.
>>>
>>> Instead, the generic ioport_map() can just return the MMIO location
>>> of the ports directly by applying the PCI_IO_PA offset, while
>>> ioread32/iowrite32 trivially turn into readl/writel as they do
>>> on most other architectures.
>>>
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> With this applied this fails to build for me:
>>
>>     UPD     include/generated/utsversion.h
>>     CC      init/version-timestamp.o
>>     LD      vmlinux
>> m68k-linux-uclibc-ld: drivers/pci/quirks.o: in function
>> `quirk_switchtec_ntb_dma_alias':
>> quirks.c:(.text+0x23e4): undefined reference to `pci_iomap'
>> m68k-linux-uclibc-ld: quirks.c:(.text+0x24fe): undefined reference to
>> `pci_iounmap'
>> m68k-linux-uclibc-ld: drivers/pci/quirks.o: in function
>> `disable_igfx_irq':
>> quirks.c:(.text+0x32f4): undefined reference to `pci_iomap'
>> m68k-linux-uclibc-ld: quirks.c:(.text+0x3348): undefined reference to
>> `pci_iounmap'
> 
> Thanks for the report, I was able to reproduce the problem now
> and applied the fixup below. I had tested m5475evb_defconfig earlier,
> and that built cleanly with PCI enabled, but I had missed how
> that still used GENERIC_IOMAP because it has CONFIG_MMU enabled.
> 
> Does this fixup work for you?

Yes, this looks good, works for me.
Feel free to add this if you like:

Acked-by: Greg Ungerer <gerg@linux-m68k.org>


> On a related note, I'm curious about how the MCF54xx chips are
> used in practice, as I see that they are the only coldfire chips
> with PCI and they all have an MMU. Are there actual users of these
> chips that have PCI but choose not to use the MMU?

No, I think everyone with these uses them with MMU enabled.

It is probably more of an historical curiosity to use them with
the MMU disabled. That supported pre-dated mainline kernels having
full ColdFire MMU support by a good few years.

Regards
Greg



>        Arnd
> 
> 8<-----
>  From a36995e2a64711556c6773797367d165828f6705 Mon Sep 17 00:00:00 2001
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Mon, 24 Mar 2025 07:53:47 +0100
> Subject: [PATCH] m68k: coldfire: select PCI_IOMAP for PCI
> 
> After I dropped CONFIG_GENERIC_IOMAP, some PCI drivers started failing
> to link when CONFIG_MMU is disabled:
> 
> ERROR: modpost: "pci_iounmap" [drivers/video/fbdev/i740fb.ko] undefined!
> ERROR: modpost: "pci_iounmap" [drivers/video/fbdev/vt8623fb.ko] undefined!
> ERROR: modpost: "pci_iomap_wc" [drivers/video/fbdev/vt8623fb.ko] undefined!
> ERROR: modpost: "pci_iomap" [drivers/video/fbdev/vt8623fb.ko] undefined!
> ERROR: modpost: "pci_iounmap" [drivers/video/fbdev/s3fb.ko] undefined!
> ...
> 
> It turns out that there were two mistakes in my patch: on !MMU I forgot
> to enable CONFIG_GENERIC_PCI_IOMAP, and for Coldfire with MMU enabled,
> teh GENERIC_IOMAP was left in place but incorrectly configured.
> 
> Fixes: 9d48cc07d0d7 ("m68k/nommu: stop using GENERIC_IOMAP")
> Reported-by: Greg Ungerer <gerg@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index b50c275fa94d..eb5bb6d36899 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -18,12 +18,13 @@ config M68K
>   	select DMA_DIRECT_REMAP if M68K_NONCOHERENT_DMA && !COLDFIRE
>   	select GENERIC_ATOMIC64
>   	select GENERIC_CPU_DEVICES
> -	select GENERIC_IOMAP if HAS_IOPORT && MMU
> +	select GENERIC_IOMAP if HAS_IOPORT && MMU && !COLDFIRE
>   	select GENERIC_IRQ_SHOW
>   	select GENERIC_LIB_ASHLDI3
>   	select GENERIC_LIB_ASHRDI3
>   	select GENERIC_LIB_LSHRDI3
>   	select GENERIC_LIB_MULDI3
> +	select GENERIC_PCI_IOMAP if PCI
>   	select HAS_IOPORT if PCI || ISA || ATARI_ROM_ISA
>   	select HAVE_ARCH_LIBGCC_H
>   	select HAVE_ARCH_SECCOMP


