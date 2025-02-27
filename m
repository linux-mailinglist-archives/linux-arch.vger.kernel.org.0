Return-Path: <linux-arch+bounces-10450-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97362A48CF4
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAC73AE88A
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 23:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EE722A4F7;
	Thu, 27 Feb 2025 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ARGEEGvX"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C03E1BC2A;
	Thu, 27 Feb 2025 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740700091; cv=none; b=E/zDFJdYEsAlGbZ8KBcQj3x/4Zxn4iwRHkLNQWby5pn222sahy3oja772e9It24id3+X03Sv7qCbHL6ljJl5NKEoLhdRkGv12KYhG/KxndoO1sTJ/43WRVdC81FirqDqvrTaT3if2jPEt4s9Lj0exrv5aErkgtqOcW+YVdRUd7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740700091; c=relaxed/simple;
	bh=GnTgwM5BGKnpf69z6pQZfipcfzVLGUuXYzevsYtj9F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEIYtdGY1eOsL30ps50k2V807gNdcNRnxlf0TN4ecz+3T8RIcuaMr4EsbNoo4Mzmxz17W8TH7HX/+8kDaIQaox2MX6UnbAGCPSaComs1M0+u+8Q+AtgWn5Bm0O9dnAjscoekiPWc+/kBTpH3KDdNoMVXAtKejbtkslYsFPEw5ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ARGEEGvX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 37760210EAC1;
	Thu, 27 Feb 2025 15:48:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 37760210EAC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740700089;
	bh=PoN3ODPwJXVt8EEX+g0K7GieYEoDrpAu09pRK78IiSA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ARGEEGvXlOzvGXc5ZDerKy/kL06984xRuXdzu6/WT5VD7PAeyw4dckrk5KluN7Je7
	 J4u2cQ1O/IN805x2ojNBNLRbTZ5JJljbEZZK5io65o9vxBHj5CacyO81gNH56dk8Op
	 +MYzvEfAiPRjg06OWywmxzmeY9HXgj1GNLxmS7tE=
Message-ID: <f5cdead5-1136-4c66-9088-1a057a0a71bc@linux.microsoft.com>
Date: Thu, 27 Feb 2025 15:48:08 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
 <2889fab1-4836-4a66-aa63-b63d8cc70a69@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <2889fab1-4836-4a66-aa63-b63d8cc70a69@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 8:22 PM, Easwar Hariharan wrote:
> On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
>> Introduce hv_result_to_string() for this purpose. This allows
>> hypercall failures to be debugged more easily with dmesg.
>>
> 
> Let the commit message stand on its own, i.e. state that hv_result_to_string()
> is introduced to convert hyper-v status codes to string.
> 
I thought since the subject line is part of the commit message, this kind of
phrasing is ok. However I see that in my email client it is a little odd because
the subject line is a bit far removed from the rest of the message.

I'll change it :)

