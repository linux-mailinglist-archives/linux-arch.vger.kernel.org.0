Return-Path: <linux-arch+bounces-1694-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7B083CE75
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 22:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B255F1F2836F
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 21:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9C613A269;
	Thu, 25 Jan 2024 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="WspdAUIE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428BE13A24B
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706217865; cv=none; b=E5UmF96v6/B56pvprmQ1cdqkuyynFeS4lyIWn18MzNsKVcVvqLa4B20CYpUhOpQ9k9PhLHFqjRs/pqplvAmaG1JsxqwdS6c3kCYW/Z9yZxBVTzMXDtmCsqB2cvt3bpSJkncnOzKSckeBTZh2RcgnTUlDslTEnaWkEeQQ8vlTy7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706217865; c=relaxed/simple;
	bh=tHMBMbsAsM3IXeBIrKPdzVCQltyNYuAPz6fP7IR+O8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIyWmT4NXSQQExvBTuH16pz7ZY5LhO3i4knBfi0pKw1yOsd5sZseG5HyEFGx8d4O3/utZlKOtUmDDHEIXRvOla6LdTI2rG7DevkIfyH0ggRccCRn77i/9w/J+Z92nij+bpZsju0TItHq2W4Fw/bux149sqySzdfR5/OKabqo2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=WspdAUIE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d71e184695so31492715ad.3
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 13:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706217861; x=1706822661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZoT2G19TBg11JNaEabcqd35tlnxoe/xDz/ZFeMpMZQ=;
        b=WspdAUIEb77G5QPdkXdLpWooF/wcW8YHG9eDseiHXKlOlo9DEq6rb/B32H4MSiIKbo
         1hPW1jfR8fKBuUF8VA9a+W05Drso1f69RLZKPeZYUJ6Wsqb7tkKqS/JpLKK6BO2MHqc3
         1E1oviIjaI48/VMcBFX6EQi3LCNletDb8tZatecr+6V6CVwbtM9bIafaaNo3CXBm+rqS
         zsG6FYjyvQVwP1XROUTpdU1gpJMiscap6uU/QwoAtngvZHbNLus5+84ihOIHr/wo8wZ6
         JxIvarVUw0zDV5RiNm29xepkaIrgfTA3UsjGqrp0mtjf6XbAxpx7fJtsPmXwuZp1lKGY
         xXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706217861; x=1706822661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZoT2G19TBg11JNaEabcqd35tlnxoe/xDz/ZFeMpMZQ=;
        b=Q5ycQ46AJQXSlTQlcflOBQJdTIH0aOary6aufng1x5jUBBQrGuqe6n/yIKlG7Ofg73
         NbN1FWzJw6fHS70MgGPBwkFyz43gIh1xz/jgPFepR9WltVFpXhy0stUPKfP6AB5WlFWs
         d45i02oNvV1NqoR6G7zLKQAr+UY5vGIdBuo6vJAgt9NasAuUuizwTma2ckTuU0OghAPp
         u3RDV3Zlgs8b5szCy8Wak0b6CBfFLEe2Nr7D4QHiyuQ6c4G+zjaKFWK8Fd4uuoO/tSt2
         4PWNzOC2RlbbbdkLkgag6EEwToiHVMsJyEixzEbjSyKYRKkd4wDFr6E/Y73SBpU8fcVa
         O4Tw==
X-Gm-Message-State: AOJu0YzUEc1Hz0dFu0TvA2MGVlKqY4+oXBrRfw7XSNMASYeiUm/ExfwH
	Lnh/3D4J3yshg8ihMyzK8l5DVZOmC4L+fQsF9D06gy2QLxw931hvAQn22ANC2/M=
X-Google-Smtp-Source: AGHT+IGvjaE/JTMbYh7Rdf5yyt9F1/RX+/vud6/Lnw+WvAKkovbLy31AhW1vaTpjsJmHDLgapvOZag==
X-Received: by 2002:a17:902:db09:b0:1d0:98d8:955c with SMTP id m9-20020a170902db0900b001d098d8955cmr344975plx.124.1706217861416;
        Thu, 25 Jan 2024 13:24:21 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id ml5-20020a17090334c500b001d8921f2058sm989116plb.205.2024.01.25.13.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 13:24:21 -0800 (PST)
