Return-Path: <linux-arch+bounces-10937-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B300AA67E85
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 22:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8600019C36A3
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 21:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5594206F08;
	Tue, 18 Mar 2025 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dFI2VrSs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mQ/4TodD"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7737E1;
	Tue, 18 Mar 2025 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332445; cv=none; b=HGTXiaR2SLJjNdHNZKM64MEePs0t6pZTKnAGmTs9JspnrPjMQ2GFBguEsDRrfDGfjoyhZEM26m7brkd0F6BFHHADhmFEgaS19DX8I18fWUoBMSYiFthox1fnxHSjN9Eti2ZWSdm19mppQBZoLQdGCsertgnMJlUM2mugjTMdGts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332445; c=relaxed/simple;
	bh=GB0MKorwfNVgHASjmfnIgFFRgN0GQO0DS1Q/f1fURzE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HMpjT2bTi787HyqmJ9TuAs2VR3pEEqg6FACQrg4j8gLzl+lFZmc4l6jt4rE696kU816C/gS+s7HPC1bLnJV7LCkmucaCyeF/gGtTjDQXzAQfxdyFtTmGjziuFinv11XQvvAl4+My4jrhwdLbK9lQfi6wInm33ySL3NfNW+lGXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dFI2VrSs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mQ/4TodD; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B9911140098;
	Tue, 18 Mar 2025 17:14:01 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Tue, 18 Mar 2025 17:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742332441;
	 x=1742418841; bh=6Wnno4ANVKxueaFjx6I4DVJGzAoa07LKkIYejE1OybM=; b=
	dFI2VrSsmJvKZXQEWv0b+6lLs6h2rrXpBXnD1WDs/tjYgHOrEPqjQWYfpgJLJ6Dz
	0uDpMTiYauSbiQ4w2sPcdGkd+qAIZWKppygqbk/wfeUy/5S3ligXhQnU0UPnPamc
	bMnZNv6U/QohqSlf4tad3QFXfd4U1AKDR7poUyd+1pJ8gXBV9d6Bb9QjJlapLC1t
	L6Z5wDmWa1pm8yDStkhgRHlWgUQ3Niz8m597DS0xsI8YtDvYLdJyqscOVqMvw+LZ
	hArMs2YXZ8HI8A61ETHkr8uZL+3lzuAJPMVGi3NUeWSmci/NXyfy/ISbdCjh1fb0
	anJmKVtYQJFh0/k9ChTKyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742332441; x=
	1742418841; bh=6Wnno4ANVKxueaFjx6I4DVJGzAoa07LKkIYejE1OybM=; b=m
	Q/4TodDV8ABnaVLbk4J9v4V2dkLG+MvRKig12GI7AQAb9/7YOBqOyG3ROJb+rr5d
	cHKzOapNwmhS7uGqA9TEOIa4fTT9tWJhEFIUwYJptXONDrOnkYzF0pIZ7nPtP3hC
	+rKCCB/jOvJ4vRY86cSe6324xoxM3LCh2Pa8gn4Zbg5TyDwdyPYNaIOjAGvwnSzr
	FetD+Tyn4ZBnH0mVXa0Cke3SEYdYO0pMR/KIjeKNAP1pYyGHJrQtlvJGxlJVs+Of
	rs0V6sz1QQHX+/1G7GvCuJu/qx61R2ofEcLYus0wSVWAmhbajW+aAC/F5vkG2s4R
	/FYA+2ozaAXrAOXwmKv7g==
