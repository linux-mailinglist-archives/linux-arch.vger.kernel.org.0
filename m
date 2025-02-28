Return-Path: <linux-arch+bounces-10452-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B9CA48D15
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 01:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FEBD3AC83E
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4D3184F;
	Fri, 28 Feb 2025 00:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Bhv8kHy+"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7028380;
	Fri, 28 Feb 2025 00:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740701739; cv=none; b=ZogePR5QjarGTnPjteDGNcqFD3IFrNgq6zBpgMv+giUGkQrz4Zg5Uax1KGcaOy0jFyBkXEe2ttu+icy8lYedd1mvzFZypmBuKnpQswAbo78rV+4cCVo7gOvwha8Xmmk9En96A5QeV6sps3No8PIhlHyXMR8KwER6PHjTCmDQQ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740701739; c=relaxed/simple;
	bh=nXrcUtirXrnTVC0iG1kClgB79FD9SRjOMfr0a8C0fbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SvIpeyFGk4KLBW9nDOSMSWHqCRPjYeABQqf28RgcWHImsx6WITbm3qDuFDl/7mafMIiCUVw5XeLhEytBXzdNocd3x2h+9fZ06aimH/49ADAbWAa80VvlT3w0u5XJxGX+WRIXNtbh+yuaFOWT0KS+552qAFSP3ChDliC5G8cG1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Bhv8kHy+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 74A76210EAC2;
	Thu, 27 Feb 2025 16:15:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74A76210EAC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740701737;
	bh=/0FduMPXpF7odq2DR/Ozy+31RaB9icS1pf1FrxFmkKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Bhv8kHy+sgZqzC2QNGG4nkBJZmft7Ae7dPdAa+GFHwR1Y70qp9IFzmSOPqN67MuVQ
	 /Ig2XSXEsKwDNj83vkk5MSOUt2pKbARSLpttnbYR2YKRgUXbUBGMt6DNw0ILfTO2GI
	 o8FAi6neeKcLAEDBGoTLk6TGaC2VoExZGyxFKV3o=
Message-ID: <7ea741fb-9935-42f2-a4f0-99df8df563eb@linux.microsoft.com>
Date: Thu, 27 Feb 2025 16:15:35 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
To: Roman Kisel <romank@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
 will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
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
 <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
 <74af19c4-639f-4bcc-b667-b5f102bbb312@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <74af19c4-639f-4bcc-b667-b5f102bbb312@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/27/2025 9:02 AM, Roman Kisel wrote:
> 
> 
> On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
> 
> [...]
> 
>> +
>> +const char *hv_result_to_string(u64 hv_status)
>> +{
>> +    switch (hv_result(hv_status)) {
> 
> [...]
> 
>> +        return "HV_STATUS_VTL_ALREADY_ENABLED";
>> +    default:
>> +        return "Unknown";
>> +    };
>> +    return "Unknown";
>> +}
>> +EXPORT_SYMBOL_GPL(hv_result_to_string);
> 
> Should we remove this and output the hexadecimal error code in ~3 places
> this function is used?
> 
I guess you're implying it's not worth adding such a function for only a
few places in the code? That is a good point, and a bit of an oversight
on my part while editing this series. Originally all the hypercall helper
functions in the driver code (10+ places) used this function as well, but
I removed those printks_()s as a temporary solution to limit the use of
printk in the driver code (as opposed to dev_printk() which is preferred).

I didn't think to remove *this* patch as a result of that change!
I do want to figure out a good way to add that logging back to the hypercall
helpers, so I do want to try and get some form of this patch in to aid
debugging hypercalls - it has been very very useful over time.

> The "Unknown" part would make debugging harder actually when something
> fails. I presume that the mainstream scenarios all work, and it is the
> edge cases that might fail, and these are likelier to produce "Unknown".
> 
That is a very good point. Ideally, we could log "Unknown" along with
the hex code instead of replacing it.

What do you think about keeping this function, but instead of using it
directly, introduce a "standard" way for logging hypercall errors which
can hopefully be used everywhere in the kernel?
e.g. a simple macro:
#define hv_hvcall_err(control, status)
do {
	u64 ___status = (status);
	pr_err("Hypercall: %#x err: %#x : %s", (control) & 0xFFFF, hv_result(___status), hv_result_to_string(___status));
} while (0)

I feel like this is the best of both worlds, and actually makes it even
easier to do this logging everywhere it is wanted (for me, that includes
all the /dev/mshv-related hypercalls).
We could add strings for the HVCALL_ values too, and/or include __func__
in the macro to aid in finding the context it was used in.

> Folks who actually debug failed hypercalls rarely have issues with
> looking up the error code, and printing "Unknown" to the log is worse
> than a hexadecimal. Like even the people who wrote the code got nothing
> to say about what is going on.
> 
Yep, totally agree having the hex code available can be valuable in
unexpected situations.


