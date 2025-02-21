Return-Path: <linux-arch+bounces-10318-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4173DA40046
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 21:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A143516944F
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2025 20:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5678C253B64;
	Fri, 21 Feb 2025 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dygnEZ7c"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D480B253B5C;
	Fri, 21 Feb 2025 20:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168099; cv=none; b=IQE2650/+w+F0U56nuvrz6TtUjFBxWA8dDwmJvm6Y0ddgOzy8uu+uvYTNCI+dRqxObgy0gFPaxJnKA3JhEVwfJXrtQnYijpYht/QJ/Z0ldn+llQ7eUmBSpfw+A1GR2303CbP2pV/bbx4qUQgWo+CLdjUlKOmhkircwwqV69bjWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168099; c=relaxed/simple;
	bh=3XgieEOBUGAAZvE8C5VsBMWxSTo4PYdIE8rWpuaj1s4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aI55rRl7SbxP8mLaup1DEyx0RDxZMUNBTNxPUkOHvTn+BwcLAm37L3Hchiuln7esPcMzC3ruosIu5kJsJs8uHQbVe8Ip0zIlIW49Y1Rr5Z+ISfIn5A99Tv4lIZOQ3cjpxn15iS+d/Cjl8Ff7dSauIsSEpXEWo+uT2dRcOwRWvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dygnEZ7c; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id E7EC62069417;
	Fri, 21 Feb 2025 12:01:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E7EC62069417
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740168097;
	bh=44dStVmRn1/6hW7hYJxHZ4v+2e/QWDNOYlE859iLC28=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=dygnEZ7czHywqTChRPKx3oed3NemHmKjVSvPaxfSp1FXfXKwdo9FSARhhWOhgaCk5
	 CUcGU7heUGdXEtTn+6eSprExcB579ljnj7s6nJQ/DFRjmSIts9zupM6yrzmxoL7BD5
	 2SGf5+3OX54Ub8APiiTDbg/y8tIlNB62mQfFPaJs=
Message-ID: <991e7df9-d814-48a9-9469-a0b2f72acabb@linux.microsoft.com>
Date: Fri, 21 Feb 2025 12:01:36 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Introduce CONFIG_MSHV_ROOT for root partition code
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, mhklinux@outlook.com, eahariha@linux.microsoft.com,
 mukeshrathor@microsoft.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 arnd@arndb.de, jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com
References: <1740167795-13296-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1740167795-13296-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The subject line says v2 but this is actually v3!

Nuno

On 2/21/2025 11:56 AM, Nuno Das Neves wrote:
> Running in the root partition is a unique and specialized case that
> requires additional code. CONFIG_MSHV_ROOT allows Hyper-V guest kernels
> to exclude this code, which is important since significant additional code
> specific to the root partition is expected to be added over time.
> 
> To do this, change hv_root_partition to be a function which is stubbed out
> to return false if CONFIG_MSHV_ROOT=n, and don't compile hv_proc.c at all,
> stubbing out those functions with inline versions.
> 
> Store the partition type (guest or root) in an enum hv_curr_partition_type,
> which can be extended beyond just guest and root partition.
> 
> While at it, introduce hv_result_to_errno() to convert Hyper-V status codes
> to regular linux errors. This is useful because the caller of a hypercall
> helper function (such as those in hv_proc.c) usually can't and doesn't
> interpret the Hyper-V status, so it is better to convert it to an error code
> and reduce the possibility of misinterpreting it. This also alows the stubbed
> versions of the hv_proc.c functions to just return a linux error code.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
> Changes in v3:
> * Fix a typo [Easwar Hariharan]
> * Fix ret being initialized to HV_STATUS_SUCCESS in some hypercall helpers
>   [Michael Kelley]
> * Fix CONFIG_MSHV_ROOT being used in patch 2, before it is defined [Michael
>   Kelley]
> * Shorten hv_current_partition_type to hv_curr_partition_type [Mukesh Rathor]
> 
> Changes in v2:
> * Add patch to convert hypercall statuses to linux error codes [Easwar
>   Hariharan]
> * While at it, split the original patch into two logical pieces, one to change
>   hv_root_partition into a function, and one to introduce MSHV_CONFIG_ROOT
> * Improve the clarity of and add an error message to
>   hv_identify_partition_type() [Easwar Hariharan] [Michael Kelley]
> * Better explain *why* the patches are useful, in the commit messages [Michael
>   Kelley]
> * Add a Kconfig comment explaining why PAGE_SIZE_4KB is needed [Michael Kelley]
> * Minor style and typo fixes
> 
> Nuno Das Neves (3):
>   hyperv: Convert hypercall statuses to linux error codes
>   hyperv: Change hv_root_partition into a function
>   hyperv: Add CONFIG_MSHV_ROOT to gate root partition support
> 
>  arch/arm64/hyperv/mshyperv.c       |  2 +
>  arch/x86/hyperv/hv_init.c          | 10 ++---
>  arch/x86/kernel/cpu/mshyperv.c     | 24 +----------
>  drivers/clocksource/hyperv_timer.c |  4 +-
>  drivers/hv/Kconfig                 | 16 +++++++
>  drivers/hv/Makefile                |  3 +-
>  drivers/hv/hv.c                    | 10 ++---
>  drivers/hv/hv_common.c             | 69 +++++++++++++++++++++++++++---
>  drivers/hv/hv_proc.c               | 10 ++---
>  drivers/hv/vmbus_drv.c             |  2 +-
>  drivers/iommu/hyperv-iommu.c       |  4 +-
>  include/asm-generic/mshyperv.h     | 40 ++++++++++++++---
>  12 files changed, 139 insertions(+), 55 deletions(-)
> 


