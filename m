Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093D8348001
	for <lists+linux-arch@lfdr.de>; Wed, 24 Mar 2021 19:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbhCXSGU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Mar 2021 14:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232618AbhCXSFy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Mar 2021 14:05:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4430861A1B;
        Wed, 24 Mar 2021 18:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616609154;
        bh=4ddFWD0HDeMvJooIHBmVBLMfgHrZIiewXKZt5ch7iWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A6FHmx+M+t/r7327J8jHlQn2j7eeeQwtuRXHcULuzLaaVTXqZuHY/wFrucrpfDQZC
         takEBJ1G9jXLsxWNCfiPyc5ZsXKzT28qWT72jH7fC40YsYIR6fwCVeQCoVV2TtWmRK
         LS4MrPVDMZakskpDgdmzRuOpYyqqXPbmznxYMSyIwiDu9rGOlBQrm7O3NetB/A0p/w
         bo3i8Dzo1959a2p8UE2xQyE/NJhKDQ5hgIwCiTXFbJtvuzmT5chNnES9MbrJQ9BnGx
         jqlnKGaoqZzmXDfV9VMH5xlIPe9OzrVIVBpaKUO3ToguDiPbUNN04mlRNBY/WbP8/S
         iEWD9+cmga8Tw==
Date:   Wed, 24 Mar 2021 18:05:46 +0000
From:   Will Deacon <will@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH v3 01/27] arm64: Cope with CPUs stuck in VHE mode
Message-ID: <20210324180546.GA13181@willie-the-truck>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-2-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304213902.83903-2-marcan@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 05, 2021 at 06:38:36AM +0900, Hector Martin wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> It seems that the CPU known as Apple M1 has the terrible habit
> of being stuck with HCR_EL2.E2H==1, in violation of the architecture.
> 
> Try and work around this deplorable state of affairs by detecting
> the stuck bit early and short-circuit the nVHE dance. It is still
> unknown whether there are many more such nuggets to be found...
> 
> Reported-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kernel/head.S     | 33 ++++++++++++++++++++++++++++++---
>  arch/arm64/kernel/hyp-stub.S | 28 ++++++++++++++++++++++++----
>  2 files changed, 54 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 66b0e0b66e31..673002b11865 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -477,14 +477,13 @@ EXPORT_SYMBOL(kimage_vaddr)
>   * booted in EL1 or EL2 respectively.
>   */
>  SYM_FUNC_START(init_kernel_el)
> -	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
> -	msr	sctlr_el1, x0
> -
>  	mrs	x0, CurrentEL
>  	cmp	x0, #CurrentEL_EL2
>  	b.eq	init_el2
>  
>  SYM_INNER_LABEL(init_el1, SYM_L_LOCAL)
> +	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
> +	msr	sctlr_el1, x0
>  	isb
>  	mov_q	x0, INIT_PSTATE_EL1
>  	msr	spsr_el1, x0
> @@ -504,6 +503,34 @@ SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
>  	msr	vbar_el2, x0
>  	isb
>  
> +	/*
> +	 * Fruity CPUs seem to have HCR_EL2.E2H set to RES1,
> +	 * making it impossible to start in nVHE mode. Is that
> +	 * compliant with the architecture? Absolutely not!
> +	 */
> +	mrs	x0, hcr_el2
> +	and	x0, x0, #HCR_E2H
> +	cbz	x0, 1f
> +
> +	/* Switching to VHE requires a sane SCTLR_EL1 as a start */
> +	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
> +	msr_s	SYS_SCTLR_EL12, x0
> +
> +	/*
> +	 * Force an eret into a helper "function", and let it return
> +	 * to our original caller... This makes sure that we have
> +	 * initialised the basic PSTATE state.
> +	 */
> +	mov	x0, #INIT_PSTATE_EL2
> +	msr	spsr_el1, x0
> +	adr_l	x0, stick_to_vhe
> +	msr	elr_el1, x0
> +	eret
> +
> +1:
> +	mov_q	x0, INIT_SCTLR_EL1_MMU_OFF
> +	msr	sctlr_el1, x0
> +
>  	msr	elr_el2, lr
>  	mov	w0, #BOOT_CPU_MODE_EL2
>  	eret
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 5eccbd62fec8..c7601030ee82 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -27,12 +27,12 @@ SYM_CODE_START(__hyp_stub_vectors)
>  	ventry	el2_fiq_invalid			// FIQ EL2t
>  	ventry	el2_error_invalid		// Error EL2t
>  
> -	ventry	el2_sync_invalid		// Synchronous EL2h
> +	ventry	elx_sync			// Synchronous EL2h
>  	ventry	el2_irq_invalid			// IRQ EL2h
>  	ventry	el2_fiq_invalid			// FIQ EL2h
>  	ventry	el2_error_invalid		// Error EL2h
>  
> -	ventry	el1_sync			// Synchronous 64-bit EL1
> +	ventry	elx_sync			// Synchronous 64-bit EL1
>  	ventry	el1_irq_invalid			// IRQ 64-bit EL1
>  	ventry	el1_fiq_invalid			// FIQ 64-bit EL1
>  	ventry	el1_error_invalid		// Error 64-bit EL1
> @@ -45,7 +45,7 @@ SYM_CODE_END(__hyp_stub_vectors)
>  
>  	.align 11
>  
> -SYM_CODE_START_LOCAL(el1_sync)
> +SYM_CODE_START_LOCAL(elx_sync)
>  	cmp	x0, #HVC_SET_VECTORS
>  	b.ne	1f
>  	msr	vbar_el2, x1
> @@ -71,7 +71,7 @@ SYM_CODE_START_LOCAL(el1_sync)
>  
>  9:	mov	x0, xzr
>  	eret
> -SYM_CODE_END(el1_sync)
> +SYM_CODE_END(elx_sync)
>  
>  // nVHE? No way! Give me the real thing!
>  SYM_CODE_START_LOCAL(mutate_to_vhe)
> @@ -243,3 +243,23 @@ SYM_FUNC_START(switch_to_vhe)
>  #endif
>  	ret
>  SYM_FUNC_END(switch_to_vhe)
> +
> +SYM_FUNC_START(stick_to_vhe)
> +	/*
> +	 * Make sure the switch to VHE cannot fail, by overriding the
> +	 * override. This is hilarious.
> +	 */
> +	adr_l	x1, id_aa64mmfr1_override
> +	add	x1, x1, #FTR_OVR_MASK_OFFSET
> +	dc 	civac, x1
> +	dsb	sy
> +	isb

Why do we need an ISB here?

> +	ldr	x0, [x1]
> +	bic	x0, x0, #(0xf << ID_AA64MMFR1_VHE_SHIFT)
> +	str	x0, [x1]

I find it a bit bizarre doing this here, as for the primary CPU we're still
a way away from parsing the early paramaters and for secondary CPUs this
doesn't need to be done for each one. Furthermore, this same code is run
on the resume path, which can probably then race with itself.

Is it possible to do it later on the boot CPU only, e.g. in
init_feature_override()? We should probably also log a warning that we're
ignoring the option because nVHE is not available.

Will
