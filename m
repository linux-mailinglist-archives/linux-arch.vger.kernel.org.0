Return-Path: <linux-arch+bounces-14979-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B5EC7291E
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 08:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A6A8E2F8EB
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 07:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5F3302CBD;
	Thu, 20 Nov 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb6ActO4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CE372AA1;
	Thu, 20 Nov 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623272; cv=none; b=WOTjKHEDtbsE40zDET/KmtXgfPNXOG1LEWSgj4+hYYTNa9tdr8eEI/7MIu3VOMap/CdCbzzXYtprXPJNHNNKkIw6W9BSqwqKjYMfWKhffY2BJ9x+6y/DGXrUBIAaSLZvwnd2ABSHFO2WRdACc5/k1CFajmYSBxW/XzxikX+HOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623272; c=relaxed/simple;
	bh=Q9x7pfr68ABlQkeGDOQXfTv4u0y1Q9ao0HbtlLeZBks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8G1KECx4JYF0ZzO1ftXXaDkqdQ+SagpOMeUrSavoPmI+BXaw7Z1S4NORPS/wlR4yvUM8PpgHraCSEcshQxSssVqxuGwCsCgUC4C70WpRWqh3OJ4aLoF1p8Uz8SxrBoQC6RFP9lHEOW5+Bh5jzUi3ctUl9QwD89CeQHxnsUDYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb6ActO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED68C4CEF1;
	Thu, 20 Nov 2025 07:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763623271;
	bh=Q9x7pfr68ABlQkeGDOQXfTv4u0y1Q9ao0HbtlLeZBks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nb6ActO4kn5WR22MgZjBWnEhix29+SAXSkzvBaTiYlthZrhPeDL2UyotiI4/dFl3G
	 CifRWjVgR+IJPR1LDUCi/XQzpU3AP2TnzTk7P0jgZwbG7vNm8sQquNWtMFl+/om2Tb
	 LxYHzl8vQQELTJQb7NnXh80mV/vTTRhBUBxXHc7+lcavP0TtPpsXyKrQtj3bBODjAx
	 +HgdU2zRDeqKOoI5hiFt9a9mKAt9tZ58Lp83ZEibBiIP16VJNgbSspvaUazIqEQESj
	 87GBtLVfJZnjF+CR/0M18mx8sy7KXThc3JEI/6owWCwr6ZgohZQpRMi9pI15uksJ2M
	 NQSikIjacL0WA==
Message-ID: <c503061b-00cc-4d04-8380-3a0fe0a2c788@kernel.org>
Date: Thu, 20 Nov 2025 08:21:04 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/26] dt-bindings: reserved-memory: Add Google Kinfo
 Pixel reserved memory
To: Eugen Hristev <eugen.hristev@linaro.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com, rdunlap@infradead.org,
 corbet@lwn.net, david@redhat.com, mhocko@suse.com
Cc: tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 jonechou@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119154427.1033475-26-eugen.hristev@linaro.org>
 <e73bdb23-c27b-4a18-b7e3-942f2d40b726@kernel.org>
 <060e7412-8f1f-4d31-af39-79213c560e85@linaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <060e7412-8f1f-4d31-af39-79213c560e85@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/11/2025 17:19, Eugen Hristev wrote:
> 
> 
> On 11/19/25 18:02, Krzysztof Kozlowski wrote:
>> On 19/11/2025 16:44, Eugen Hristev wrote:
>>> Add documentation for Google Kinfo Pixel reserved memory area.
>>
>> Above and commit msg describe something completely else than binding. In
>> the binding you described kinfo Linux driver, above you suggest this is
>> some sort of reserved memory.
>>
>>>
>>> Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
>>> ---
>>>  .../reserved-memory/google,kinfo.yaml         | 49 +++++++++++++++++++
>>>  MAINTAINERS                                   |  5 ++
>>>  2 files changed, 54 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml b/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
>>> new file mode 100644
>>> index 000000000000..12d0b2815c02
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/reserved-memory/google,kinfo.yaml
>>> @@ -0,0 +1,49 @@
>>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/reserved-memory/google,kinfo.yaml#
>>
>> Filename based on the compatible.
>>
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Google Pixel Kinfo reserved memory
>>> +
>>> +maintainers:
>>> +  - Eugen Hristev <eugen.hristev@linaro.org>
>>> +
>>> +description:
>>> +  This binding describes the Google Pixel Kinfo reserved memory, a region
>>
>> Don't use "This binding", but please describe here hardware.
>>
>>> +  of reserved-memory used to store data for firmware/bootloader on the Pixel
>>> +  platform. The data stored is debugging information on the running kernel.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - const: google,kinfo
>>> +
>>> +  memory-region:
>>> +    maxItems: 1
>>> +    description: Reference to the reserved-memory for the data
>>
>> This does not match description. Unfortunately it looks like you added a
>> node just to instantiate Linux driver and this is not allowed.
>>
>> If this was some special reserved memory region, then it would be part
>> of reserved memory bindings - see reserved-memory directory.
> 
> I sent this patch for reserved-memory directory, where all the
> reserved-memory bindings reside. Or maybe I do not understand your
> comment ?>

There is no ref to reserved memory here. Please look first how reserved
memory bindings are written,

>> Compatible suggests that it is purely Linux driver, so another hint.
> 
> This reserved memory area is used by both Linux and firmware. Linux
> stores some information into this reserved memory to be used by the
> firmware/bootloader in some specific scenarios (e.g. crash or recovery
> situations)
> As the firmware reserves this memory for this specific purpose, it is
> natural to inform Linux that the memory should not be used by another
> purpose, but by the purpose it was reserved for.

But you did not write bindings for it. You wrote bindings for Linux
device driver, I already explained that last time.

> Which would be the best way to have Linux understand where is this
> memory area so it could be handled?


> 
> 
>>
>> Looks like this is a SoC specific thing, so maybe this should be folded
>> in some of the soc drivers.
>>
> Not really soc specific. Any soc who implements this at firmware level
> can use it. The firmware can reserve some memory for this specific
> purpose and then pass it to Linux, so Linux can fill it up.
> It just happens that the Pixel phone has this implemented right now, but
> it is not constrained to Pixel only.
> 
> Instantiating this driver with a call like platform_device_register_data
> would make the driver unaware of where exactly the firmware looks for
> the data. This is right now passed through the DT node. Do you have a
> better suggestion on how to pass it ?

I do not see how this question is relevant here. I don't care how you
pass it to the driver, because we discuss bindings. You created bindings
for Linux driver and that's a no. If you wanted that, I suggests that it
could be instantiated by some other driver, but sure - we don't have to
go that way, that was just an idea how to solve the problem bindings
like this cannot be accepted.

Best regards,
Krzysztof

