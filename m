Return-Path: <linux-arch+bounces-3271-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8038900ED
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 14:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B907295AA6
	for <lists+linux-arch@lfdr.de>; Thu, 28 Mar 2024 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B118175E;
	Thu, 28 Mar 2024 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Dwr4ABU6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F681728;
	Thu, 28 Mar 2024 13:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634212; cv=none; b=px7jQ7LazxsK+tVfPgv3rbn8eZiEKEbTE1eHtm+uS5GUX3QNKCKC2MvypCgoow+Ok72baoK4moMmxFdt4hDg4a5U0hpv8XyHxISyPSa2rCb3xFIh60fLvzH61KmpXtqmwi4ch9jUJFMu8LEJeX8ZwSNNhRtIGWCKaqTfkIRXUqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634212; c=relaxed/simple;
	bh=d33+0SwUQJCpC+ipPAAkFBTnksa4Ra7GgJ3ubwKBSXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiqaYrRIzyGNIoPAsASJZIFg0QC9VoAfmrjjK2Ca7LtXttRv7dms4g9lCwujolFN9aLDql3fEcgZxEzaeNxEXWQ1Jt/hdydDv42sqr1xVZftQeJjIKJqhSGXdNVb+Sv/zV0D1MQARxjrZdlLI5/HTvbeT8F2c6F0+cFWFyO6fkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Dwr4ABU6; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1711634200;
	bh=d33+0SwUQJCpC+ipPAAkFBTnksa4Ra7GgJ3ubwKBSXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dwr4ABU6PkSmFXqbCuKRIQQVV0sKlTkAoOmUjX8Hb00Myg2MUbRNGiPLTlqS0fP17
	 UsLsPQNI0xfaMxGFrz1ItaIm/5RPD/Xhu+dcrhar3gCUJ0RpTbw2FTMzGhfI0MMxwJ
	 Oz1idHi6ND94Noc/RFGL5k8Y0pK/OWyDO4DlO6RY+Isy5ZfVmMgqXftF7iTVWvEkic
	 nmAYCaYgx2dpWiDRImQPvXtVby9MITT9R0Jekwh9IBYK5o5Hum2khx+vclzp/N69m9
	 AOJNeiVHhVtAQP9bKA7s13YGxGlLYDocGe0bYnTayMiMsRVutY/5baj7ZUFb4iIqoZ
	 xyq/PGh2viWGg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4V54pJ29MfznPv;
	Thu, 28 Mar 2024 09:56:40 -0400 (EDT)
Message-ID: <2084d534-5e64-4a38-aba5-aeb03c9e71cd@efficios.com>
Date: Thu, 28 Mar 2024 09:57:07 -0400
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARC: mm: fix new code about cache aliasing
To: Vineet Gupta <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20240328053919.992821-1-vgupta@kernel.org>
 <20240328053919.992821-3-vgupta@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240328053919.992821-3-vgupta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-28 01:39, Vineet Gupta wrote:
> Manual/partial revert of 8690bbcf3b70 ("Introduce cpu_dcache_is_aliasing() across all architectures")
> 
> Current generation of ARCv2/ARCv3 based HSxx cores are only PIPT (to software
> at least).
> 
> Legacy ARC700 cpus could be VIPT aliasing (based on cache geometry and
> PAGE_SIZE) however recently that support was ripped out so VIPT aliasing
> cache is not relevant to ARC anymore.
> 
> P.S. : This has been discussed a few times on lists [1]
> P.S.2: Please CC the arch maintainers and/or mailing list before adding
>         such interfaces.

Because 8690bbcf3b70 was introducing a tree-wide change affecting all
architectures, I CC'd linux-arch@vger.kernel.org. I expected all
architecture maintainers to follow that list, which is relatively
low volume.

I'm sorry that you learn about this after the fact as a result.
My intent was to use the list rather than CC about 50 additional
people/mailing lists.

Of course, if VIPT aliasing is removed from ARC, removing the
config ARCH_HAS_CPU_CACHE_ALIASING and using the generic
cpu_dcache_is_aliasing() is the way to go. Feel free to add
my:

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu


> 
> [1] http://lists.infradead.org/pipermail/linux-snps-arc/2023-February/006899.html
> 
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
> ---
>   arch/arc/Kconfig                 | 1 -
>   arch/arc/include/asm/cachetype.h | 9 ---------
>   2 files changed, 10 deletions(-)
>   delete mode 100644 arch/arc/include/asm/cachetype.h
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 99d2845f3feb..4092bec198be 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -6,7 +6,6 @@
>   config ARC
>   	def_bool y
>   	select ARC_TIMERS
> -	select ARCH_HAS_CPU_CACHE_ALIASING
>   	select ARCH_HAS_CACHE_LINE_SIZE
>   	select ARCH_HAS_DEBUG_VM_PGTABLE
>   	select ARCH_HAS_DMA_PREP_COHERENT
> diff --git a/arch/arc/include/asm/cachetype.h b/arch/arc/include/asm/cachetype.h
> deleted file mode 100644
> index 05fc7ed59712..000000000000
> --- a/arch/arc/include/asm/cachetype.h
> +++ /dev/null
> @@ -1,9 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ASM_ARC_CACHETYPE_H
> -#define __ASM_ARC_CACHETYPE_H
> -
> -#include <linux/types.h>
> -
> -#define cpu_dcache_is_aliasing()	true
> -
> -#endif

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


