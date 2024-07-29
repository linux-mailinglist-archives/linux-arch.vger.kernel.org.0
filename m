Return-Path: <linux-arch+bounces-5677-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6101893FB5C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 18:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC991F22601
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87E7FBA8;
	Mon, 29 Jul 2024 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nsJm1e/K"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5FF2AD22;
	Mon, 29 Jul 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271006; cv=none; b=ZwX8GVQEVK1m6uHzpiGDQ+fBcWWydmZ1mo97tyUzbg0S+H7YmnXjIBxuLxfspmBgC1Gttym8GDwoqL3fiOzE3yMvcQANoj/81TR7391XDIlC3gclm+1RHUCz6pETgT8ox9zaasSJJzUg5dRPKQITmuaRbeGhjtFYRH9jawwMbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271006; c=relaxed/simple;
	bh=SpgYIfT7ohd+1/9KmjbGziIoqwPeWIEc+Hem11koaFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7aLw+o1CDKLu7Y9lTk5l41eaCnsD8/T1drdzOi7oo1zRezS1Ju4dqY2nL3D0VJlhB+xnq1EkZGA9hG1Cu3GSh7UhdoBQGczitZOoa2HE7qKRzbSzpRv0/lSaNrhVjlLJmgbHmsDszLQPVYH1r/mQXtZmNvESAS7YELVAyu/Azo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nsJm1e/K; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id D122D20B7165;
	Mon, 29 Jul 2024 09:36:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D122D20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722271005;
	bh=WrkxJ/NqKc2VEyAF8b52mcYznuMgiU4byXEXWWcOhOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nsJm1e/KRyqRI4KRwRC5npLsTK5ouUAlmotGladZc0kwCWohhpYjm1mcRiztpLPUr
	 mU2AXMimOqtwKlmDCgp+26OOZ1P2QPH49nn7KtQN7O5sL1aY9I+Kgf1B6IeY+nqKu4
	 vubO5pHW20Dep6J5qbEzYd8a5s7P4s8U9AM7VjqA=
Message-ID: <76099a4c-c276-403b-89d5-fd72516e01d3@linux.microsoft.com>
Date: Mon, 29 Jul 2024 09:36:47 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] Drivers: hv: vmbus: Get the IRQ number from DT
To: Krzysztof Kozlowski <krzk@kernel.org>, arnd@arndb.de,
 bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, kw@linux.com, kys@microsoft.com, lenb@kernel.org,
 lpieralisi@kernel.org, mingo@redhat.com, rafael@kernel.org, robh@kernel.org,
 tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-7-romank@linux.microsoft.com>
 <7418bfcd-c572-4574-accc-7f2ae117529f@kernel.org>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <7418bfcd-c572-4574-accc-7f2ae117529f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/27/2024 1:56 AM, Krzysztof Kozlowski wrote:
> On 27/07/2024 00:59, Roman Kisel wrote:
>> @@ -2338,6 +2372,21 @@ static int vmbus_device_add(struct platform_device *pdev)
>>   		cur_res = &res->sibling;
>>   	}
>>   
>> +	/*
>> +	 * Hyper-V always assumes DMA cache coherency, and the DMA subsystem
>> +	 * might default to 'not coherent' on some architectures.
>> +	 * Avoid high-cost cache coherency maintenance done by the CPU.
>> +	 */
>> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>> +	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>> +
>> +	if (!of_property_read_bool(np, "dma-coherent"))
>> +		pr_warn("Assuming cache coherent DMA transactions, no 'dma-coherent' node supplied\n");
> 
> Why do you need this property at all, if it is allways dma-coherent? Are
> you supporting dma-noncoherent somewhere?
No support for non-coherent. Wanted to do a sanity check. Had better 
check for dma-noncoherent and warn about that I believe.

> 
> Best regards,
> Krzysztof
> 

-- 
Thank you,
Roman


