Return-Path: <linux-arch+bounces-10591-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD37DA5762C
	for <lists+linux-arch@lfdr.de>; Sat,  8 Mar 2025 00:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D74E189B5B2
	for <lists+linux-arch@lfdr.de>; Fri,  7 Mar 2025 23:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C52135B5;
	Fri,  7 Mar 2025 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hRXz7RZY"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBD72135AC;
	Fri,  7 Mar 2025 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390578; cv=none; b=D4MRlMhkrjyEJyE5wiw658r39SU8qgLDonF7F6AF66Y1oB4jrNrQncWNK+lidbDgQAKJEkFAiu8CXw7lAWUUpVijD9TVpCvmH4ELt7Q+e115oB8gZ+H72cyLQ5dPj78eUA/2YFkx/RLSHtuGxFjkhESTXPZBvVttSpRy88Fah3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390578; c=relaxed/simple;
	bh=oKXypGS+UWpAZ6bvzRd1RflS3yJ1s7aitXHt/9YOrtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZLhoAMbk74pjEuDrSJquIDeSK84pvTPyql2SjBWsKlyw4tG3qwLFoY+0+FJprI5ZSl+Was5noYzx8VskLF2Su/lI+YmN2I0VLaz3LcPKs5bcEEy/ZfX2l2Dk5cfIDjGlAk+zu9Mb0IXOQFD81jFywMwYzHDF3B/f4lFPNAgtXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hRXz7RZY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 18B652038F3D;
	Fri,  7 Mar 2025 15:36:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 18B652038F3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741390575;
	bh=pvMewxoixOT50Mq8lWiSZg7G62SZLT+bu1HI67HwrAw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hRXz7RZYKpsMsBEckWZTZVYOLoxBMc9Q+K2eeXTV0Lc30zdIpL2u+MOHVjL2vBieo
	 ANjWIswYp1+CX+mEBK0jI66DtErlmDOeaBg8v4E/mKPbv/pNkrk1tX0vNxbeUG7FOA
	 I+tZQyx8nDCEksJhoNtWOW/Z/YE3YiqeKevehgL0=
Message-ID: <5ffb92c5-2133-4b47-a1eb-b1acca2c4388@linux.microsoft.com>
Date: Fri, 7 Mar 2025 15:35:58 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] hyperv: Add definitions for root partition
 driver to hv headers
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
 <1740611284-27506-10-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41575301E96B82BF3813828BD4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41575301E96B82BF3813828BD4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/2025 9:26 AM, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, February 26, 2025 3:08 PM
