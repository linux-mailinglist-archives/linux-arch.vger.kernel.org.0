Return-Path: <linux-arch+bounces-4297-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536398C2B63
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 23:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17AB1F23705
	for <lists+linux-arch@lfdr.de>; Fri, 10 May 2024 21:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3A713B58E;
	Fri, 10 May 2024 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QcF/moWc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9547013B582
	for <linux-arch@vger.kernel.org>; Fri, 10 May 2024 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715374984; cv=none; b=Ak6tHY0Xos3OEZMpVQdbQWcSPp873KYVC7SElbs/UoUg8CngUvjSW2wx4a7cauGp+CpP2NoN0IsuBolYBt082MNtjMI1e3cZM5QWbSRwmfBdx6YJExbupA2WxXb/j+Ol/fvdAYhCWNoXClVSPuYSi/kZacOcHwFe9go1E+5DJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715374984; c=relaxed/simple;
	bh=ht8vGH+eRp4JoG/jKhm/l8eFU/thbckIPh38sPehaF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5C9vzkP40K6LTQAFLzPPmyvz4zggT06MVgZ+ljDH229Se8PKw3ff/WVxdZeyRrfMvLMGCxoys4jHigkw0G+OQfZp6Gc0VO9t+QyIvkDrtHzSeSqlUZf6snwUPZWkSGJXRRU2g/3FjkO117Tyu0ALcHVMmUniSqgTw2hkAbcjpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QcF/moWc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so22898025ad.1
        for <linux-arch@vger.kernel.org>; Fri, 10 May 2024 14:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715374981; x=1715979781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=70XwkvLb6QGypvEuEeEsNDMqohqQheU/3q6EeX2hHv8=;
        b=QcF/moWcoVOkvoI4qks4CBozZZsI65NNibOvax20jihPPaUqjR41OhTYQw5PkPw/4g
         cEKhhpYVubiz5zEaV/CChV9e7VchyrYfdlVgEyo4/R4zC3/L0QuOSqKFYui1LtE9HN0d
         rQYKQ6WRih3b+ZsGy8oD7M9EnJnC0A9ew57gmPn/VLZhdOKDvlosZcr/OeTEyTjEp4jA
         fyyZ3FEyt4NFQIX9GC84dBkJS39eB0U8LrBSYJQrwCRt9jAPh0J9uxtqD+R7OLBUyNTJ
         GcHFii1ZdEOELS/jicNu/TtYsgMbILlj0BmVCPLeweO5mHak9m6Wv68PGk1oWWy5MFql
         pT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715374981; x=1715979781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70XwkvLb6QGypvEuEeEsNDMqohqQheU/3q6EeX2hHv8=;
        b=kCVUGyYR/r9nOkqpM6RgHt/BXOIsVdi8Li7ZZsf6pSchLMTQFrD/IsqsLRX+NSi5xa
         sybRkE2i6GlreV7GftBD6E1EEMPpl+W165ruwsBsG9SABQ2qHe1Dz3ofdXedK+2EFQbO
         H1Jgoc7cO5iVevMF9oEXRR2M4jXamTksdrQVlh07JTjN299XmtvtD9iMAQtRMfFmyNkb
         3d+SNmVtjaoSegmigOu5gHXN2rzW6fxdmouQA2ouMBXERZ6z4TuxUmBAheRiTQQRTm99
         0CS7vVoY8ZWpnSMgv2Tojp9cK9At8N7IAyW1ByIS5VhXlpCOmD1RxEEw0nyWW7LgfmpX
         X0xw==
X-Forwarded-Encrypted: i=1; AJvYcCUSnzO0Oo7p0GX25wIqTTnkrEMzT/v6tVA/r7iwPGJHF+VqZ5MxgXOgvfMSTT5FBU/x5b/PszrSQRLy7vkQwSDAkFMWZBewblTTnw==
X-Gm-Message-State: AOJu0YxlsEW+WlyvjiNmx+1pAMGbGgm1Jk7oYZjLRnGUqvbwNsPr8eF4
	/0F1TxIHr4Vvq17IWjgBBaQWJBpj5VicvJgnwdeh/SxNiLUxnENmr4Xy5SallBI=
X-Google-Smtp-Source: AGHT+IHWLLpJM9kP3GIJnAD3PIjowIRI5CiaLB2E1fEGzbZDh0VtuOglA9xHF/Pw/rBd48Qyed+Qyg==
X-Received: by 2002:a17:903:228d:b0:1e5:a3b2:3dad with SMTP id d9443c01a7336-1ef43f51f2cmr48325145ad.42.1715374980776;
        Fri, 10 May 2024 14:03:00 -0700 (PDT)
