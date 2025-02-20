Return-Path: <linux-arch+bounces-10262-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49127A3E4A8
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 20:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE16424FFD
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 19:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED265263F34;
	Thu, 20 Feb 2025 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TpP0wcMZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857FB257D;
	Thu, 20 Feb 2025 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740078127; cv=none; b=QpS4irOagzZvfzVWW671nw1wB+pQOSddW6ToLMDA6Qp1PeGMPG35dwKxRRBGrceEBABEWWLpG/J5GnUb/UM+7Na/Pj2pl1IjTmCHg8boZeE1UcnFcXZkkfSiiWfMO/neUR1BcRSpn0d8pW9YFkLkxwBr4U0PTMuKjEelRgOb5hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740078127; c=relaxed/simple;
	bh=CFyn5eFkvEhiAg66OMPRKiFTTmzZl2xZuLvL7BXSNZs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=knS2zojVzoogpN+NsCza36fz7a1Wfbv8Bo4x6w4dKG/kpAc9POqfRD86ZmmcAk/JnkmWLq6BRFUXR36Oun3qWvBgPPQoI0yRVNUK0jsKVfvrVAwTYeVSYlEJMKClvmYr+botnqnsSNDriEQ+XCkZszUNldRr2DdO6TIBdTDWOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TpP0wcMZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-24-22-154-137.hsd1.wa.comcast.net [24.22.154.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6C1062059191;
	Thu, 20 Feb 2025 11:02:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C1062059191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740078126;
	bh=NeQEm7g/5Ed+D26MEHjj4MWfwDZexQdKcjr1nchYGZU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=TpP0wcMZCTRtM+c3Z7qG3/PCJYlDhwyoZnyPaR09jH6dl45kzjHXtPjI24GQ/6xsL
	 QQ6Z3LvqJurk+NGZ/iwfdFvK8c1VsWZKifGI+ToeeNOPjuc0+9o/gWeWO/jWYYOFbz
	 AmUyVSHXWUn9EwXFquo8gNtmRCwIMvXkrdKz1JpU=
Message-ID: <e85ddfef-2081-4c8a-96e6-e84a8410ff85@linux.microsoft.com>
Date: Thu, 20 Feb 2025 11:02:06 -0800
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
Subject: Re: [PATCH v2 3/3] hyperv: Add CONFIG_MSHV_ROOT to gate root
 partition support
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
References: <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740076396-15086-4-git-send-email-nunodasneves@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <1740076396-15086-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/2025 10:33 AM, Nuno Das Neves wrote:
> CONFIG_MSHV_ROOT allows kernels built to run as a normal Hyper-V guest
> to exclude the root partition code, which is expected to grow
> significantly over time.
> 
> This option is a tristate so future driver code can be built as a
> (m)odule, allowing faster development iteration cycles.
> 
> If CONFIG_MSHV_ROOT is disabled, don't compile hv_proc.c, and stub
> hv_root_partition() to return false unconditionally. This allows the
> compiler to optimize away root partition code blocks since they will
> be disabled at compile time.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig             | 16 ++++++++++++++++
>  drivers/hv/Makefile            |  3 ++-
>  include/asm-generic/mshyperv.h | 24 ++++++++++++++++++++----
>  3 files changed, 38 insertions(+), 5 deletions(-)

Looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

