Return-Path: <linux-arch+bounces-13647-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5889FB58AEC
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 03:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC9616DB32
	for <lists+linux-arch@lfdr.de>; Tue, 16 Sep 2025 01:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D071FBC91;
	Tue, 16 Sep 2025 01:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qjBDmvrA"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE5C1A23A4;
	Tue, 16 Sep 2025 01:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985325; cv=none; b=s4KjywInxbdGzHmpPb47JjjjYBySdGrdOb8ZRpwawroTdTSYwBfyqcQVfebtHRyKF0xdW7OEeeqP3A8NrBea/E5QbW8BGNAa9LYA4ggcggCGUzRrbZxH7xHDpy//Ty6yxVd0IjfTcy+WiJO2j4XJ5TDtueyKxpiUUciM4D3eu4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985325; c=relaxed/simple;
	bh=e8+qgCH0IeUFzw1vQWjrJ7DFTXLksJXvY2hHzXm9Vns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYo/dnijBFXAoK0A5LtkoogIaUn6wzuFVPM5ORbyy0zJ1w8hHtM41bnLx1gfv/xtNwL778ULKKVCxAeNMKSMiy516K6UjfeATOUBx2ahob8c/4GPWtRmL4ZwI18kgyhNarBF58IGdXwv8hTt2yEPrk/Ga6Hpp3bcVA1EAp+tfxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qjBDmvrA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9053B20154E0;
	Mon, 15 Sep 2025 18:15:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9053B20154E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757985323;
	bh=ovMJ9DSpplT2GjjBR4nwbyz6Y1azv+JnluF9GSxLyBk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qjBDmvrA6xDSOYzuru0jRZ59mcpB7rj3DitZ7wEVBW2kEjd7+F5Jn8eKddxMEv64n
	 YUd0jZxMk8B9ObtLBG8oKkRcu5MOBp6etSDEsKw0hnHLSjmmo7t2i4TjBoEA8L9bsY
	 Yo+IeCXj+AINeznqtoot8MABRbXHqeBWscujzdZY=
Message-ID: <cfcbdf49-33e6-685c-daed-4dd8f1523c49@linux.microsoft.com>
Date: Mon, 15 Sep 2025 18:15:21 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v1 3/6] hyperv: Add definitions for hypervisor crash dump
 support
Content-Language: en-US
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "arnd@arndb.de" <arnd@arndb.de>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-4-mrathor@linux.microsoft.com>
 <SN6PR02MB41577F7E862976DE192DB9C0D415A@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41577F7E862976DE192DB9C0D415A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/25 10:54, Michael Kelley wrote:
> From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, September 9, 2025 5:10 PM
>>
>> Add data structures for hypervisor crash dump support to the hypervisor
>> host ABI header file. Details of their usages are in subsequent commits.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> ---
>>  include/hyperv/hvhdk_mini.h | 55 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>
>> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
>> index 858f6a3925b3..ad9a8048fb4e 100644
>> --- a/include/hyperv/hvhdk_mini.h
>> +++ b/include/hyperv/hvhdk_mini.h
>> @@ -116,6 +116,17 @@ enum hv_system_property {
>>  	/* Add more values when needed */
>>  	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE = 15,
>>  	HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY = 21,
>> +	HV_SYSTEM_PROPERTY_CRASHDUMPAREA = 47,
>> +};
>> +
>> +#define HV_PFN_RANGE_PGBITS 24  /* HV_SPA_PAGE_RANGE_ADDITIONAL_PAGES_BITS */
>> +union hv_pfn_range {            /* HV_SPA_PAGE_RANGE */
>> +	u64 as_uint64;
>> +	struct {
>> +		/* 39:0: base pfn.  63:40: additional pages */
>> +		u64 base_pfn : 64 - HV_PFN_RANGE_PGBITS;
>> +		u64 add_pfns : HV_PFN_RANGE_PGBITS;
>> +	} __packed;
>>  };
>>
>>  enum hv_dynamic_processor_feature_property {
>> @@ -142,6 +153,8 @@ struct hv_output_get_system_property {
>>  #if IS_ENABLED(CONFIG_X86)
>>  		u64 hv_processor_feature_value;
>>  #endif
>> +		union hv_pfn_range hv_cda_info; /* CrashdumpAreaAddress */
>> +		u64 hv_tramp_pa;                /* CrashdumpTrampolineAddress */
>>  	};
>>  } __packed;
>>
>> @@ -234,6 +247,48 @@ union hv_gpa_page_access_state {
>>  	u8 as_uint8;
>>  } __packed;
>>
>> +enum hv_crashdump_action {
>> +	HV_CRASHDUMP_NONE = 0,
>> +	HV_CRASHDUMP_SUSPEND_ALL_VPS,
>> +	HV_CRASHDUMP_PREPARE_FOR_STATE_SAVE,
>> +	HV_CRASHDUMP_STATE_SAVED,
>> +	HV_CRASHDUMP_ENTRY,
>> +};
> 
> Nit: Since these values are part of the ABI, it's probably better
> to assign explicit values to each enum member in order to
> ward off any mistaken reordering or additions in the middle
> of the list.

No, like I have mentioned in the past, we are mirroring hyp headers
with the eventual goal of just consuming from there directly.
Each change in ABI header is very carefully examined, we now have
a process for it. 
 
>> +
>> +struct hv_partition_event_root_crashdump_input {
>> +	u32 crashdump_action; /* enum hv_crashdump_action */
>> +} __packed;
>> +
>> +struct hv_input_disable_hyp_ex {   /* HV_X64_INPUT_DISABLE_HYPERVISOR_EX */
>> +	u64 rip;
>> +	u64 arg;
>> +} __packed;
>> +
>> +struct hv_crashdump_area {	   /* HV_CRASHDUMP_AREA */
>> +	u32 version;
>> +	union {
>> +		u32 flags_as_uint32;
>> +		struct {
>> +			u32 cda_valid : 1;
>> +			u32 cda_unused : 31;
>> +		} __packed;
>> +	};
>> +	/* more unused fields */
>> +} __packed;
>> +
>> +union hv_partition_event_input {
>> +	struct hv_partition_event_root_crashdump_input crashdump_input;
>> +};
>> +
>> +enum hv_partition_event {
>> +	HV_PARTITION_EVENT_ROOT_CRASHDUMP = 2,
>> +};
>> +
>> +struct hv_input_notify_partition_event {
>> +	u32 event;      /* enum hv_partition_event */
>> +	union hv_partition_event_input input;
>> +} __packed;
>> +
>>  struct hv_lp_startup_status {
>>  	u64 hv_status;
>>  	u64 substatus1;
>> --
>> 2.36.1.vfs.0.0
>>
> 