>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/hv_common.c         | 65 ++++++++++++++++++++++++++++++++++
>>  drivers/hv/hv_proc.c           | 13 ++++---
>>  include/asm-generic/mshyperv.h |  1 +
>>  3 files changed, 74 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index 9804adb4cc56..ce20818688fe 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -740,3 +740,68 @@ void hv_identify_partition_type(void)
>>  			pr_crit("Hyper-V: CONFIG_MSHV_ROOT not enabled!\n");
>>  	}
>>  }
>> +
>> +const char *hv_result_to_string(u64 hv_status)
>> +{
>> +	switch (hv_result(hv_status)) {
>> +	case HV_STATUS_SUCCESS:
>> +		return "HV_STATUS_SUCCESS";
>> +	case HV_STATUS_INVALID_HYPERCALL_CODE:
>> +		return "HV_STATUS_INVALID_HYPERCALL_CODE";
>> +	case HV_STATUS_INVALID_HYPERCALL_INPUT:
>> +		return "HV_STATUS_INVALID_HYPERCALL_INPUT";
>> +	case HV_STATUS_INVALID_ALIGNMENT:
>> +		return "HV_STATUS_INVALID_ALIGNMENT";
>> +	case HV_STATUS_INVALID_PARAMETER:
>> +		return "HV_STATUS_INVALID_PARAMETER";
>> +	case HV_STATUS_ACCESS_DENIED:
>> +		return "HV_STATUS_ACCESS_DENIED";
>> +	case HV_STATUS_INVALID_PARTITION_STATE:
>> +		return "HV_STATUS_INVALID_PARTITION_STATE";
>> +	case HV_STATUS_OPERATION_DENIED:
>> +		return "HV_STATUS_OPERATION_DENIED";
>> +	case HV_STATUS_UNKNOWN_PROPERTY:
>> +		return "HV_STATUS_UNKNOWN_PROPERTY";
>> +	case HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE:
>> +		return "HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE";
>> +	case HV_STATUS_INSUFFICIENT_MEMORY:
>> +		return "HV_STATUS_INSUFFICIENT_MEMORY";
>> +	case HV_STATUS_INVALID_PARTITION_ID:
>> +		return "HV_STATUS_INVALID_PARTITION_ID";
>> +	case HV_STATUS_INVALID_VP_INDEX:
>> +		return "HV_STATUS_INVALID_VP_INDEX";
>> +	case HV_STATUS_NOT_FOUND:
>> +		return "HV_STATUS_NOT_FOUND";
>> +	case HV_STATUS_INVALID_PORT_ID:
>> +		return "HV_STATUS_INVALID_PORT_ID";
>> +	case HV_STATUS_INVALID_CONNECTION_ID:
>> +		return "HV_STATUS_INVALID_CONNECTION_ID";
>> +	case HV_STATUS_INSUFFICIENT_BUFFERS:
>> +		return "HV_STATUS_INSUFFICIENT_BUFFERS";
>> +	case HV_STATUS_NOT_ACKNOWLEDGED:
>> +		return "HV_STATUS_NOT_ACKNOWLEDGED";
>> +	case HV_STATUS_INVALID_VP_STATE:
>> +		return "HV_STATUS_INVALID_VP_STATE";
>> +	case HV_STATUS_NO_RESOURCES:
>> +		return "HV_STATUS_NO_RESOURCES";
>> +	case HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED:
>> +		return "HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED";
>> +	case HV_STATUS_INVALID_LP_INDEX:
>> +		return "HV_STATUS_INVALID_LP_INDEX";
>> +	case HV_STATUS_INVALID_REGISTER_VALUE:
>> +		return "HV_STATUS_INVALID_REGISTER_VALUE";
>> +	case HV_STATUS_OPERATION_FAILED:
>> +		return "HV_STATUS_OPERATION_FAILED";
>> +	case HV_STATUS_TIME_OUT:
>> +		return "HV_STATUS_TIME_OUT";
>> +	case HV_STATUS_CALL_PENDING:
>> +		return "HV_STATUS_CALL_PENDING";
>> +	case HV_STATUS_VTL_ALREADY_ENABLED:
>> +		return "HV_STATUS_VTL_ALREADY_ENABLED";
>> +	default:
>> +		return "Unknown";
>> +	};
>> +	return "Unknown";
> 
> Unnecessary extra return since the default case already returns "Unknown"
> 
Good point, I think I'd prefer to remove the first return and leave the
default case empty.

>> +}
>> +EXPORT_SYMBOL_GPL(hv_result_to_string);
>> +
> 
> Extra line here ^
> 
Thanks

>> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
>> index 2fae18e4f7d2..8fc30f509fa7 100644
>> --- a/drivers/hv/hv_proc.c
>> +++ b/drivers/hv/hv_proc.c
>> @@ -87,7 +87,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>>  				     page_count, 0, input_page, NULL);
>>  	local_irq_restore(flags);
>>  	if (!hv_result_success(status)) {
>> -		pr_err("Failed to deposit pages: %lld\n", status);
>> +		pr_err("%s: Failed to deposit pages: %s\n", __func__,
>> +		       hv_result_to_string(status));
>>  		ret = hv_result_to_errno(status);
>>  		goto err_free_allocations;
>>  	}
>> @@ -137,8 +138,9 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
>>  
>>  		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
>>  			if (!hv_result_success(status)) {
>> -				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
>> -				       lp_index, apic_id, status);
>> +				pr_err("%s: cpu %u apic ID %u, %s\n",
>> +				       __func__, lp_index, apic_id,
>> +				       hv_result_to_string(status));
>>  				ret = hv_result_to_errno(status);
>>  			}
>>  			break;
>> @@ -179,8 +181,9 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
>>  
>>  		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
>>  			if (!hv_result_success(status)) {
>> -				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
>> -				       vp_index, flags, status);
>> +				pr_err("%s: vcpu %u, lp %u, %s\n",
>> +				       __func__, vp_index, flags,
>> +				       hv_result_to_string(status));
>>  				ret = hv_result_to_errno(status);
>>  			}
>>  			break;
> 
> There are more convertible instances in arch/x86/hyperv/irqdomain.c and drivers/iommu/hyperv-iommu.c
> 
Ah, thank you, happy to add those!

>> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
>> index b13b0cda4ac8..dc4729dba9ef 100644
>> --- a/include/asm-generic/mshyperv.h
>> +++ b/include/asm-generic/mshyperv.h
>> @@ -298,6 +298,7 @@ static inline int cpumask_to_vpset_skip(struct hv_vpset *vpset,
>>  	return __cpumask_to_vpset(vpset, cpus, func);
>>  }
>>  
>> +const char *hv_result_to_string(u64 hv_status);
>>  int hv_result_to_errno(u64 status);
>>  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
>>  bool hv_is_hyperv_initialized(void);


