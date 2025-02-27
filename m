Return-Path: <linux-arch+bounces-10436-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF002A487A6
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 19:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81951884D5F
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 18:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CAF1EFF90;
	Thu, 27 Feb 2025 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BXlm4RHI"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1BF17D355;
	Thu, 27 Feb 2025 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680256; cv=none; b=I8DEyfEG8bTDgKHeg5H74YJwxUXGA1QMtv5P4NsRl8R3D+fqR/4/qEWjQ1IIF/6iTWiGcBjPBcyfFHrEGUM1Z5UL2c+dDRA6dA0GkrHc3jnyrqY0Z6q3Dmjs8Lm1lzOL0vHVPjsFPyZlaR/d/kdrArNEKCneg6egseYlvzxlxqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680256; c=relaxed/simple;
	bh=T35L5Jrzh9K3odoxbOl+2BaGbvc4Y27uKPOjd+b18mg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AgOLFA6lCiOP29UCDfmU97znYu37aoZdSlluNIXrTivx817BX9HPX0wrGMcjMzyVWNJ/unb8YkXviIpY3st1JwYNaAsGSyMUx2Mo6LDvuPmlFYxx0pnwJ9pFuKcKqEHw0JbKuHPzgSdfb/TbHKmNARS6N7fSYG4zfHMs93HqIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BXlm4RHI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id 871D4210D0D8;
	Thu, 27 Feb 2025 10:17:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 871D4210D0D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740680254;
	bh=y/zseaxlPbdmYBiPxyHV4pdZdkvQhGA5Y7F0yihhtvc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BXlm4RHIbOTxRmYXWiBvRqo6B8cJXoL64mUHWbbRbFA9+DcFlxfIK4fFzrjzS/Jr3
	 v/9FIsg5I4/jC3qnsDRJIFVC3revzKLeO+AxkA9GPzELPLGkBR/cIm4Cu8qbhISeXV
	 JooH+NCga5XGo1c196E8EJDn8t4EXLIhONvZnJa8=
Message-ID: <b08ebe97-fe27-4f7c-b7ff-989df4e91445@linux.microsoft.com>
Date: Thu, 27 Feb 2025 10:17:32 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
 eahariha@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, mhklinux@outlook.com, decui@microsoft.com,
 catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
 arnd@arndb.de, jinankjain@linux.microsoft.com, muminulrussell@gmail.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
 ssengar@linux.microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, stanislav.kinsburskiy@gmail.com,
 gregkh@linuxfoundation.org, vkuznets@redhat.com, prapal@linux.microsoft.com,
 muislam@microsoft.com, anrayabh@linux.microsoft.com, rafael@kernel.org,
 lenb@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v5 02/10] x86/mshyperv: Add support for extended Hyper-V
 features
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-3-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1740611284-27506-3-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/2025 3:07 PM, Nuno Das Neves wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> 
> Extend the "ms_hyperv_info" structure to include a new field,
> "ext_features", for capturing extended Hyper-V features.
> Update the "ms_hyperv_init_platform" function to retrieve these features
> using the cpuid instruction and include them in the informational output.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 6 ++++--
>  include/asm-generic/mshyperv.h | 1 +
>  2 files changed, 5 insertions(+), 2 deletions(-)

Looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

