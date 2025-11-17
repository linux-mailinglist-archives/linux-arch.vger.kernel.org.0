Return-Path: <linux-arch+bounces-14841-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD95C65D1F
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 19:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95E20363D35
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE9F324B24;
	Mon, 17 Nov 2025 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lSk8kQ2u"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0028832A3D8;
	Mon, 17 Nov 2025 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405478; cv=none; b=uc7v0JlNIK0G+vqDLKrEuHS9PnWpCOpqw1YsJZ+lbbJGlDYE9Lg6UivZc3ci23mTX9NL+Wa6ceyMICx5MTvi6PEJxbkxa/ypPRJ8nK4jpdQ/WeAuWxA4Ab3YLt5AJOAJecitqwmMyCR5c7CetIAGABjOMqjEoQEpqkPJZbm5kQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405478; c=relaxed/simple;
	bh=Ew0A5V3Ws+ovgaW3RBjnFeT6hkh0OU2OjbtDAgeMBeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGvaYObcbcXTp/dVeaeznY7s2ge3JH2pdh6l9iafWytBa7FpAD92ZE+auO7t6NTnzca2FJxAMvITQhQfVhveHWqoMbNvolq8THrFf21T1dil0u4+Na+g1bpuWVUheuHJbk61Q+drTIra1zvTgeqefnD8s13aWbwQvDJmbWNIaaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lSk8kQ2u; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7aNsSoqL4Oh9FppblaXOE+GKfYhRL9+dtetncwBHI7I=; b=lSk8kQ2uqPCfHJcpdG530/aCCq
	O14UG2HC5+fxKf5XeN0v+ppv0P4u9+RBP9YpGI1a5LDxmwzUBtpGJDmS+rLQ68GNJD8f0DKvhuoy/
	GQroSx1idJ6x7HDdAgVbHT5Tunx2PeqJZg5Z6kRzgJPlRf4ljfC9iXNBUAEHuIGYEote0t3nnPSuG
	BJoAEJNwGOCDH/5xx58ixucIcTUZhJJs1yTvdZC9DbaU/x2XjUPlV8PIfY//v+7q+IrHS2+WQcTze
	YkeXb0EGr5ryOu+SttJr4o7uES7Pq4mhbdO2QGFAfYg5GPWcH247xbr/4WeMPu16SoUGDN8RELLVX
	16fnJYMA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL4Jk-0000000Gflu-13Cq;
	Mon, 17 Nov 2025 18:51:12 +0000
Message-ID: <3bf1793a-2ffd-4017-b4bf-dc63f3a2a7c8@infradead.org>
Date: Mon, 17 Nov 2025 10:51:11 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] lib: Support
 ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Conor Dooley <conor@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 Dan Williams <dan.j.williams@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Drew Fustini <fustini@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: james.morse@arm.com, Will Deacon <will@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com,
 Yushan Wang <wangyushan12@huawei.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 Andy Lutomirski <luto@kernel.org>, Dave Jiang <dave.jiang@intel.com>
References: <20251117104800.2041329-1-Jonathan.Cameron@huawei.com>
 <20251117104800.2041329-4-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251117104800.2041329-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/17/25 2:47 AM, Jonathan Cameron wrote:
> diff --git a/lib/Kconfig b/lib/Kconfig
> index e629449dd2a3..e11136d188ae 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -542,6 +542,10 @@ config MEMREGION
>  config ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
>  	bool
>  
> +config GENERIC_CPU_CACHE_MAINTENANCE
> +	bool
> +	select ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION
> +
>  config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
>  	bool

Architectures and/or platforms select ARCH_HAS_*.

With this change above, it becomes the only entry in
lib/Kconfig that does "select ARCH_HAS_anytning".

so I think this is wrong, back*wards.

-- 
~Randy


