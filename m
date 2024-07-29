Return-Path: <linux-arch+bounces-5676-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8B793FB55
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 18:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FAF01C21C64
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E4E15B999;
	Mon, 29 Jul 2024 16:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZUDmSJGE"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54569147C79;
	Mon, 29 Jul 2024 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722270829; cv=none; b=jiU2TZrdHnOTVo39WvYD2XhUj+5Rc2VAYcWtRuZHzTVJ9njDk00oJAOIu21KqLlPZY2c3Mju6pgkzqPiqrjKYyhVNa5oMT13BVhbG+iinSgQ+HiSVzY51WSh5K4r2pXTTDaV/IaQj4ijMKn+JdkerVChbucw4Afrf1N1jkGKrOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722270829; c=relaxed/simple;
	bh=wcDxgonwgoBA/zGy+67qp1P4PGEmPqKogRz1aMKHZx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCYrpV3WvskVzWwkohc5w1xvIDd/RgCYJZRiR+7mLqNifWz4KqQLWyHVdPoJ8QGIeSxQUv5JKl1DM0O0HWyiC/HwIIkT+C/Oq3NHWurLQZWIP4t/qohfRwpR930j5CMWSFnv3iTpKUt54dGi1xR/8vyg9AMhlEFmQonjSMupRSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZUDmSJGE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.186.190] (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id AEA0120B7165;
	Mon, 29 Jul 2024 09:33:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEA0120B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722270822;
	bh=Pe5a2f6xBZU/rfjsgpGCDuU34zxs5EfhIwpF9ZP48FE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZUDmSJGEKlgFu3BCYCt6kVfYlnI4eyFxaBwtFaduKGqJBCxQXD41+WwyJRuBfUrCe
	 JfuA8ynk7np8yHVAVj2LZ6OSCILEhbjKQBW7yOEQ45HdrNJyF7XhwTHeszIIV2zbZm
	 glBZOzJV3EzEJWSnBXkp6NnYrqjvD2b9++2ffHOU=
Message-ID: <e7559a1f-600b-4f7d-b17c-53fbd2920201@linux.microsoft.com>
Date: Mon, 29 Jul 2024 09:33:44 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] dt-bindings: bus: Add Hyper-V VMBus cache
 coherency and IRQs
To: Krzysztof Kozlowski <krzk@kernel.org>, arnd@arndb.de,
 bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, kw@linux.com, kys@microsoft.com, lenb@kernel.org,
 lpieralisi@kernel.org, mingo@redhat.com, rafael@kernel.org, robh@kernel.org,
 tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
 sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240726225910.1912537-1-romank@linux.microsoft.com>
 <20240726225910.1912537-6-romank@linux.microsoft.com>
 <c45516aa-3cf9-444e-8c71-f701dfd8a15b@kernel.org>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <c45516aa-3cf9-444e-8c71-f701dfd8a15b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/27/2024 1:53 AM, Krzysztof Kozlowski wrote:
> On 27/07/2024 00:59, Roman Kisel wrote:
>> Add dt-bindings for the Hyper-V VMBus DMA cache coherency
>> and interrupt specification.
>>
> 
> You did not add any bindings. I don't understand this description.
> 
My bad, extended the example for the interrupt controller node.
Will fix in the next version.

> Anyway, not tested.
> 
Understood. I didn't realize that yml goes through testing, thought it
was akin to a machine-readable portion of the documentation.

> <form letter>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
I used the "cached" version of the get_maintainers.pl output produced 
for v2. The bad assumption was that adding a yml do Documentation would 
not affect that. Will fix, appreciate helping me so much in getting this 
into a good shape!

> 
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
> 
> Please kindly resend and include all necessary To/Cc entries.
> </form letter>
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Thank you,
Roman


