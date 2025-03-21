Return-Path: <linux-arch+bounces-11025-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 611BCA6C34C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 20:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECE1188EF9E
	for <lists+linux-arch@lfdr.de>; Fri, 21 Mar 2025 19:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641E51D54D1;
	Fri, 21 Mar 2025 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UhSL1fQQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E690F18FC75;
	Fri, 21 Mar 2025 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742584917; cv=none; b=ZPzi6djmMNMb7FKuJKTShM9haOFLnLLiYGifl960MxXmHOHWlD5yGmcVfVNTu9szHrh9EMCK4TBvmhbMRt7ydZZd/LhuE1bUXxUe3aNz4C6LsBuENPvL1qClccFkPwvpD7W0cYZaBbSz+CA2Oy6AhvQjoo9ds6LhcaE1bXZaGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742584917; c=relaxed/simple;
	bh=U4UMzZipjyQsFQ5piujejsQB+c1XLlwVJNvQsvBQ9MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f2hg6pYuCqnoQu8zO+EGticcqnQrTbD4xtWVx5OLOI0/EAo4mXwpNhVRjep8Hx4sCOLt+KLMAQhgaV0oU8LWcAQxXwr0zLt83uUfnPoe5h0wMLu6dMojQMOidtqQIHbQ2IGZOPztrNuc9uWbrJ0ySIWMOnNoQ7+s3NHLCHGtqiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UhSL1fQQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id 11FED2025389;
	Fri, 21 Mar 2025 12:21:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11FED2025389
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742584915;
	bh=TyoFMEsYsu5vnNBRoDsYQO5n/7yf/MyffHvokDDAMiI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UhSL1fQQ52kZteeudkl1dGGnJISMWQ88TblnTnd/kOBJXIkwUleGbA7RRT9mfUAHr
	 RKGZAYFpvHN0fhQhDzKaZdA/tJLpe4RIVrc/KxQps3DjSdMFTNTiEiMUHjqRu+g96E
	 aBKQEud+tdfK46cXvPwxEl0Cqwg67lSYLpc9rHsE=
Message-ID: <bebb7d7a-ef56-4dc1-9eca-844f0f827976@linux.microsoft.com>
Date: Fri, 21 Mar 2025 12:21:49 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] x86/hyperv: Use hv_hvcall_*() to set up hypercall
 arguments -- part 1
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, bhelgaas@google.com, arnd@arndb.de
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250313061911.2491-1-mhklinux@outlook.com>
 <20250313061911.2491-3-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250313061911.2491-3-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/2025 11:19 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Update hypercall call sites to use the new hv_hvcall_*() functions
> to set up hypercall arguments. Since these functions zero the
> fixed portion of input memory, remove now redundant calls to memset()
> and explicit zero'ing of input fields.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> 
> Notes:
>     Changes in v2:
>     * Fixed get_vtl() and hv_vtl_apicid_to_vp_id() to properly treat the input
>       and output arguments as arrays [Nuno Das Neves]
>     * Enhanced __send_ipi_mask_ex() and hv_map_interrupt() to check the number
>       of computed banks in the hv_vpset against the batch_size. Since an
>       hv_vpset currently represents a maximum of 4096 CPUs, the hv_vpset size
>       does not exceed 512 bytes and there should always be sufficent space. But
>       do the check just in case something changes. [Nuno Das Neves]
> 
>  arch/x86/hyperv/hv_apic.c   | 10 ++++------
>  arch/x86/hyperv/hv_init.c   |  6 ++----
>  arch/x86/hyperv/hv_vtl.c    |  9 +++------
>  arch/x86/hyperv/irqdomain.c | 17 ++++++++++-------
>  4 files changed, 19 insertions(+), 23 deletions(-)
> 

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