X-ME-Sender: <xms:F-LZZy9i0AVgHg-YAxTpb124c99eTBx38tHM1-Qg2LszbHeO1h4RUQ>
    <xme:F-LZZyskOj8tXApOtq1mDy3oRBPQp9YoKEYYnrbImc_SZkPjIwH4UaD9XJBdVucmL
    9sQE7_nZuFAQ2MGioo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    vdejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtshgsohhgvghnugesrghlph
    hhrgdrfhhrrghnkhgvnhdruggvpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhlvghr
    ohihsegtshhgrhhouhhprdgvuhdprhgtphhtthhopehmphgvsegvlhhlvghrmhgrnhdrih
    gurdgruhdprhgtphhtthhopehmrghtthhsthekkeesghhmrghilhdrtghomhdprhgtphht
    thhopehnphhighhgihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvlhhlvghrse
    hgmhigrdguvgdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepjhgrmhgvshdrsghothhtohhmlhgvhieshhgrnhhsvghnphgrrhhtnhgvrh
    hshhhiphdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:F-LZZ4BgRMG0eAxsIote5hKKvCoaN4SXRlCZ_otOdfFFvz7XHT5_Ig>
    <xmx:F-LZZ6eCs_NZ5WlasQgWvDs0mRuVxgDQ-EqMCMskWnEdubX_9LcrWQ>
    <xmx:F-LZZ3NvCIv8H_n97d6jL42SkKKWBkml4iYZkXFnXNXQIBGxCj9UZw>
    <xmx:F-LZZ0lio7_8obwVeZUmRWtis46Jpxj8QNkQYa_yPycLplbdyZZcrg>
    <xmx:GeLZZ6iI2zTTRi4-1WdYuNqLi26yaA5Xh5sDeCMxyU0p-pxYSjTiEUKV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1A2B82220072; Tue, 18 Mar 2025 17:13:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T334a9a9a7e89e162
Date: Tue, 18 Mar 2025 22:13:35 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nathan Chancellor" <nathan@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Matt Turner" <mattst88@gmail.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Greg Ungerer" <gerg@linux-m68k.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Helge Deller" <deller@gmx.de>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Naveen N Rao" <naveen@kernel.org>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Julian Vetter" <julian@outer-limits.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Message-Id: <5b2779f8-573d-401e-817e-979e02f811d3@app.fastmail.com>
In-Reply-To: <20250318203906.GA4089579@ax162>
References: <20250315105907.1275012-1-arnd@kernel.org>
 <20250315105907.1275012-6-arnd@kernel.org> <20250318203906.GA4089579@ax162>
Subject: Re: [PATCH 5/6] mips: drop GENERIC_IOMAP wrapper
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 18, 2025, at 21:39, Nathan Chancellor wrote:
> On Sat, Mar 15, 2025 at 11:59:06AM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h

>>  void __ioread64_copy(void *to, const void __iomem *from, size_t count);
>>  
>> +#ifdef CONFIG_PCI_DRIVERS_LEGACY
>> +struct pci_dev;
>> +void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
>> +#define pci_iounmap pci_iounmap
>> +#endif
>> +
>>  #include <asm-generic/io.h>
>>  
>>  static inline void *isa_bus_to_virt(unsigned long address)
>> diff --git a/arch/mips/lib/iomap-pci.c b/arch/mips/lib/iomap-pci.c
>> index a9cb28813f0b..2f82c776c6d0 100644
>> --- a/arch/mips/lib/iomap-pci.c
>> +++ b/arch/mips/lib/iomap-pci.c
>> @@ -43,4 +43,13 @@ void __iomem *__pci_ioport_map(struct pci_dev *dev,
>>  	return (void __iomem *) (ctrl->io_map_base + port);
>>  }
>>  
>> +void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
>> +{
>> +	struct pci_controller *ctrl = dev->bus->sysdata;
>> +	void __iomem *base = (void __iomem *)ctrl->io_map_base;
>> +
>> +	if (addr < base || addr > (base + resource_size(ctrl->io_resource)))
>> +		iounmap(addr);
>> +}
>> +
>>  #endif /* CONFIG_PCI_DRIVERS_LEGACY */
>> -- 
>> 2.39.5
>> 
>
> This change as commit 976bf3aec388 ("mips: drop GENERIC_IOMAP wrapper") in
> -next introduces new instances of -Wnull-pointer-arithmetic when building
> certain mips configurations with clang.
>