>>
>> A few additional definitions are required for the mshv driver code
>> (to follow). Introduce those here and clean up a little bit while
>> at it.
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  include/hyperv/hvgdk_mini.h |  64 ++++++++++++++++-
>>  include/hyperv/hvhdk.h      | 132 ++++++++++++++++++++++++++++++++++--
>>  include/hyperv/hvhdk_mini.h |  91 +++++++++++++++++++++++++
>>  3 files changed, 280 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
>> index 58895883f636..e4a3cca0cbce 100644
>> --- a/include/hyperv/hvgdk_mini.h
>> +++ b/include/hyperv/hvgdk_mini.h
>> @@ -13,7 +13,7 @@ struct hv_u128 {
>>  	u64 high_part;
>>  } __packed;
>>
>> -/* NOTE: when adding below, update hv_status_to_string() */
>> +/* NOTE: when adding below, update hv_result_to_string() */
>>  #define HV_STATUS_SUCCESS			    0x0
>>  #define HV_STATUS_INVALID_HYPERCALL_CODE	    0x2
>>  #define HV_STATUS_INVALID_HYPERCALL_INPUT	    0x3
>> @@ -51,6 +51,7 @@ struct hv_u128 {
>>  #define HV_HYP_PAGE_SHIFT		12
>>  #define HV_HYP_PAGE_SIZE		BIT(HV_HYP_PAGE_SHIFT)
>>  #define HV_HYP_PAGE_MASK		(~(HV_HYP_PAGE_SIZE - 1))
>> +#define HV_HYP_LARGE_PAGE_SHIFT		21
>>
>>  #define HV_PARTITION_ID_INVALID		((u64)0)
>>  #define HV_PARTITION_ID_SELF		((u64)-1)
>> @@ -374,6 +375,10 @@ union hv_hypervisor_version_info {
>>  #define HV_SHARED_GPA_BOUNDARY_ACTIVE			BIT(5)
>>  #define HV_SHARED_GPA_BOUNDARY_BITS			GENMASK(11, 6)
>>
>> +/* HYPERV_CPUID_FEATURES.ECX bits. */
>> +#define HV_VP_DISPATCH_INTERRUPT_INJECTION_AVAILABLE	BIT(9)
>> +#define HV_VP_GHCB_ROOT_MAPPING_AVAILABLE		BIT(10)
>> +
>>  enum hv_isolation_type {
>>  	HV_ISOLATION_TYPE_NONE	= 0,	/*
>> HV_PARTITION_ISOLATION_TYPE_NONE */
>>  	HV_ISOLATION_TYPE_VBS	= 1,
>> @@ -437,9 +442,12 @@ union hv_vp_assist_msr_contents {	 /*
>> HV_REGISTER_VP_ASSIST_PAGE */
>>  #define HVCALL_MAP_GPA_PAGES				0x004b
>>  #define HVCALL_UNMAP_GPA_PAGES				0x004c
>>  #define HVCALL_CREATE_VP				0x004e
>> +#define HVCALL_INSTALL_INTERCEPT			0x004d
> 
> This is numerically out-of-order.  Should be before HVCALL_CREATE_VP.
> 
Oops! Thanks for spotting that.

>>  #define HVCALL_DELETE_VP				0x004f
>>  #define HVCALL_GET_VP_REGISTERS				0x0050
>>  #define HVCALL_SET_VP_REGISTERS				0x0051
>> +#define HVCALL_TRANSLATE_VIRTUAL_ADDRESS		0x0052
>> +#define HVCALL_CLEAR_VIRTUAL_INTERRUPT			0x0056
>>  #define HVCALL_DELETE_PORT				0x0058
>>  #define HVCALL_DISCONNECT_PORT				0x005b
>>  #define HVCALL_POST_MESSAGE				0x005c
>> @@ -447,12 +455,15 @@ union hv_vp_assist_msr_contents {	 /*
>> HV_REGISTER_VP_ASSIST_PAGE */
>>  #define HVCALL_POST_DEBUG_DATA				0x0069
>>  #define HVCALL_RETRIEVE_DEBUG_DATA			0x006a
>>  #define HVCALL_RESET_DEBUG_SESSION			0x006b
>> +#define HVCALL_MAP_STATS_PAGE				0x006c
>> +#define HVCALL_UNMAP_STATS_PAGE				0x006d
>>  #define HVCALL_ADD_LOGICAL_PROCESSOR			0x0076
>>  #define HVCALL_GET_SYSTEM_PROPERTY			0x007b
>>  #define HVCALL_MAP_DEVICE_INTERRUPT			0x007c
>>  #define HVCALL_UNMAP_DEVICE_INTERRUPT			0x007d
>>  #define HVCALL_RETARGET_INTERRUPT			0x007e
>>  #define HVCALL_NOTIFY_PORT_RING_EMPTY			0x008b
>> +#define HVCALL_REGISTER_INTERCEPT_RESULT		0x0091
>>  #define HVCALL_ASSERT_VIRTUAL_INTERRUPT			0x0094
>>  #define HVCALL_CREATE_PORT				0x0095
>>  #define HVCALL_CONNECT_PORT				0x0096
>> @@ -460,12 +471,18 @@ union hv_vp_assist_msr_contents {	 /*
>> HV_REGISTER_VP_ASSIST_PAGE */
>>  #define HVCALL_GET_VP_ID_FROM_APIC_ID			0x009a
>>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
>>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
>> +#define HVCALL_SIGNAL_EVENT_DIRECT			0x00c0
>> +#define HVCALL_POST_MESSAGE_DIRECT			0x00c1
>>  #define HVCALL_DISPATCH_VP				0x00c2
>> +#define HVCALL_GET_GPA_PAGES_ACCESS_STATES		0x00c9
>> +#define HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d7
>> +#define HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS	0x00d8
>>  #define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY	0x00db
>>  #define HVCALL_MAP_VP_STATE_PAGE			0x00e1
>>  #define HVCALL_UNMAP_VP_STATE_PAGE			0x00e2
>>  #define HVCALL_GET_VP_STATE				0x00e3
>>  #define HVCALL_SET_VP_STATE				0x00e4
>> +#define HVCALL_GET_VP_CPUID_VALUES			0x00f4
>>  #define HVCALL_MMIO_READ				0x0106
>>  #define HVCALL_MMIO_WRITE				0x0107
>>
>> @@ -807,6 +824,8 @@ struct hv_x64_table_register {
>>  	u64 base;
>>  } __packed;
>>
>> +#define HV_NORMAL_VTL	0
>> +
>>  union hv_input_vtl {
>>  	u8 as_uint8;
>>  	struct {
>> @@ -1325,6 +1344,49 @@ struct hv_retarget_device_interrupt {	 /*
>> HV_INPUT_RETARGET_DEVICE_INTERRUPT */
>>  	struct hv_device_interrupt_target int_target;
>>  } __packed __aligned(8);
>>
>> +enum hv_intercept_type {
>> +#if defined(CONFIG_X86_64)
>> +	HV_INTERCEPT_TYPE_X64_IO_PORT			= 0x00000000,
>> +	HV_INTERCEPT_TYPE_X64_MSR			= 0x00000001,
>> +	HV_INTERCEPT_TYPE_X64_CPUID			= 0x00000002,
>> +#endif
>> +	HV_INTERCEPT_TYPE_EXCEPTION			= 0x00000003,
>> +	/* Used to be HV_INTERCEPT_TYPE_REGISTER */
>> +	HV_INTERCEPT_TYPE_RESERVED0			= 0x00000004,
>> +	HV_INTERCEPT_TYPE_MMIO				= 0x00000005,
>> +#if defined(CONFIG_X86_64)
>> +	HV_INTERCEPT_TYPE_X64_GLOBAL_CPUID		= 0x00000006,
>> +	HV_INTERCEPT_TYPE_X64_APIC_SMI			= 0x00000007,
>> +#endif
>> +	HV_INTERCEPT_TYPE_HYPERCALL			= 0x00000008,
>> +#if defined(CONFIG_X86_64)
>> +	HV_INTERCEPT_TYPE_X64_APIC_INIT_SIPI		= 0x00000009,
>> +	HV_INTERCEPT_MC_UPDATE_PATCH_LEVEL_MSR_READ	= 0x0000000A,
>> +	HV_INTERCEPT_TYPE_X64_APIC_WRITE		= 0x0000000B,
>> +	HV_INTERCEPT_TYPE_X64_MSR_INDEX			= 0x0000000C,
>> +#endif
>> +	HV_INTERCEPT_TYPE_MAX,
>> +	HV_INTERCEPT_TYPE_INVALID			= 0xFFFFFFFF,
>> +};
>> +
>> +union hv_intercept_parameters {
>> +	/*  HV_INTERCEPT_PARAMETERS is defined to be an 8-byte field. */
>> +	__u64 as_uint64;
>> +#if defined(CONFIG_X86_64)
>> +	/* HV_INTERCEPT_TYPE_X64_IO_PORT */
>> +	__u16 io_port;
>> +	/* HV_INTERCEPT_TYPE_X64_CPUID */
>> +	__u32 cpuid_index;
>> +	/* HV_INTERCEPT_TYPE_X64_APIC_WRITE */
>> +	__u32 apic_write_mask;
>> +	/* HV_INTERCEPT_TYPE_EXCEPTION */
>> +	__u16 exception_vector;
>> +	/* HV_INTERCEPT_TYPE_X64_MSR_INDEX */
>> +	__u32 msr_index;
>> +#endif
>> +	/* N.B. Other intercept types do not have any parameters. */
>> +};
>> +
>>  /* Data structures for HVCALL_MMIO_READ and HVCALL_MMIO_WRITE */
>>  #define HV_HYPERCALL_MMIO_MAX_DATA_LENGTH 64
>>
>> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
>> index 64407c2a3809..1b447155c338 100644
>> --- a/include/hyperv/hvhdk.h
>> +++ b/include/hyperv/hvhdk.h
>> @@ -19,11 +19,24 @@
>>
>>  #define HV_VP_REGISTER_PAGE_VERSION_1	1u
>>
>> +#define HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT		7
>> +
>> +union hv_vp_register_page_interrupt_vectors {
>> +	u64 as_uint64;
>> +	struct {
>> +		u8 vector_count;
>> +		u8 vector[HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT];
>> +	} __packed;
>> +} __packed;
>> +
>>  struct hv_vp_register_page {
>>  	u16 version;
>>  	u8 isvalid;
>>  	u8 rsvdz;
>>  	u32 dirty;
>> +
>> +#if IS_ENABLED(CONFIG_X86)
>> +
>>  	union {
>>  		struct {
>>  			/* General purpose registers
>> @@ -95,6 +108,22 @@ struct hv_vp_register_page {
>>  	union hv_x64_pending_interruption_register pending_interruption;
>>  	union hv_x64_interrupt_state_register interrupt_state;
>>  	u64 instruction_emulation_hints;
>> +	u64 xfem;
>> +
>> +	/*
>> +	 * Fields from this point are not included in the register page save chunk.
>> +	 * The reserved field is intended to maintain alignment for unsaved fields.
>> +	 */
>> +	u8 reserved1[0x100];
>> +
>> +	/*
>> +	 * Interrupts injected as part of HvCallDispatchVp.
>> +	 */
>> +	union hv_vp_register_page_interrupt_vectors interrupt_vectors;
>> +
>> +#elif IS_ENABLED(CONFIG_ARM64)
>> +	/* Not yet supported in ARM */
>> +#endif
>>  } __packed;
>>
>>  #define HV_PARTITION_PROCESSOR_FEATURES_BANKS 2
>> @@ -299,10 +328,11 @@ union hv_partition_isolation_properties {
>>  #define HV_PARTITION_ISOLATION_HOST_TYPE_RESERVED   0x2
>>
>>  /* Note: Exo partition is enabled by default */
>> -#define HV_PARTITION_CREATION_FLAG_EXO_PARTITION                    BIT(8)
>> -#define HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED                    BIT(13)
>> -#define HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED   BIT(19)
>> -#define HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE                   BIT(22)
>> +#define HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED		BIT(4)
>> +#define HV_PARTITION_CREATION_FLAG_EXO_PARTITION			BIT(8)
>> +#define HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED			BIT(13)
>> +#define HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED	BIT(19)
>> +#define HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE			BIT(22)
>>
>>  struct hv_input_create_partition {
>>  	u64 flags;
>> @@ -349,13 +379,23 @@ struct hv_input_set_partition_property {
>>  enum hv_vp_state_page_type {
>>  	HV_VP_STATE_PAGE_REGISTERS = 0,
>>  	HV_VP_STATE_PAGE_INTERCEPT_MESSAGE = 1,
>> +	HV_VP_STATE_PAGE_GHCB,
> 
> Seems like this enum member should have an explicit value assigned
> since it is part of the contract with the hypervisor.
> 
Fair enough. They are just 0, 1, 2, but I agree it's better to be
explicit with the ABI values.

>>  	HV_VP_STATE_PAGE_COUNT
>>  };
>>
>>  struct hv_input_map_vp_state_page {
>>  	u64 partition_id;
>>  	u32 vp_index;
>> -	u32 type; /* enum hv_vp_state_page_type */
>> +	u16 type; /* enum hv_vp_state_page_type */
>> +	union hv_input_vtl input_vtl;
>> +	union {
>> +		u8 as_uint8;
>> +		struct {
>> +			u8 map_location_provided : 1;
>> +			u8 reserved : 7;
>> +		};
>> +	} flags;
>> +	u64 requested_map_location;
>>  } __packed;
>>
>>  struct hv_output_map_vp_state_page {
>> @@ -365,7 +405,14 @@ struct hv_output_map_vp_state_page {
>>  struct hv_input_unmap_vp_state_page {
>>  	u64 partition_id;
>>  	u32 vp_index;
>> -	u32 type; /* enum hv_vp_state_page_type */
>> +	u16 type; /* enum hv_vp_state_page_type */
>> +	union hv_input_vtl input_vtl;
>> +	u8 reserved0;
>> +} __packed;
>> +
>> +struct hv_x64_apic_eoi_message {
>> +	__u32 vp_index;
>> +	__u32 interrupt_vector;
>>  } __packed;
>>
>>  struct hv_opaque_intercept_message {
>> @@ -515,6 +562,13 @@ struct hv_synthetic_timers_state {
>>  	u64 reserved[5];
>>  } __packed;
>>
>> +struct hv_async_completion_message_payload {
>> +	__u64 partition_id;
>> +	__u32 status;
>> +	__u32 completion_count;
>> +	__u64 sub_status;
>> +} __packed;
>> +
>>  union hv_input_delete_vp {
>>  	u64 as_uint64[2];
>>  	struct {
>> @@ -649,6 +703,57 @@ struct hv_input_set_vp_state {
>>  	union hv_input_set_vp_state_data data[];
>>  } __packed;
>>
>> +union hv_x64_vp_execution_state {
>> +	__u16 as_uint16;
>> +	struct {
>> +		__u16 cpl:2;
>> +		__u16 cr0_pe:1;
>> +		__u16 cr0_am:1;
>> +		__u16 efer_lma:1;
>> +		__u16 debug_active:1;
>> +		__u16 interruption_pending:1;
>> +		__u16 vtl:4;
>> +		__u16 enclave_mode:1;
>> +		__u16 interrupt_shadow:1;
>> +		__u16 virtualization_fault_active:1;
>> +		__u16 reserved:2;
>> +	} __packed;
>> +};
>> +
>> +struct hv_x64_intercept_message_header {
>> +	__u32 vp_index;
>> +	__u8 instruction_length:4;
>> +	__u8 cr8:4; /* Only set for exo partitions */
>> +	__u8 intercept_access_type;
>> +	union hv_x64_vp_execution_state execution_state;
>> +	struct hv_x64_segment_register cs_segment;
>> +	__u64 rip;
>> +	__u64 rflags;
>> +} __packed;
>> +
>> +union hv_x64_memory_access_info {
>> +	__u8 as_uint8;
>> +	struct {
>> +		__u8 gva_valid:1;
>> +		__u8 gva_gpa_valid:1;
>> +		__u8 hypercall_output_pending:1;
>> +		__u8 tlb_locked_no_overlay:1;
>> +		__u8 reserved:4;
>> +	} __packed;
>> +};
>> +
>> +struct hv_x64_memory_intercept_message {
>> +	struct hv_x64_intercept_message_header header;
>> +	__u32 cache_type; /* enum hv_cache_type */
>> +	__u8 instruction_byte_count;
>> +	union hv_x64_memory_access_info memory_access_info;
>> +	__u8 tpr_priority;
>> +	__u8 reserved1;
>> +	__u64 guest_virtual_address;
>> +	__u64 guest_physical_address;
>> +	__u8 instruction_bytes[16];
>> +} __packed;
>> +
>>  /*
>>   * Dispatch state for the VP communicated by the hypervisor to the
>>   * VP-dispatching thread in the root on return from HVCALL_DISPATCH_VP.
>> @@ -716,6 +821,7 @@ static_assert(sizeof(struct hv_vp_signal_pair_scheduler_message)
>> ==
>>  #define HV_DISPATCH_VP_FLAG_SKIP_VP_SPEC_FLUSH		0x8
>>  #define HV_DISPATCH_VP_FLAG_SKIP_CALLER_SPEC_FLUSH	0x10
>>  #define HV_DISPATCH_VP_FLAG_SKIP_CALLER_USER_SPEC_FLUSH	0x20
>> +#define HV_DISPATCH_VP_FLAG_SCAN_INTERRUPT_INJECTION	0x40
>>
>>  struct hv_input_dispatch_vp {
>>  	u64 partition_id;
>> @@ -730,4 +836,18 @@ struct hv_output_dispatch_vp {
>>  	u32 dispatch_event; /* enum hv_vp_dispatch_event */
>>  } __packed;
>>
>> +struct hv_input_modify_sparse_spa_page_host_access {
>> +	u32 host_access : 2;
>> +	u32 reserved : 30;
>> +	u32 flags;
>> +	u64 partition_id;
>> +	u64 spa_page_list[];
>> +} __packed;
>> +
>> +/* hv_input_modify_sparse_spa_page_host_access flags */
>> +#define HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE  0x1
>> +#define HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED     0x2
>> +#define HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE      0x4
>> +#define HV_MODIFY_SPA_PAGE_HOST_ACCESS_HUGE_PAGE       0x8
>> +
>>  #endif /* _HV_HVHDK_H */
>> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
>> index f8a39d3e9ce6..42e7876455b5 100644
>> --- a/include/hyperv/hvhdk_mini.h
>> +++ b/include/hyperv/hvhdk_mini.h
>> @@ -36,6 +36,52 @@ enum hv_scheduler_type {
>>  	HV_SCHEDULER_TYPE_MAX
>>  };
>>
>> +/* HV_STATS_AREA_TYPE */
>> +enum hv_stats_area_type {
>> +	HV_STATS_AREA_SELF = 0,
>> +	HV_STATS_AREA_PARENT = 1,
>> +	HV_STATS_AREA_INTERNAL = 2,
>> +	HV_STATS_AREA_COUNT
>> +};
>> +
>> +enum hv_stats_object_type {
>> +	HV_STATS_OBJECT_HYPERVISOR		= 0x00000001,
>> +	HV_STATS_OBJECT_LOGICAL_PROCESSOR	= 0x00000002,
>> +	HV_STATS_OBJECT_PARTITION		= 0x00010001,
>> +	HV_STATS_OBJECT_VP			= 0x00010002
>> +};
>> +
>> +union hv_stats_object_identity {
>> +	/* hv_stats_hypervisor */
>> +	struct {
>> +		u8 reserved[15];
>> +		u8 stats_area_type;
>> +	} __packed hv;
>> +
>> +	/* hv_stats_logical_processor */
>> +	struct {
>> +		u32 lp_index;
>> +		u8 reserved[11];
>> +		u8 stats_area_type;
>> +	} __packed lp;
>> +
>> +	/* hv_stats_partition */
>> +	struct {
>> +		u64 partition_id;
>> +		u8  reserved[7];
>> +		u8  stats_area_type;
>> +	} __packed partition;
>> +
>> +	/* hv_stats_vp */
>> +	struct {
>> +		u64 partition_id;
>> +		u32 vp_index;
>> +		u16 flags;
>> +		u8  reserved;
>> +		u8  stats_area_type;
>> +	} __packed vp;
>> +};
>> +
>>  enum hv_partition_property_code {
>>  	/* Privilege properties */
>>  	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS			= 0x00010000,
>> @@ -47,19 +93,45 @@ enum hv_partition_property_code {
>>
>>  	/* Compatibility properties */
>>  	HV_PARTITION_PROPERTY_PROCESSOR_XSAVE_FEATURES		=
>> 0x00060002,
>> +	HV_PARTITION_PROPERTY_XSAVE_STATES                      = 0x00060007,
>>  	HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE		= 0x00060008,
>>  	HV_PARTITION_PROPERTY_PROCESSOR_CLOCK_FREQUENCY		=
>> 0x00060009,
>>  };
>>
>> +enum hv_snp_status {
>> +	HV_SNP_STATUS_NONE = 0,
>> +	HV_SNP_STATUS_AVAILABLE = 1,
>> +	HV_SNP_STATUS_INCOMPATIBLE = 2,
>> +	HV_SNP_STATUS_PSP_UNAVAILABLE = 3,
>> +	HV_SNP_STATUS_PSP_INIT_FAILED = 4,
>> +	HV_SNP_STATUS_PSP_BAD_FW_VERSION = 5,
>> +	HV_SNP_STATUS_BAD_CONFIGURATION = 6,
>> +	HV_SNP_STATUS_PSP_FW_UPDATE_IN_PROGRESS = 7,
>> +	HV_SNP_STATUS_PSP_RB_INIT_FAILED = 8,
>> +	HV_SNP_STATUS_PSP_PLATFORM_STATUS_FAILED = 9,
>> +	HV_SNP_STATUS_PSP_INIT_LATE_FAILED = 10,
>> +};
>> +
>>  enum hv_system_property {
>>  	/* Add more values when needed */
>>  	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE = 15,
>> +	HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY = 21,
>> +};
>> +
>> +enum hv_dynamic_processor_feature_property {
>> +	/* Add more values when needed */
>> +	HV_X64_DYNAMIC_PROCESSOR_FEATURE_MAX_ENCRYPTED_PARTITIONS = 13,
>> +	HV_X64_DYNAMIC_PROCESSOR_FEATURE_SNP_STATUS = 16,
>>  };
>>
>>  struct hv_input_get_system_property {
>>  	u32 property_id; /* enum hv_system_property */
>>  	union {
>>  		u32 as_uint32;
>> +#if IS_ENABLED(CONFIG_X86)
>> +		/* enum hv_dynamic_processor_feature_property */
>> +		u32 hv_processor_feature;
>> +#endif
>>  		/* More fields to be filled in when needed */
>>  	};
>>  } __packed;
>> @@ -67,9 +139,28 @@ struct hv_input_get_system_property {
>>  struct hv_output_get_system_property {
>>  	union {
>>  		u32 scheduler_type; /* enum hv_scheduler_type */
>> +#if IS_ENABLED(CONFIG_X86)
>> +		u64 hv_processor_feature_value;
>> +#endif
>>  	};
>>  } __packed;
>>
>> +struct hv_input_map_stats_page {
>> +	u32 type; /* enum hv_stats_object_type */
>> +	u32 padding;
>> +	union hv_stats_object_identity identity;
>> +} __packed;
>> +
>> +struct hv_output_map_stats_page {
>> +	u64 map_location;
>> +} __packed;
>> +
>> +struct hv_input_unmap_stats_page {
>> +	u32 type; /* enum hv_stats_object_type */
>> +	u32 padding;
>> +	union hv_stats_object_identity identity;
>> +} __packed;
>> +
>>  struct hv_proximity_domain_flags {
>>  	u32 proximity_preferred : 1;
>>  	u32 reserved : 30;
>> --
>> 2.34.1


