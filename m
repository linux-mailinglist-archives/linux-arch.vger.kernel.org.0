Return-Path: <linux-arch+bounces-4472-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF908CA35C
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 22:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D720B20D08
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 20:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57172139583;
	Mon, 20 May 2024 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pexG1JSd"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D719D139D0E;
	Mon, 20 May 2024 20:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716237378; cv=none; b=bEKAjX1oo3GkOC2eGWCv6uIiqoREuIlttCWQPqgiDmmfLoqU802RblnyjFT94DleG9gn1nHdVD2dRwKMwtHQnckqjp77IamYmr873LqdurMjO7/rMipdtnyu6f0RNzGbMIaa9eK1/4RzpS50ShQSLSdJjDfhf1fK68/frwUHC0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716237378; c=relaxed/simple;
	bh=berpTgxxSrfJLrHiDgBaFd7goEBykaCW9v/TCOW7O/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+WumIMwVcjAQv094vK/Pzwh8QOft3nLtARebWVSXDdmHIqjlSFCrCqV/BPr3O96oSJbafOwp5qdJ7oZFHXOgt6yMLExCU8zG5CDR/9gWvS9fRkEdMA9pmY1Oqn8yV/nNjZbQqSL2Ekw7gPUJUsHsmhXaVLfw/noLv7jPAR1ncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pexG1JSd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id EACFB205421D;
	Mon, 20 May 2024 13:36:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EACFB205421D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716237376;
	bh=XdydB7zjUjYezj9ReQeRzLuYYU1bVLh5sU+DZTi2Y5g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pexG1JSdUuURsSLjO/6WhipEb+tmTM4SWikJZFoOTk4zC9rXqU/I4I7r5xLcpxKC0
	 TV/VHCWd/hYWGI5TQrQo/hQc+JpKk4sFzc1oOTnfwSsU9/2mScLtgPGX9CcIxkuCmq
	 PGe6Xm702lEEo4Klhcm0K/ncemEUcxHt34buPKtk=
Message-ID: <587482fa-b747-42e8-b581-01132475211c@linux.microsoft.com>
Date: Mon, 20 May 2024 13:36:15 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] arm64/hyperv: Support DeviceTree
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, arnd@arndb.de,
 bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, kw@linux.com, kys@microsoft.com, lenb@kernel.org,
 lpieralisi@kernel.org, mingo@redhat.com, mhklinux@outlook.com,
 rafael@kernel.org, robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Cc: ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-2-romank@linux.microsoft.com>
 <1766fc9a-1d10-4c93-a9db-a7e0db8b01e7@linaro.org>
 <267ef0e2-2384-44bd-81f9-f33dda7bb9d2@linux.microsoft.com>
 <6f7ae5e6-d20f-4980-9b6e-25ba6d7b5558@linaro.org>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <6f7ae5e6-d20f-4980-9b6e-25ba6d7b5558@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/19/2024 11:45 PM, Krzysztof Kozlowski wrote:
> On 15/05/2024 19:33, Roman Kisel wrote:
>>>>    static bool hyperv_initialized;
>>>> @@ -27,6 +30,29 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +static bool hyperv_detect_fdt(void)
>>>> +{
>>>> +#ifdef CONFIG_OF
>>>> +	const unsigned long hyp_node = of_get_flat_dt_subnode_by_name(
>>>> +			of_get_flat_dt_root(), "hypervisor");
>>>
>>> Why do you add an ABI for node name? Although name looks OK, but is it
>>> really described in the spec that you depend on it? I really do not like
>>> name dependencies...
>>
>> Followed the existing DeviceTree's of naming and approaches in the
>> kernel to surprise less and "invent" even less. As for the spec, the
> 
> I am sorry, but there is no approved existing approach of adding ABI for
> node names. There are exceptions or specific cases, but that's not
> "invent less" approach. ABI is defined by compatible.
I should check on the compatible instead of adding a node that is not 
mentioned in the DeviceTree spec as I understand. Appreciate your help!

> 
> Best regards,
> Krzysztof
> 

-- 
Thank you,
Roman

