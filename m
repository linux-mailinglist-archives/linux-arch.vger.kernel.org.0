Return-Path: <linux-arch+bounces-10479-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D6A4A73A
	for <lists+linux-arch@lfdr.de>; Sat,  1 Mar 2025 01:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007501764A9
	for <lists+linux-arch@lfdr.de>; Sat,  1 Mar 2025 00:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B27017580;
	Sat,  1 Mar 2025 00:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rWsihsDT"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4861524F;
	Sat,  1 Mar 2025 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740790326; cv=none; b=DHZ0zNLjjnFzyv30/ocqHm+/WgAVlsep8MWSzyrpxhA7Ocr/wXECoo7mStQJlVYXyQ1lWCqLKUCAJ3UOuMWk1zCXxV9ZBIGAl/JWWICyvsYLqG7BiylQTzvaLkydpPe6sg+2I+GeEh4FDXtdn+GvcdlLFqZwp0HejzO6y5+OZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740790326; c=relaxed/simple;
	bh=BsEmdMudaUz3PgI3BkuDtppdLURSPv6myzm8ZxD1LmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l29REiPPjm/VfJgL7aeupLoExahtluEexuCg3fCmmvNxnCLOm3DWkBJjpLizBvI3Sdi/siE+RkP6vtBTfK1mIiBZ+VUAC5hr+U3gIfXO5y6estZKhR7SrtF9H61ZA03fh5x1XlMG9E67YyreL4Dz+Xhs895rAmLFz+v0Lqo/s5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rWsihsDT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 913572038A20;
	Fri, 28 Feb 2025 16:52:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 913572038A20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740790324;
	bh=T620nyTuZVYQMk4K7Xd1cOEmvgLEGoaTUqKBJMcV+KM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rWsihsDTvP6m5ghpLfFYjTA3Q1Jwd5YXl6D5DgJJwInij7mlZdSf4y65VEn1mdEBu
	 yLiJ3b69QA9r9fFwiQs+UUNdbQ1WOHayST5ggSBLNQk/TLB56C0wnN6ktTTFD4ZHYO
	 jYea37sOlCj5bpaphYbytdTd6DX7GdsIv9Gl+ioQ=
Message-ID: <f205ab8f-47ad-4080-9042-b0c555810827@linux.microsoft.com>
Date: Fri, 28 Feb 2025 16:52:00 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/10] hyperv: Add definitions for root partition
 driver to hv headers
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
 <1740611284-27506-10-git-send-email-nunodasneves@linux.microsoft.com>
 <4fc076cd-7ac0-4569-909c-9c1abc3ae80c@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <4fc076cd-7ac0-4569-909c-9c1abc3ae80c@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/2025 5:27 PM, Easwar Hariharan wrote:
> On 2/26/2025 3:08 PM, Nuno Das Neves wrote:
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
> 
> <snip>
> 
>>  union hv_input_vtl {
>>  	u8 as_uint8;
>>  	struct {
>> @@ -1325,6 +1344,49 @@ struct hv_retarget_device_interrupt {	 /* HV_INPUT_RETARGET_DEVICE_INTERRUPT */
>>  	struct hv_device_interrupt_target int_target;
>>  } __packed __aligned(8);
>>  
>> +enum hv_intercept_type {
>> +#if defined(CONFIG_X86_64)
> 
> These chosen ifdef's come across kinda arbitrary. The hypervisor code has
> this enabled for both 32-bit and 64-bit x86, but you've chosen x86_64 only.
> I thought that may be because we only intend to support root partition for 64-bit
> platforms, but then, below...
> 
Oops! They should all be X86 instead of X86_64. It's true root partition is only
supported on 64-bit systems, but guests (whom also use these headers) can of course
be 32-bit. It makes better sense to just use CONFIG_X86 for these ifdefs.

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
> 
> ...you've chosen to include 32bit here, where the hypervisor code supports both.
> 
> Confused
> 
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
> 
> Can these be plain u32? Similar below...
> 
Yes, these are some uapi types I forgot to convert somehow, oops!

Thanks
Nuno

<snip>