Thanks for the report, I missed that the generic ioport_map() function
is missing the PCI_IOBASE macro, we should probably remove that from
the asm-generic/io.h header and require architectures to define it
themselves, since the NULL fallback is pretty much always wrong.

There is also a type mismatch between the MIPS
PCI_IOBASE/mips_io_port_base and the one that asm-generic/io.h
expects, so I had to add a couple of extra typecasts, which
makes it rather ugly, but the change below seems to work.

     Arnd

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 1fe56d1870a6..78c6573f91f2 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -544,12 +544,16 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 
 void __ioread64_copy(void *to, const void __iomem *from, size_t count);
 
-#ifdef CONFIG_PCI_DRIVERS_LEGACY
+#if defined(CONFIG_PCI) && defined(CONFIG_PCI_DRIVERS_LEGACY)
 struct pci_dev;
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
 #define pci_iounmap pci_iounmap
 #endif
 
+#ifndef PCI_IOBASE
+#define PCI_IOBASE ((void __iomem *)mips_io_port_base)
+#endif
+
 #include <asm-generic/io.h>
 
 static inline void *isa_bus_to_virt(unsigned long address)
diff --git a/arch/mips/include/asm/mach-loongson64/spaces.h b/arch/mips/include/asm/mach-loongson64/spaces.h
index ce04e998a37b..dbd26db5f2c5 100644
--- a/arch/mips/include/asm/mach-loongson64/spaces.h
+++ b/arch/mips/include/asm/mach-loongson64/spaces.h
@@ -7,9 +7,10 @@
 #endif /* CONFIG_64BIT */
 
 /* Skip 128k to trap NULL pointer dereferences */
-#define PCI_IOBASE	_AC(0xc000000000000000 + SZ_128K, UL)
+#define PCI_PORT_BASE	_AC(0xc000000000000000 + SZ_128K, UL)
+#define PCI_IOBASE	(void __iomem *)PCI_PORT_BASE
 #define PCI_IOSIZE	SZ_16M
-#define MAP_BASE	(PCI_IOBASE + PCI_IOSIZE)
+#define MAP_BASE	(PCI_PORT_BASE + PCI_IOSIZE)
 
 #define IO_SPACE_LIMIT  (PCI_IOSIZE - 1)
 
diff --git a/arch/mips/include/asm/mach-ralink/spaces.h b/arch/mips/include/asm/mach-ralink/spaces.h
index a9f0570d0f04..a63d106c89c6 100644
--- a/arch/mips/include/asm/mach-ralink/spaces.h
+++ b/arch/mips/include/asm/mach-ralink/spaces.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_MACH_RALINK_SPACES_H_
 #define __ASM_MACH_RALINK_SPACES_H_
 
-#define PCI_IOBASE	mips_io_port_base
+#define PCI_IOBASE	(void __iomem *)mips_io_port_base
 #define PCI_IOSIZE	SZ_64K
 #define IO_SPACE_LIMIT	(PCI_IOSIZE - 1)
 
diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
index a35dd7311795..b9f90f33fc9a 100644
--- a/arch/mips/loongson64/init.c
+++ b/arch/mips/loongson64/init.c
@@ -128,7 +128,7 @@ void __init prom_init(void)
 	}
 
 	/* init base address of io space */
-	set_io_port_base(PCI_IOBASE);
+	set_io_port_base((unsigned long)PCI_IOBASE);
 
 	if (loongson_sysconf.early_config)
 		loongson_sysconf.early_config();
@@ -178,7 +178,7 @@ static int __init add_legacy_isa_io(struct fwnode_handle *fwnode, resource_size_
 		return -EINVAL;
 	}
 
-	vaddr = PCI_IOBASE + range->io_start;
+	vaddr = (unsigned long)PCI_IOBASE + range->io_start;
 
 	vmap_page_range(vaddr, vaddr + size, hw_start, pgprot_device(PAGE_KERNEL));

