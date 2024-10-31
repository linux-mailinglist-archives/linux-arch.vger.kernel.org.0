Return-Path: <linux-arch+bounces-8739-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C54F9B866D
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 23:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1C81C21787
	for <lists+linux-arch@lfdr.de>; Thu, 31 Oct 2024 22:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C621D0DE6;
	Thu, 31 Oct 2024 22:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CA42Pkd8"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4797F1E1A33;
	Thu, 31 Oct 2024 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415562; cv=none; b=Xyni5Ae/yW6OlP3s1vfTpNpJHqhIXeCSYKS3YnvwjhECPnTQIwx672VmREmERKUKf9Naqr8Mhb83WITSUDp0Mw2ns7Z45aC7ocfZqLAQ/di+Iuzwlv2LvoJibLAtMMZhCWVdgRhyrx+o1p23RBhrmyDHqa6rZXkVsgFkf7Gdgps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415562; c=relaxed/simple;
	bh=YhlhvI2YQgj/7M+uXnhLz4j5eWdRPCwjq4xSWx40Aro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnYdHcUFGI51KRZnSNWfte9SWzZMA33JcA6rpdF3vceCVEgC6JLU/ry6/svP2IT0QxC6CL9hCrR7lN/TMNums0H2dVPaig+jUiUDvrZQTLKkZ7xMA80mRrqGCUjaW/uxtP10Ouk55qzY9YKup8u5JWrDllg/Sr9g2mSPD306n3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CA42Pkd8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0DC1F20C08A6;
	Thu, 31 Oct 2024 15:59:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DC1F20C08A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1730415555;
	bh=Igl9G1C4hOVKzBEFno2MrS2ZBovfo3EzzSumDWDVDac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CA42Pkd8gk+aW8coxUfcz9FnbFPOm4DNzDPCYaaqMeDNXZyjHbYFoVBqFM2ra2QA0
	 gQ3Ywty+9jx/fcSph8pm89kL2on5UwnczZAJca3EIIJcEGpMxIV/b5GDAGfOiBWB5W
	 0uF5JXHULaaK+8SPYeqwgllQxC7n/jWbNL2sYcio=
Message-ID: <aecdc98c-1f12-4f17-b145-9f02aebc01c2@linux.microsoft.com>
Date: Thu, 31 Oct 2024 15:59:14 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Add new headers for Hyper-V Dom0
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, iommu@lists.linux.dev,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, virtualization@lists.linux.dev
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, sgarzare@redhat.com,
 jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mukeshrathor@microsoft.com,
 tyhicks@linux.microsoft.com
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <fc47d535-ed52-4ca5-80cc-30003efdd464@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <fc47d535-ed52-4ca5-80cc-30003efdd464@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/2024 12:05 PM, Easwar Hariharan wrote:
> On 10/3/2024 12:50 PM, Nuno Das Neves wrote:
>> To support Hyper-V Dom0 (aka Linux as root partition), many new
>> definitions are required.
>>
>> The plan going forward is to directly import headers from
>> Hyper-V. This is a more maintainable way to import definitions
>> rather than via the TLFS doc. This patch series introduces
>> new headers (hvhdk.h, hvgdk.h, etc, see patch #3) directly
>> derived from Hyper-V code.
>>
>> This patch series replaces hyperv-tlfs.h with hvhdk.h, but only
>> in Microsoft-maintained Hyper-V code where they are needed. This
>> leaves the existing hyperv-tlfs.h in use elsewhere - notably for
>> Hyper-V enlightenments on KVM guests.
>>
>> An intermediary header "hv_defs.h" is introduced to conditionally
>> include either hyperv-tlfs.h or hvhdk.h. This is required because
>> several headers which today include hyperv-tlfs.h, are shared
>> between Hyper-V and KVM code (e.g. mshyperv.h).
>>
>> Summary:
>> Patch 1-2: Cleanup patches
>> Patch 3: Add the new headers (hvhdk.h, etc..) in include/hyperv/
>> Patch 4: Add hv_defs.h and use it in mshyperv.h, svm.h,
>>          hyperv_timer.h
>> Patch 5: Switch to the new headers, only in Hyper-V code
>>
>> Nuno Das Neves (5):
>>   hyperv: Move hv_connection_id to hyperv-tlfs.h
>>   hyperv: Remove unnecessary #includes
>>   hyperv: Add new Hyper-V headers
>>   hyperv: Add hv_defs.h to conditionally include hyperv-tlfs.h or
>>     hvhdk.h
>>   hyperv: Use hvhdk.h instead of hyperv-tlfs.h in Hyper-V code
>>

Hi Easwar, thanks for the questions. I will attempt to clarify.
> 
> What is the model for Hyper-V code that has both guest and host roles
> where the corresponding hypercalls are available for both? As I
> understand it, those are supposed to be in hvgdk*.h.
>

It's true that the naming of the files implies hvgdk*.h is for guests,
and hvhdk*.h (which includes hvgdk*.h), is for hosts/dom0. But I would
only take that as a rough guide.

The real reason for keeping these names is to make it a easier to copy
and maintain the definitions from the Windows code into Linux, by
keeping the provenance of exactly where they came from.

> For a specific example, IOMMU hypercalls can operate on stage 2 or stage
> 1 translations depending on the role of the (hyper) caller and the input
> values provided. Should a driver using these hypercalls import both
> hvhdk* and hvgdk*? What about hyperv-tlfs?
>

I'd recommend importing hvhdk.h since it contains everything you need
(including hvgdk*.h).

The goal of this patchset is to move away from hyperv-tlfs.h, because by
definition it should only contain definitions from the TLFS document.

> Patches 4 and 5 seem to draw a bright line between host and guest roles
> while the reality is more gray. Please do correct me if I'm wrong here,
> perhaps the picture would be clearer if Stas' suggestion of a new header
> file is implemented.
> 

Patches 4 and 5 introduce the new headers in a way that avoids any
potential impact on KVM and other non-Microsoft-maintained code.

The 'line' is not between guest and host, but between Microsoft-maintained
and non-Microsoft-maintained code.

Thanks,
Nuno

> Thanks,
> Easwar


