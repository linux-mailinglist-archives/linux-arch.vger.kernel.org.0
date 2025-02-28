Return-Path: <linux-arch+bounces-10467-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59BDA49F17
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 17:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E703A26C8
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE771272924;
	Fri, 28 Feb 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qvq7hX3v"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8172500CD;
	Fri, 28 Feb 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760812; cv=none; b=eo9Nsb4uXIUTbA4HAk6S2aoRldV61ZBK3Yn2DJ8CHowsFgWb87VQkWQic9mOqGfdCWz+fWn/2zH+II0hXlOeXuI64e/NE9IxiDf89/LOHX3MVtmkPuKk6P5NiorO3qkvwoCJaNAAhOs338QKOCbZAym6VIzd4ZmWvP47IAXHCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760812; c=relaxed/simple;
	bh=2Pm0dsopJGfUVusd2Go+NzpJtGsYWBd+yH4fEzbLNOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bq71U46/Gu+RsacEs3Uk7creZXO8TC9iiiBun8JCy9LoNW3ydxhuHCx4iTgsNCgxKyYQhm51MmkkmFCkmNVBKsCCrzieW0UNqZfldO6sCAfzVktIZ/ZaDbyVbOeBAIrvsngp+LSo/HE/1B6IcpKc/IF8JW16klSBMdqFc7/3MXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qvq7hX3v; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 75B44210D0D5;
	Fri, 28 Feb 2025 08:40:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 75B44210D0D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740760810;
	bh=t6vW4NSGnOxnDi0VQotxMy3KX/u7aGrTt7sLX+40uF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qvq7hX3vmgvcAlM2s3ZD+rHzoKNsk7bPCxEHqpcjf3cIsKuDm49RePAi0xKglijjY
	 4yPi1ZUTnJAYR5Bclt2Frb7Vy2NW8C/oUhQQHc3TJZWwo+QqvmmLDE6vq7lKzVaO6J
	 MqXsFeBLG2Fs7Wz+dXsOtvPLCGOPdZvt9kJeTHC4=
Message-ID: <69c868f9-8bac-4bbe-ba56-832ab6a21660@linux.microsoft.com>
Date: Fri, 28 Feb 2025 08:40:10 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org
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
 <7ea741fb-9935-42f2-a4f0-99df8df563eb@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <7ea741fb-9935-42f2-a4f0-99df8df563eb@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/27/2025 4:15 PM, Nuno Das Neves wrote:
> On 2/27/2025 9:02 AM, Roman Kisel wrote:

[...]

> I guess you're implying it's not worth adding such a function for only a
> few places in the code? That is a good point, and a bit of an oversight
> on my part while editing this series. Originally all the hypercall helper
> functions in the driver code (10+ places) used this function as well, but
> I removed those printks_()s as a temporary solution to limit the use of
> printk in the driver code (as opposed to dev_printk() which is preferred).
> 
> I didn't think to remove *this* patch as a result of that change!
> I do want to figure out a good way to add that logging back to the hypercall
> helpers, so I do want to try and get some form of this patch in to aid
> debugging hypercalls - it has been very very useful over time.
> 

Right, I thought that the function looked more as a bring-up aid rather
than a full fledged solution to some problem.

>> The "Unknown" part would make debugging harder actually when something
>> fails. I presume that the mainstream scenarios all work, and it is the
>> edge cases that might fail, and these are likelier to produce "Unknown".
>>
> That is a very good point. Ideally, we could log "Unknown" along with
> the hex code instead of replacing it.
> 
> What do you think about keeping this function, but instead of using it
> directly, introduce a "standard" way for logging hypercall errors which
> can hopefully be used everywhere in the kernel?
> e.g. a simple macro:
> #define hv_hvcall_err(control, status)
> do {
> 	u64 ___status = (status);
> 	pr_err("Hypercall: %#x err: %#x : %s", (control) & 0xFFFF, hv_result(___status), hv_result_to_string(___status));
> } while (0)
> 
> I feel like this is the best of both worlds, and actually makes it even
> easier to do this logging everywhere it is wanted (for me, that includes
> all the /dev/mshv-related hypercalls).
> We could add strings for the HVCALL_ values too, and/or include __func__
> in the macro to aid in finding the context it was used in.
> 

That doesn’t seem to be common in the kernel from what I’ve seen in 
dmesg, although there is certainly a lot of appeal in that approach. 
However, we will have to remember to update the function each time when 
another status code is added not to leave things half-cooked.

Also it is a bit surprising the *kernel* should report that rather than 
the VMM from the user mode. E.g. the kernel does not report all errors 
on file open, file seek, etc. As I understand, the hv status codes are
later mapped to errno in a lossy manner, and errno is what the user mode
receives?

As long as the hex code is logged, I am fine with the change.

>> Folks who actually debug failed hypercalls rarely have issues with
>> looking up the error code, and printing "Unknown" to the log is worse
>> than a hexadecimal. Like even the people who wrote the code got nothing
>> to say about what is going on.
>>
> Yep, totally agree having the hex code available can be valuable in
> unexpected situations.
> 

Appreciate giving my concerns a thorough consideration!

-- 
Thank you,
Roman


