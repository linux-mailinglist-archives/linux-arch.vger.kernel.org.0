Return-Path: <linux-arch+bounces-9621-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD28A03F71
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 13:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 052C97A2157
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jan 2025 12:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CBF1EF097;
	Tue,  7 Jan 2025 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="K8Sn0vHt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F331E9B18;
	Tue,  7 Jan 2025 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253473; cv=none; b=lImhb9YEx4JAbtsPtCtk6wZmFMVL5KOF2IzPvQQaip2a12JwoYcKHevW56a0GBtmqnWrwzYf1vco4F1/KEMhOCFLtbcuWlj0ZbHBfvH72AOpCfS3Xvf6LzT7Sx4SrqAvb9auIUsg2jDKN0TMfCdZINY1ReeUhp+7o0J0zpnyNvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253473; c=relaxed/simple;
	bh=Fyxx5vweceEg5DZc0nxYGqsC19+XYJMa4og9H3Vzvb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVg+1NH42UZ85v0J/9s9pSO54S5ejRxfdCuC1GlrErRK9RraUi9z7QGGRtajUxl8mUIbI0UDeRru5DTLP4/YXaiBIq0gPcYckIoivWt5JAK8vq84Gf0tHjGPZ5E6LVJIe9PU8RxeCN/YZpwaXk7ybebT9gspsI2/sv1wFoorr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=K8Sn0vHt; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4YS9R95VpRz1DQrv;
	Tue,  7 Jan 2025 13:32:05 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4YS9R855Gvz1DPkt;
	Tue,  7 Jan 2025 13:32:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1736253125;
	bh=afiW8AwTqxiyrnYAmDWsh5UN0PQKjWSItqqmcC5x0jI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K8Sn0vHtwM1d9RRHFMpf2UBap6Ok8/k3Y7KwC2OxqXXituKlp3nxPRyAyw6ESSaEg
	 nRhg8kkgeHKR8GWCh1uafNV9eGH67rpjoOXkPL//LTDEBibTsZkLTAwXFx8/Wb/AXh
	 cIT1WOGyJ7orxqpPCFoWzougYe222KDCTr5pTxiQ=
Message-ID: <6e1aa2aa-a70d-4292-9c5e-21c8fea386f5@gaisler.com>
Date: Tue, 7 Jan 2025 13:32:03 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] mm: pgtable: introduce generic
 __tlb_remove_table()
To: Qi Zheng <zhengqi.arch@bytedance.com>, peterz@infradead.org,
 agordeev@linux.ibm.com, kevin.brodsky@arm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <f7febc7719fd84673a8eae8af71b7b4278d3e110.1735549103.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <f7febc7719fd84673a8eae8af71b7b4278d3e110.1735549103.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-12-30 10:07, Qi Zheng wrote:
> diff --git a/arch/sparc/include/asm/tlb_32.h b/arch/sparc/include/asm/tlb_32.h
> index 5cd28a8793e39..910254867dfbd 100644
> --- a/arch/sparc/include/asm/tlb_32.h
> +++ b/arch/sparc/include/asm/tlb_32.h
> @@ -2,6 +2,7 @@
>  #ifndef _SPARC_TLB_H
>  #define _SPARC_TLB_H
>  
> +#define __HAVE_ARCH_TLB_REMOVE_TABLE

sparc32 does not select MMU_GATHER_TABLE_FREE, and therefore does not
have (nor need) __tlb_remove_table, so this define should not be added.


>  #include <asm-generic/tlb.h>
>  
>  #endif /* _SPARC_TLB_H */
> diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
> index 3037187482db7..1a6e694418e39 100644
> --- a/arch/sparc/include/asm/tlb_64.h
> +++ b/arch/sparc/include/asm/tlb_64.h
> @@ -33,6 +33,7 @@ void flush_tlb_pending(void);
>  #define tlb_needs_table_invalidate()	(false)
>  #endif
>  
> +#define __HAVE_ARCH_TLB_REMOVE_TABLE
>  #include <asm-generic/tlb.h>
>  
>  #endif /* _SPARC64_TLB_H */
LGTM. 


With the removal of the define for sparc32 in v5:

Acked-by: Andreas Larsson <andreas@gaisler.com> # sparc

Thanks,
Andreas


