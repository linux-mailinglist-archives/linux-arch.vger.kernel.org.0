Return-Path: <linux-arch+bounces-10437-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D1BA48832
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 19:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D21B3A6C47
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 18:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD81F5844;
	Thu, 27 Feb 2025 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FNbW9YBu"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782351DE3A4;
	Thu, 27 Feb 2025 18:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682232; cv=none; b=tYtu/78MqZeepEOoksvPR8jrliROE9N42smaAZZbg3L0ZynJK0Ip7TDvUx01N0Rog39Lhb249JkBM/6cOeXZkgDht0N5YpKylE4rzVgMM5+wzr92L+ElxpenovHsSklRbnUrseEFF4rzw2k/mVfJMNBu7iXOPZDhgacrsepT3vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682232; c=relaxed/simple;
	bh=F1lTmqgjHYJPjcmbtxE/n3iAXCq4SZkVmt5nqUeZPXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUAbgYd+WIY89QNALCaSsR9uBKRLzqDEcEVKRwFBqz1yAXKXFwNuyPrcMg2/EtvjN+qyyOmRCQeWDoUsIIJ/2YQKb2qi0uK56A4ybbuB+pWwKnIbT1zTkolVWhTfDRm77C5UBEAoI/6jPwMfVII+7dCL0dRsU9AWhkOsncMCeYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FNbW9YBu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9B421210D0D8;
	Thu, 27 Feb 2025 10:50:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B421210D0D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740682231;
	bh=dHwZT1w8oWRsXa8H/+DiZfRcRSkOTyh9HqlMdGrYI/Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FNbW9YBuPokWfkhV8B0zMJtN5945pEMQP20InF/WOW6hK0iLB5iSFm7uJafeCDov9
	 ygoVc1l10LfK0HlQbcUkAzGjyXWi8ArYK0CYgWh0b61j196eOqg//F7JMoJtHcRzGr
	 /mlcu6UBD8g84zdCQtIgCvdToz5xVsg4gg8RkKH4=
Message-ID: <f332b77a-940f-4007-a44a-de64878d5201@linux.microsoft.com>
Date: Thu, 27 Feb 2025 10:50:30 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
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
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 2/26/2025 3:08 PM, Nuno Das Neves wrote:
> Provide a set of IOCTLs for creating and managing child partitions when
> running as root partition on Hyper-V. The new driver is enabled via
> CONFIG_MSHV_ROOT.
> 

[...]


As I understood, the changes fall into these buckets:

1. Partition management (VPs and memory). Built of the top of fd's which
    looks as the right approach. There is ref counting etc.
2. Scheduling. Here, there is the mature KVM and Xen code to find
    inspiration in. Xen being the Type 1 hypervisor should likely be
    closer to MSHV in my understanding.
3. IOCTL code allocation. Not sure how this is allocated yet given that
    the patch series has been through a multi-year review, that must be
    settled by now.
4. IOCTLs themselves. The majority just marshals data to the
    hypervisor.

Despite the rather large size of the patch, I spot-checked the places
where I have the chance to make an informed decision, and could not find
anything that'd stand out as suspicious to me. Going to extrapolate that
the patch itself should be good enough. Given that this code has been in
development and validation for a few years, I'd vote to merge it. That
will also enable upstreaming the rest of the VTL mode code that powers
Azure Boost (https://github.com/microsoft/OHCL-Linux-Kernel)

Reviewed-by: Roman Kisel <romank@linux.microsoft.com>

-- 
Thank you,
Roman


