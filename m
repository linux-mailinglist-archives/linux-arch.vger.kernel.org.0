Return-Path: <linux-arch+bounces-10430-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9059EA48608
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 18:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678DA3A9FBC
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCBC1DAC88;
	Thu, 27 Feb 2025 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VlV7HjWL"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03D11D9A7F;
	Thu, 27 Feb 2025 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675733; cv=none; b=GRu0QaPsbetZUKT458KUPob/176VUIzXXT/3rLosTa6EpRWxNG9AYN/fmETNUMbwqNkccOG9N2P3RYedCw8Gta52LQXcCsU3LlZmuXsZgh25GN3SqE8I4Aw3qV7ujB0gUQ+VzNHBzZJjoGhGTIdl83RXX3MhgbSs6H+Jia6bYZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675733; c=relaxed/simple;
	bh=g21j8Ki80r5R3Q3hRSeH57lB4KZggPymAcYwAS/yqeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4y7C3a2xI0FWQFi7pWps+5L681UrFj06GAjSdk25T2QSRDzo5OItEChedBMJRuFMfOKGC4Mf+wXu01cchIPGuwwBC0VAe4JJ6YxliY+c+PcWjx54ghFtcMkzVJ1VUC8CndPD90WjQajj6ASCSEXp4ozpn3zYq1czS5sJoqt1OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VlV7HjWL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id F0B68210D0D8;
	Thu, 27 Feb 2025 09:02:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F0B68210D0D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740675730;
	bh=UoCV5HAJeH3XjGtJFdhDgStkjmGqfA1T4wdKfeu4AsQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VlV7HjWLGHggF73qzcmagSPrXdyB3Ix7hVmrQTgBusBHr3KadTdfJw7oJ2yXwUk/u
	 kr4aIHEUGfkzWNvvtjBkjAK/7EfisK4p8Jts/+3gCZZGO/f3wovVYe/0X7hvCNX0Nf
	 n+uakKRBuAXNaRCdRUx/ewFxPDYTCuUsc/g4y41M=
Message-ID: <74af19c4-639f-4bcc-b667-b5f102bbb312@linux.microsoft.com>
Date: Thu, 27 Feb 2025 09:02:09 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
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
 <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/26/2025 3:07 PM, Nuno Das Neves wrote:

[...]

> +
> +const char *hv_result_to_string(u64 hv_status)
> +{
> +	switch (hv_result(hv_status)) {

[...]

> +		return "HV_STATUS_VTL_ALREADY_ENABLED";
> +	default:
> +		return "Unknown";
> +	};
> +	return "Unknown";
> +}
> +EXPORT_SYMBOL_GPL(hv_result_to_string);

Should we remove this and output the hexadecimal error code in ~3 places
this function is used?

The "Unknown" part would make debugging harder actually when something
fails. I presume that the mainstream scenarios all work, and it is the
edge cases that might fail, and these are likelier to produce "Unknown".

Folks who actually debug failed hypercalls rarely have issues with
looking up the error code, and printing "Unknown" to the log is worse
than a hexadecimal. Like even the people who wrote the code got nothing
to say about what is going on.

-- 
Thank you,
Roman


