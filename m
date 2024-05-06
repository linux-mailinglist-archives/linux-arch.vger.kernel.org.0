Return-Path: <linux-arch+bounces-4215-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48428BCB81
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 12:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06D41C216B1
	for <lists+linux-arch@lfdr.de>; Mon,  6 May 2024 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46B14262C;
	Mon,  6 May 2024 10:00:58 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87531422DD;
	Mon,  6 May 2024 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714989658; cv=none; b=Re8YYeotRZcuad3gjB56/4TxZsUnIbspFzbOUMuZSyJOjgybxJDIocwL44g2HeuDKh2/XbZxNmV9nk4hcWoXJEC/xhYhXUPWF1+RcSZZ3/R+KSbOEyYkRe5Zxqr+bSEY4gnbLb/CNfhc8dmtP/S6yteA4vC8OQ2NWBSNvEx9CGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714989658; c=relaxed/simple;
	bh=P5tko6/lyTWQ/u9uOI9iYPSwPgP63qpNA47f1bWVdG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghdxZgBG8WIiHx9PdVzKduf25vv+d9nqrvEUCJ1LQVHQXURBE9anSPFMrFG1trnh2liv+BEZy4Jf5XZB3l48GhtMU1K3nKTxXZ1MxxYAHPXrPFiSVC1vHmdPdvUA0VbBCtg5cb9sRh88F2bbxrZuWRmhejb3XylV6vxLPMglBWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 086AE106F;
	Mon,  6 May 2024 03:01:22 -0700 (PDT)
Received: from [10.163.35.238] (unknown [10.163.35.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D8243F793;
	Mon,  6 May 2024 03:00:53 -0700 (PDT)
Message-ID: <5f9e5d19-8a38-4e98-8cbb-e5501c76f740@arm.com>
Date: Mon, 6 May 2024 15:30:54 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memblock: discard .text/.data if
 CONFIG_ARCH_KEEP_MEMBLOCK not set
Content-Language: en-US
To: Wei Yang <richard.weiyang@gmail.com>, arnd@arndb.de, rppt@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240506012104.10864-1-richard.weiyang@gmail.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240506012104.10864-1-richard.weiyang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/6/24 06:51, Wei Yang wrote:
> When CONFIG_ARCH_KEEP_MEMBLOCK not set, we expect to discard related
> code and data. But it doesn't until CONFIG_MEMORY_HOTPLUG not set
> neither.

When CONFIG_ARCH_KEEP_MEMBLOCK is not set memblock information both for
normal and reserved memory get freed up but should the memblock related
code and data also be freed up as well ? Then I would also believe such
memory saving will be very minimal given CONFIG_ARCH_KEEP_MEMBLOCK code
is too limited scoped in the tree.

Also could you please explain how it is related to CONFIG_MEMORY_HOTPLUG
config being set or not.

> 
> This patch puts memblock's .text/.data into its own section, so that it
> only depends on CONFIG_ARCH_KEEP_MEMBLOCK to discard related code and
> data. After this, init size increase from 2420K to 2432K.

Is not this memory size saving some what insignificant to warrant a code
change ? Also is this problem applicable only to CONFIG_ARCH_KEEP_MEMBLOCK
config. Could you also provide details on how did you measure these numbers ?

> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 14 +++++++++++++-
>  include/linux/memblock.h          |  8 ++++----
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index f7749d0f2562..775c5eedb9e6 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -147,6 +147,14 @@
>  #define MEM_DISCARD(sec) *(.mem##sec)
>  #endif
>  
> +#if defined(CONFIG_ARCH_KEEP_MEMBLOCK)
> +#define MEMBLOCK_KEEP(sec)    *(.mb##sec)
> +#define MEMBLOCK_DISCARD(sec)
> +#else
> +#define MEMBLOCK_KEEP(sec)
> +#define MEMBLOCK_DISCARD(sec) *(.mb##sec)
> +#endif
> +
>  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>  #define KEEP_PATCHABLE		KEEP(*(__patchable_function_entries))
>  #define PATCHABLE_DISCARDS
> @@ -356,6 +364,7 @@
>  	*(.ref.data)							\
>  	*(.data..shared_aligned) /* percpu related */			\
>  	MEM_KEEP(init.data*)						\
> +	MEMBLOCK_KEEP(init.data*)					\
>  	*(.data.unlikely)						\
>  	__start_once = .;						\
>  	*(.data.once)							\
> @@ -573,6 +582,7 @@
>  		*(.ref.text)						\
>  		*(.text.asan.* .text.tsan.*)				\
>  	MEM_KEEP(init.text*)						\
> +	MEMBLOCK_KEEP(init.text*)					\
>  
>  
>  /* sched.text is aling to function alignment to secure we have same
> @@ -680,6 +690,7 @@
>  	KEEP(*(SORT(___kentry+*)))					\
>  	*(.init.data .init.data.*)					\
>  	MEM_DISCARD(init.data*)						\
> +	MEMBLOCK_DISCARD(init.data*)					\
>  	KERNEL_CTORS()							\
>  	MCOUNT_REC()							\
>  	*(.init.rodata .init.rodata.*)					\
> @@ -706,7 +717,8 @@
>  #define INIT_TEXT							\
>  	*(.init.text .init.text.*)					\
>  	*(.text.startup)						\
> -	MEM_DISCARD(init.text*)
> +	MEM_DISCARD(init.text*)						\
> +	MEMBLOCK_DISCARD(init.text*)
>  
>  #define EXIT_DATA							\
>  	*(.exit.data .exit.data.*)					\
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index e2082240586d..3e1f1d42dde7 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -100,13 +100,13 @@ struct memblock {
>  
>  extern struct memblock memblock;
>  
> +#define __init_memblock        __section(".mbinit.text") __cold notrace \
> +						  __latent_entropy
> +#define __initdata_memblock    __section(".mbinit.data")
> +
>  #ifndef CONFIG_ARCH_KEEP_MEMBLOCK
> -#define __init_memblock __meminit
> -#define __initdata_memblock __meminitdata
>  void memblock_discard(void);
>  #else
> -#define __init_memblock
> -#define __initdata_memblock
>  static inline void memblock_discard(void) {}
>  #endif
>  

