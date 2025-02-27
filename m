Return-Path: <linux-arch+bounces-10445-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C207A48C6E
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 00:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DA516C230
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 23:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BE323E35A;
	Thu, 27 Feb 2025 23:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GVDOlEPT"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3132C23E34E;
	Thu, 27 Feb 2025 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740697727; cv=none; b=C/Etl09hNl5KI5P9ChH8hVDCKHfBi/HjGYzD+XUfJw5jezZfX0uYYQFQhS2gULdsXlAbt2fFOtDSbA+ZhcCtSoEJuhcqnv2cbSErVU+AtDUPzE0m6f57uUZK76wZTuK5FNADtmJfDljRrYrdfIue/Fie1pYYaWf/WjrSIiIu/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740697727; c=relaxed/simple;
	bh=PZcXt2MzmIOD5ThvbAUvWdxsdkwQ+yVhj9303HPTuq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiIgcUaBiKZL9xdibbgg3u+41AeC1eu4ojFxmypJDq0o4GLvF7ZHiavqrQLc3UCoWDCqwHnUBzIbtPcTBJ0ciMZu/R4vxcJfzvSb2baX3XpvtEshAZ36imd+exMitP9kGoOM7zf+wUGu0buwcfThaA31av7W3R6/3CgvDr7OdoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GVDOlEPT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5037E210EAC0;
	Thu, 27 Feb 2025 15:08:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5037E210EAC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740697725;
	bh=zYskf4Q6IOL04q9jyqtfU8Zgdvew2yriJ3Ik8GT2/Z0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GVDOlEPTyz3LD9fsfIPoqV+r6EmceZBi0lZLEjt/esvDYSWBzJjxwDfhA40k7eLd+
	 0K0FXz2Kavl7vHD5TLQAvsxN/qTlo/ZLEwepIXxhd+v+y1mh/0ohhhVwfX9M2yKbDK
	 HIizPi+oz4D9ih/ptnOZGFMknxlWUe66k2Iq4mt0=
Message-ID: <49a69fe3-fca5-426d-999d-61ee0c8f60f3@linux.microsoft.com>
Date: Thu, 27 Feb 2025 15:08:45 -0800
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
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <8338dd00-3aa4-418f-a547-1c19623358cb@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/2025 2:54 PM, Easwar Hariharan wrote:
[...]

> 
> Sorry, I have to disagree with this, a recent commit of mine[1] closed a WSL
> issue that was open for over 2 years for, partly, the utter uselessness of
> the hex return code of the hypercall.

Thanks for your efforts, and sorry to hear you had a frustrating
debugging experience (sounds like it).

Would be great to learn the details to understand how this function is
going to improve the situation:

1. How come the hex error code was useless, what is not matching
    anything in the Linux headers?
2. How having "Unknown" in the log can possibly be better?
3. Given that the select hv status codes and the proposed strings have
    1:1 correspondence, and there is the 1:N catch-all case for the
    "Unknown", how's that better?

> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d2138eab8cde61e0e6f62d0713e45202e8457d6d
> 
> Thanks,
> Easwar (he/him)

-- 
Thank you,
Roman


