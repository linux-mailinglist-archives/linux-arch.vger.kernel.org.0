Return-Path: <linux-arch+bounces-10646-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F670A59D57
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 18:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF63518890EE
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 17:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3CA230BF8;
	Mon, 10 Mar 2025 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DCvJlH7l"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0A322154C;
	Mon, 10 Mar 2025 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627204; cv=none; b=SNE2bwHJE2otYWjO1Of1vShFea+2mnR9HZxPsOzrbP7D33CSE6cLjUgKScNjjnSlzEfQLiw+JQeXh+aASWt99YJLGznnqLiJHF93nNtr/qJVAEQIgMe5eFNwXbGKFveWh/rRF0z+cBoGbBQCBCcLA+1y136AXSfH8lQSfp/BPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627204; c=relaxed/simple;
	bh=/YXMvkcQ/GzyTRwquiLmoSYe6UojhZjW60zM2YXCe5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvDBn/Fij6uVx+u58AxCK//hhMYM8sfehjjDl1jtCziFLs6cugJubajaQ8lec7IqHea6CxDTPAshFI20krUI0QBXhV96kM9YAF+uelpAHuBuKBvBHzY3qoNSpYnasNUc656UbSv/ZY5b4bBPqMspEBZ6gBc8f5YM3q3BfPxZu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DCvJlH7l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id B693E2038F31;
	Mon, 10 Mar 2025 10:20:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B693E2038F31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741627203;
	bh=13DS2/TB/IXIH8xoTGEcQtgWmxhNupVcmk4y3r8tsVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DCvJlH7lbXZNt/E1m1ad8ZjehpHPz1EJUOHWNCbySluNx0imTgB0IvFntVbtpwLYj
	 5U4GwnENiBtd6A89KwSCOFeva6PjIT8utJ1CXa7p1OlsNSKqDuXfP2bHCkSiQ444ZW
	 JquC4aUWaAMFvwW2v15oYkJg5ul0DQ4IvSj6xERw=
Message-ID: <ce6f5bb0-545f-4d9f-a792-29a2f1520ba8@linux.microsoft.com>
Date: Mon, 10 Mar 2025 10:20:02 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v5 06/11] arm64, x86: hyperv: Report the VTL
 the system boots in
To: Wei Liu <wei.liu@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com,
 lenb@kernel.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 mark.rutland@arm.com, maz@kernel.org, mingo@redhat.com,
 oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org,
 ssengar@linux.microsoft.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
 tglx@linutronix.de, will@kernel.org, yuzenghui@huawei.com,
 devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-7-romank@linux.microsoft.com>
 <Z84yyAqkqJ2ZyAd-@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
 <2342dda1-2976-4506-ab68-640739a1bd5b@linux.microsoft.com>
 <Z88Y-R7BnXa4Xi3I@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <Z88Y-R7BnXa4Xi3I@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/10/2025 9:53 AM, Wei Liu wrote:
> On Mon, Mar 10, 2025 at 09:42:15AM -0700, Roman Kisel wrote:

[...]

>>
>>> Please be consistent across different architectures.
>>>
>>
>> In the earlier versions of the patch series, I had that piece
>> from the above mirrored in the arm64, and there was advice on
>> removing the function as it contained just one statement.
>> I'll revisit the approach, thanks for your help!
> 
> As long as the output is consistent across different architectures, I'm
> good.

I should add a comment most likely to save people some time grepping
the code as the line does look like should always print that. IOW
not printing for VTL0 is obscured by the preprocessor/#define cruft.

> 
> Wei.
> 
>>
>>>>    	x86_platform.realmode_reserve = x86_init_noop;
>>>>    	x86_platform.realmode_init = x86_init_noop;
>>>> -- 
>>>> 2.43.0
>>>>
>>>>
>>
>> -- 
>> Thank you,
>> Roman
>>

-- 
Thank you,
Roman


