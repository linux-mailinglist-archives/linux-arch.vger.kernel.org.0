Return-Path: <linux-arch+bounces-10473-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D449A4A5E4
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 23:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405723AB3BF
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 22:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7F51DE4F1;
	Fri, 28 Feb 2025 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iPaqpljp"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8331DE2C4;
	Fri, 28 Feb 2025 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781619; cv=none; b=AW93kx5JNKA1JclU6GlnRXY4ejn8cP+4sPcgGVlJbcpZ+oPnjG/sKHxn1quLvFZzwbXeuslgNphNRQVZsL4zbo9QyTfedPpZ9Iva55l5ufugVxd120OQ+fpnrlz1abQpQD/9q28+qWxdodTN6trmU54iu90tnhrVKQlITS0J7BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781619; c=relaxed/simple;
	bh=EroVIw18pxTxZJ5SU7P+p+0Qd9h+XB1JAMjk4ODpyp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GcdbEu88fPtqepCZhBI5E1yKtpz5dePJoq7u+fLYJ6zdvjVnje4oPQ3IJahSy/GXP6m9L7UIhgHe6cWtuXIvoBES3E5g6hukuebd5DmH2GTqDcbhO9m61UVpOl2j89QZ6nhz5cpXUe8+pH2CSaOXFtaz+Yr1u/012Js/t/w2wrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iPaqpljp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id BB67A210D0EB;
	Fri, 28 Feb 2025 14:26:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB67A210D0EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740781618;
	bh=1A0wwVr+M5YdleD5WdQbyvCNYbPCnowwpdIat8Rx3jU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iPaqpljp0SPsYOEXK7VBrtInRVWgckeDIadHTBLILkbz6lm3ZiSAC5yniZwL98w9Q
	 F7FNXGkQStzvgrEgW0HShsyY3FA7178mzv+tFFHskRkkW3SP/1XHSFHHr1amJtB1+D
	 9HGrCNlzv6+oPzIhOR72qkgcAaskPXKU8ovhxizY=
Message-ID: <65e3bf97-8d3c-4a53-a3ad-42a16c0456d1@linux.microsoft.com>
Date: Fri, 28 Feb 2025 14:26:57 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, x86@kernel.org,
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
 <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
 <74af19c4-639f-4bcc-b667-b5f102bbb312@linux.microsoft.com>
 <8338dd00-3aa4-418f-a547-1c19623358cb@linux.microsoft.com>
 <49a69fe3-fca5-426d-999d-61ee0c8f60f3@linux.microsoft.com>
 <70b62e52-639a-4026-9a52-102d1de46ffd@linux.microsoft.com>
 <212cc582-845d-42b2-89f2-1e9579f752ec@linux.microsoft.com>
 <9254eaa1-8ff0-4dd6-a443-5f127049bdaa@linux.microsoft.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <9254eaa1-8ff0-4dd6-a443-5f127049bdaa@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/2025 12:22 PM, Easwar Hariharan wrote:
> On 2/28/2025 9:20 AM, Roman Kisel wrote:
>>

[...]

>>
>> So I'd think that the hex error codes from the hypervisor give the user
>> exactly as much as the error symbolic names do to get the system to the
>> desired state: nothing.
> I continue to disagree, seeing HV_STATUS_NO_RESOURCES is better than 0x1D,
> because the user may think to look at `top` or `free -h` or similar to see
> what could be killed to improve the situation.
> 

I agree that the symbolic name might save the step of looking up the
error code in the headers. Now, the next step depends on how much the
user is into virt technologies (if at all). That is
to illustrate the point that a hint in the logs (or in the
Documentation) is crucial of what to do next.

The symbolic name might mislead; a hex code maybe with an addition of
"please look up what may fix this at <URL> or report the problem here
<URL>" would look better to _my imaginary_ customer :) That would be
as much friendly as possible, if the kernel needs to print any of that
at all. Likely the VMM in the user land if it gets that code as-is.

Thank you for the fair critique and the time!

[...]

>>> Thanks,
>>> Easwar (he/him)
>>
> 

-- 
Thank you,
Roman


