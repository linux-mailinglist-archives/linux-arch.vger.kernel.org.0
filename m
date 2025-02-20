Return-Path: <linux-arch+bounces-10260-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964E5A3E434
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 19:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA163A6105
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 18:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D96C263892;
	Thu, 20 Feb 2025 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D/9s01lZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23403262D3F;
	Thu, 20 Feb 2025 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077394; cv=none; b=av3/50Pg40DUFM44QnVyrxyBLKC0o+A91EV6tvagOSoiVL0ulXUUR2FZ04Yris9tixfdvy6PIgDdAYKHRjkqJkAgg/Q7mQFnaMKHc6J7DvRiLxJ4i0gvY7M/cll0UepGEzkcN40YJAsPSbR70+JaKGUT2mRO46Dkndnzu0MVi0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077394; c=relaxed/simple;
	bh=kSCU9+JquK/2OpXpdUctnlfeQrwtWLB/Kldpw5JpKqo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F4KMX+Blbu6ggpMTTEzAqLHFi30/lEL0t7VsSpjN1sk8Gsua/6HpJ0G5wpsipY1tO9mqLT3NYmKlnkTFCTMAUXZVmqI0pwl9McyzNpzaiQQw74Z5ekMtYU0Kzlztup9FziKVKUXQJvXA4XvkK7ydRbKVTo/RGeA/vdnmDGwETbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D/9s01lZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id E8FE220376ED;
	Thu, 20 Feb 2025 10:49:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E8FE220376ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740077392;
	bh=44SQwiHPIB0p5JuEwqgKZPx20bgpKG8Sxk5d1VuRkDw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=D/9s01lZbEfNAXBA6vnFq2qMTsGAlER5Os9YgpIO7tp7mr1gQY4FXKIIfkZS2jFVI
	 M8OnVSdBMRK0ODt29c883pq0a0EAx2KjQZR7GW2Ax1PoFr2y12hdiAFLxYBNvl135t
	 KDbIyIeby2C2Myqf4GeidSYulrpOZ0Ziq12ils6I=
Message-ID: <b4887ddf-a296-4f2b-8fb8-a5f9c681142a@linux.microsoft.com>
Date: Thu, 20 Feb 2025 10:49:52 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, mhklinux@outlook.com, eahariha@linux.microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 arnd@arndb.de, jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mukeshrathor@microsoft.com
Subject: Re: [PATCH v2 1/3] hyperv: Convert hypercall statuses to linux error
 codes
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740076396-15086-2-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1740076396-15086-2-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/2025 10:33 AM, Nuno Das Neves wrote:
> Return linux-friendly error codes from hypercall helper functions,
> which allows them to be used more flexibly.
> 
> Introduce hv_result_to_errno() for this purpose, which also handles
> the special value U64_MAX returned from hv_do_hypercall().
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c         | 34 ++++++++++++++++++++++++++++++++++
>  drivers/hv/hv_proc.c           |  6 +++---
>  include/asm-generic/mshyperv.h |  1 +
>  3 files changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index ee3083937b4f..2120aead98d9 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -683,3 +683,37 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
>  	return HV_STATUS_INVALID_PARAMETER;
>  }
>  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
> +
> +/* Convert a hypercall result into a linux-friendly error code. */
> +int hv_result_to_errno(u64 status)
> +{
> +	/* hv_do_hypercall() may return U64_MAX, hypercalls aren't possible */
> +	if (unlikely(status == U64_MAX))
> +		return -EOPNOTSUPP;
> +	/*
> +	 * A failed hypercall is usually only recoverable (or loggable) near
> +	 * the call site where the HV_STATUS_* code is known. So the errno
> +	 * it gets converted to is not too useful further up the stack.
> +	 * Provice a few mappings that could be useful, and revert to -EIO

Typo: Provide

Otherwise, looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Thanks,
Easwar (he/him)

