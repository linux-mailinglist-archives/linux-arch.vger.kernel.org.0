Return-Path: <linux-arch+bounces-10650-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4826EA5A1A5
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 19:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F134D3AE857
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 18:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299B6233D7C;
	Mon, 10 Mar 2025 18:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lkfc7WqT"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFB7226D17;
	Mon, 10 Mar 2025 18:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630031; cv=none; b=iP0mHF20f0PBmh4Cpqe8jsilntUMXpKI9VZE4g7+K/zrTZSdPLlnTdDADgwIbhAt565N6iYGYP+vaTfIEoDr7P8fBv/BZ+E/y9KKG1fsFiDIpwX6L56Ia4E76XfkALEfiJkDYQl+NnO1MWQiAy2TRnnuhCX60nfrYAI8/JB1koQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630031; c=relaxed/simple;
	bh=CA9EMsdy0ESHhNUh8YAZSmW8LOgcKOF7hv3RuqiayFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlvvO4KvSwuNI7wmFqDPJu5PoTsb1MlA7Ieqip+74ReoRp72wv4/xmqbCeQExzUtW5reFkNr9wEVWE3bPSJ5pW5GTqWZbdCTCIoUcrE2P/52IOghPZYfV0FhBGbeiDLx5nqRcqCaNwqYh9l409dNH7X+9oiDed+HAVwNLGopZiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lkfc7WqT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id AEB1B2038F50;
	Mon, 10 Mar 2025 11:07:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEB1B2038F50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741630029;
	bh=E13Z4tIU2QebiQ+fHYjb3GAytcpWMD9ZkrlSMteHVzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lkfc7WqTTy9o/NtCmsNne2YvNu14qrm7uDsjvvXkQk5sfBSt0aW2JUGCLGbi53VQm
	 x7EtA7dAZvpUOAdKpa+WyJR+DDJq7wyFqIlErDY/ZzM4lWwuea+zOldXaRC8xhF7xm
	 s2kAl+3x2CXQIATrHNeR52YStsliYwkkKncXNNUo=
Message-ID: <ba6b906d-04a2-423d-a527-9ef7ab1dccf2@linux.microsoft.com>
Date: Mon, 10 Mar 2025 11:07:08 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v5 07/11] dt-bindings: microsoft,vmbus: Add
 interrupts and DMA coherence
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com,
 lenb@kernel.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 mark.rutland@arm.com, maz@kernel.org, mingo@redhat.com,
 oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org,
 ssengar@linux.microsoft.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
 tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
 yuzenghui@huawei.com, devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-8-romank@linux.microsoft.com>
 <20250310-demonic-ferret-of-judgment-5dbdbf@krzk-bin>
 <c7f9d861-f617-4064-8c98-2ace06e9c25e@linux.microsoft.com>
 <09d4966a-5804-40a4-9c5f-356a954a7704@kernel.org>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <09d4966a-5804-40a4-9c5f-356a954a7704@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/10/2025 10:40 AM, Krzysztof Kozlowski wrote:
> On 10/03/2025 18:05, Roman Kisel wrote:
>>
>>
>> On 3/10/2025 2:28 AM, Krzysztof Kozlowski wrote:
>>> On Fri, Mar 07, 2025 at 02:02:59PM -0800, Roman Kisel wrote:
>>>> To boot on ARM64, VMBus requires configuring interrupts. Missing
>>>> DMA coherence property is sub-optimal as the VMBus transations are
>>>> cache-coherent.
>>>>
>>>> Add interrupts to be able to boot on ARM64. Add DMA coherence to
>>>> avoid doing extra work on maintaining caches on ARM64.
>>>
>>> How do you add it?
>>>
>>
>> I added properties to the node. Should I fix the description, or I am
>> misunderstanding the question?
> 
> I saw interrupts in the schema, but I did not see dma-coherence. I also
> did not see any DTS patches here, so I don't understand what node you
> are referring to.
> 

I will refer to talks, example-bindings, writing-schema you've suggested
to waste your time less. It appears there is some fundamental flaw in my
understanding of how these YAML files work so much so that I cannot even
write a commit description that can be understood, for the 5th time in
the row, sorry about that.

>>
>>>>
>>>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>>>> ---
>>>>    .../devicetree/bindings/bus/microsoft,vmbus.yaml          | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
>>>> index a8d40c766dcd..3ab7d0116626 100644
>>>> --- a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
>>>> +++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
>>>> @@ -28,13 +28,16 @@ properties:
>>>>    required:
>>>>      - compatible
>>>>      - ranges
>>>> +  - interrupts
>>>>      - '#address-cells'
>>>>      - '#size-cells'
>>>>    
>>>> -additionalProperties: false
>>>> +additionalProperties: true
>>>
>>> This is neither explained in commit msg nor correct.
>>>
>>
>> Not explained, as there is no good explanation as described below.
>>
>>> Drop the change. You cannot have device bindings ending with 'true'
>>> here - see talks, example-bindings, writing-schema and whatever resource
>>> is there.
>>>
>>
>> Thanks, I'll put more effort into bringing this into a better form!
>> If you have time, could you comment on the below?
>>
>> The Documentation says
>>
>>     * additionalProperties: true
>>       Rare case, used for schemas implementing common set of properties.
>> Such schemas are supposed to be referenced by other schemas, which then
>> use 'unevaluatedProperties: false'.  Typically bus or common-part schemas.
>>
>> This is a bus so I added that line to the YAML, and I saw it in many
> 
> If this is a bus, then where is schema using it for
> bus-attached-devices? You cannot have bus without devices.
> 
> You *must* fulfill that part:
> "Such schemas are supposed to be referenced by other schemas, which then"
> 
> instead of calling it bus...
> 

It is modeled as a bus in the kernel:
https://www.kernel.org/doc/html/latest/virt/hyperv/vmbus.html

> Please upstream bindings for the bus devices and extend the example here
> with these devices.

The set of synthetic devices that reside on the bus isn't fixed, and
they don't require description neither in ACPI nor in DT as
the devices negotiate their MMIO regions through the hyperv driver.

Perhaps, it is not as much bus as expected by the YAML files.

> 
> Or this is not bus (calling something vmpony does not make it a pony).
> 
 > > Best regards,
> Krzysztof

-- 
Thank you,
Roman


