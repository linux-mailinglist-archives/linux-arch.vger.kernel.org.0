Return-Path: <linux-arch+bounces-10573-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E7A573CA
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 22:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276813B512A
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 21:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA442586E2;
	Fri,  7 Mar 2025 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I19wXnmt"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0002580DB;
	Fri,  7 Mar 2025 21:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383541; cv=none; b=Aj+naqrSxf8QjvBmsCxkXfkchiAsADUbeJV8zn7RjXlxBklWTdvt3bHgmpAHKtrOGfZUhUSqMWPmO+XquuJYdQLs6uA3wKhomzSUzHM7SjhUgLJw4kUc2kIuFK9yAog5qwp1qciRHo3TxX8/wtz5LOV3vEHrZGVR2Ca8W5xN6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383541; c=relaxed/simple;
	bh=+wi8o9NkAeErLhcfBbbC/HrwvBoXP4xttRM/E2ADzf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JNbaAj/k6SiFUODeA+xY6Wzf/E379E5Qu9tpk9PtlpzgABD5ajUttU08il3iMr6DVnSZ7AbpevaRa/mHeNLYY/fg6G+0/mCafRQxQqRq9LzhL9dNRr09Wj6DjuHt+clM3I2zwek6bsXdOYeNFp0PPj44M1F2GuTtIPlMzwRFxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I19wXnmt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5141B2038F3B;
	Fri,  7 Mar 2025 13:38:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5141B2038F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741383540;
	bh=PErTl8OjCmr+pXwdzsQjeewJzsWEtdQvnkkFx+B+7d4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I19wXnmtMTh5TKUlGJZ1jrhcfilqlen7AEI9d0oLMxbG8/LUNvkfP6s7gePdSXzP4
	 atNUJWmjNO40FAQcmyGeeiz6CUyVP5t/l6f4UyWBLO8gk2CkeZnnor3kJ8YVqEjKMd
	 6KM77EOO72WSaKZMIexUsot5lon5rj3stvV+gx/c=
Message-ID: <bed778c5-4642-4429-914d-7ef2e6ecccc6@linux.microsoft.com>
Date: Fri, 7 Mar 2025 13:38:42 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] Drivers/hv: Export some functions for use by
 root partition module
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "arnd@arndb.de"
 <arnd@arndb.de>,
 "jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
 "muminulrussell@gmail.com" <muminulrussell@gmail.com>,
 "skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
 "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "apais@linux.microsoft.com" <apais@linux.microsoft.com>,
 "Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
 "stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
 "muislam@microsoft.com" <muislam@microsoft.com>,
 "anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-7-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB415706E75693B821FAF0A231D4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB415706E75693B821FAF0A231D4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/2025 11:23 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, February 26, 2025 3:08 PM
>>
> 
> Nit: For the patch Subject line, use prefix "Drivers: hv:" instead of with a slash.
> That's what we usually use and what you have used for other patches in this
> series.
> 
Thanks, I thought I checked these but I guess I missed this! I'll update for v6.

>> get_hypervisor_version, hv_call_deposit_pages, hv_call_create_vp,
>> hv_call_deposit_pages, and hv_call_create_vp are all needed in module
>> with CONFIG_MSHV_ROOT=m.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> 
> Modulo the nit:
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> 
>> ---
>>  arch/arm64/hyperv/mshyperv.c   | 1 +
>>  arch/x86/kernel/cpu/mshyperv.c | 1 +
>>  drivers/hv/hv_common.c         | 1 +
>>  drivers/hv/hv_proc.c           | 3 ++-
>>  4 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
>> index 2265ea5ce5ad..4e27cc29c79e 100644
>> --- a/arch/arm64/hyperv/mshyperv.c
>> +++ b/arch/arm64/hyperv/mshyperv.c
>> @@ -26,6 +26,7 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info
>> *info)
>>
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>>
>>  static int __init hyperv_init(void)
>>  {
>> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
>> index 2c29dfd6de19..0116d0e96ef9 100644
>> --- a/arch/x86/kernel/cpu/mshyperv.c
>> +++ b/arch/x86/kernel/cpu/mshyperv.c
>> @@ -420,6 +420,7 @@ int hv_get_hypervisor_version(union hv_hypervisor_version_info
>> *info)
>>
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>>
>>  static void __init ms_hyperv_init_platform(void)
>>  {
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index ce20818688fe..252fd66ad4db 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -717,6 +717,7 @@ int hv_result_to_errno(u64 status)
>>  	}
>>  	return -EIO;
>>  }
>> +EXPORT_SYMBOL_GPL(hv_result_to_errno);
>>
>>  void hv_identify_partition_type(void)
>>  {
>> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
>> index 8fc30f509fa7..20c8cee81e2b 100644
>> --- a/drivers/hv/hv_proc.c
>> +++ b/drivers/hv/hv_proc.c
>> @@ -108,6 +108,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>>  	kfree(counts);
>>  	return ret;
>>  }
>> +EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>>
>>  int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>>  {
>> @@ -194,4 +195,4 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>>
>>  	return ret;
>>  }
>> -
>> +EXPORT_SYMBOL_GPL(hv_call_create_vp);
>> --
>> 2.34.1