Date: Thu, 25 Jan 2024 13:24:16 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: debug@rivosinc.com
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, corbet@lwn.net, aou@eecs.berkeley.edu,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, shuah@kernel.org, brauner@kernel.org,
	guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
	shikemeng@huaweicloud.com, david@redhat.com,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	vincent.chen@sifive.com, andy.chiu@sifive.com, gerg@kernel.org,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, chenjiahao16@huawei.com,
	ruscur@russell.cc, bgray@linux.ibm.com, alx@kernel.org,
	baruch@tkos.co.il, zhangqing@loongson.cn, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, joey.gouly@arm.com,
	shr@devkernel.io, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 15/28] riscv/mm: Implement map_shadow_stack()
 syscall
Message-ID: <ZbLRgEVZvh7LE+k/@ghost>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-16-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125062739.1339782-16-debug@rivosinc.com>

On Wed, Jan 24, 2024 at 10:21:40PM -0800, debug@rivosinc.com wrote:
> From: Deepak Gupta <debug@rivosinc.com>
> 
> As discussed extensively in the changelog for the addition of this
> syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
> existing mmap() and madvise() syscalls do not map entirely well onto the
> security requirements for guarded control stacks since they lead to
> windows where memory is allocated but not yet protected or stacks which
> are not properly and safely initialised. Instead a new syscall
> map_shadow_stack() has been defined which allocates and initialises a
> shadow stack page.
> 
> This patch implements this syscall for riscv. riscv doesn't require token
> to be setup by kernel because user mode can do that by itself. However to
> provide compatiblity and portability with other architectues, user mode can
> specify token set flag.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/kernel/Makefile      |   2 +
>  arch/riscv/kernel/usercfi.c     | 150 ++++++++++++++++++++++++++++++++
>  include/uapi/asm-generic/mman.h |   1 +
>  3 files changed, 153 insertions(+)
>  create mode 100644 arch/riscv/kernel/usercfi.c
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index fee22a3d1b53..8c668269e886 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -102,3 +102,5 @@ obj-$(CONFIG_COMPAT)		+= compat_vdso/
>  
>  obj-$(CONFIG_64BIT)		+= pi/
>  obj-$(CONFIG_ACPI)		+= acpi.o
> +
> +obj-$(CONFIG_RISCV_USER_CFI) += usercfi.o
> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> new file mode 100644
> index 000000000000..35ede2cbc05b
> --- /dev/null
> +++ b/arch/riscv/kernel/usercfi.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 Rivos, Inc.
Nit: Should be updated to 2024
> + * Deepak Gupta <debug@rivosinc.com>
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/bitops.h>
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/uaccess.h>
> +#include <linux/sizes.h>
> +#include <linux/user.h>
> +#include <linux/syscalls.h>
> +#include <linux/prctl.h>
> +#include <asm/csr.h>
> +#include <asm/usercfi.h>
> +
> +#define SHSTK_ENTRY_SIZE sizeof(void *)
> +
> +/*
> + * Writes on shadow stack can either be `sspush` or `ssamoswap`. `sspush` can happen
> + * implicitly on current shadow stack pointed to by CSR_SSP. `ssamoswap` takes pointer to
> + * shadow stack. To keep it simple, we plan to use `ssamoswap` to perform writes on shadow
> + * stack.
> + */
> +static noinline unsigned long amo_user_shstk(unsigned long *addr, unsigned long val)
> +{
> +	/*
> +	 * In case ssamoswap faults, return -1.
> +	 * Never expect -1 on shadow stack. Expect return addresses and zero
> +	 */
> +	unsigned long swap = -1;
> +
> +	__enable_user_access();
> +	asm_volatile_goto(
> +				".option push\n"
> +				".option arch, +zicfiss\n"
> +#ifdef CONFIG_64BIT
> +				"1: ssamoswap.d %0, %2, %1\n"
> +#else
> +				"1: ssamoswap.w %0, %2, %1\n"

A SSAMOSWAP macro that conditionally defines this would be cleaner

> +#endif
> +				_ASM_EXTABLE(1b, %l[fault])
> +				RISCV_ACQUIRE_BARRIER
> +				".option pop\n"
> +				: "=r" (swap), "+A" (*addr)

I just ran into this on one of my patches that not every compiler
supports output args in asm goto blocks. You need to guard this with the
kconfig option CC_HAS_ASM_GOTO_TIED_OUTPUT. Unfortunately, that means
that this code needs two versions, or you can choose to gate CFI behind
this option, it's supported by recent versions of GCC/CLANG.

For readability it is also nice to use labels for the asm variables such
as `"=r" (swap)` can be `[swap] "=r" (swap)` and then replace %0 with
%[swap].

- Charlie

> +				: "r" (val)
> +				: "memory"
> +				: fault
> +			);
> +	__disable_user_access();
> +	return swap;
> +fault:
> +	__disable_user_access();
> +	return -1;
> +}
> +
> +/*
> + * Create a restore token on the shadow stack.  A token is always XLEN wide
> + * and aligned to XLEN.
> + */
> +static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
> +{
> +	unsigned long addr;
> +
> +	/* Token must be aligned */
> +	if (!IS_ALIGNED(ssp, SHSTK_ENTRY_SIZE))
> +		return -EINVAL;
> +
> +	/* On RISC-V we're constructing token to be function of address itself */
> +	addr = ssp - SHSTK_ENTRY_SIZE;
> +
> +	if (amo_user_shstk((unsigned long __user *)addr, (unsigned long) ssp) == -1)
> +		return -EFAULT;
> +
> +	if (token_addr)
> +		*token_addr = addr;
> +
> +	return 0;
> +}
> +
> +static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long size,
> +				unsigned long token_offset,
> +				bool set_tok)
> +{
> +	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
> +	struct mm_struct *mm = current->mm;
> +	unsigned long populate, tok_loc = 0;
> +
> +	if (addr)
> +		flags |= MAP_FIXED_NOREPLACE;
> +
> +	mmap_write_lock(mm);
> +	addr = do_mmap(NULL, addr, size, PROT_SHADOWSTACK, flags,
> +				VM_SHADOW_STACK, 0, &populate, NULL);
> +	mmap_write_unlock(mm);
> +
> +	if (!set_tok || IS_ERR_VALUE(addr))
> +		goto out;
> +
> +	if (create_rstor_token(addr + token_offset, &tok_loc)) {
> +		vm_munmap(addr, size);
> +		return -EINVAL;
> +	}
> +
> +	addr = tok_loc;
> +
> +out:
> +	return addr;
> +}
> +
> +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
> +{
> +	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
> +	unsigned long aligned_size = 0;
> +
> +	if (!cpu_supports_shadow_stack())
> +		return -EOPNOTSUPP;
> +
> +	/* Anything other than set token should result in invalid param */
> +	if (flags & ~SHADOW_STACK_SET_TOKEN)
> +		return -EINVAL;
> +
> +	/*
> +	 * Unlike other architectures, on RISC-V, SSP pointer is held in CSR_SSP and is available
> +	 * CSR in all modes. CSR accesses are performed using 12bit index programmed in instruction
> +	 * itself. This provides static property on register programming and writes to CSR can't
> +	 * be unintentional from programmer's perspective. As long as programmer has guarded areas
> +	 * which perform writes to CSR_SSP properly, shadow stack pivoting is not possible. Since
> +	 * CSR_SSP is writeable by user mode, it itself can setup a shadow stack token subsequent
> +	 * to allocation. Although in order to provide portablity with other architecture (because
> +	 * `map_shadow_stack` is arch agnostic syscall), RISC-V will follow expectation of a token
> +	 * flag in flags and if provided in flags, setup a token at the base.
> +	 */
> +
> +	/* If there isn't space for a token */
> +	if (set_tok && size < SHSTK_ENTRY_SIZE)
> +		return -ENOSPC;
> +
> +	if (addr && (addr % PAGE_SIZE))
> +		return -EINVAL;
> +
> +	aligned_size = PAGE_ALIGN(size);
> +	if (aligned_size < size)
> +		return -EOVERFLOW;
> +
> +	return allocate_shadow_stack(addr, aligned_size, size, set_tok);
> +}
> diff --git a/include/uapi/asm-generic/mman.h b/include/uapi/asm-generic/mman.h
> index 57e8195d0b53..0c0ac6214de6 100644
> --- a/include/uapi/asm-generic/mman.h
> +++ b/include/uapi/asm-generic/mman.h
> @@ -19,4 +19,5 @@
>  #define MCL_FUTURE	2		/* lock all future mappings */
>  #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
>  
> +#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
>  #endif /* __ASM_GENERIC_MMAN_H */
> -- 
> 2.43.0
> 

