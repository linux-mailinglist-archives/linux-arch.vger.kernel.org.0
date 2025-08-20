Return-Path: <linux-arch+bounces-13236-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C592B2E2F1
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 19:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF062189CB76
	for <lists+linux-arch@lfdr.de>; Wed, 20 Aug 2025 17:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23AF32A3E2;
	Wed, 20 Aug 2025 17:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R/9SvcRf"
X-Original-To: linux-arch@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E8436CE0D;
	Wed, 20 Aug 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709632; cv=none; b=mTRC8TOECUEcUmb8kC1FB4KJ3e/Ie3qU0rfmhnQnu3tkp8Vygja1HPRXecnEaTiWxyLlG5u4QytTsx/ZUZGQVPRFY0ALvU8ADv18LKFKfsGNpDAx8hR6pSH8QHd+SyltnwlAe/aRzWvn5UGLa4l69f4rXOUaLrUs29Qi6E0ia28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709632; c=relaxed/simple;
	bh=zJJXarkWRvK9U5sgJZh498uNlfpa8H3ZMfTenpd3sjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXxM8yW9yTorhWDXlUgf8wbOjC0+Pi23ELVzqLm4uHd5Kp5CPPs33daeUcVD8eXYsq6D+A2siN7cRweNaz/83kIOvqFPBDDlabd0YyDQvi9T9pdXv8WORflAy5NuYzIYsvKDU3HmGKqfsaeJ3RDAGKlKuuAKEPhiR2yA/Qe7wWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R/9SvcRf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=qayB9LeR+RX6qridAjwC/zM9VoXQvXrNVT4vZTRfnEA=; b=R/9SvcRfJuRvlkls/k6xHiZo0X
	7JJOUj/v+RIkIQ3mpC3FpeaiwocGruY1eprsKXh06G8RTQcg5BAQTeprwpvLcw4Mi8DmFYXTFgEdM
	R0JZ7nWeBSdQngpgJTmRBhg0RtStcBJOJaHl0CrcWj1wApC62jEkVYeDLiUJ0YNfheUyM+3NbDgVk
	mBRPhB+APpGklJ7AQyKqWdv5YlxKFmReO9DU1jffLEvPUGP1oKzNXeC9HkH99Er6Iw+K7Fv6gq9M3
	Wp6KGkNzn+Ea767MMcS0lG6kMbPI5qWa+JxC+1jxfYqL26wuFOSF3kY56cfDDhYAqM1Wc7wp/yMyv
	Gdjhnkhw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uomHF-0000000ETuY-2LE7;
	Wed, 20 Aug 2025 17:07:09 +0000
Message-ID: <dc829b1a-f0d5-42b8-b128-e305a1ceb32b@infradead.org>
Date: Wed, 20 Aug 2025 10:07:08 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] acpi: PoC of Cache control via ACPI0019 and _DSM
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
 linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 Will Deacon <will@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, "H . Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Yicong Yang <yangyicong@huawei.com>, linuxarm@huawei.com,
 Yushan Wang <wangyushan12@huawei.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org,
 Andy Lutomirski <luto@kernel.org>
References: <20250820102950.175065-1-Jonathan.Cameron@huawei.com>
 <20250820102950.175065-8-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250820102950.175065-8-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/20/25 3:29 AM, Jonathan Cameron wrote:
> diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
> index 4551b28e14dd..158d3819004e 100644
> --- a/drivers/cache/Kconfig
> +++ b/drivers/cache/Kconfig
> @@ -3,6 +3,13 @@ menu "Cache Drivers"
>  
>  if GENERIC_CPU_CACHE_MAINTENANCE
>  
> +config ACPI_CACHE_CONTROL
> +       tristate "ACPI cache maintenance"
> +       depends on ARM64 && ACPI
> +       help

If there is a v4, please use one tab to indent the 3 lines above.

> +         ACPI0019 device ID in DSDT identifies an interface that may be used

and tab + 2 spaces to indent the 1 line above.

> +	 to carry out certain forms of cache flush operation.

-- 
~Randy


