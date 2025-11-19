Return-Path: <linux-arch+bounces-14906-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D40FC6E4D6
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 12:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4EBB358F1B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 11:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC2B354AC6;
	Wed, 19 Nov 2025 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbpzBxMP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ECE2F2608;
	Wed, 19 Nov 2025 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763552335; cv=none; b=c737d3ExWQYYJmkZMmZK1Vp5rT3LogPrdKwgO10QvqO/5Qcqu3SeiiuTGnX/LiUw69ZcuT277dZVoq9pwDYDO9qT4tOpMTLJ4WF7WI+bpNnZR9GZo3zsL/zBHcT/oxMV8tT4EVlTuqdJoNSf2IcwhWBPPsZOTrb8SIuNPS65oO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763552335; c=relaxed/simple;
	bh=09EAP2XN+lRanTOPE2mYQg/imEyLIAMTytu/FERJ3KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLxI9GR6+/CzO9jBOWHgT8N/3UNiIb3oa/eJgkBPSApgXkslT4O9lEUKpLvfLADoHRU+XIqYbAdjl1qIzFHLh+ICAlNce3T11g5xqc0wQpJcF5sAm6WJR4p9oUav8O+xeHC5B55ytta9xS2M3Mx5ISPlZLz+6FzvpBR7x+HOQso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbpzBxMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510B7C2BCB4;
	Wed, 19 Nov 2025 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763552334;
	bh=09EAP2XN+lRanTOPE2mYQg/imEyLIAMTytu/FERJ3KE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZbpzBxMPlijcUIWVvcKZTNGa7zCAJwZY9chXx+w8GbRHAR+rI1lSfYrqXSSvSDYaE
	 MePEVV4EjqdFYyQgiSidQHYaWwO7pQarT3TKZOtNh3sSfSwIQ6SflX1gDL9lMSxLny
	 w06MV9gY5w5TZlc4+ewlulKiXr9osdtN3qFwbuQWIMM4miVH0RvJzhNpO1lxypNit0
	 eeE/heuKvBJlnAAv4sK4Mv4MYw7Xohrvhu7Amo4HOBaY8PCND2DXnAiONttsXskaMh
	 8/Bno4vIYUEF05KYxb1WyXsUI4O64niqkk/pUg+0oPMnWbdq0tM2VTdA0KoQ6gV8im
	 c4sJ+iwsxJ/XQ==
Message-ID: <9b55623a-4606-4610-a0fe-55b8cd6b95e7@kernel.org>
Date: Wed, 19 Nov 2025 12:38:46 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] mm: enable PT_RECLAIM on all 64-bit architectures
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, ioworker0@gmail.com, linmag7@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763537007.git.zhengqi.arch@bytedance.com>
 <caacf08b765ef00770b7c75afdb5e5754485b2aa.1763537007.git.zhengqi.arch@bytedance.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <caacf08b765ef00770b7c75afdb5e5754485b2aa.1763537007.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.11.25 08:31, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Now, the MMU_GATHER_RCU_TABLE_FREE is enabled on all 64-bit architectures,
> so make PT_RECLAIM depend on 64BIT, thereby enabling PT_RECLAIM on all
> 64-bit architectures.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   arch/x86/Kconfig | 1 -
>   mm/Kconfig       | 9 ++-------
>   2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index eac2e86056902..96bff81fd4787 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -330,7 +330,6 @@ config X86
>   	select FUNCTION_ALIGNMENT_4B
>   	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>   	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
> -	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
>   	select ARCH_SUPPORTS_SCHED_SMT		if SMP
>   	select SCHED_SMT			if SMP
>   	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
> diff --git a/mm/Kconfig b/mm/Kconfig
> index d548976d0e0ad..94eec5c0cad96 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1448,14 +1448,9 @@ config ARCH_HAS_USER_SHADOW_STACK
>   	  The architecture has hardware support for userspace shadow call
>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>   
> -config ARCH_SUPPORTS_PT_RECLAIM
> -	def_bool n
> -
>   config PT_RECLAIM
> -	bool "reclaim empty user page table pages"
> -	default y
> -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
> -	select MMU_GATHER_RCU_TABLE_FREE
> +	def_bool y
> +	depends on 64BIT

As discussed in the other thread, likely

config PT_RECLAIM
	def_bool y
	depends on MMU_GATHER_RCU_TABLE_FREE && 64BIT

Could be nice, and if possible even dropping the 64BIT limitation as 
well if there is no need to.


-- 
Cheers

David

