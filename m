Return-Path: <linux-arch+bounces-10453-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D403A48D1D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 01:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582271697A2
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0263E17E0;
	Fri, 28 Feb 2025 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g7NibrQd"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BD823CB;
	Fri, 28 Feb 2025 00:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701868; cv=none; b=Z9WKKkjV0c8rvYRJOUWejCl+8z0EfS9vmWX1ncVrAsv6edzaUretNiRbO+9wjHiV2jsnEz+7ipgxN0ysZmooWZB8yfSYwI7GdFgKiGmIC1xYBjktMJZkofcjbKEjt7UzsirxPRP2QIt9Rm8z9wjRSyCa/CRd+1J52FhZ4H8oBBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701868; c=relaxed/simple;
	bh=XOmNL9shOGu0sCqz0EEK7+KtTBa6jHO1/CCsYBEnqXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJFaBdeb97AUx7y9g2IlrfT7dp9Jeqb4QDwV/Jms593rg88YJy074J1VxW/lHU3hUuaswVuaAQDIF1ri24Nsr3Nhj9gli3OTMDkpgSO7HOP2COWxUCZi2ZL2XH77Z9a0q460nC5eTmpn53/T/y30LfU75eKntV3uuSibjolDixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g7NibrQd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 94D10210EAC2;
	Thu, 27 Feb 2025 16:17:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 94D10210EAC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740701867;
	bh=i0ZDrhkLSCLc2jf7TcTUKC2c3xBVgJDsNtUs7W0iKYk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g7NibrQdqws5JRPkgJqIsiE2d7Y64O6ROaP1K5ksEH5RdhwCg6L8FbbcJggiKRfJp
	 8q/Niz8hKhPUqAQ3fqeipGIBgF0io6TAB8yTWiZ6nQpVTkPWxtYvjqK8mM8NcyBrh2
	 PSiJK1oHnv8IYoOIzZ108JWhO/Yf2fdCdgA2ANdg=
Message-ID: <f8d7c151-fc7b-4f57-96fa-2252c60bd81f@linux.microsoft.com>
Date: Thu, 27 Feb 2025 16:17:45 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] x86/mshyperv: Add support for extended Hyper-V
 features
To: Roman Kisel <romank@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, daniel.lezcano@linaro.org,
 joro@8bytes.org, robin.murphy@arm.com, arnd@arndb.de,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-3-git-send-email-nunodasneves@linux.microsoft.com>
 <681a8922-b743-42cb-8793-ece9ae8919c1@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <681a8922-b743-42cb-8793-ece9ae8919c1@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/27/2025 9:59 AM, Roman Kisel wrote:
> 
> 
> On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
>> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> [...]
>>   -    pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
>> -        ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
>> +    pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, ext 0x%x, hints 0x%x, misc 0x%x\n",
>> +        ms_hyperv.features, ms_hyperv.priv_high,
>> +        ms_hyperv.ext_features, ms_hyperv.hints,
>>           ms_hyperv.misc_features);
> 
> Would using %#x instead of 0x%x be better in your opinion?
> 
It's a reasonable suggestion. I'm not sure if it's worth another
version, if this patch seems good enough to merge as-is.
However if I'm doing another version of this series that still
includes this patch, then I can certainly make the change.

Thanks!

> [..]


