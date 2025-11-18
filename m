Return-Path: <linux-arch+bounces-14880-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D187BC6AD93
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 18:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DB4732C8EB
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E733A1D12;
	Tue, 18 Nov 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="Kc2mvjby"
X-Original-To: linux-arch@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C7377EB7;
	Tue, 18 Nov 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485780; cv=none; b=AILSOx9v6y5WQZ+6Gu6YW4/x+Ltrfgof3k1YD2qp5Ftz9CPil5geyICd2rHtuZ4QtAOWrwIKYRo3Bk3Ufe96v6WJDUZC6UB7ZCL3EIYsa9/RfPBvKDcAcPOuolzXEjK+IrtAoUkdl0m8A3DqizeYQDEEODlx0E5n0kEQhXGaS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485780; c=relaxed/simple;
	bh=n0ahv9J5Kl6+P6HPlNJ38OxVVoh1FaxDHLeaN6W/57o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFxRW3I6X+k1U7pXth67RB6Xr4lTimJTnF9LbS4Bx6bxjTi2SGbsWIaOme86t2I2WMwUgJRrRVcl6WKxEg4gAtzfiwBI4ECnUHBvDHEqn4P5o9mn6sLezb8KZ7B0KG7q7GTCETgWmS32pmk9v3FNkXw1Si0sEzdUgF5va5ekDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=fail (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=Kc2mvjby reason="signature verification failed"; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id B83C225BFD;
	Tue, 18 Nov 2025 18:09:35 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6IF34XJUK659; Tue, 18 Nov 2025 18:09:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1763485774; bh=n0ahv9J5Kl6+P6HPlNJ38OxVVoh1FaxDHLeaN6W/57o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kc2mvjbyAdOb4VYAkc9KStqoc9NeuHqwFtKCLbSNCWcZnV230XGGVU39qCpeAMCXL
	 lkPowddwJWkiczZ2JUthpKpfhalyWRj2phQyoVxh22Ebno2w9cHKyLecABRo0rzqCj
	 k58elY9ycXj48sLwXArt3i4z4hZJfoY8zGSVkY2M7Gw0t0G9aPLM/GcVKQ6I7ns1ii
	 E82wx9D6piFTz+HCRUDj9uPH38YriYkQ66/PDZoM6reGnJ1htfKi/Z50kENXDe4gdZ
	 d+LmxPBwQkT5ur891EDneHfDzbIjADQ/KeeXYRVFHs/FXt2A+O7oekqUT4uqqjKnO4
	 +vQyGJS4tsD/A==
Date: Tue, 18 Nov 2025 17:09:00 +0000
From: Yao Zi <ziyao@disroot.org>
To: Huacai Chen <chenhuacai@loongson.cn>,
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, f@disroot.org
Cc: loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 04/14] LoongArch: Adjust boot & setup for 32BIT/64BIT
Message-ID: <aRyoLBjD_8Hz91DV@pie>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-5-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118112728.571869-5-chenhuacai@loongson.cn>

On Tue, Nov 18, 2025 at 07:27:18PM +0800, Huacai Chen wrote:
> Adjust boot & setup for both 32BIT and 64BIT, including: efi header
> definition, MAX_IO_PICS definition, kernel entry and environment setup
> routines, etc.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/include/asm/addrspace.h |  2 +-
>  arch/loongarch/include/asm/irq.h       |  5 ++++
>  arch/loongarch/kernel/efi-header.S     |  4 +++
>  arch/loongarch/kernel/efi.c            |  4 ++-
>  arch/loongarch/kernel/env.c            |  9 ++++--
>  arch/loongarch/kernel/head.S           | 39 +++++++++++---------------
>  arch/loongarch/kernel/relocate.c       |  9 +++++-
>  7 files changed, 45 insertions(+), 27 deletions(-)
> 

...

> diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
> index 23bd5ae2212c..3e8a25eb901b 100644
> --- a/arch/loongarch/kernel/env.c
> +++ b/arch/loongarch/kernel/env.c
> @@ -68,18 +68,23 @@ static int __init fdt_cpu_clk_init(void)
>  
>  	np = of_get_cpu_node(0, NULL);
>  	if (!np)
> -		return -ENODEV;
> +		goto fallback;
>  
>  	clk = of_clk_get(np, 0);
>  	of_node_put(np);
>  
>  	if (IS_ERR(clk))
> -		return -ENODEV;
> +		goto fallback;
>  
>  	cpu_clock_freq = clk_get_rate(clk);
>  	clk_put(clk);
>  
>  	return 0;
> +
> +fallback:
> +	cpu_clock_freq = 200 * 1000 * 1000;

Why pick 200MHz here? And shouldn't the clock being always provided in
devicetree if it's necessary for kernel to function?

Per the schema for LoongArch CPUs (loongarch/cpus.yaml), "clocks"
property is also described as mandantory, thus I don't think such
fallback makes sense.

> +
> +	return -ENODEV;
>  }
>  late_initcall(fdt_cpu_clk_init);

Best regards,
Yao Zi

