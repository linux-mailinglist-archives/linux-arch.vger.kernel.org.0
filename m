Return-Path: <linux-arch+bounces-14840-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B260C65551
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 18:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25D17344CB5
	for <lists+linux-arch@lfdr.de>; Mon, 17 Nov 2025 17:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FFC301705;
	Mon, 17 Nov 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPT+kdRJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B72C236D;
	Mon, 17 Nov 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398685; cv=none; b=njQeLDahRgbKTkMz8MyKVa3Kbw8XvMa6ZdOyRwu7RU+AVEeY4V8+rSphRuRelrm2kAfRzGMlJ8r9p7IoYZxt3nbI8hwW0wF+/papD0qXphVBYtp58RzMo7OXDQ4SAkr0d4juI72Z7HgN8wY+Z/g8PPA6gWEEDNXVYR+PbavPEbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398685; c=relaxed/simple;
	bh=XI7Dqc8hDG/imiQjwpaa5L5QUXIhiYHcmUsbHNJq770=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qD90mhmYWUD4VPGjw4iwOn/CXcnwonxwmaOmyC8veo1zigU6/KrpfFubJs8clYI08BK7IuHH0SHbmoYO500WM+U/EQuIPR6lNavdOCZ/2ZKIV1tGTtSrrDHlePNmnQBQtvrY2IUJVRf5B2XwpDMzK4p0fB6W+BarMcE3o7PZ5+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPT+kdRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11DDC116B1;
	Mon, 17 Nov 2025 16:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763398685;
	bh=XI7Dqc8hDG/imiQjwpaa5L5QUXIhiYHcmUsbHNJq770=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dPT+kdRJmrc++E4JgaDg0HvOn87ub1fN81aujiL3JuYrC+XABLmrn8IKbujtOxjox
	 06UW28/7RYwaB1AdZehoyv5pTGVprSBAXjHnoKbjSL+FhOIiMfHk/eazN5xF1ef35L
	 iI2y5+BgESdTBJPjDJ0iyZWOBGh7c+XsGh6M04pYgwNZsjWk51POupKSyh33gdm0EP
	 45y5/jkWLrEhutdIoC4OWF5kMcmkisDNjsD7jjLCsAiCX9ZO+pgaVPoMulUmJlaGb9
	 4LERACYZwJIsl5lju9+IsQAyONXCgmYbWkB3p/ehSBdOllMUN3kNW2OC6dfYrgwBMJ
	 Dugsm9vMMNdlA==
Message-ID: <355d3bf3-c6bc-403e-9f19-89259d868611@kernel.org>
Date: Mon, 17 Nov 2025 17:57:58 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] mm: make PT_RECLAIM depend on
 MMU_GATHER_RCU_TABLE_FREE && 64BIT
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.11.25 12:11, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>

Subject: s/&&/&/

> 
> Make PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE so that PT_RECLAIM can
> be enabled by default on all architectures that support
> MMU_GATHER_RCU_TABLE_FREE.
> 
> Considering that a large number of PTE page table pages (such as 100GB+)
> can only be caused on a 64-bit system, let PT_RECLAIM also depend on
> 64BIT.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>   arch/x86/Kconfig | 1 -
>   mm/Kconfig       | 6 +-----
>   2 files changed, 1 insertion(+), 6 deletions(-)
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
> index a5a90b169435d..e795fbd69e50c 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1440,14 +1440,10 @@ config ARCH_HAS_USER_SHADOW_STACK
>   	  The architecture has hardware support for userspace shadow call
>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>   
> -config ARCH_SUPPORTS_PT_RECLAIM
> -	def_bool n
> -
>   config PT_RECLAIM
>   	bool "reclaim empty user page table pages"
>   	default y
> -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
> -	select MMU_GATHER_RCU_TABLE_FREE
> +	depends on MMU_GATHER_RCU_TABLE_FREE && MMU && SMP && 64BIT

Who would we have MMU_GATHER_RCU_TABLE_FREE without MMU? (can we drop 
the MMU part)

Why do we care about SMP in the first place? (can we frop SMP)

But I also wonder why we need "MMU_GATHER_RCU_TABLE_FREE && 64BIT":

Would it be harmful on 32bit (sure, we might not reclaim as much, but 
still there is memory to be reclaimed?)?

If all 64BIT support MMU_GATHER_RCU_TABLE_FREE (as you previously 
state), why can't we only check for 64BIT?

-- 
Cheers

David

