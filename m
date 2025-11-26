Return-Path: <linux-arch+bounces-15088-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7B8C8C33F
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 23:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B93B94E1C2D
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 22:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA0B2E54BD;
	Wed, 26 Nov 2025 22:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaMoRZ0g"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125C1096F;
	Wed, 26 Nov 2025 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764195920; cv=none; b=KdxAmgYuDtntjuHIFL8WsExJvcyqHWL5BaFWYZO9uGHsvLj49NFjjmnLXFGZ7CNrREvjf3w2X4pWY5Z4nEvAnK95LI6gYhLPSSYj+FcC8Z511Y6oE7/7E3zPyY3R33BD9h8Hh4b1jNtAtggVfzQYJHYqp46ofXk7MxSsGsfM864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764195920; c=relaxed/simple;
	bh=vi3sXuoq8NW4X5pAcVp0cXxkzqgvDgMYVY32kpZLpT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnKPSIVm9O+V7MP8A9MMETrJmcWCGhBJw0FhZ1nTKJ/9PcQUdnf2ci0mWweUnnKr3BDK5BDKbZCq3JCrvWGxtIaHpSRuQmny0p7lgyqXsceipxgD+qnjQEpIA2w35e913wRoCyVamS7LaUEi26AF6g5PDpKso1mF4cO/xJKHVD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaMoRZ0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286FCC113D0;
	Wed, 26 Nov 2025 22:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764195919;
	bh=vi3sXuoq8NW4X5pAcVp0cXxkzqgvDgMYVY32kpZLpT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VaMoRZ0gYufKwy89nGlnYRXsSbkvzfjN/4HSsLlH0zGOWVl+uwyAEosiAATPxNtFp
	 lfEueX4VbHiUN4/BDDnC2DFdOtackaJXgwLSTfhJU8ReCAvFFi7cg1MEep4TSRC/68
	 gQvHFBwc7153fEYeGlk4hDv0DPyr1WcI4cmLj0xpzhYuevHrROQ+uH3WLpnwivyUsq
	 AVNz578ogLHWx20x1F/GL+igi9XCcTQMBbxYmrfV7spLqv5XTDLoGL9fX5wifpXyS2
	 5t2pTO7KakTznKxIqEuBC+oY6OFvyhgQNrBlJdP9cWI3plNw56aH8hhltL4h/7QMXV
	 dnrl20kgh8ffA==
Date: Wed, 26 Nov 2025 22:25:17 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Raybharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, maz@kernel.org, tglx@linutronix.de,
	Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org,
	agordeev@linux.ibm.com, guoweikang.kernel@gmail.com, osandov@fb.com,
	bsz@amazon.de, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 2/3] irqchip/gic-v3: allocate one SGI for MSHV
Message-ID: <20251126222517.GA1387324@liuwe-devbox-debian-v2.local>
References: <20251125170124.2443340-1-anirudh@anirudhrb.com>
 <20251125170124.2443340-3-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125170124.2443340-3-anirudh@anirudhrb.com>

On Tue, Nov 25, 2025 at 05:01:23PM +0000, Anirudh Raybharam wrote:
> From: Anirudh Rayabharam <anirudh@anirudhrb.com>
[...]
>  /* SMCCC hypercall parameters */
>  #define HV_SMCCC_FUNC_NUMBER	1
>  #define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 3de351e66ee8..56013dd0564c 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -35,6 +35,7 @@
>  #include <asm/exception.h>
>  #include <asm/smp_plat.h>
>  #include <asm/virt.h>
> +#include <asm/mshyperv.h>
>  
>  #include "irq-gic-common.h"
>  
> @@ -1456,8 +1457,24 @@ static void __init gic_smp_init(void)
>  		.fwnode		= gic_data.fwnode,
>  		.param_count	= 1,
>  	};
> +	/* Register all 8 non-secure SGIs */
> +	const int NR_SMP_SGIS = 8;
> +	int nr_sgis = NR_SMP_SGIS;
>  	int base_sgi;
>  
> +	/*
> +	 * Allocate one more SGI for use by Hyper-V. This is only needed when
> +	 * Linux is running in a parent partition. Hyper-V will use this interrupt
> +	 * to notify the parent partition of intercepts.
> +	 *
> +	 * When running on Hyper-V, it is okay to use SGIs 8-15. They're not reserved
> +	 * for secure firmware.
> +	 */
> +#if IS_ENABLED(CONFIG_HYPERV)
> +	if (hv_parent_partition())
> +		nr_sgis += 1;
> +#endif
> +

This is far too intrusive. Let's take Marc's feedback and work with the
hypervisor team to resolve this properly.

Wei

