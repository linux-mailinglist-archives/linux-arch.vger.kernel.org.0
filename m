Return-Path: <linux-arch+bounces-10449-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342FA48CBD
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D11831890854
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 23:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769A2276D0C;
	Thu, 27 Feb 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nUZ5Sq2w"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14431276D02;
	Thu, 27 Feb 2025 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740698721; cv=none; b=MsVumVbrnW9xvc2MQ/XBdH7yVBjAMiOwPrjipdT8mz0Peh7oEGwQYyXVURjK4DyFH1X4nrvaCs4NyVGsYyzbVkO8G8TAu/w7/yfdWsbSXpQkCPj9NEfkaM9NBAQjDYeqEMBQ4RuRI491GceaGVcnis5YknrPjTacaiqsqkiIMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740698721; c=relaxed/simple;
	bh=G16hnuKykWl9QjERQ1K9zZ2Wx2FtcPK/i/Z5ELkK3ok=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IGUxCyYrnvS8drgUiRCPv2XNPl9H5SLjfDyM1Ga1FH3Q+h4CCPboIvSgfBCIHOrg+ozRmwNHURKe0pqDIe0b1wShfAz+W+GJ+Gbqg/r3vxs7paEXKnhafdoP1dhgweLp20Y+AMobTq+eAJHZoyzx2r7msiFdQ6XILejoKO3Vki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nUZ5Sq2w; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id A30CA210EAC0;
	Thu, 27 Feb 2025 15:25:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A30CA210EAC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740698719;
	bh=6R/d69xIPnatoLajwtN5SPNB03Ui7q2MxXbR43k6h6A=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=nUZ5Sq2woTZNa8bIOcVxHVzfj8fnmzJRFv8NcRJhxl7FGKh1FFsM5eMjQkaoK7hz7
	 3M2gjH6gsVfCr3K1Q2F3CZ5tmXjF7N557dC2trMTS+9aTnpNsCkirzR640o1v4r9nb
	 qoy7McOe2AL7Peg/quv8CSv5fL/iZfV0ryBMdo5s=
Message-ID: <70b62e52-639a-4026-9a52-102d1de46ffd@linux.microsoft.com>
Date: Thu, 27 Feb 2025 15:25:17 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
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
Subject: Re: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
To: Roman Kisel <romank@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
 <74af19c4-639f-4bcc-b667-b5f102bbb312@linux.microsoft.com>
 <8338dd00-3aa4-418f-a547-1c19623358cb@linux.microsoft.com>
 <49a69fe3-fca5-426d-999d-61ee0c8f60f3@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <49a69fe3-fca5-426d-999d-61ee0c8f60f3@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/27/2025 3:08 PM, Roman Kisel wrote:
> 
> 
> On 2/27/2025 2:54 PM, Easwar Hariharan wrote:
> [...]
> 
>>
>> Sorry, I have to disagree with this, a recent commit of mine[1] closed a WSL
>> issue that was open for over 2 years for, partly, the utter uselessness of
>> the hex return code of the hypercall.
> 
> Thanks for your efforts, and sorry to hear you had a frustrating
> debugging experience (sounds like it).

TBF, I didn't personally struggle with it for 2 years, IMHO, it was the opaqueness
of what the value meant that contributed to user pain.

> 
> Would be great to learn the details to understand how this function is
> going to improve the situation:
> 
> 1. How come the hex error code was useless, what is not matching
>    anything in the Linux headers?

It doesn't match anything in the Linux headers, but it's an NTSTATUS, not HVSTATUS.

Coming from the PoV of a user, it would be a much more useful message to see:

[  249.512760] hv_storvsc fd1d2cbd-ce7c-535c-966b-eb5f811c95f0: tag#683 cmd 0x28 status: scsi 0x2 srb 0x4 hv STATUS_UNSUCCESSFUL

than 

[  249.512760] hv_storvsc fd1d2cbd-ce7c-535c-966b-eb5f811c95f0: tag#683 cmd 0x28 status: scsi 0x2 srb 0x4 hv 0xc0000001

> 2. How having "Unknown" in the log can possibly be better?

IMHO, seeing "Unknown" in an error report means that there's a new return value
that needs to be mapped to errno in hv_status_to_errno() and updated here as well.

> 3. Given that the select hv status codes and the proposed strings have
>    1:1 correspondence, and there is the 1:N catch-all case for the
>    "Unknown", how's that better?
> 

I didn't really follow this question, but I suppose the answer to Q2 answers this as
well. If not, please expand and I'll try to answer.

Thanks,
Easwar (he/him)

