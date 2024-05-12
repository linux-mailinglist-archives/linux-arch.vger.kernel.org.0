Return-Path: <linux-arch+bounces-4343-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73808C37A2
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 18:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D2328136B
	for <lists+linux-arch@lfdr.de>; Sun, 12 May 2024 16:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7D246B9F;
	Sun, 12 May 2024 16:51:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49535DDD7;
	Sun, 12 May 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715532704; cv=none; b=FtSkCyiOFpBH8fWe+f9+c0Lr7y4Z9AP014sFNZPssWKn9zf3BBGX5jLG2m0+OyTuyO/enVMq0KpnaDk6edwUBI6ksk28xIQr39qpfmL7VJLkK+owmgOT+wfOmY9V57pxoMHcfhL6Dh31Nzs4+BUC3KU4XYn+Sc2HT9qGrUKXI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715532704; c=relaxed/simple;
	bh=u+mTLviAtKqkjVwjm67/CPoAoh0BegY5v8YMcgwh08k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkUUoXl8KP4lxQb2r1xY3A/G4egOa41N6ahy3ZMXszxIHMMP6mIHMgfO3VtyivmAKViovCf82tKoi+wXswBZyWQtc3u+VAkmf3wbZNYwFtiaA+YzjztMDrVk0LHRjep0TEdQMTYtgXNMTk5ca9TPnGQ7GfuGhbb0sUev4+J2NpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 28326240003;
	Sun, 12 May 2024 16:50:22 +0000 (UTC)
Message-ID: <d0e2d1a5-110a-40be-8662-7c78afe22446@ghiti.fr>
Date: Sun, 12 May 2024 18:50:18 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/29] riscv/mm: Implement map_shadow_stack() syscall
Content-Language: en-US
To: Deepak Gupta <debug@rivosinc.com>, paul.walmsley@sifive.com,
 rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
 kito.cheng@sifive.com, keescook@chromium.org, ajones@ventanamicro.com,
 conor.dooley@microchip.com, cleger@rivosinc.com, atishp@atishpatra.org,
 bjorn@rivosinc.com, alexghiti@rivosinc.com, samuel.holland@sifive.com,
 conor@kernel.org
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
 akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
 shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
 jerry.shih@sifive.com, hankuan.chen@sifive.com, greentime.hu@sifive.com,
 evan@rivosinc.com, xiao.w.wang@intel.com, charlie@rivosinc.com,
 apatel@ventanamicro.com, mchitale@ventanamicro.com,
 dbarboza@ventanamicro.com, sameo@rivosinc.com, shikemeng@huaweicloud.com,
 willy@infradead.org, vincent.chen@sifive.com, guoren@kernel.org,
 samitolvanen@google.com, songshuaishuai@tinylab.org, gerg@kernel.org,
 heiko@sntech.de, bhe@redhat.com, jeeheng.sia@starfivetech.com,
 cyy@cyyself.name, maskray@google.com, ancientmodern4@gmail.com,
 mathis.salmen@matsal.de, cuiyunhui@bytedance.com, bgray@linux.ibm.com,
 mpe@ellerman.id.au, baruch@tkos.co.il, alx@kernel.org, david@redhat.com,
 catalin.marinas@arm.com, revest@chromium.org, josh@joshtriplett.org,
 shr@devkernel.io, deller@gmx.de, omosnace@redhat.com, ojeda@kernel.org,
 jhubbard@nvidia.com
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-15-debug@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240403234054.2020347-15-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 04/04/2024 01:35, Deepak Gupta wrote:
> As discussed extensively in the changelog for the addition of this
> syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
> existing mmap() and madvise() syscalls do not map entirely well onto the
> security requirements for shadow stack memory since they lead to windows
> where memory is allocated but not yet protected or stacks which are not
> properly and safely initialised. Instead a new syscall map_shadow_stack()
> has been defined which allocates and initialises a shadow stack page.
>
> This patch implements this syscall for riscv. riscv doesn't require token
> to be setup by kernel because user mode can do that by itself. However to
> provide compatibility and portability with other architectues, user mode
> can specify token set flag.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/kernel/Makefile      |   2 +
>   arch/riscv/kernel/usercfi.c     | 149 ++++++++++++++++++++++++++++++++
>   include/uapi/asm-generic/mman.h |   1 +
>   3 files changed, 152 insertions(+)
>   create mode 100644 arch/riscv/kernel/usercfi.c
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 604d6bf7e476..3bec82f4e94c 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -107,3 +107,5 @@ obj-$(CONFIG_COMPAT)		+= compat_vdso/
>   
>   obj-$(CONFIG_64BIT)		+= pi/
>   obj-$(CONFIG_ACPI)		+= acpi.o
> +
> +obj-$(CONFIG_RISCV_USER_CFI) += usercfi.o
> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> new file mode 100644
> index 000000000000..c4ed0d4e33d6
> --- /dev/null
> +++ b/arch/riscv/kernel/usercfi.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Rivos, Inc.
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
> +	 * Since shadow stack is supported only in 64bit configuration,
> +	 * ssamoswap.d is used below.

> *        * CONFIG_RISCV_USER_CFI is dependent
> +	 * on 64BIT and compile of this file is dependent on CONFIG_RISCV_USER_CFI
> +	 * In case ssamoswap faults, return -1.


To me, this part of the comment is not needed.


> +	 * Never expect -1 on shadow stack. Expect return addresses and zero


In that case, should we BUG() instead?


> +	 */
> +	unsigned long swap = -1;
> +
> +	__enable_user_access();
> +	asm goto(
> +				".option push\n"
> +				".option arch, +zicfiss\n"
> +				"1: ssamoswap.d %[swap], %[val], %[addr]\n"
> +				_ASM_EXTABLE(1b, %l[fault])
> +				RISCV_ACQUIRE_BARRIER
> +				".option pop\n"
> +				: [swap] "=r" (swap), [addr] "+A" (*addr)
> +				: [val] "r" (val)
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
> +	addr = do_mmap(NULL, addr, size, PROT_READ, flags,


Hmmm why do you map the shadow stack as PROT_READ here?


> +				VM_SHADOW_STACK | VM_WRITE, 0, &populate, NULL);
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


I would use:

if (addr && (addr & (PAGE_SIZE - 1))


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
>   #define MCL_FUTURE	2		/* lock all future mappings */
>   #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
>   
> +#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
>   #endif /* __ASM_GENERIC_MMAN_H */


Don't we need to advertise this new syscall to the man pages?


