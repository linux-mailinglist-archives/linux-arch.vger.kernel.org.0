Return-Path: <linux-arch+bounces-14988-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D646C738E9
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 11:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0DC6355898
	for <lists+linux-arch@lfdr.de>; Thu, 20 Nov 2025 10:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67D3277CA4;
	Thu, 20 Nov 2025 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="BIl5qm13"
X-Original-To: linux-arch@vger.kernel.org
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40672FDC4C;
	Thu, 20 Nov 2025 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.28.160.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763635761; cv=none; b=fMiqY9Fd/8a29AXw+DOXWLEUsG22BCZwCay26DjeaX6oSNmBXiar8FkBEgP3hM6dj12aQuF5eO9f7KV38lSd5ZZEQdNPkoQJdLiMCZ51oM81TwNVyHgAT4Ly+L7LtyGf7adoDjJiCbfJlfXwdY6PNAcMW7+OH0uM1TG90sCbKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763635761; c=relaxed/simple;
	bh=Dpo93d0Xn+a2sO/3PRWqEkPL1WIkgkdVNVES7XVrkBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRfotkte4BrDPJEOjDI7YS7Yspg8Z64wu2U71eu16cmcw/7O73ZWIzM1CmI/C7+2D1yqNs5wnXoblfMe6WJjEFpUgHW6nCzyMxmVi+vBrillI7+LX8lE13wreZn/MnKyC6QQbBiXKnm3zO8KlpCeS7IPPWiUqTHgkjde8tC+LeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name; spf=pass smtp.mailfrom=xen0n.name; dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b=BIl5qm13; arc=none smtp.client-ip=115.28.160.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen0n.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
	t=1763635230; bh=Dpo93d0Xn+a2sO/3PRWqEkPL1WIkgkdVNVES7XVrkBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BIl5qm13f9EggIypAr7VBGYAcW0f9aAPjnCyB3gxVJe8Poh/T2Jr977E4RPjWUoKT
	 UWxvfoiT2wNx4DFUl+USw2LuVsZnwnaeqXfDyjEajxunjyxmLftwmf0vcFDpGuN2tR
	 IDGQgbdAV6WZ7A9kokiVRSDEj2MLP1d4/T4z9v94=
Received: from [28.0.0.1] (unknown [IPv6:240e:30f:307:db01:18aa:f52:2bb9:3])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailbox.box.xen0n.name (Postfix) with ESMTPSA id BF756600F4;
	Thu, 20 Nov 2025 18:40:29 +0800 (CST)
Message-ID: <a13a5f0b-49ca-4116-8654-5bc57c0ca6a0@xen0n.name>
Date: Thu, 20 Nov 2025 18:40:28 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 09/14] LoongArch: Adjust system call for 32BIT/64BIT
To: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
 Xuefeng Li <lixuefeng@loongson.cn>, Guo Ren <guoren@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
 <20251118112728.571869-10-chenhuacai@loongson.cn>
Content-Language: en-US
From: WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20251118112728.571869-10-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/25 19:27, Huacai Chen wrote:
> Adjust system call for both 32BIT and 64BIT, including: add the uapi
> unistd_{32,64}.h and syscall_table_{32,64}.h inclusion, add sys_mmap2()
> definition, change the system call entry routines, etc.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/Kbuild        |  1 +
>   arch/loongarch/include/uapi/asm/Kbuild   |  1 +
>   arch/loongarch/include/uapi/asm/unistd.h |  6 ++++++
>   arch/loongarch/kernel/Makefile.syscalls  |  1 +
>   arch/loongarch/kernel/entry.S            | 22 +++++++++++-----------
>   arch/loongarch/kernel/syscall.c          | 13 +++++++++++++
>   6 files changed, 33 insertions(+), 11 deletions(-)
> 
> [snip]
> diff --git a/arch/loongarch/kernel/syscall.c b/arch/loongarch/kernel/syscall.c
> index ab94eb5ce039..1249d82c1cd0 100644
> --- a/arch/loongarch/kernel/syscall.c
> +++ b/arch/loongarch/kernel/syscall.c
> @@ -34,9 +34,22 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len, unsigned long,
>   	return ksys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
>   }
>   
> +SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len, unsigned long,
> +		 prot, unsigned long, flags, unsigned long, fd, unsigned long, offset)
> +{
> +	if (offset & (~PAGE_MASK >> 12))
> +		return -EINVAL;
> +
> +	return ksys_mmap_pgoff(addr, len, prot, flags, fd, offset >> (PAGE_SHIFT - 12));
> +}
> +

Why not guard this with #ifdef CONFIG_32BIT?

>   void *sys_call_table[__NR_syscalls] = {
>   	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
> +#ifdef CONFIG_32BIT
> +#include <asm/syscall_table_32.h>
> +#else
>   #include <asm/syscall_table_64.h>
> +#endif
>   };
>   
>   typedef long (*sys_call_fn)(unsigned long, unsigned long,

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

