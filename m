Return-Path: <linux-arch+bounces-12262-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09568AD0D99
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 15:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37CDC3A8E47
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08122221FC1;
	Sat,  7 Jun 2025 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="b248/oQa"
X-Original-To: linux-arch@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400351C1F05;
	Sat,  7 Jun 2025 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749301920; cv=none; b=OxTJiNdRHlGhkEXrOw//5IQ72/MAqyjGdyJvbwVmFdtY26Gc8xKa/lrC3m5ucNB05qcfNKtPpZIp8lwvMK8K89H+EFQxc6zZ6b7bqArfGpxzrvf8OCH/MOK3fjKyOX7f+8AL1F8i3Aq0tRAum844+xbF33XxE8IlrMrIgLUmfOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749301920; c=relaxed/simple;
	bh=Ai7NAnv5K+kMHZxpoFbINR2CBhqG0P+RKU4aX2dYOxw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PhkLatoo+rA+wmB6AJ0g1AO3CmuDZvLBzzCDQPHv36fjnpDg3CC1ahlO9Ar6rIbH7AdhbnOLkR3v3D0NW+677XeGwTnPow/UB34k/IDt43xhQaKJ6mnqVdHxnkwmH3IZUph8KotWTbl0VtbVXzHV2EtDTHfelm3H68Fs1qEhwqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=b248/oQa; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jrVwKzGPjckLkzNJjHBIKlpaV73c0aS3LTClbKsc998=; t=1749301918; x=1749906718; 
	b=b248/oQa/+LrZua1EKuv8AqRbYirupf0D2tv3+UMhk3+HOBxWGOYLywz8nbXCRdtvqQv/1eLJ8r
	JoHj2DvtzJQ2keC+W94B9176CHF0EJ8NsQMkqWMPtpm8kOEdXjLptYtZF4OyU3cLLVLN87OQX9DiL
	NltO6M7SYdfDLc2cBIOv91Bi3vJJXmoTsjK12A7/Wmdinuvpgv8ZUtdXiSm3jFpQQbZvsau/RgOvA
	IGiicKakccEJTpXgRzFpz/ECZTmOC0eSWTHKhB3rVWb2xXInHUUmPmCYkQU5yU12uMy9xnPwyXpFA
	eFyMgQxdfqON3TiCDWobzgzdFEYcbQ05Gt1g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uNtL2-00000001oUO-0wWd; Sat, 07 Jun 2025 15:11:56 +0200
Received: from p5b13afe4.dip0.t-ipconnect.de ([91.19.175.228] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uNtL1-00000003P5x-3y0E; Sat, 07 Jun 2025 15:11:56 +0200
Message-ID: <28e5dd815b7169da93c43245e1b362bca0968a41.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 32/41] sh: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 the SuperH headers
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Yoshinori
 Sato	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	linux-sh@vger.kernel.org
Date: Sat, 07 Jun 2025 15:11:54 +0200
In-Reply-To: <20250314071013.1575167-33-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
	 <20250314071013.1575167-33-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Thomas,

