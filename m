Return-Path: <linux-arch+bounces-10442-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B42A48C0B
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 23:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6DA16D4C2
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 22:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584C1227B8E;
	Thu, 27 Feb 2025 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hWbxuV9P"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56F427781F;
	Thu, 27 Feb 2025 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696873; cv=none; b=uCNiokyU5o1nh8cEgs/kcCEuiwcbF1aqYeHQ0o9XaX3d3yEH5kE2lhmDloKaeJq0C1v598KIXG61UKRZOyo3WXyNOdw+TYpdLJom6F5Bu6w6VfSzw2O0pCImLzpICPU+KY6oLd3jZI+xyBcxUJoDYbvCi9aOOKQYCofa+/CwhDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696873; c=relaxed/simple;
	bh=RuA59ClwIqQKbbK7C7kTIuq0JiW34Kv6jLeLH44Uv24=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oj8lWSsnoC2eSeSi/UeQ5AMo+ieRiB7uEwLtmMTYCeKv9QnieCXXZdOjZ8m0DUZtKx3+2bKHIhaguQ94F9q/kdVScna6UcbsYUAcz/EGwcGpNDZQQ731thW/SuCwrJprRM7K02yJ6viBzLVcfcaOdLI86F8wuQBe663IKl3JKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hWbxuV9P; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id 710C3210EAC0;
	Thu, 27 Feb 2025 14:54:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 710C3210EAC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740696871;
	bh=N9e9a8/heH4xuMeTDXGwYikxUbMHl5ORfY3Jz5KULqs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=hWbxuV9PupeHKuyO0Jlff9XgGej1tmlh9xoKKaLTJxZtVX5L3mKrFgoqXUYmhbxPD
	 vPwYqUasVmrF46RL++TMuFhde996cZq4lthnz06yokTUCjvCx7MUfWWgxBWCg+pr2z
	 vGdAotzlyZ6VMqEWaU+OwG9CiA1heCNEpHQ425NU=
Message-ID: <8338dd00-3aa4-418f-a547-1c19623358cb@linux.microsoft.com>
Date: Thu, 27 Feb 2025 14:54:29 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
 eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 arnd@arndb.de, jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
To: Roman Kisel <romank@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
 <74af19c4-639f-4bcc-b667-b5f102bbb312@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
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
> The "Unknown" part would make debugging harder actually when something
> fails. I presume that the mainstream scenarios all work, and it is the
> edge cases that might fail, and these are likelier to produce "Unknown".
> 
> Folks who actually debug failed hypercalls rarely have issues with
> looking up the error code, and printing "Unknown" to the log is worse
> than a hexadecimal. Like even the people who wrote the code got nothing
> to say about what is going on.
> 

Sorry, I have to disagree with this, a recent commit of mine[1] closed a WSL
issue that was open for over 2 years for, partly, the utter uselessness of
the hex return code of the hypercall.

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d2138eab8cde61e0e6f62d0713e45202e8457d6d

Thanks,
Easwar (he/him)

