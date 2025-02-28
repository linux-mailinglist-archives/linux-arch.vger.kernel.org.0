Return-Path: <linux-arch+bounces-10468-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B87A49F29
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 17:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BFA3B3508
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375D927293A;
	Fri, 28 Feb 2025 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZC+q+2cm"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0704272934;
	Fri, 28 Feb 2025 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760964; cv=none; b=obyyUlZPrrrQ3imcoFT0zaEk6ZiDXtzmG/jk1gnBDfuIwp7WWU18zOtVJMcwjO64acZuEEwA6p/YF0TrkFP+L3sWjYaSbigUNORBihruGB/SKSARA/8zQA/utZWKfpM3rWV90mBZ9WWmaiUY+0/mQyrPCyAuQ51MJesq1/j6nrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760964; c=relaxed/simple;
	bh=T6kfUpZuk53u2gUMdt3ZDjO959gu9SM3ku33kK6/eJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ma+oWi7anay4eXh4hCZhxTqlMze0pf9Xj/dzXnfoe1lHApj4VwzFxm2Udgc28BIVbyzc4YZOQ9UBH6pJh/Qv3kfP099vAgev+y3xiwD9UuG4Oi0m5wEq0GxccOJrbWhcP7GMJAo11kvybEoFv3RrG7Cqq4wdO//zH17kI4Sjkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZC+q+2cm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D1BD3210D0D5;
	Fri, 28 Feb 2025 08:42:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D1BD3210D0D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740760962;
	bh=BuXyC1oOSB2vm0Rr+d7N6BqT0+ZyS774E0qFu11I2qQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZC+q+2cmxoMS5/5w+OQJrDHlI0cWX7041Z04WaxlO64/2SMVAme2kzBQNMQFXi/we
	 ObwR14nqEWrUYtHgXNr4LVNAIeFjUCg6DoWgQDBHcS527oIdmDS1oMTc1aVgfGsCI8
	 CcCkJXpoU7L9cjOUCBceQ9lSqXrova55ptgkseGo=
Message-ID: <41ec1b2e-0a82-4712-926d-ac73a7151e61@linux.microsoft.com>
Date: Fri, 28 Feb 2025 08:42:41 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/10] x86/mshyperv: Add support for extended Hyper-V
 features
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
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
 <f8d7c151-fc7b-4f57-96fa-2252c60bd81f@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <f8d7c151-fc7b-4f57-96fa-2252c60bd81f@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/27/2025 4:17 PM, Nuno Das Neves wrote:
> On 2/27/2025 9:59 AM, Roman Kisel wrote:
>>
>>
>> On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
>>> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>> [...]
>>>    -    pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
>>> -        ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
>>> +    pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, ext 0x%x, hints 0x%x, misc 0x%x\n",
>>> +        ms_hyperv.features, ms_hyperv.priv_high,
>>> +        ms_hyperv.ext_features, ms_hyperv.hints,
>>>            ms_hyperv.misc_features);
>>
>> Would using %#x instead of 0x%x be better in your opinion?
>>
> It's a reasonable suggestion. I'm not sure if it's worth another
> version, if this patch seems good enough to merge as-is.
> However if I'm doing another version of this series that still
> includes this patch, then I can certainly make the change.
> 

You're right, a suggestion like that shouldn't warrant another version,
agreed! Whether you implement that tweak or not, looks good to me.

Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

> Thanks!
> 
>> [..]
> 

-- 
Thank you,
Roman


