Return-Path: <linux-arch+bounces-10269-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D04A3E71F
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 22:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF4F3BBF58
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 21:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071612641C4;
	Thu, 20 Feb 2025 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ezAm1HEF"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9361026389E;
	Thu, 20 Feb 2025 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740088759; cv=none; b=KCAYGgDs6maEho1wC012sgC4Eu/17JVDubIsuf6eF89zEJvTEf3yXRSThyLUnExe6mhs2T74yXs5ic/NkEXeERhhPZaR8eq/gyukc6gZ113bTP4bcU0U2QDK/I/cJSEVKiL8lq80vH17XQSp99p1WtDesuG+F8vgKSLshuhRgUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740088759; c=relaxed/simple;
	bh=lQKrO7hRKFvPkXPOhro0RocDZUoQobXxB5LLeWKhcsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSiQao/DhpgUbbZX/aEZOS7REMUJ/tNzpqu8eCzgGEUjHwK/vYkXriQiAmTiQV4kMJp2jCKQNOxy4BgePxIh4TLQjhHrxMWHsA5LtOaPoYsziPzG+wzPDgodF5+AmnyZEo5W67BAhCn4DmVs+m0YfZjWa9S36uGYdYA9/6rmjXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ezAm1HEF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id CDBD4203E3BD;
	Thu, 20 Feb 2025 13:59:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CDBD4203E3BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740088758;
	bh=FEsnSqX4vmc2Vw8nrvOl5pCsw/4QZ5ESc75P84YC+hE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ezAm1HEF4gHOeMlOP+6fjyF88pVNvPb+9hwXxCsEMZQF7E3Xw8Vs7i9jy8hMdF30Y
	 haKY/m7as+ywuX/onzx/6pTONyW1O2zzb7iD5uPu8EdntHmTzzhBCugHRKIcrDyhj7
	 YCct5mJmmRerGCWdus3URuo7aU+wFC+C3pn9H0eA=
Message-ID: <61b11926-3e85-4fd5-92a9-ca7c7e4b4c7c@linux.microsoft.com>
Date: Thu, 20 Feb 2025 13:59:17 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] hyperv: Convert hypercall statuses to linux error
 codes
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, mhklinux@outlook.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, daniel.lezcano@linaro.org, joro@8bytes.org,
 robin.murphy@arm.com, arnd@arndb.de, jinankjain@linux.microsoft.com,
 muminulrussell@gmail.com, skinsburskii@linux.microsoft.com,
 mukeshrathor@microsoft.com
References: <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740076396-15086-2-git-send-email-nunodasneves@linux.microsoft.com>
 <b4887ddf-a296-4f2b-8fb8-a5f9c681142a@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <b4887ddf-a296-4f2b-8fb8-a5f9c681142a@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/2025 10:49 AM, Easwar Hariharan wrote:
> On 2/20/2025 10:33 AM, Nuno Das Neves wrote:
>> Return linux-friendly error codes from hypercall helper functions,
>> which allows them to be used more flexibly.
>>
>> Introduce hv_result_to_errno() for this purpose, which also handles
>> the special value U64_MAX returned from hv_do_hypercall().
>>
>> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>> ---
>>  drivers/hv/hv_common.c         | 34 ++++++++++++++++++++++++++++++++++
>>  drivers/hv/hv_proc.c           |  6 +++---
>>  include/asm-generic/mshyperv.h |  1 +
>>  3 files changed, 38 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
>> index ee3083937b4f..2120aead98d9 100644
>> --- a/drivers/hv/hv_common.c
>> +++ b/drivers/hv/hv_common.c
>> @@ -683,3 +683,37 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
>>  	return HV_STATUS_INVALID_PARAMETER;
>>  }
>>  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
>> +
>> +/* Convert a hypercall result into a linux-friendly error code. */
>> +int hv_result_to_errno(u64 status)
>> +{
>> +	/* hv_do_hypercall() may return U64_MAX, hypercalls aren't possible */
>> +	if (unlikely(status == U64_MAX))
>> +		return -EOPNOTSUPP;
>> +	/*
>> +	 * A failed hypercall is usually only recoverable (or loggable) near
>> +	 * the call site where the HV_STATUS_* code is known. So the errno
>> +	 * it gets converted to is not too useful further up the stack.
>> +	 * Provice a few mappings that could be useful, and revert to -EIO
> 
> Typo: Provide
> 
Yep, looks like there will be a v3, I'll fix it there.
Thanks for the review!

> Otherwise, looks good to me.
> 
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> 
> Thanks,
> Easwar (he/him)


