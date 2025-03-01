Return-Path: <linux-arch+bounces-10480-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C87A4A76A
	for <lists+linux-arch@lfdr.de>; Sat,  1 Mar 2025 02:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFA818975D9
	for <lists+linux-arch@lfdr.de>; Sat,  1 Mar 2025 01:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451577082E;
	Sat,  1 Mar 2025 01:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dVMt1oTi"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA445D477;
	Sat,  1 Mar 2025 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740792588; cv=none; b=YuparL6TcDy/exdwugNIqjv7EcU4rbev3S+pe3DyT798z7pgWqfUAdGh1BNjEO5y9tV7KA8Dhl7JUSYdmkiqVJ+8XoYaSogaqy1G93mM6nrZ3QdUd0YSpfBPK5GmC4S9WNFox5xiXCD7SzUTHxxRLeyS+5+KBqD2xAPoxoaHtwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740792588; c=relaxed/simple;
	bh=QD4AKrECpbvvBe/L3b3AXHIL8c+PuFGrRL2Ip37IsHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuXrv+oMjAlx6PHhpZXGH1SpMRr3V+Qsv8XhUMkRNfG6b+5y84OmpDPBYAlEBmT8wsNLM3iEzOwD+f58OvNGwE5B83qtuSI0DcaKiCnA1zCTIt/cQLenTboac18qMwMbgjzQcZ5lKBjIndwyqZ+TzfjYDjVqTNCoAlEUfixexOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dVMt1oTi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5B7392038A22;
	Fri, 28 Feb 2025 17:29:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B7392038A22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740792586;
	bh=fQg7ILySdOBkHpl5o6FQRwzicfVWX7YnpeaSEDtj2sU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dVMt1oTiRRQ7OGgYHkGszBrYb6DwmvGTKzAkC7zxJ7vhypSMUVdQSb5RPsPegs7hq
	 pL5qmK2plw2PPZXVObyenXvjKLpY7YNkd9rX2G00/f1U0/Bv9YGkAmZQiERen3U12o
	 6g+WiBMCMDAIIAXOnsGNj6LKq5VClmYw5bsYIF3s=
Message-ID: <c299e02a-83a5-462a-a6a8-ae34c6bb2831@linux.microsoft.com>
Date: Fri, 28 Feb 2025 17:29:42 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
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
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
 <8ce2dc94-d4e7-45d7-8228-e8afd2bef3bc@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <8ce2dc94-d4e7-45d7-8228-e8afd2bef3bc@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 8:59 PM, Easwar Hariharan wrote:
> On 2/26/2025 3:08 PM, Nuno Das Neves wrote:
>> Provide a set of IOCTLs for creating and managing child partitions when
>> running as root partition on Hyper-V. The new driver is enabled via
>> CONFIG_MSHV_ROOT.
>>
>> A brief overview of the interface:
>>
>> MSHV_CREATE_PARTITION is the entry point, returning a file descriptor
>> representing a child partition. IOCTLs on this fd can be used to map
>> memory, create VPs, etc.
>>
>> Creating a VP returns another file descriptor representing that VP which
>> in turn has another set of corresponding IOCTLs for running the VP,
>> getting/setting state, etc.
>>
>> MSHV_ROOT_HVCALL is a generic "passthrough" hypercall IOCTL which can be
>> used for a number of partition or VP hypercalls. This is for hypercalls
>> that do not affect any state in the kernel driver, such as getting and
>> setting VP registers and partition properties, translating addresses,
>> etc. It is "passthrough" because the binary input and output for the
>> hypercall is only interpreted by the VMM - the kernel driver does
>> nothing but insert the VP and partition id where necessary (which are
>> always in the same place), and execute the hypercall.
>>
>> Co-developed-by: Wei Liu <wei.liu@kernel.org>
>> Signed-off-by: Wei Liu <wei.liu@kernel.org>
>> Co-developed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>> Co-developed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
>> Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
>> Co-developed-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
>> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
>> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
>> Co-developed-by: Muminul Islam <muislam@microsoft.com>
>> Signed-off-by: Muminul Islam <muislam@microsoft.com>
>> Co-developed-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
>> Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
> 
> I see some issues reported by checkpatch, both vanilla and --strict.
> <snip>

Yes, most of them are from --strict.

The macro argument reuse ones are a non-issue I think. I suppose this
could be cleaned up for the vp_ and pt_ macros, I might do that.

"struct mutex/spinlock_t definition without comment" - I'm not sure
if that's really needed. The code that uses these primitives
demonstrates their purpose better than a comment, I think.

"Avoid CamelCase" - Some Hyper-V definitions that use the original
CamelCase definitions are introduced in this patch. These are
stats-related - partition and vp statistics that can be gathered
from the hypervisor. In a future patch these will be converted to
strings and displayed in debugfs, and... hmm, to be honest I'm not
sure why they need to remain in CamelCase when we convert everything
else to Linux style... For now there are only 2 of these definitions
and they're only defined in mshv_root_main.c so I think it's ok.
I'll consider what to do when the rest of the stats code is proposed,
which includes a big chunk of these CamelCase definitions.

"Use of volatile is usually wrong" - I admit I'm not an expert in
this area. We use it for a pointer to hv_synic_event_ring, similar
to how it is used to access hv_synic_event_flags_page in vmbus_drv.c.

"Added, moved or deleted file(s), does MAINTAINERS need updating?" -
drivers/hv is already listed in MAINTAINERS.

Thanks
Nuno

> 
> Thanks,
> Easwar (he/him)