On Fri, 2025-03-14 at 08:10 +0100, Thomas Huth wrote:
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, or when dealing with uapi headers that
> rather should use __ASSEMBLER__ instead. So let's standardize on
> the __ASSEMBLER__ macro that is provided by the compilers now.
>=20
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).
>=20
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/sh/include/asm/cache.h                   |  4 ++--
>  arch/sh/include/asm/dwarf.h                   |  6 +++---
>  arch/sh/include/asm/fpu.h                     |  4 ++--
>  arch/sh/include/asm/ftrace.h                  |  8 ++++----
>  arch/sh/include/asm/mmu.h                     |  4 ++--
>  arch/sh/include/asm/page.h                    |  8 ++++----
>  arch/sh/include/asm/pgtable.h                 |  4 ++--
>  arch/sh/include/asm/pgtable_32.h              |  8 ++++----
>  arch/sh/include/asm/processor.h               |  4 ++--
>  arch/sh/include/asm/smc37c93x.h               |  4 ++--
>  arch/sh/include/asm/suspend.h                 |  2 +-
>  arch/sh/include/asm/thread_info.h             | 10 +++++-----
>  arch/sh/include/asm/tlb.h                     |  4 ++--
>  arch/sh/include/asm/types.h                   |  4 ++--
>  arch/sh/include/mach-common/mach/romimage.h   |  6 +++---
>  arch/sh/include/mach-ecovec24/mach/romimage.h |  6 +++---
>  arch/sh/include/mach-kfr2r09/mach/romimage.h  |  6 +++---
>  17 files changed, 46 insertions(+), 46 deletions(-)
>=20
> diff --git a/arch/sh/include/asm/cache.h b/arch/sh/include/asm/cache.h
> index b38dbc9755811..e7ac9c9502751 100644
> --- a/arch/sh/include/asm/cache.h
> +++ b/arch/sh/include/asm/cache.h
> @@ -22,7 +22,7 @@
> =20
>  #define __read_mostly __section(".data..read_mostly")
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  struct cache_info {
>  	unsigned int ways;		/* Number of cache ways */
>  	unsigned int sets;		/* Number of cache sets */
> @@ -48,5 +48,5 @@ struct cache_info {
> =20
>  	unsigned long flags;
>  };
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>  #endif /* __ASM_SH_CACHE_H */
> diff --git a/arch/sh/include/asm/dwarf.h b/arch/sh/include/asm/dwarf.h
> index 5719544741221..f46d18b84833f 100644
> --- a/arch/sh/include/asm/dwarf.h
> +++ b/arch/sh/include/asm/dwarf.h
> @@ -189,7 +189,7 @@
>   */
>  #define DWARF_ARCH_RA_REG	17
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <linux/compiler.h>
>  #include <linux/bug.h>
> @@ -379,7 +379,7 @@ extern int module_dwarf_finalize(const Elf_Ehdr *, co=
nst Elf_Shdr *,
>  				 struct module *);
>  extern void module_dwarf_cleanup(struct module *);
> =20
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
> =20
>  #define CFI_STARTPROC	.cfi_startproc
>  #define CFI_ENDPROC	.cfi_endproc
> @@ -402,7 +402,7 @@ extern void module_dwarf_cleanup(struct module *);
>  #define CFI_REL_OFFSET	CFI_IGNORE
>  #define CFI_UNDEFINED	CFI_IGNORE
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  static inline void dwarf_unwinder_init(void)
>  {
>  }
> diff --git a/arch/sh/include/asm/fpu.h b/arch/sh/include/asm/fpu.h
> index 0379f4cce5ed2..a086e38b70eef 100644
> --- a/arch/sh/include/asm/fpu.h
> +++ b/arch/sh/include/asm/fpu.h
> @@ -2,7 +2,7 @@
>  #ifndef __ASM_SH_FPU_H
>  #define __ASM_SH_FPU_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #include <asm/ptrace.h>
> =20
> @@ -67,6 +67,6 @@ static inline void clear_fpu(struct task_struct *tsk, s=
truct pt_regs *regs)
>  void float_raise(unsigned int flags);
>  int float_rounding_mode(void);
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> =20
>  #endif /* __ASM_SH_FPU_H */
> diff --git a/arch/sh/include/asm/ftrace.h b/arch/sh/include/asm/ftrace.h
> index 1c10e10663909..d35781ab716ef 100644
> --- a/arch/sh/include/asm/ftrace.h
> +++ b/arch/sh/include/asm/ftrace.h
> @@ -7,7 +7,7 @@
>  #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
>  #define FTRACE_SYSCALL_MAX	NR_syscalls
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  extern void mcount(void);
> =20
>  #define MCOUNT_ADDR		((unsigned long)(mcount))
> @@ -35,10 +35,10 @@ static inline unsigned long ftrace_call_adjust(unsign=
ed long addr)
> =20
>  void prepare_ftrace_return(unsigned long *parent, unsigned long self_add=
r);
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>  #endif /* CONFIG_FUNCTION_TRACER */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  /* arch/sh/kernel/return_address.c */
>  extern void *return_address(unsigned int);
> @@ -53,6 +53,6 @@ static inline void arch_ftrace_nmi_enter(void) { }
>  static inline void arch_ftrace_nmi_exit(void) { }
>  #endif
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> =20
>  #endif /* __ASM_SH_FTRACE_H */
> diff --git a/arch/sh/include/asm/mmu.h b/arch/sh/include/asm/mmu.h
> index 172e329fd92d0..b9c9f91e66165 100644
> --- a/arch/sh/include/asm/mmu.h
> +++ b/arch/sh/include/asm/mmu.h
> @@ -33,7 +33,7 @@
> =20
>  #define PMB_NO_ENTRY		(-1)
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <linux/errno.h>
>  #include <linux/threads.h>
>  #include <asm/page.h>
> @@ -102,6 +102,6 @@ pmb_remap(phys_addr_t phys, unsigned long size, pgpro=
t_t prot)
>  	return pmb_remap_caller(phys, size, prot, __builtin_return_address(0));
>  }
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> =20
>  #endif /* __MMU_H */
> diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
> index 3990cbd9aa044..def4205491ec9 100644
> --- a/arch/sh/include/asm/page.h
> +++ b/arch/sh/include/asm/page.h
> @@ -30,7 +30,7 @@
>  #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT-PAGE_SHIFT)
>  #endif
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <asm/uncached.h>
> =20
>  extern unsigned long shm_align_mask;
> @@ -85,7 +85,7 @@ typedef struct page *pgtable_t;
> =20
>  #define pte_pgprot(x) __pgprot(pte_val(x) & PTE_FLAGS_MASK)
> =20
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
> =20
>  /*
>   * __MEMORY_START and SIZE are the physical addresses and size of RAM.
> @@ -126,10 +126,10 @@ typedef struct page *pgtable_t;
>  #define ___va(x)	((x)+PAGE_OFFSET)
>  #endif
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #define __pa(x)		___pa((unsigned long)x)
>  #define __va(x)		(void *)___va((unsigned long)x)
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
> =20
>  #ifdef CONFIG_UNCACHED_MAPPING
>  #if defined(CONFIG_29BIT)
> diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.=
h
> index 729f5c6225fbb..10fa8f2bb8d1f 100644
> --- a/arch/sh/include/asm/pgtable.h
> +++ b/arch/sh/include/asm/pgtable.h
> @@ -17,7 +17,7 @@
>  #include <asm/page.h>
>  #include <asm/mmu.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <asm/addrspace.h>
>  #include <asm/fixmap.h>
> =20
> @@ -28,7 +28,7 @@
>  extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>  #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
> =20
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
> =20
>  /*
>   * Effective and physical address definitions, to aid with sign
> diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtab=
le_32.h
> index f939f1215232c..bb9f9a2fc85c0 100644
> --- a/arch/sh/include/asm/pgtable_32.h
> +++ b/arch/sh/include/asm/pgtable_32.h
> @@ -170,7 +170,7 @@ static inline unsigned long copy_ptea_attributes(unsi=
gned long x)
>  	(PTE_MASK | _PAGE_ACCESSED | _PAGE_CACHABLE | \
>  	 _PAGE_DIRTY | _PAGE_SPECIAL)
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #if defined(CONFIG_X2TLB) /* SH-X2 TLB */
>  #define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_CACHABLE | \
> @@ -287,9 +287,9 @@ static inline unsigned long copy_ptea_attributes(unsi=
gned long x)
>  				__pgprot(0)
>  #endif
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  /*
>   * Certain architectures need to do special things when PTEs
> @@ -486,5 +486,5 @@ static inline int pte_swp_exclusive(pte_t pte)
>  PTE_BIT_FUNC(low, swp_mkexclusive, |=3D _PAGE_SWP_EXCLUSIVE);
>  PTE_BIT_FUNC(low, swp_clear_exclusive, &=3D ~_PAGE_SWP_EXCLUSIVE);
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>  #endif /* __ASM_SH_PGTABLE_32_H */
> diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/proces=
sor.h
> index 73fba7c922f92..2a0b5713ab80e 100644
> --- a/arch/sh/include/asm/processor.h
> +++ b/arch/sh/include/asm/processor.h
> @@ -5,7 +5,7 @@
>  #include <asm/cpu-features.h>
>  #include <asm/cache.h>
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  /*
>   *  CPU type and hardware bug flags. Kept separately for each CPU.
>   *
> @@ -168,7 +168,7 @@ extern unsigned int instruction_size(unsigned int ins=
n);
> =20
>  void select_idle_routine(void);
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> =20
>  #include <asm/processor_32.h>
> =20
> diff --git a/arch/sh/include/asm/smc37c93x.h b/arch/sh/include/asm/smc37c=
93x.h
> index 891f2f8f2fd03..caf4cd8dd2411 100644
> --- a/arch/sh/include/asm/smc37c93x.h
> +++ b/arch/sh/include/asm/smc37c93x.h
> @@ -67,7 +67,7 @@
>  #define UART_DLL	0x0	/* Divisor Latch (LS) */
>  #define UART_DLM	0x2	/* Divisor Latch (MS) */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  typedef struct uart_reg {
>  	volatile __u16 rbr;
>  	volatile __u16 ier;
> @@ -78,7 +78,7 @@ typedef struct uart_reg {
>  	volatile __u16 msr;
>  	volatile __u16 scr;
>  } uart_reg;
> -#endif /* ! __ASSEMBLY__ */
> +#endif /* ! __ASSEMBLER__ */
> =20
>  /* Alias for Write Only Register */
> =20
> diff --git a/arch/sh/include/asm/suspend.h b/arch/sh/include/asm/suspend.=
h
> index 47db17520261e..0f991babc5597 100644
> --- a/arch/sh/include/asm/suspend.h
> +++ b/arch/sh/include/asm/suspend.h
> @@ -2,7 +2,7 @@
>  #ifndef _ASM_SH_SUSPEND_H
>  #define _ASM_SH_SUSPEND_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <linux/notifier.h>
> =20
>  #include <asm/ptrace.h>
> diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thre=
ad_info.h
> index 9f19a682d315f..471db51730361 100644
> --- a/arch/sh/include/asm/thread_info.h
> +++ b/arch/sh/include/asm/thread_info.h
> @@ -21,7 +21,7 @@
>  #define FAULT_CODE_PROT		(1 << 3)	/* protection fault */
>  #define FAULT_CODE_USER		(1 << 4)	/* user-mode access */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <asm/processor.h>
> =20
>  struct thread_info {
> @@ -49,7 +49,7 @@ struct thread_info {
>  /*
>   * macros/functions for gaining access to the thread information structu=
re
>   */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #define INIT_THREAD_INFO(tsk)			\
>  {						\
>  	.task		=3D &tsk,			\
> @@ -86,7 +86,7 @@ static inline struct thread_info *current_thread_info(v=
oid)
> =20
>  extern void init_thread_xstate(void);
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> =20
>  /*
>   * Thread information flags
> @@ -144,7 +144,7 @@ extern void init_thread_xstate(void);
>   */
>  #define TS_USEDFPU		0x0002	/* FPU used by this task this quantum */
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  #define TI_FLAG_FAULT_CODE_SHIFT	24
> =20
> @@ -164,5 +164,5 @@ static inline unsigned int get_thread_fault_code(void=
)
>  	return ti->flags >> TI_FLAG_FAULT_CODE_SHIFT;
>  }
> =20
> -#endif	/* !__ASSEMBLY__ */
> +#endif	/* !__ASSEMBLER__ */
>  #endif /* __ASM_SH_THREAD_INFO_H */
> diff --git a/arch/sh/include/asm/tlb.h b/arch/sh/include/asm/tlb.h
> index ddf324bfb9a09..39df40d0ebc29 100644
> --- a/arch/sh/include/asm/tlb.h
> +++ b/arch/sh/include/asm/tlb.h
> @@ -2,7 +2,7 @@
>  #ifndef __ASM_SH_TLB_H
>  #define __ASM_SH_TLB_H
> =20
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  #include <linux/pagemap.h>
>  #include <asm-generic/tlb.h>
> =20
> @@ -29,5 +29,5 @@ asmlinkage int handle_tlbmiss(struct pt_regs *regs, uns=
igned long error_code,
>  			      unsigned long address);
> =20
>  #endif /* CONFIG_MMU */
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>  #endif /* __ASM_SH_TLB_H */
> diff --git a/arch/sh/include/asm/types.h b/arch/sh/include/asm/types.h
> index 9b3fc923ee287..fec3e89df0b10 100644
> --- a/arch/sh/include/asm/types.h
> +++ b/arch/sh/include/asm/types.h
> @@ -7,10 +7,10 @@
>  /*
>   * These aren't exported outside the kernel to avoid name space clashes
>   */
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
> =20
>  typedef u16 insn_size_t;
>  typedef u32 reg_size_t;
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>  #endif /* __ASM_SH_TYPES_H */
> diff --git a/arch/sh/include/mach-common/mach/romimage.h b/arch/sh/includ=
e/mach-common/mach/romimage.h
> index 1915714263aab..22fb47ec9b152 100644
> --- a/arch/sh/include/mach-common/mach/romimage.h
> +++ b/arch/sh/include/mach-common/mach/romimage.h
> @@ -1,12 +1,12 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifdef __ASSEMBLY__
> +#ifdef __ASSEMBLER__
> =20
>  /* do nothing here by default */
> =20
> -#else /* __ASSEMBLY__ */
> +#else /* __ASSEMBLER__ */
> =20
>  static inline void mmcif_update_progress(int nr)
>  {
>  }
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> diff --git a/arch/sh/include/mach-ecovec24/mach/romimage.h b/arch/sh/incl=
ude/mach-ecovec24/mach/romimage.h
> index 2da6ff326cbd0..f93d494736c3d 100644
> --- a/arch/sh/include/mach-ecovec24/mach/romimage.h
> +++ b/arch/sh/include/mach-ecovec24/mach/romimage.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifdef __ASSEMBLY__
> +#ifdef __ASSEMBLER__
> =20
>  /* EcoVec board specific boot code:
>   * converts the "partner-jet-script.txt" script into assembly
> @@ -22,7 +22,7 @@
>  1 :	.long 0xa8000000
>  2 :
> =20
> -#else /* __ASSEMBLY__ */
> +#else /* __ASSEMBLER__ */
> =20
>  /* Ecovec board specific information:
>   *
> @@ -45,4 +45,4 @@ static inline void mmcif_update_progress(int nr)
>  	__raw_writeb(1 << (nr - 1), PGDR);
>  }
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
> diff --git a/arch/sh/include/mach-kfr2r09/mach/romimage.h b/arch/sh/inclu=
de/mach-kfr2r09/mach/romimage.h
> index 209275872ff06..f68bb480d3784 100644
> --- a/arch/sh/include/mach-kfr2r09/mach/romimage.h
> +++ b/arch/sh/include/mach-kfr2r09/mach/romimage.h
> @@ -1,5 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifdef __ASSEMBLY__
> +#ifdef __ASSEMBLER__
> =20
>  /* kfr2r09 board specific boot code:
>   * converts the "partner-jet-script.txt" script into assembly
> @@ -22,10 +22,10 @@
>  1:	.long 0xa8000000
>  2:
> =20
> -#else /* __ASSEMBLY__ */
> +#else /* __ASSEMBLER__ */
> =20
>  static inline void mmcif_update_progress(int nr)
>  {
>  }
> =20
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */

I agree with this. Changes look good to me.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

