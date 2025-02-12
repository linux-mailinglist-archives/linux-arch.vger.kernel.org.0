Return-Path: <linux-arch+bounces-10135-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D44A33312
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2025 00:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2FF167975
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 23:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD3420459F;
	Wed, 12 Feb 2025 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U08z9jK9"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAA7200114;
	Wed, 12 Feb 2025 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739401299; cv=none; b=FNLyyKL/Fy2slENE7T2pInPSX8FGEmbmJjWc1wwV9T7rnwXI5+drYkVGyBZvWfFQv4353ECFl705ZGfbFeGX8dSPoCG3qyqx47p8FRBHrGrkxCxF3yUaivTgGlyiD26kOuOtunHT9IiURG1QPWSCRWPJ0vEJlJUCrcTEzs0/34I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739401299; c=relaxed/simple;
	bh=rtbIGAaTmhLmf9KN3tRsPE4qOAzIjQbhJr1m74rRhwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ev1w0C3VKjKKLbsB2Jj5YpneKtUHL9ba2U2F2bTmav00xGzQnUmZBRq59l26sDJliXpkiU+/rNl4oa0Kd+aV6+SvpnSLn10Bu+SoztPXNRyjDazHwKIkwe1eIMdQhBDmIIPs/OL2hucGfQ3m0OS9+KQqhvi4VqNXhicR0gYCqbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U08z9jK9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 63C73203F3F9;
	Wed, 12 Feb 2025 15:01:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63C73203F3F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739401297;
	bh=kVD/TzWf8xNmuKwiACtI1JZzyEv978UeZM6dCbKDUxQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U08z9jK9iAY0zzo79A7JsC/Mz2ZbWBnrHFM5KY0O7MHmTpEOGkvA8SJUPe2B3lRVa
	 jvX1WzrD4fslrZg15JInATk0D9kx25QMttWTdsm0IK1VZtYMIGPhwhJNJuJAgX25PJ
	 Kv5P4xmlJC1vHp70JcBwBMfZWe2qmtpArPf05eG8=
Message-ID: <f7ce3ca7-e555-418d-9c88-6df379a3ec56@linux.microsoft.com>
Date: Wed, 12 Feb 2025 15:01:36 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hyperv: Add CONFIG_MSHV_ROOT to gate hv_root_partition
 checks
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, daniel.lezcano@linaro.org, joro@8bytes.org,
 robin.murphy@arm.com, arnd@arndb.de, jinankjain@linux.microsoft.com,
 muminulrussell@gmail.com, skinsburskii@linux.microsoft.com,
 mukeshrathor@microsoft.com
References: <1739312515-18848-1-git-send-email-nunodasneves@linux.microsoft.com>
 <20ba4b7c-bebb-4b1f-8c6c-4cd52a5083b5@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20ba4b7c-bebb-4b1f-8c6c-4cd52a5083b5@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/2025 9:47 PM, Easwar Hariharan wrote:
> On 2/11/2025 2:21 PM, Nuno Das Neves wrote:
>> Introduce CONFIG_MSHV_ROOT as a tristate to enable root partition
>> booting and future mshv driver functionality.
>>
>> Change hv_root_partition into a function which always returns false
>> if CONFIG_MSHV_ROOT=n.
>>
>> Introduce hv_current_partition_type to store the type of partition
>> (guest, root, or other kinds in future), and hv_identify_partition_type()
>> to it up early in Hyper-V initialization.
> 
> ...to *set* it up early?
> 
Yep! Thanks for catching that

>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>> Depends on
>> https://lore.kernel.org/linux-hyperv/1738955002-20821-3-git-send-email-nunodasneves@linux.microsoft.com/
>>
>>  arch/arm64/hyperv/mshyperv.c       |  2 ++
>>  arch/x86/hyperv/hv_init.c          | 10 ++++----
>>  arch/x86/kernel/cpu/mshyperv.c     | 24 ++----------------
>>  drivers/clocksource/hyperv_timer.c |  4 +--
>>  drivers/hv/Kconfig                 | 12 +++++++++
>>  drivers/hv/Makefile                |  3 ++-
>>  drivers/hv/hv.c                    | 10 ++++----
>>  drivers/hv/hv_common.c             | 32 +++++++++++++++++++-----
>>  drivers/hv/vmbus_drv.c             |  2 +-
>>  drivers/iommu/hyperv-iommu.c       |  4 +--
>>  include/asm-generic/mshyperv.h     | 39 +++++++++++++++++++++++++-----
>>  11 files changed, 92 insertions(+), 50 deletions(-)
>>
> 
> <snip>
> 
>> +
>> +void hv_identify_partition_type(void)
>> +{
>> +	/*
>> +	 * Check partition creation and cpu management privileges
>> +	 *
>> +	 * Hyper-V should never specify running as root and as a Confidential
>> +	 * VM. But to protect against a compromised/malicious Hyper-V trying
>> +	 * to exploit root behavior to expose Confidential VM memory, ignore
>> +	 * the root partition setting if also a Confidential VM.
>> +	 */
>> +	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
>> +	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
>> +	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
>> +		hv_current_partition_type = HV_PARTITION_TYPE_ROOT;
>> +		pr_info("Hyper-V: running as root partition\n");
>> +	} else {
>> +		hv_current_partition_type = HV_PARTITION_TYPE_GUEST;
>> +	}
>> +}
> 
> This should assume GUEST as default and modify to ROOT if all the checks pass.
> 
It is doing that, isn't it?

In fact the 'else' branch here is redundant and just there for additional clarity.

hv_current_partition_type is zeroed (so GUEST) by default, but I could make that explicit
if you prefer:
+enum hv_partition_type hv_current_partition_type = HV_PARTITION_TYPE_GUEST;

How does that sound? Am I misunderstanding something here?

> <snip>
> 
>> +static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>> +{
>> +	return hv_result(U64_MAX);
>> +}
> 
> Is there value in perhaps #defining hv_result_<whatever this is> as U64_MAX and returning that for documentation?
> For e.g. assuming this is something like EOPNOTSUPP
> 
> #define HV_RESULT_NOT_SUPP U64_MAX
> 
> static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> { return hv_result(HV_RESULT_NOT_SUPP); }
> 
The idea here was to copy what hv_do_hypercall does returning U64_MAX in case the hypercall
page is missing, which will hv_result() into an invalid status code. A special value for
that status could make this pattern clearer. I'd want to call out that this isn't a "real"
Hyper-V status code somehow. HV_STATUS's are 16 bits, so it would look more like:

/* "LINUX" because this isn't really a status from the hypervisor.. */
#define HV_STATUS_LINUX_FAIL 0xFFFF
static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
{ return HV_STATUS_LINUX_FAIL; }

Another option: there is another patch coming (which you know of) which maps hypercall
status codes to regular Linux errors like -EOPNOTSUPP. I could simply merge that patch
with this one (or make this a series for v2), and that would result in less churn.
(And leave alone the current use of U64_MAX in hv_do_hypercall, for now).

Nuno

> <snip>
> 
> Thanks,
> Easwar (he/him)