Received: from ghost ([2601:647:5700:6860:629e:3f2:f321:6c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13873esm36725165ad.266.2024.05.10.14.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 14:03:00 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:54 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Deepak Gupta <debug@rivosinc.com>
Cc: paul.walmsley@sifive.com, rick.p.edgecombe@intel.com,
	broonie@kernel.org, Szabolcs.Nagy@arm.com, kito.cheng@sifive.com,
	keescook@chromium.org, ajones@ventanamicro.com,
	conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	apatel@ventanamicro.com, mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com, sameo@rivosinc.com,
	shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, david@redhat.com, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, shr@devkernel.io,
	deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com
Subject: Re: [PATCH v3 10/29] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
Message-ID: <Zj6LfpQhOjTLEx2O@ghost>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-11-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403234054.2020347-11-debug@rivosinc.com>

On Wed, Apr 03, 2024 at 04:34:58PM -0700, Deepak Gupta wrote:
> `arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
> VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
> updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
> This is to make sure that any existing apps using PROT_WRITE still work.
> 
> Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
> Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
> encodings for shadow stack. Above changes ensure that existing apps
> continue to work because underneath kernel will be picking
> `protection_map[VM_WRITE|VM_READ]` PTE encodings.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/mman.h    | 24 ++++++++++++++++++++++++
>  arch/riscv/include/asm/pgtable.h |  1 +
>  arch/riscv/kernel/sys_riscv.c    | 11 +++++++++++
>  arch/riscv/mm/init.c             |  2 +-
>  mm/mmap.c                        |  1 +
>  5 files changed, 38 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/mman.h
> 
> diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
> new file mode 100644
> index 000000000000..ef9fedf32546
> --- /dev/null
> +++ b/arch/riscv/include/asm/mman.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_MMAN_H__
> +#define __ASM_MMAN_H__
> +
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +#include <uapi/asm/mman.h>
> +
> +static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> +	unsigned long pkey __always_unused)
> +{
> +	unsigned long ret = 0;
> +
> +	/*
> +	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
> +	 * Only VM_WRITE means shadow stack.
> +	 */
> +	if (prot & PROT_WRITE)
> +		ret = (VM_READ | VM_WRITE);
> +	return ret;
> +}
> +#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> +
> +#endif /* ! __ASM_MMAN_H__ */
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 6066822e7396..4d5983bc6766 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -184,6 +184,7 @@ extern struct pt_alloc_ops pt_ops __initdata;
>  #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
>  #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
>  					 _PAGE_EXEC | _PAGE_WRITE)
> +#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
>  
>  #define PAGE_COPY		PAGE_READ
>  #define PAGE_COPY_EXEC		PAGE_READ_EXEC
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index f1c1416a9f1e..846c36b1b3d5 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -8,6 +8,8 @@
>  #include <linux/syscalls.h>
>  #include <asm/cacheflush.h>
>  #include <asm-generic/mman-common.h>
> +#include <vdso/vsyscall.h>
> +#include <asm/mman.h>
>  
>  static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>  			   unsigned long prot, unsigned long flags,
> @@ -17,6 +19,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>  	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
>  		return -EINVAL;
>  
> +	/*
> +	 * If only PROT_WRITE is specified then extend that to PROT_READ
> +	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
> +	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
> +	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
> +	 */
> +	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))

The comments says that this should extend to PROT_READ if only
PROT_WRITE is specified. This condition instead is checking if
PROT_WRITE is selected but PROT_READ is not. If prot is (VM_EXEC |
VM_WRITE) then it would be extended to (VM_EXEC | VM_WRITE | VM_READ).
This will not currently cause any issues because these both map to the
same value in the protection_map PAGE_COPY_EXEC, however this seems to
be not the intention of this change.

prot == PROT_WRITE better suits the condition explained in the comment.

> +		prot |= PROT_READ;
> +
>  	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
>  			       offset >> (PAGE_SHIFT - page_shift_offset));
>  }
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index fa34cf55037b..98e5ece4052a 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -299,7 +299,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>  static const pgprot_t protection_map[16] = {
>  	[VM_NONE]					= PAGE_NONE,
>  	[VM_READ]					= PAGE_READ,
> -	[VM_WRITE]					= PAGE_COPY,
> +	[VM_WRITE]					= PAGE_SHADOWSTACK,
>  	[VM_WRITE | VM_READ]				= PAGE_COPY,
>  	[VM_EXEC]					= PAGE_EXEC,
>  	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d89770eaab6b..57a974f49b00 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -47,6 +47,7 @@
>  #include <linux/oom.h>
>  #include <linux/sched/mm.h>
>  #include <linux/ksm.h>
> +#include <linux/processor.h>

It doesn't seem like this is necessary for this patch.

- Charlie

>  
>  #include <linux/uaccess.h>
>  #include <asm/cacheflush.h>
> -- 
> 2.43.2
> 

