Return-Path: <linux-arch+bounces-11922-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C13E6AB59E5
	for <lists+linux-arch@lfdr.de>; Tue, 13 May 2025 18:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA8D1B64B77
	for <lists+linux-arch@lfdr.de>; Tue, 13 May 2025 16:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2D126BF7;
	Tue, 13 May 2025 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PxGNd/Dd"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0305979D0;
	Tue, 13 May 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153898; cv=none; b=f9d5Yc2wpuKYU5cPuDlTnwDqf626SyCfsmEtdj40/0FRGJ6X6w6PrGyXGo7u5W7wXdXy0IXUOH5VzaNO90Xz3/YaOjlhtrD0cAIUqMk8dlhP7NgNRmB4DWLsB+H/N9f+zsLQhPk++wLcaLPcwtCJknwE+Ux7j5lZDAZDdxsOmVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153898; c=relaxed/simple;
	bh=aBUoZJFpEpmEz0s0BhTVSS3PEUvzBXAhyJZAXhfePm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jjIvkWtYnXZoU10fYtFSxYKQQIxk792QWx0rJlaePKFWM9s7Wu2q7CkHJVHsWoH4hTvfZe/74wioODA/b21LLOE+YT5yAYSuTtzgnYp7PANtRlE5HjYmcjxXe5Xi5jltcvkwR7XhBxWcsnNnj91X2ivy9W1kmFOgrs6+777A55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PxGNd/Dd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5B716201DB28;
	Tue, 13 May 2025 09:31:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5B716201DB28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747153896;
	bh=xeNP9qTG4NblI43yV9gDsR1NWq0U1vL5VHxMC8sh8Ak=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PxGNd/DdbrmBW7NsLSjWGWpIQwTV5jQXEIrAyEsEvUtoZo91/T7H8HFZ5U+7WAKE8
	 e/EgCpq2DQYeg+7CgV4P+eS2XizEApZfcH24R6hkNyEoAmvcRya+7SItd9iodwFLNI
	 Z66jY48yWnl7EOg9vSwruk0X6yHKwqaeLDB0bAdA=
Message-ID: <a7ad48ca-2346-4039-a3a9-f93317b2d1a1@linux.microsoft.com>
Date: Tue, 13 May 2025 09:31:36 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v2 3/4] arch: hyperv: Get/set SynIC
 synth.registers via paravisor
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com, arnd@arndb.de, bp@alien8.de,
 catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 kys@microsoft.com, mingo@redhat.com, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
References: <20250511230758.160674-1-romank@linux.microsoft.com>
 <20250511230758.160674-4-romank@linux.microsoft.com>
 <323ecc55-d829-4c74-8cb6-7b3a77dd3351@oracle.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <323ecc55-d829-4c74-8cb6-7b3a77dd3351@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/12/2025 2:39 AM, ALOK TIWARI wrote:
> 
> 
> On 12-05-2025 04:37, Roman Kisel wrote:
>> +/*
>> + * Not every paravisor supports getting SynIC registers, and
>> + * this function may fail. The caller has to make sure that this 
>> function
>> + * runs on the CPU of interest.
>> + */
> 
> Title and Intent: Clearly state the purpose of the function in the first 
> sentence
> /*
>   * Attempt to get the SynIC register value.
>   *
>   * Not all paravisors support reading SynIC registers, so this function
>   * may fail. The caller must ensure that it is executed on the target
>   * CPU.
>   *
>   * Returns: The SynIC register value or ~0ULL on failure.
>   * Sets err to -ENODEV if the provided register is not a valid SynIC
>   * MSR.
>   */
> 
>> +u64 hv_pv_get_synic_register(unsigned int reg, int *err)
>> +{
>> +    if (!hv_is_synic_msr(reg)) {
>> +        *err = -ENODEV;
>> +        return !0ULL;
>> +    }
>> +    return native_read_msr_safe(reg, err);
>> +}
>> +EXPORT_SYMBOL_GPL(hv_pv_get_synic_register);
>> +
>> +/*
>> + * Not every paravisor supports setting SynIC registers, and
>> + * this function may fail. The caller has to make sure that this 
>> function
>> + * runs on the CPU of interest.
>> + */
> 
> ditto.
> 
>> +int hv_pv_set_synic_register(unsigned int reg, u64 val)
>> +{
>> +    if (!hv_is_synic_msr(reg))
>> +        return -ENODEV;
>> +    return wrmsrl_safe(reg, val);
>> +}
>> +EXPORT_SYMBOL_GPL(hv_pv_set_synic_register);
> 

Indeed, I wrote a bit of a novel in the comments which might be
distracting and making it harder to find the point :)

Ought to be more conscious of the reader's perhaps constrained
time budget. I'll restructure that as you suggested!

> Thanks,
> Alok
> 

-- 
Thank you,
Roman


