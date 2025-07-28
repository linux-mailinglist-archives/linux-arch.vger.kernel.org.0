Return-Path: <linux-arch+bounces-12976-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105A0B140D6
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 19:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CA83A4151
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B71B2066DE;
	Mon, 28 Jul 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="am+xvDzv"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB306FB9;
	Mon, 28 Jul 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753722155; cv=none; b=P/Ve9G2yZQ1cEthvPvUoa7/LMMQ/1WR0wBmrgg1huKjhSIuFRX7Vk+bVv/MPyO3vU6kSSHI7rJnvpzUa/38lJWDpRFDz6S4L23aaFEGfhzV4MPrZYD76MUk2mWhB0JXEI3SS2joVZduL+fyhGSSYC+efN7fAwng6XdyAl7qFW+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753722155; c=relaxed/simple;
	bh=7c3SNVtj1tYyffbU7QShuuFAcnhvIKUQvO7+rwQHIuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UudDu3oP6R9pBNSUrDjri/CbC0YyRhP24MntKNiU06xqst7Ks8s90fOz9EgVWJnDPTPLLizIJ/lGn2CIqrkRjMiKsJwsMbBnTaXANydsM8LGPmqOgK1QAUSz7Y5xAHL8Xzgj362vZoeLzEGYcv7uw6VsLkPKPWkvPKJ14NpS04w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=am+xvDzv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.232.206] (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id C4268201B1CC;
	Mon, 28 Jul 2025 10:02:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C4268201B1CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753722153;
	bh=2DNBQnXA8dcGCQuVJocQEOXmGajpYBtPA9D+7X3s7Dg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=am+xvDzvI/wG0H0dAQ9VK+E7DV/5bXtrwFwEzEOvzSPW+oXzxUjgsJ5WMHS+jDiC6
	 KHTli7jCk3B4cFGSKCwhak+CKF1zdHKtuaTY+cy7EQ9EO+T1N6+jrPCxq/wjXzsbDq
	 Zmr21H8fPXSTNH88EkmmFTTnyUOkVfNP2STvLjMI=
Message-ID: <1303b11c-0d84-4f42-995e-6dd2c5a528c7@linux.microsoft.com>
Date: Mon, 28 Jul 2025 10:02:32 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] Drivers: hv: Use hv_setup_*() to set up hypercall
 arguments
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 lpieralisi@kernel.org, kw@linux.com, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <20250718045545.517620-5-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250718045545.517620-5-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/2025 9:55 PM, mhkelley58@gmail.com wrote:
<snip>
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 2b4080e51f97..d9b569b204d2 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1577,21 +1577,21 @@ static int hv_free_page_report(struct page_reporting_dev_info *pr_dev_info,
>  {
>  	unsigned long flags;
>  	struct hv_memory_hint *hint;
> -	int i, order;
> +	int i, order, batch_size;
>  	u64 status;
>  	struct scatterlist *sg;
>  
> -	WARN_ON_ONCE(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
>  	WARN_ON_ONCE(sgl->length < (HV_HYP_PAGE_SIZE << page_reporting_order));
>  	local_irq_save(flags);
> -	hint = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	batch_size = hv_setup_in_array(&hint, sizeof(*hint), sizeof(hint->ranges[0]));
>  	if (!hint) {
>  		local_irq_restore(flags);
>  		return -ENOSPC;
>  	}
> +	WARN_ON_ONCE(nents > batch_size);
>  

I don't think WARN_ON_ONCE is sufficient here... this looks like a bug in the current code.
The loop below will go out of bounds of the input page if nents is too large.

Ideally this function would be refactored to batch the operation so that this isn't a
problem.

Nuno
>  	hint->heat_type = HV_EXTMEM_HEAT_HINT_COLD_DISCARD;
> -	hint->reserved = 0;
>  	for_each_sg(sgl, sg, nents, i) {
>  		union hv_gpa_page_range *range;
>  
<snip>


