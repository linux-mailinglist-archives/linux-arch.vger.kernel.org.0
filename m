Return-Path: <linux-arch+bounces-12448-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03104AE6D6E
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jun 2025 19:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DF63A74CF
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jun 2025 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3129D201276;
	Tue, 24 Jun 2025 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NujHNQ2O"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8CB1A8F60;
	Tue, 24 Jun 2025 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750785536; cv=none; b=BuDJZBJR7pR3NnIFRUJ8N4VOwYBVeAKSuyTQ5yKglWzrtqd+9+KSucbu+YjrZ6mR8p7Jr4WkAqF5SISBkiW4Azh6K/ZKiX8NzHvxOZdY4nSOkFq9afvkaRBLqG1uKILl2vAmC7pB7lW6jnBHTHVpbDRUGSjgDbMUgmEjVR/oKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750785536; c=relaxed/simple;
	bh=PnTgYeBpRSho9z0Ic1t0YlYCnaY1cMzK7pe6Kx3IIRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5qLbmV879rQj1ODy642uJE1gwMFkquf1Grna2WlCCJj6t8phmrEhvGZx4wzP5Mrt6q1IAq+usktQM9SXaWnTYcJieXa5YiwjGmTo8Hn3tfuI9O1UB3fL+uk4f1DBvAnZBT4TVs0teomhxdDCHFiVYa+6cf3JyVzTAT5L2malS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NujHNQ2O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=D9mXoB0hmEQUOqAzambBPKWUXGRpwqp2/RutLHj6JLI=; b=NujHNQ2OnYYeEaXEsUYNleH6ug
	QTVUIU1QQHbjR71G3gbICoiPb9Rzrd/sdqHMh+NtgWgQ21eS61qVv4c5go8ZecVF3CKX9jn0ehCV0
	erloRGflpgCwKvNcyt3igKFTr1kuFLqpdnamEasF3NPX2Mf4zGGv+XoEgL6cPWgGcJOfCWCEKQTB0
	8LKXC8CCE5irZO72zvdt+blMrOn3JBSnSsR1ccH19LZrlbSL0R1FJC8SkUo4yO0c9gZJqBqZ6TEFv
	QVoqrlN5W8hzRMo0/iwPyWuKQr/w6By0GQG/O4MVmGxxJyeN4Vq+bnhixFFgeokIraly5cNY/DMEr
	s9jna1yg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU7IE-00000007CNt-32oy;
	Tue, 24 Jun 2025 17:18:46 +0000
Message-ID: <037f1ba1-ead1-4627-b464-39f1a8010d3f@infradead.org>
Date: Tue, 24 Jun 2025 10:18:41 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] cache: Support cache maintenance for HiSilicon SoC
 Hydra Home Agent
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
 linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 gregkh@linuxfoundation.org, Will Deacon <will@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
Cc: Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
 Yushan Wang <wangyushan12@huawei.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, H Peter Anvin
 <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <20250624154805.66985-1-Jonathan.Cameron@huawei.com>
 <20250624154805.66985-7-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250624154805.66985-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 6/24/25 8:48 AM, Jonathan Cameron wrote:
> diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
> index bedc51bea1d1..0ed87f25bd69 100644
> --- a/drivers/cache/Kconfig
> +++ b/drivers/cache/Kconfig
> @@ -10,6 +10,20 @@ config CACHE_COHERENCY_SUBSYSTEM
>  	  kernel subsystems to issue invalidations and similar coherency
>  	  operations.
>  
> +if CACHE_COHERENCY_SUBSYSTEM
> +
> +config HISI_SOC_HHA
> +	tristate "HiSilicon Hydra Home Agent (HHA) device driver"
> +	depends on (ARM64 && ACPI) || COMPILE_TEST
> +	help
> +	  The Hydra Home Agent (HHA) is responsible of cache coherency

	                                            for cache coherency

> +	  on SoC. This drivers provides cache maintenance functions of HHA.

	  on the SoC.

> +
> +	  This driver can be built as a module. If so, the module will be
> +	  called hisi_soc_hha.
> +
> +endif

-- 
~Randy


