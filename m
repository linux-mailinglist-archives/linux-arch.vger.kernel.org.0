Return-Path: <linux-arch+bounces-5965-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF33E94753C
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 08:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8851F224D3
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 06:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A3A142E86;
	Mon,  5 Aug 2024 06:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ln0nDgh3"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185581DFF7;
	Mon,  5 Aug 2024 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839303; cv=none; b=NxJLf2Jq6e3zddYL2h65RjQ0616rIxUgWUIpnHUKnkTpr0ZBTFVQZEAWTB+z1UDK8zpbKyTOXp4c+X2rxYFMoXqS1Pqew3ZdGeywBTP2NhhIe0VzLmPkBkUpuzz8SZDksy4Za2EaR3HxN0GDqKhoHQX7f35/oy37fAKTo25YngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839303; c=relaxed/simple;
	bh=9GIoyi3vCEXFFyYGEr0wsqBNa4FTgGkvni+KwMAQ9PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5oAvqbxxlibk9IdYvKb+W7kX2La5wRS/FhisS7rYNBxTMreAbEcfEvaRjrvID3pbNjQsNIzGcDL1BpK9/4eoAv2aqzvGEbzVg7Vmw7OIaYS8cX9wh5U96kWUgZSrHjE/SrN6Dqy8cHqPsXZoBPj+I0/s5aL6wpdjk5OsRjoOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ln0nDgh3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id A8D5620B7127; Sun,  4 Aug 2024 23:28:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A8D5620B7127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722839301;
	bh=0EyiuCQjwZtY7cc05nIywrStY+vcE+GzimaJl2ixH/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ln0nDgh3lc7pJQo8FjqGY8IN1/FyLkrqKolSABpiRTvjgfYGDRnNJEzS0ZK7I9HHj
	 3JIYAot8yUVGgXWyTWlAGsTsK1dp8sh/SbBEn+1BdklnDXSc782yGRwYJALhiQtSr5
	 fY3J6G2Gtw+B7ixfgjDVy7cym63u8h/xkypUyAMI=
Date: Sun, 4 Aug 2024 23:28:21 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	catalin.marinas@arm.com, dave.hansen@linux.intel.com,
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
	kw@linux.com, kys@microsoft.com, lenb@kernel.org,
	lpieralisi@kernel.org, mingo@redhat.com, rafael@kernel.org,
	robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v3 4/7] arm64: hyperv: Boot in a Virtual Trust Level
Message-ID: <20240805062821.GA31897@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-5-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726225910.1912537-5-romank@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jul 26, 2024 at 03:59:07PM -0700, Roman Kisel wrote:
> To run in the VTL mode, Hyper-V drivers have to know what
> VTL the system boots in, and the arm64/hyperv code does not
> update the variable that stores the value.
> 
> Update the variable to enable the Hyper-V drivers to boot
> in the VTL mode and print the VTL the code runs in.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/Makefile        |  1 +
>  arch/arm64/hyperv/hv_vtl.c        | 13 +++++++++++++
>  arch/arm64/hyperv/mshyperv.c      |  4 ++++
>  arch/arm64/include/asm/mshyperv.h |  7 +++++++
>  4 files changed, 25 insertions(+)
>  create mode 100644 arch/arm64/hyperv/hv_vtl.c
> 
> diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
> index 87c31c001da9..9701a837a6e1 100644
> --- a/arch/arm64/hyperv/Makefile
> +++ b/arch/arm64/hyperv/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-y		:= hv_core.o mshyperv.o
> +obj-$(CONFIG_HYPERV_VTL_MODE)	+= hv_vtl.o
> diff --git a/arch/arm64/hyperv/hv_vtl.c b/arch/arm64/hyperv/hv_vtl.c
> new file mode 100644
> index 000000000000..38642b7b6be0
> --- /dev/null
> +++ b/arch/arm64/hyperv/hv_vtl.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024, Microsoft, Inc.
> + *
> + * Author : Roman Kisel <romank@linux.microsoft.com>
> + */
> +
> +#include <asm/mshyperv.h>
> +
> +void __init hv_vtl_init_platform(void)
> +{
> +	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
> +}
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 341f98312667..8fd04d6e4800 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -98,6 +98,10 @@ static int __init hyperv_init(void)
>  		return ret;
>  	}
>  
> +	/* Find the VTL */
> +	ms_hyperv.vtl = get_vtl();
> +	hv_vtl_init_platform();
> +
>  	ms_hyperv_late_init();
>  
>  	hyperv_initialized = true;
> diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
> index a7a3586f7cb1..63d6bb6998fc 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -49,6 +49,13 @@ static inline u64 hv_get_msr(unsigned int reg)
>  				ARM_SMCCC_OWNER_VENDOR_HYP,	\
>  				HV_SMCCC_FUNC_NUMBER)
>  
> +#ifdef CONFIG_HYPERV_VTL_MODE
> +void __init hv_vtl_init_platform(void);
> +int __init hv_vtl_early_init(void);
> +#else
> +static inline void __init hv_vtl_init_platform(void) {}
> +#endif
> +

These functions are defined in x86 header as well. We can move it to generic header.

- Saurabh

