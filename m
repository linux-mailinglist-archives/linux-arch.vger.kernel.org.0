Return-Path: <linux-arch+bounces-10431-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D121A48724
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 18:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FD11697B2
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675131E833D;
	Thu, 27 Feb 2025 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q9T9093D"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5481DB361;
	Thu, 27 Feb 2025 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679181; cv=none; b=ZuB6wGid/idLsXZIY/WCdIyYLD2tzaeBbxiVZUuKxTWnhBcS/moIUECO7wtRAnxq5NUE3dEaon655nbAOIqEFhNK0840hQh41pszeUnJN89rrvIYNL6Sbs54xp9l8dWJKWuBlActnUwrNZOQ2xewN4OhzSoor8n070xqOiueaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679181; c=relaxed/simple;
	bh=5NIXZUiqqKyQCGzzMTtqpeyMILyPsOILmtm36AbcP+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWqpJgC0OJfgOEpIq/Fqs8p0GyZJ1uv5yrJzZrm/n5qcwYpg8E/FFpJnqM91n9w5Fr+G+TT/2glH4hEyxaPo8h1PAqbAH0PlxdaLsmjA4nBxqRJMvgPsNZY6BQ9ZFU8qcITVhOYKLQNnlQCA2p+QIIVyvmCPPS/nBhN3gVa2mo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q9T9093D; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3653B2107A9A;
	Thu, 27 Feb 2025 09:59:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3653B2107A9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740679179;
	bh=1cWNu+rL2XdcdJVhPLU9VIeXn64oBQqcNz36m3NYwI0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q9T9093DwMoOphebD28z8327uEo6bfOM00Eldccj/caewO1Vyph91pM+MjCyVmF8u
	 GAQEXjYW8M1QfAV0wuqX8/+q4COSEOzbOnvSWcFZ6GvELBURwtxXIN7qrDgQ1Vo52J
	 s3uD5tx6MbUdInEm1O/OhLl5ddUtj04ozTG374YE=
Message-ID: <681a8922-b743-42cb-8793-ece9ae8919c1@linux.microsoft.com>
Date: Thu, 27 Feb 2025 09:59:39 -0800
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
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <1740611284-27506-3-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
[...]
>   
> -	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc 0x%x\n",
> -		ms_hyperv.features, ms_hyperv.priv_high, ms_hyperv.hints,
> +	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, ext 0x%x, hints 0x%x, misc 0x%x\n",
> +		ms_hyperv.features, ms_hyperv.priv_high,
> +		ms_hyperv.ext_features, ms_hyperv.hints,
>   		ms_hyperv.misc_features);

Would using %#x instead of 0x%x be better in your opinion?

[..]
-- 
Thank you,
Roman


