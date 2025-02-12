Return-Path: <linux-arch+bounces-10129-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1A7A31E2E
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 06:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCB43A8C98
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 05:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EE31E5702;
	Wed, 12 Feb 2025 05:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iDrcQD4O"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F7E2BD10;
	Wed, 12 Feb 2025 05:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339247; cv=none; b=MApmJOwH1HK5aSuHSodTlRKSkvz9IfF1dgEPt7oXm8wVgAv2yPPBiIeOMxTY8ifp/dIZxJkjOSiAa9gzvT6eGbSNyd6UGS3QnypU9JU6HmPNN7ZrbqvbK0ampESLpaJfMXu4MC/kGUa8x0eHnXBDsFe3TUXd1o17hhFpQVeoF30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339247; c=relaxed/simple;
	bh=bKZCNONeJ8ga4R1OU5uHKgLTrt0Ti+1H6/HUJpIjnPw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o9ptK51ZZdO31zf9IKKQ7/nXtenGBLvjXWXj0Y2oXk8hs5/tt4kieQvqGZVNXe6iQXQo4eyEdmwo9BuE51cy6lZ3DHudoOz0XFhKKCyCGWIeoAyjFcL1ISCreDzwyeDtwBcla0iTGY3ihT2fBfyx40NcxjT1tqnTYfZSrhrC7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iDrcQD4O; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-59-8-18.hsd1.wa.comcast.net [73.59.8.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 79DD82107AB7;
	Tue, 11 Feb 2025 21:47:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 79DD82107AB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739339245;
	bh=2cvrA/jSJRuBK0OsorOMxFgUQoJApVJ8Yjx0E2P1rLo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=iDrcQD4OZx3ePmwlps16DC5hZu4V/C9DuCTp+LaKEl3ZiloWrQfyzNMez2hcdI1uh
	 XoGNtNuo/7DezrquDlx4sVkCzw3MiKGoeavdOOsF58V7ipziEgE5uGKn0KEVwZT/wq
	 1mG0nWC0EPeb5nGqsafzZiwgfjhKdlAW889o53ac=
Message-ID: <20ba4b7c-bebb-4b1f-8c6c-4cd52a5083b5@linux.microsoft.com>
Date: Tue, 11 Feb 2025 21:47:24 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, eahariha@linux.microsoft.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 arnd@arndb.de, jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mukeshrathor@microsoft.com
Subject: Re: [PATCH] hyperv: Add CONFIG_MSHV_ROOT to gate hv_root_partition
 checks
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1739312515-18848-1-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1739312515-18848-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/2025 2:21 PM, Nuno Das Neves wrote:
> Introduce CONFIG_MSHV_ROOT as a tristate to enable root partition
> booting and future mshv driver functionality.
> 
> Change hv_root_partition into a function which always returns false
> if CONFIG_MSHV_ROOT=n.
> 
> Introduce hv_current_partition_type to store the type of partition
> (guest, root, or other kinds in future), and hv_identify_partition_type()
> to it up early in Hyper-V initialization.

...to *set* it up early?

> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
> Depends on
> https://lore.kernel.org/linux-hyperv/1738955002-20821-3-git-send-email-nunodasneves@linux.microsoft.com/
> 
>  arch/arm64/hyperv/mshyperv.c       |  2 ++
>  arch/x86/hyperv/hv_init.c          | 10 ++++----
>  arch/x86/kernel/cpu/mshyperv.c     | 24 ++----------------
>  drivers/clocksource/hyperv_timer.c |  4 +--
>  drivers/hv/Kconfig                 | 12 +++++++++
>  drivers/hv/Makefile                |  3 ++-
>  drivers/hv/hv.c                    | 10 ++++----
>  drivers/hv/hv_common.c             | 32 +++++++++++++++++++-----
>  drivers/hv/vmbus_drv.c             |  2 +-
>  drivers/iommu/hyperv-iommu.c       |  4 +--
>  include/asm-generic/mshyperv.h     | 39 +++++++++++++++++++++++++-----
>  11 files changed, 92 insertions(+), 50 deletions(-)
> 

<snip>

> +
> +void hv_identify_partition_type(void)
> +{
> +	/*
> +	 * Check partition creation and cpu management privileges
> +	 *
> +	 * Hyper-V should never specify running as root and as a Confidential
> +	 * VM. But to protect against a compromised/malicious Hyper-V trying
> +	 * to exploit root behavior to expose Confidential VM memory, ignore
> +	 * the root partition setting if also a Confidential VM.
> +	 */
> +	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
> +	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
> +	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
> +		hv_current_partition_type = HV_PARTITION_TYPE_ROOT;
> +		pr_info("Hyper-V: running as root partition\n");
> +	} else {
> +		hv_current_partition_type = HV_PARTITION_TYPE_GUEST;
> +	}
> +}

This should assume GUEST as default and modify to ROOT if all the checks pass.

<snip>

> +static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
> +{
> +	return hv_result(U64_MAX);
> +}

Is there value in perhaps #defining hv_result_<whatever this is> as U64_MAX and returning that for documentation?
For e.g. assuming this is something like EOPNOTSUPP

#define HV_RESULT_NOT_SUPP U64_MAX

static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
{ return hv_result(HV_RESULT_NOT_SUPP); }

<snip>

Thanks,
Easwar (he/him)

