Return-Path: <linux-arch+bounces-8019-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 056FC999EF1
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 10:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886FD1F2304D
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2605720ADE8;
	Fri, 11 Oct 2024 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SWkP/aJm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R19x8WHf"
X-Original-To: linux-arch@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9DC1CB334;
	Fri, 11 Oct 2024 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635053; cv=none; b=oZ2lKJSS+7rGSMeeafYorkJQUsEv08qPp6IzLOE+/GtWOZanL2RK241XPHwJdvAxv5wiuXp4t9bEZmRTms/S17CHSX4FJosEP6FaK3Sr6ekHLI2FtgcKfNMK/aFD3Rsd9ExKqtk8d3YEeM3i1IFQ3ov35I1TMV83JW5d2jh2dc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635053; c=relaxed/simple;
	bh=8EUqwvVY7/NZVo1qP3E37S4ZJrjC+XzHgmrKAQgTsL4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=a+0aLFGwfqyz3OPBBMI4To+bW/q11GZNYX/R/O2WYZfHx1CqbiuNIgC4Afao437SV9RqPiwnKDKoxk7H5ncid4tLcgU1IxJtMUi++xv36BnQpZ2yyg38taqShblfR/c+m8JquPsMbkDl8QroinEdv7p2K2SgHAKOr7Ow9OG5jQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SWkP/aJm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R19x8WHf; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 437161140112;
	Fri, 11 Oct 2024 04:24:09 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 11 Oct 2024 04:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728635049;
	 x=1728721449; bh=UyL+mCcJFkad+Eo1GO8YfBJSki2GXtgM/kCxpSj0AKk=; b=
	SWkP/aJm/pV3SqODnIlySdfirz1D7can3fMoAIZZ0UBAqQzyE1l7rKpm3JcSTj3B
	SNT+w6wDA0QRjlJNDjwN4Y4+9MQ20bCm+tqR+S55jmuYEB9Ms5GtPxkgDpSGkSPh
	TZf11sAkUxwMvUG0VxkRR4O5dBv00BRF4mqzGt1A9WJ/w6VPTQKL1teoXWHbB+0s
	8Y4gzG1k+DK1ptS5jHfZVUnnSr3yJD0iL8oG/TecQk65E/fwHBwJirVEOKmTfB0e
	z78S/YthYlQavNwPWQry+OchUdMojKjJzSSuJMEPQS+iFSjwyWVNKEDdgNytDId4
	zdyhR9l4cATznL92Hh0M/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728635049; x=
	1728721449; bh=UyL+mCcJFkad+Eo1GO8YfBJSki2GXtgM/kCxpSj0AKk=; b=R
	19x8WHfJtBQUdyWvNwYDX2IifYZwIwnsXeY7LhBWre0BjTdfWnhvDo7AJ7FCH8f9
	rTntw46ZPNoNrqh57vL+awtosa8a9GfEIdmv8ZyaU+Qjpmxpa6AoSfOWaO3BiQ1x
	2BeuqvMea8ii5j98RZs5ET5VeV6UQUbQ/AiFmcHPL94oSHDesrYOxsKewEwBbq4J
	vVZ0cLlkyiJqF00Asc5MN40QWFPi6TYNwWVueb/8nMFPwQ8C3dPLgtkSU6utwA7j
	judfccDurlemaARwbgCmqkhSCroTaFbDWWxOjKAUkHh0vF6bk9NQrnsyPd9KEZAt
	z8mxGgUj4Oga2wI1vgDnA==
