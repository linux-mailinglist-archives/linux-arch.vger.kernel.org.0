Return-Path: <linux-arch+bounces-10393-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62577A46EE7
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936A516DE54
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8B025E834;
	Wed, 26 Feb 2025 22:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c/O4t9/L"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE0725E800;
	Wed, 26 Feb 2025 22:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740610796; cv=none; b=JICPmw3o4KvvlWHQ4gY3s2z7P8r77sIb9ktnGdAqpct9tdWHRu3i7ZzwdegbCe+i21PxTgHZlcWQ9fHQ2v98aOi7ZckQp2K8QOe85xmksQDFqmU0GrmhfpWe2SA1ID6nzoZTTiNiFNSP5ZOkgmo9z1HmxHg/0J6aRZguPdy3jsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740610796; c=relaxed/simple;
	bh=QohsatoNAoe0TQFSqGvJl126DEabaHO6T2dlFIpaGVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQ2+gCdSrtSqpH9/fnILMSWKzbW1vE6QhAC+KtIkkOF74dvsSWf/W9NCYM9UfVdomwsuL381ATtLCK7gwDJiY7QKJur8m0Yt2WrGX/QvxCR0ns9w2Q4axydHr4RPjAVswkATzbMpaRCoOJzyRVuXjSzlDrDfiXM4zuS0GVVKCjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c/O4t9/L; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id D198E2109CE5;
	Wed, 26 Feb 2025 14:59:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D198E2109CE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740610794;
	bh=OCE0WBdUPXGKc2haUGWEgiDBQXQQk3jIxxuUZ6s5eCw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c/O4t9/L8wDTZCI7cWXrk7oCLDPo5hzYnkRpLJUhJCs1cwcfjcc4tvyHn62imt4Vb
	 3mbEAmnAyuD8SydWTRmSFSmJxJbOnkCU2GgMjCNN8wUtkc/QwMHYunFF0p6m+68t4G
	 uVB1l5q7E+9pXofJm3HPkQD6YwINC0ds8MciIFg4=
Message-ID: <f6115867-281d-4c97-87d2-3698e6474b7a@linux.microsoft.com>
Date: Wed, 26 Feb 2025 14:59:53 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] x86/hyperv: Fix output argument to hypercall that
 changes page visibility
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250226200612.2062-1-mhklinux@outlook.com>
 <20250226200612.2062-2-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250226200612.2062-2-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 12:06 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> The hypercall in hv_mark_gpa_visibility() is invoked with an input
> argument and an output argument. The output argument ostensibly returns
> the number of pages that were processed. But in fact, the hypercall does
> not provide any output, so the output argument is spurious.
> 
> The spurious argument is harmless because Hyper-V ignores it, but in the
> interest of correctness and to avoid the potential for future problems,
> remove it.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> I have not provided a "Fixes:" tag because the error causes no impact.
> There's no value in backporting the fix.
> 
>  arch/x86/hyperv/ivm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index dd68d9ad9b22..ec7880271cf9 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -464,7 +464,6 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
>  			   enum hv_mem_host_visibility visibility)
>  {
>  	struct hv_gpa_range_for_visibility *input;
> -	u16 pages_processed;
>  	u64 hv_status;
>  	unsigned long flags;
>  
> @@ -493,7 +492,7 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
>  	memcpy((void *)input->gpa_page_list, pfn, count * sizeof(*pfn));
>  	hv_status = hv_do_rep_hypercall(
>  			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
> -			0, input, &pages_processed);
> +			0, input, NULL);
>  	local_irq_restore(flags);
>  
>  	if (hv_result_success(hv_status))

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

