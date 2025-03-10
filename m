Return-Path: <linux-arch+bounces-10643-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A56DA59C0D
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 18:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F943A7EF9
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 17:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FA9233713;
	Mon, 10 Mar 2025 17:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ASdtXEiz"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A553C233703;
	Mon, 10 Mar 2025 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626359; cv=none; b=ppsWn3bquSi14YMAsXznb6HZI56yM6PEUubKU6y4YtHn6USt0DH+TJ7RWqVETqgCjMvnyW78ZSwjFIu/PjbAv4jFXWfR9TJYTKBbTjQs2r34/uoCuYG3nPHF4+1TZ00LuSSsOASBVWhR2kn9zxDEsqiZPAHdI8+Z1Vb++5fJiRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626359; c=relaxed/simple;
	bh=Yr8aJ2IZDKlLsVdnrX3O2mRmkiDeU1PvYFcf0WrFd84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skt0XEv8uxc4Vy8yXkuImlCa17ouhBhe6ARqrIggCN7RliV0ZPwazYQLGobArPgE4TWRcKWtN2rahTzvtv7kG57zEKmmDSNqOSbTYqNsDeSoC2K1g+9yXFG8Eh5T5TMia7miH5obKItQH4J8N5ze9w711kn8FXoDa7ap+J2GrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ASdtXEiz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id CA8B82038F32;
	Mon, 10 Mar 2025 10:05:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA8B82038F32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741626357;
	bh=9k2ujwCkxT/pnQt2SpcTPLQF5W45ehk16LpQKOSM9kE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ASdtXEizJBNBlir7Guq6DH/+cVwx7N/FgUmEK+XbPU0pYIqCSwEx1mx/GflRf57tm
	 MnevelamszmPc2/kut2m5GTFfDoExBbWYXR6coPOMciOGK6Yb1hRgiEuFq0zuoi++a
	 4wrrUAgnXET7zmFf32p4ObaaELCgZyEhfx4WpkTk=
Message-ID: <c7f9d861-f617-4064-8c98-2ace06e9c25e@linux.microsoft.com>
Date: Mon, 10 Mar 2025 10:05:56 -0700
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
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20250310-demonic-ferret-of-judgment-5dbdbf@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/10/2025 2:28 AM, Krzysztof Kozlowski wrote:
> On Fri, Mar 07, 2025 at 02:02:59PM -0800, Roman Kisel wrote:
>> To boot on ARM64, VMBus requires configuring interrupts. Missing
>> DMA coherence property is sub-optimal as the VMBus transations are
>> cache-coherent.
>>
>> Add interrupts to be able to boot on ARM64. Add DMA coherence to
>> avoid doing extra work on maintaining caches on ARM64.
> 
> How do you add it?
> 

I added properties to the node. Should I fix the description, or I am
misunderstanding the question?

>>
>> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
>> ---
>>   .../devicetree/bindings/bus/microsoft,vmbus.yaml          | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
>> index a8d40c766dcd..3ab7d0116626 100644
>> --- a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
>> +++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
>> @@ -28,13 +28,16 @@ properties:
>>   required:
>>     - compatible
>>     - ranges
>> +  - interrupts
>>     - '#address-cells'
>>     - '#size-cells'
>>   
>> -additionalProperties: false
>> +additionalProperties: true
> 
> This is neither explained in commit msg nor correct.
> 

Not explained, as there is no good explanation as described below.

> Drop the change. You cannot have device bindings ending with 'true'
> here - see talks, example-bindings, writing-schema and whatever resource
> is there.
> 

Thanks, I'll put more effort into bringing this into a better form!
If you have time, could you comment on the below?

The Documentation says

   * additionalProperties: true
     Rare case, used for schemas implementing common set of properties.
Such schemas are supposed to be referenced by other schemas, which then 
use 'unevaluatedProperties: false'.  Typically bus or common-part schemas.

This is a bus so I added that line to the YAML, and I saw it in many
other YAML files. Without that line, there was a warning from the local
DT validation described in the Documentation about not having pin
controls which was weird, and adding

"additionalProperties: true"

fixed the warnings (didn't debug much though). As a side note, there was
a similar warning coming from another YAML during running DT schema
validation as described in the Documentation so maybe warnings are fine.

> Best regards,
> Krzysztof
> 

-- 
Thank you,
Roman