X-ME-Sender: <xms:qOAIZzkwl7WBdDJ1zHKuEZLDEH8ZZ2M73TqLqkobJWlfCyRaMjI_cw>
    <xme:qOAIZ23aNFE0z4JCS6t8ZebZ0uNzIqGipLjI4pvQczVrT9JV8gXa1alM-DAGJGopv
    S1YMLY2fVbsnXN2ZtM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgurdhlrghighhhthesrg
    gtuhhlrggsrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghr
    mhdrtghomhdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrd
    gtohhmpdhrtghpthhtohephhgthhesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    pehjvhgvthhtvghrsehkrghlrhgrhihinhgtrdgtohhmpdhrtghpthhtohephihsihhonh
    hnvggruheskhgrlhhrrgihihhntgdrtghomhdprhgtphhtthhopegthhgvnhhhuhgrtggr
    iheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhuohhrvghnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qOAIZ5pGm-mwttjOsXR_R05EgkpPfKGoasgvfI-vFcs_cSd2J7CLnw>
    <xmx:qOAIZ7nXZt_KlwURdKGjvEcW5yfmuXNlmieKtbZUWQogGJQefNwLBg>
    <xmx:qOAIZx3UaQ0Zr_ZCzNdQaOzDsyrbrvGS2QUmR-28JY4y3y7a_Y_D4A>
    <xmx:qOAIZ6v6Q_y-mJwMAI8jh5rCVhKsLNTFRkXaYqrPNG4xYquCt9aUzw>
    <xmx:qeAIZzVsuKpsvUWzdBiUJdNTF4R4Vh65TXEMHmrvTxVT8usO5-wg-_rF>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 19560222006F; Fri, 11 Oct 2024 04:24:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Oct 2024 08:23:18 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Vetter" <jvetter@kalrayinc.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 guoren <guoren@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>, "Takashi Iwai" <tiwai@suse.com>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "David Laight" <David.Laight@aculab.com>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Christoph Hellwig" <hch@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
 "Yann Sionneau" <ysionneau@kalrayinc.com>
Message-Id: <3e6d420e-5e81-4325-b5fd-a1746ff6216f@app.fastmail.com>
In-Reply-To: <20241010123627.695191-2-jvetter@kalrayinc.com>
References: <20241010123627.695191-1-jvetter@kalrayinc.com>
 <20241010123627.695191-2-jvetter@kalrayinc.com>
Subject: Re: [PATCH v9 1/4] Consolidate IO memcpy/memset into iomem_copy.c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 10, 2024, at 12:36, Julian Vetter wrote:
> Various architectures have almost the same implementations for
> memcpy_{to,from}io and memset_io functions. So, consolidate them
> into a common lib/iomem_copy.c.
>
> Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
> Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
> ---
> Changes for v9:
> - Moved all functions to iomem_copy.c
> - Build the new iomem_copy.c unconditionally
> - Guard prototypes in asm-generic/io.h with ifdefs

I'm happy with the patch contents, but it looks like you forgot
to update the description as this is not what this version of the
patch does: Instead of consolidating the identical versions (which
you do in patches 2-4), this changes the ones that use the
memcpy/memset fallback: arc, microblaze, mips, nios2, openrisc,
riscv, and xtensa.

> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -102,6 +102,16 @@ static inline void log_post_read_mmio(u64 val, u8 
> width, const volatile void __i
> 
>  #endif /* CONFIG_TRACE_MMIO_ACCESS */
> 
> +#ifndef memcpy_fromio
> +void memcpy_fromio(void *to, const volatile void __iomem *from, size_t 
> count);
> +#endif
> +#ifndef memcpy_toio
> +void memcpy_toio(volatile void __iomem *to, const void *from, size_t 
> count);
> +#endif
> +#ifndef memset_io
> +void memset_io(volatile void __iomem *dst, int c, size_t count);
> +#endif
> +
>  /*
>   * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
>   *
> @@ -1150,58 +1160,6 @@ static inline void 
> unxlate_dev_mem_ptr(phys_addr_t phys, void *addr)
>  }
>  #endif
> 
> -#ifndef memset_io
> -#define memset_io memset_io
> -/**
> - * memset_io	Set a range of I/O memory to a constant value
> - * @addr:	The beginning of the I/O-memory range to set
> - * @val:	The value to set the memory to
> - * @count:	The number of bytes to set
> - *
> - * Set a range of I/O memory to a given value.
> - */
> -static inline void memset_io(volatile void __iomem *addr, int value,
> -			     size_t size)
> -{
> -	memset(__io_virt(addr), value, size);
> -}
> -#endif

Unless there is a technical reason to move the location of
these I think it would be clearer to change it in place
and keep the three #ifdef but replace the contents.

You can also choose to add the definition in one patch
and then change the header in the next patch, which would
let you have more descriptive changelog texts for the
new common implementation and the second patch that changes
the fallback.

     Arnd

