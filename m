Return-Path: <linux-arch+bounces-13163-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD04FB25680
	for <lists+linux-arch@lfdr.de>; Thu, 14 Aug 2025 00:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC0E3AB823
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 22:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E064E302754;
	Wed, 13 Aug 2025 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YvU3cY4E"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B0930274F;
	Wed, 13 Aug 2025 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755123485; cv=none; b=bwHS8AQnv5YNR2adk0ucPgiLng4PuzWXcjtjGP+TuBfSRY4oJ/bz098C3pCc+vhmSbQJtmsigXen5O/HrG5zW9T5u/JwUOeE/qCCGWIdqreWOKPBKKsejiKT1qeWuQ9OY9rlWBN13MHEBW2c3tJuBfvVnJClki3KEFOwtuzl7gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755123485; c=relaxed/simple;
	bh=FWYO5qFDEHpc55EEN1ES7XCG0hi6VCbY8b9+s/QUobI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UpafArTfWYbwAIEXwjVwv25gxZmW23Pw+7KF/naEKEjonlKjYMz+BYGukb6QQsnb38JsC8r157W7hTO2dr4wKp/gWREz6c1tBHE2qbkaX/yhKmhn/1j9r45m+cbFumQ/LM4mo7Xbf84ceS2vP/WFPspWrBp9v83qDR7ITNhyDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YvU3cY4E; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.233.210] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 07E2D2015E58;
	Wed, 13 Aug 2025 15:18:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 07E2D2015E58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755123483;
	bh=8v7jEOmY3YGAoOqFZDtdYxrkJwpuSQuHvKiM5joCVS4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YvU3cY4EQKhJZ/dI5oCRV5AmsN1pllOoT1tQByZXZiykvmb+raVZ+qI/SaPzn2+LN
	 P66+AzoERz5m0c7eWUrf1Yv7sGPIDRLWihg5JNv6QFrQ+Z67yUJV1fPmqGKGvt7DSq
	 wxPpFX23YE8c18rDJ+9lXfHUlZSErsXATJ5HUXUg=
Message-ID: <28e81f65-0d0d-4868-9435-8a1bb0ace412@linux.microsoft.com>
Date: Wed, 13 Aug 2025 15:18:02 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] Drivers: hv: Use hv_setup_*() to set up hypercall
 arguments for mshv code
To: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 lpieralisi@kernel.org, kw@linux.com, mani@kernel.org, robh@kernel.org,
 bhelgaas@google.com, arnd@arndb.de
Cc: x86@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <20250718045545.517620-7-mhklinux@outlook.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250718045545.517620-7-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/2025 11:55 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Update hypercall call sites to use the new hv_setup_*() functions
> to set up hypercall arguments. Since these functions zero the
> fixed portion of input memory, remove now redundant calls to memset()
> and explicit zero'ing of input fields. Where feasible use batch size
> returned by hv_setup_inout_array() instead of separate #define value.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> 
> Notes:
>     Changes in v4:
>     * Rename hv_hvcall_*() functions to hv_setup_*() [Easwar Hariharan]
>     * Rename hv_hvcall_in_batch_size() to hv_get_input_batch_size()
>       [Easwar Hariharan]
>     
>     Changes in v3:
>     * This patch is new in v3 due to rebasing on 6.15-rc1, which has new
>       mshv-related hypercalls.
> 
>  drivers/hv/mshv_common.c       |  31 +++------
>  drivers/hv/mshv_root_hv_call.c | 121 +++++++++++++--------------------
>  drivers/hv/mshv_root_main.c    |   5 +-
>  3 files changed, 60 insertions(+), 97 deletions(-)

<snip>
I tested most of the modified call sites (about 75%), and the rest look
correct to me.

Tested-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

