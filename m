Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72EE4B69FA
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 11:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiBOK62 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 05:58:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiBOK61 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 05:58:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98F74DAAF0;
        Tue, 15 Feb 2022 02:58:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F12611FB;
        Tue, 15 Feb 2022 02:58:15 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 856C33F718;
        Tue, 15 Feb 2022 02:58:08 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:58:04 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        will@kernel.org, guoren@kernel.org, bcain@codeaurora.org,
        geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        nickhu@andestech.com, green.hu@gmail.com, dinguyen@kernel.org,
        shorne@gmail.com, deller@gmx.de, mpe@ellerman.id.au,
        peterz@infradead.org, mingo@redhat.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH 07/14] uaccess: generalize access_ok()
Message-ID: <YguHPLQug2580CuY@FVFF77S0Q05N>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-8-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-8-arnd@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 14, 2022 at 05:34:45PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are many different ways that access_ok() is defined across
> architectures, but in the end, they all just compare against the
> user_addr_max() value or they accept anything.
> 
> Provide one definition that works for most architectures, checking
> against TASK_SIZE_MAX for user processes or skipping the check inside
> of uaccess_kernel() sections.
> 
> For architectures without CONFIG_SET_FS(), this should be the fastest
> check, as it comes down to a single comparison of a pointer against a
> compile-time constant, while the architecture specific versions tend to
> do something more complex for historic reasons or get something wrong.
> 
> Type checking for __user annotations is handled inconsistently across
> architectures, but this is easily simplified as well by using an inline
> function that takes a 'const void __user *' argument. A handful of
> callers need an extra __user annotation for this.
> 
> Some architectures had trick to use 33-bit or 65-bit arithmetic on the
> addresses to calculate the overflow, however this simpler version uses
> fewer registers, which means it can produce better object code in the
> end despite needing a second (statically predicted) branch.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

As discussed over IRC, the generic sequence looks good to me, and likewise for
the arm64 change, so:

Acked-by: Mark Rutland <mark.rutland@arm.com> [arm64, asm-generic]

Thanks,
Mark.

> ---
>  arch/alpha/include/asm/uaccess.h      | 34 +++------------
>  arch/arc/include/asm/uaccess.h        | 29 -------------
>  arch/arm/include/asm/uaccess.h        | 20 +--------
>  arch/arm/kernel/swp_emulate.c         |  2 +-
>  arch/arm/kernel/traps.c               |  2 +-
>  arch/arm64/include/asm/uaccess.h      |  5 ++-
>  arch/csky/include/asm/uaccess.h       |  8 ----
>  arch/csky/kernel/signal.c             |  2 +-
>  arch/hexagon/include/asm/uaccess.h    | 25 ------------
>  arch/ia64/include/asm/uaccess.h       |  5 +--
>  arch/m68k/include/asm/uaccess.h       |  5 ++-
>  arch/microblaze/include/asm/uaccess.h |  8 +---
>  arch/mips/include/asm/uaccess.h       | 29 +------------
>  arch/nds32/include/asm/uaccess.h      |  7 +---
>  arch/nios2/include/asm/uaccess.h      | 11 +----
>  arch/nios2/kernel/signal.c            | 20 +++++----
>  arch/openrisc/include/asm/uaccess.h   | 19 +--------
>  arch/parisc/include/asm/uaccess.h     | 10 +++--
>  arch/powerpc/include/asm/uaccess.h    | 11 +----
>  arch/powerpc/lib/sstep.c              |  4 +-
>  arch/riscv/include/asm/uaccess.h      | 31 +-------------
>  arch/riscv/kernel/perf_callchain.c    |  2 +-
>  arch/s390/include/asm/uaccess.h       | 11 ++---
>  arch/sh/include/asm/uaccess.h         | 22 +---------
>  arch/sparc/include/asm/uaccess.h      |  3 --
>  arch/sparc/include/asm/uaccess_32.h   | 18 ++------
>  arch/sparc/include/asm/uaccess_64.h   | 35 ++++------------
>  arch/sparc/kernel/signal_32.c         |  2 +-
>  arch/um/include/asm/uaccess.h         |  5 ++-
>  arch/x86/include/asm/uaccess.h        | 14 +------
>  arch/xtensa/include/asm/uaccess.h     | 10 +----
>  include/asm-generic/access_ok.h       | 59 +++++++++++++++++++++++++++
>  include/asm-generic/uaccess.h         | 21 +---------
>  include/linux/uaccess.h               |  7 ----
>  34 files changed, 130 insertions(+), 366 deletions(-)
>  create mode 100644 include/asm-generic/access_ok.h
> 
> diff --git a/arch/alpha/include/asm/uaccess.h b/arch/alpha/include/asm/uaccess.h
> index 1b6f25efa247..82c5743fc9cd 100644
> --- a/arch/alpha/include/asm/uaccess.h
> +++ b/arch/alpha/include/asm/uaccess.h
> @@ -20,28 +20,7 @@
>  #define get_fs()  (current_thread_info()->addr_limit)
>  #define set_fs(x) (current_thread_info()->addr_limit = (x))
>  
> -#define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
> -
> -/*
> - * Is a address valid? This does a straightforward calculation rather
> - * than tests.
> - *
> - * Address valid if:
> - *  - "addr" doesn't have any high-bits set
> - *  - AND "size" doesn't have any high-bits set
> - *  - AND "addr+size-(size != 0)" doesn't have any high-bits set
> - *  - OR we are in kernel mode.
> - */
> -#define __access_ok(addr, size) ({				\
> -	unsigned long __ao_a = (addr), __ao_b = (size);		\
> -	unsigned long __ao_end = __ao_a + __ao_b - !!__ao_b;	\
> -	(get_fs().seg & (__ao_a | __ao_b | __ao_end)) == 0; })
> -
> -#define access_ok(addr, size)				\
> -({							\
> -	__chk_user_ptr(addr);				\
> -	__access_ok(((unsigned long)(addr)), (size));	\
> -})
> +#include <asm-generic/access_ok.h>
>  
>  /*
>   * These are the main single-value transfer routines.  They automatically
> @@ -105,7 +84,7 @@ extern void __get_user_unknown(void);
>  	long __gu_err = -EFAULT;				\
>  	unsigned long __gu_val = 0;				\
>  	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);	\
> -	if (__access_ok((unsigned long)__gu_addr, size)) {	\
> +	if (__access_ok(__gu_addr, size)) {			\
>  		__gu_err = 0;					\
>  		switch (size) {					\
>  		  case 1: __get_user_8(__gu_addr); break;	\
> @@ -200,7 +179,7 @@ extern void __put_user_unknown(void);
>  ({								\
>  	long __pu_err = -EFAULT;				\
>  	__typeof__(*(ptr)) __user *__pu_addr = (ptr);		\
> -	if (__access_ok((unsigned long)__pu_addr, size)) {	\
> +	if (__access_ok(__pu_addr, size)) {			\
>  		__pu_err = 0;					\
>  		switch (size) {					\
>  		  case 1: __put_user_8(x, __pu_addr); break;	\
> @@ -316,17 +295,14 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long len)
>  
>  extern long __clear_user(void __user *to, long len);
>  
> -extern inline long
> +static inline long
>  clear_user(void __user *to, long len)
>  {
> -	if (__access_ok((unsigned long)to, len))
> +	if (__access_ok(to, len))
>  		len = __clear_user(to, len);
>  	return len;
>  }
>  
> -#define user_addr_max() \
> -        (uaccess_kernel() ? ~0UL : TASK_SIZE)
> -
>  extern long strncpy_from_user(char *dest, const char __user *src, long count);
>  extern __must_check long strnlen_user(const char __user *str, long n);
>  
> diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
> index 783bfdb3bfa3..30f80b4be2ab 100644
> --- a/arch/arc/include/asm/uaccess.h
> +++ b/arch/arc/include/asm/uaccess.h
> @@ -23,35 +23,6 @@
>  
>  #include <linux/string.h>	/* for generic string functions */
>  
> -
> -#define __kernel_ok		(uaccess_kernel())
> -
> -/*
> - * Algorithmically, for __user_ok() we want do:
> - * 	(start < TASK_SIZE) && (start+len < TASK_SIZE)
> - * where TASK_SIZE could either be retrieved from thread_info->addr_limit or
> - * emitted directly in code.
> - *
> - * This can however be rewritten as follows:
> - *	(len <= TASK_SIZE) && (start+len < TASK_SIZE)
> - *
> - * Because it essentially checks if buffer end is within limit and @len is
> - * non-ngeative, which implies that buffer start will be within limit too.
> - *
> - * The reason for rewriting being, for majority of cases, @len is generally
> - * compile time constant, causing first sub-expression to be compile time
> - * subsumed.
> - *
> - * The second part would generate weird large LIMMs e.g. (0x6000_0000 - 0x10),
> - * so we check for TASK_SIZE using get_fs() since the addr_limit load from mem
> - * would already have been done at this call site for __kernel_ok()
> - *
> - */
> -#define __user_ok(addr, sz)	(((sz) <= TASK_SIZE) && \
> -				 ((addr) <= (get_fs() - (sz))))
> -#define __access_ok(addr, sz)	(unlikely(__kernel_ok) || \
> -				 likely(__user_ok((addr), (sz))))
> -
>  /*********** Single byte/hword/word copies ******************/
>  
>  #define __get_user_fn(sz, u, k)					\
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index d20d78c34b94..2fcbec9c306c 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -55,21 +55,6 @@ extern int __put_user_bad(void);
>  
>  #ifdef CONFIG_MMU
>  
> -/*
> - * We use 33-bit arithmetic here.  Success returns zero, failure returns
> - * addr_limit.  We take advantage that addr_limit will be zero for KERNEL_DS,
> - * so this will always return success in that case.
> - */
> -#define __range_ok(addr, size) ({ \
> -	unsigned long flag, roksum; \
> -	__chk_user_ptr(addr);	\
> -	__asm__(".syntax unified\n" \
> -		"adds %1, %2, %3; sbcscc %1, %1, %0; movcc %0, #0" \
> -		: "=&r" (flag), "=&r" (roksum) \
> -		: "r" (addr), "Ir" (size), "0" (TASK_SIZE) \
> -		: "cc"); \
> -	flag; })
> -
>  /*
>   * This is a type: either unsigned long, if the argument fits into
>   * that type, or otherwise unsigned long long.
> @@ -241,15 +226,12 @@ extern int __put_user_8(void *, unsigned long long);
>  
>  #else /* CONFIG_MMU */
>  
> -#define __addr_ok(addr)		((void)(addr), 1)
> -#define __range_ok(addr, size)	((void)(addr), 0)
> -
>  #define get_user(x, p)	__get_user(x, p)
>  #define __put_user_check __put_user_nocheck
>  
>  #endif /* CONFIG_MMU */
>  
> -#define access_ok(addr, size)	(__range_ok(addr, size) == 0)
> +#include <asm-generic/access_ok.h>
>  
>  #ifdef CONFIG_CPU_SPECTRE
>  /*
> diff --git a/arch/arm/kernel/swp_emulate.c b/arch/arm/kernel/swp_emulate.c
> index 6166ba38bf99..b74bfcf94fb1 100644
> --- a/arch/arm/kernel/swp_emulate.c
> +++ b/arch/arm/kernel/swp_emulate.c
> @@ -195,7 +195,7 @@ static int swp_handler(struct pt_regs *regs, unsigned int instr)
>  		 destreg, EXTRACT_REG_NUM(instr, RT2_OFFSET), data);
>  
>  	/* Check access in reasonable access range for both SWP and SWPB */
> -	if (!access_ok((address & ~3), 4)) {
> +	if (!access_ok((void __user *)(address & ~3), 4)) {
>  		pr_debug("SWP{B} emulation: access to %p not allowed!\n",
>  			 (void *)address);
>  		res = -EFAULT;
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index da04ed85855a..26c8c8276297 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -576,7 +576,7 @@ do_cache_op(unsigned long start, unsigned long end, int flags)
>  	if (end < start || flags)
>  		return -EINVAL;
>  
> -	if (!access_ok(start, end - start))
> +	if (!access_ok((void __user *)start, end - start))
>  		return -EFAULT;
>  
>  	return __do_cache_op(start, end);
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 2e20879fe3cf..357f7bd9c981 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -33,7 +33,7 @@
>   * This is equivalent to the following test:
>   * (u65)addr + (u65)size <= (u65)TASK_SIZE_MAX
>   */
> -static inline unsigned long __range_ok(const void __user *addr, unsigned long size)
> +static inline unsigned long __access_ok(const void __user *addr, unsigned long size)
>  {
>  	unsigned long ret, limit = TASK_SIZE_MAX - 1;
>  
> @@ -66,8 +66,9 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
>  
>  	return ret;
>  }
> +#define __access_ok __access_ok
>  
> -#define access_ok(addr, size)	__range_ok(addr, size)
> +#include <asm-generic/access_ok.h>
>  
>  /*
>   * User access enabling/disabling.
> diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
> index ac5a54f57d40..fec8f77ffc99 100644
> --- a/arch/csky/include/asm/uaccess.h
> +++ b/arch/csky/include/asm/uaccess.h
> @@ -5,14 +5,6 @@
>  
>  #define user_addr_max() (current_thread_info()->addr_limit.seg)
>  
> -static inline int __access_ok(unsigned long addr, unsigned long size)
> -{
> -	unsigned long limit = user_addr_max();
> -
> -	return (size <= limit) && (addr <= (limit - size));
> -}
> -#define __access_ok __access_ok
> -
>  /*
>   * __put_user_fn
>   */
> diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
> index c7b763d2f526..8867ddf3e6c7 100644
> --- a/arch/csky/kernel/signal.c
> +++ b/arch/csky/kernel/signal.c
> @@ -136,7 +136,7 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
>  static int
>  setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
>  {
> -	struct rt_sigframe *frame;
> +	struct rt_sigframe __user *frame;
>  	int err = 0;
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));
> diff --git a/arch/hexagon/include/asm/uaccess.h b/arch/hexagon/include/asm/uaccess.h
> index 719ba3f3c45c..bff77efc0d9a 100644
> --- a/arch/hexagon/include/asm/uaccess.h
> +++ b/arch/hexagon/include/asm/uaccess.h
> @@ -12,31 +12,6 @@
>   */
>  #include <asm/sections.h>
>  
> -/*
> - * access_ok: - Checks if a user space pointer is valid
> - * @addr: User space pointer to start of block to check
> - * @size: Size of block to check
> - *
> - * Context: User context only. This function may sleep if pagefaults are
> - *          enabled.
> - *
> - * Checks if a pointer to a block of memory in user space is valid.
> - *
> - * Returns true (nonzero) if the memory block *may* be valid, false (zero)
> - * if it is definitely invalid.
> - *
> - */
> -#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
> -#define user_addr_max() (uaccess_kernel() ? ~0UL : TASK_SIZE)
> -
> -static inline int __access_ok(unsigned long addr, unsigned long size)
> -{
> -	unsigned long limit = TASK_SIZE;
> -
> -	return (size <= limit) && (addr <= (limit - size));
> -}
> -#define __access_ok __access_ok
> -
>  /*
>   * When a kernel-mode page fault is taken, the faulting instruction
>   * address is checked against a table of exception_table_entries.
> diff --git a/arch/ia64/include/asm/uaccess.h b/arch/ia64/include/asm/uaccess.h
> index e19d2dcc0ced..e242a3cc1330 100644
> --- a/arch/ia64/include/asm/uaccess.h
> +++ b/arch/ia64/include/asm/uaccess.h
> @@ -50,8 +50,6 @@
>  #define get_fs()  (current_thread_info()->addr_limit)
>  #define set_fs(x) (current_thread_info()->addr_limit = (x))
>  
> -#define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
> -
>  /*
>   * When accessing user memory, we need to make sure the entire area really is in
>   * user-level space.  In order to do this efficiently, we make sure that the page at
> @@ -65,7 +63,8 @@ static inline int __access_ok(const void __user *p, unsigned long size)
>  	return likely(addr <= seg) &&
>  	 (seg == KERNEL_DS.seg || likely(REGION_OFFSET(addr) < RGN_MAP_LIMIT));
>  }
> -#define access_ok(addr, size)	__access_ok((addr), (size))
> +#define __access_ok __access_ok
> +#include <asm-generic/access_ok.h>
>  
>  /*
>   * These are the main single-value transfer routines.  They automatically
> diff --git a/arch/m68k/include/asm/uaccess.h b/arch/m68k/include/asm/uaccess.h
> index 79617c0b2f91..d6bb5720365a 100644
> --- a/arch/m68k/include/asm/uaccess.h
> +++ b/arch/m68k/include/asm/uaccess.h
> @@ -12,15 +12,18 @@
>  #include <asm/extable.h>
>  
>  /* We let the MMU do all checking */
> -static inline int access_ok(const void __user *addr,
> +static inline int __access_ok(const void __user *addr,
>  			    unsigned long size)
>  {
>  	/*
>  	 * XXX: for !CONFIG_CPU_HAS_ADDRESS_SPACES this really needs to check
>  	 * for TASK_SIZE!
> +	 * Removing this helper is probably sufficient.
>  	 */
>  	return 1;
>  }
> +#define __access_ok __access_ok
> +#include <asm-generic/access_ok.h>
>  
>  /*
>   * Not all varients of the 68k family support the notion of address spaces.
> diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
> index 5b6e0e7788f4..dd82e90adb52 100644
> --- a/arch/microblaze/include/asm/uaccess.h
> +++ b/arch/microblaze/include/asm/uaccess.h
> @@ -39,13 +39,7 @@
>  
>  # define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
>  
> -static inline int __access_ok(unsigned long addr, unsigned long size)
> -{
> -	unsigned long limit = user_addr_max();
> -
> -	return (size <= limit) && (addr <= (limit - size));
> -}
> -#define access_ok(addr, size) __access_ok((unsigned long)addr, size)
> +#include <asm-generic/access_ok.h>
>  
>  # define __FIXUP_SECTION	".section .fixup,\"ax\"\n"
>  # define __EX_TABLE_SECTION	".section __ex_table,\"a\"\n"
> diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
> index d7c89dc3426c..436248652b28 100644
> --- a/arch/mips/include/asm/uaccess.h
> +++ b/arch/mips/include/asm/uaccess.h
> @@ -44,34 +44,7 @@ extern u64 __ua_limit;
>  
>  #endif /* CONFIG_64BIT */
>  
> -/*
> - * access_ok: - Checks if a user space pointer is valid
> - * @addr: User space pointer to start of block to check
> - * @size: Size of block to check
> - *
> - * Context: User context only. This function may sleep if pagefaults are
> - *          enabled.
> - *
> - * Checks if a pointer to a block of memory in user space is valid.
> - *
> - * Returns true (nonzero) if the memory block may be valid, false (zero)
> - * if it is definitely invalid.
> - *
> - * Note that, depending on architecture, this function probably just
> - * checks that the pointer is in the user space range - after calling
> - * this function, memory access functions may still return -EFAULT.
> - */
> -
> -static inline int __access_ok(const void __user *p, unsigned long size)
> -{
> -	unsigned long addr = (unsigned long)p;
> -	unsigned long limit = TASK_SIZE_MAX;
> -
> -	return (size <= limit) && (addr <= (limit - size));
> -}
> -
> -#define access_ok(addr, size)					\
> -	likely(__access_ok((addr), (size)))
> +#include <asm-generic/access_ok.h>
>  
>  /*
>   * put_user: - Write a simple value into user space.
> diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
> index 37a40981deb3..832d642a4068 100644
> --- a/arch/nds32/include/asm/uaccess.h
> +++ b/arch/nds32/include/asm/uaccess.h
> @@ -38,18 +38,15 @@ extern int fixup_exception(struct pt_regs *regs);
>  
>  #define get_fs()	(current_thread_info()->addr_limit)
>  #define user_addr_max	get_fs
> +#define uaccess_kernel() (get_fs() == KERNEL_DS)
>  
>  static inline void set_fs(mm_segment_t fs)
>  {
>  	current_thread_info()->addr_limit = fs;
>  }
>  
> -#define uaccess_kernel()	(get_fs() == KERNEL_DS)
> +#include <asm-generic/access_ok.h>
>  
> -#define __range_ok(addr, size) (size <= get_fs() && addr <= (get_fs() -size))
> -
> -#define access_ok(addr, size)	\
> -	__range_ok((unsigned long)addr, (unsigned long)size)
>  /*
>   * Single-value transfer routines.  They automatically use the right
>   * size if we just have the right pointer type.  Note that the functions
> diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
> index ba9340e96fd4..9a7658df7f8d 100644
> --- a/arch/nios2/include/asm/uaccess.h
> +++ b/arch/nios2/include/asm/uaccess.h
> @@ -30,19 +30,10 @@
>  #define get_fs()		(current_thread_info()->addr_limit)
>  #define set_fs(seg)		(current_thread_info()->addr_limit = (seg))
>  
> -#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
> -
> -#define __access_ok(addr, len)			\
> -	(((signed long)(((long)get_fs().seg) &	\
> -		((long)(addr) | (((long)(addr)) + (len)) | (len)))) == 0)
> -
> -#define access_ok(addr, len)		\
> -	likely(__access_ok((unsigned long)(addr), (unsigned long)(len)))
> +#include <asm-generic/access_ok.h>
>  
>  # define __EX_TABLE_SECTION	".section __ex_table,\"a\"\n"
>  
> -#define user_addr_max() (uaccess_kernel() ? ~0UL : TASK_SIZE)
> -
>  /*
>   * Zero Userspace
>   */
> diff --git a/arch/nios2/kernel/signal.c b/arch/nios2/kernel/signal.c
> index 2009ae2d3c3b..386e46443b60 100644
> --- a/arch/nios2/kernel/signal.c
> +++ b/arch/nios2/kernel/signal.c
> @@ -36,10 +36,10 @@ struct rt_sigframe {
>  
>  static inline int rt_restore_ucontext(struct pt_regs *regs,
>  					struct switch_stack *sw,
> -					struct ucontext *uc, int *pr2)
> +					struct ucontext __user *uc, int *pr2)
>  {
>  	int temp;
> -	unsigned long *gregs = uc->uc_mcontext.gregs;
> +	unsigned long __user *gregs = uc->uc_mcontext.gregs;
>  	int err;
>  
>  	/* Always make any pending restarted system calls return -EINTR */
> @@ -102,10 +102,11 @@ asmlinkage int do_rt_sigreturn(struct switch_stack *sw)
>  {
>  	struct pt_regs *regs = (struct pt_regs *)(sw + 1);
>  	/* Verify, can we follow the stack back */
> -	struct rt_sigframe *frame = (struct rt_sigframe *) regs->sp;
> +	struct rt_sigframe __user *frame;
>  	sigset_t set;
>  	int rval;
>  
> +	frame = (struct rt_sigframe __user *) regs->sp;
>  	if (!access_ok(frame, sizeof(*frame)))
>  		goto badframe;
>  
> @@ -124,10 +125,10 @@ asmlinkage int do_rt_sigreturn(struct switch_stack *sw)
>  	return 0;
>  }
>  
> -static inline int rt_setup_ucontext(struct ucontext *uc, struct pt_regs *regs)
> +static inline int rt_setup_ucontext(struct ucontext __user *uc, struct pt_regs *regs)
>  {
>  	struct switch_stack *sw = (struct switch_stack *)regs - 1;
> -	unsigned long *gregs = uc->uc_mcontext.gregs;
> +	unsigned long __user *gregs = uc->uc_mcontext.gregs;
>  	int err = 0;
>  
>  	err |= __put_user(MCONTEXT_VERSION, &uc->uc_mcontext.version);
> @@ -162,8 +163,9 @@ static inline int rt_setup_ucontext(struct ucontext *uc, struct pt_regs *regs)
>  	return err;
>  }
>  
> -static inline void *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
> -				 size_t frame_size)
> +static inline void __user *get_sigframe(struct ksignal *ksig,
> +					struct pt_regs *regs,
> +					size_t frame_size)
>  {
>  	unsigned long usp;
>  
> @@ -174,13 +176,13 @@ static inline void *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
>  	usp = sigsp(usp, ksig);
>  
>  	/* Verify, is it 32 or 64 bit aligned */
> -	return (void *)((usp - frame_size) & -8UL);
> +	return (void __user *)((usp - frame_size) & -8UL);
>  }
>  
>  static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>  			  struct pt_regs *regs)
>  {
> -	struct rt_sigframe *frame;
> +	struct rt_sigframe __user *frame;
>  	int err = 0;
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));
> diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
> index 120f5005461b..8f049ec99b3e 100644
> --- a/arch/openrisc/include/asm/uaccess.h
> +++ b/arch/openrisc/include/asm/uaccess.h
> @@ -45,21 +45,7 @@
>  
>  #define uaccess_kernel()	(get_fs() == KERNEL_DS)
>  
> -/* Ensure that the range from addr to addr+size is all within the process'
> - * address space
> - */
> -static inline int __range_ok(unsigned long addr, unsigned long size)
> -{
> -	const mm_segment_t fs = get_fs();
> -
> -	return size <= fs && addr <= (fs - size);
> -}
> -
> -#define access_ok(addr, size)						\
> -({ 									\
> -	__chk_user_ptr(addr);						\
> -	__range_ok((unsigned long)(addr), (size));			\
> -})
> +#include <asm-generic/access_ok.h>
>  
>  /*
>   * These are the main single-value transfer routines.  They automatically
> @@ -268,9 +254,6 @@ clear_user(void __user *addr, unsigned long size)
>  	return size;
>  }
>  
> -#define user_addr_max() \
> -	(uaccess_kernel() ? ~0UL : TASK_SIZE)
> -
>  extern long strncpy_from_user(char *dest, const char __user *src, long count);
>  
>  extern __must_check long strnlen_user(const char __user *str, long n);
> diff --git a/arch/parisc/include/asm/uaccess.h b/arch/parisc/include/asm/uaccess.h
> index 0925bbd6db67..b68f19e11361 100644
> --- a/arch/parisc/include/asm/uaccess.h
> +++ b/arch/parisc/include/asm/uaccess.h
> @@ -17,9 +17,13 @@
>   * We just let the page fault handler do the right thing. This also means
>   * that put_user is the same as __put_user, etc.
>   */
> -
> -#define access_ok(uaddr, size)	\
> -	( (uaddr) == (uaddr) )
> +static inline int __access_ok(const void __user *addr, unsigned long size)
> +{
> +	return 1;
> +}
> +#define __access_ok __access_ok
> +#define TASK_SIZE_MAX DEFAULT_TASK_SIZE
> +#include <asm-generic/access_ok.h>
>  
>  #define put_user __put_user
>  #define get_user __get_user
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index a0032c2e7550..2e83217f52de 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -11,18 +11,9 @@
>  #ifdef __powerpc64__
>  /* We use TASK_SIZE_USER64 as TASK_SIZE is not constant */
>  #define TASK_SIZE_MAX		TASK_SIZE_USER64
> -#else
> -#define TASK_SIZE_MAX		TASK_SIZE
>  #endif
>  
> -static inline bool __access_ok(unsigned long addr, unsigned long size)
> -{
> -	return addr < TASK_SIZE_MAX && size <= TASK_SIZE_MAX - addr;
> -}
> -
> -#define access_ok(addr, size)		\
> -	(__chk_user_ptr(addr),		\
> -	 __access_ok((unsigned long)(addr), (size)))
> +#include <asm-generic/access_ok.h>
>  
>  /*
>   * These are the main single-value transfer routines.  They automatically
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index a94b0cd0bdc5..022d23ae300b 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -112,9 +112,9 @@ static nokprobe_inline long address_ok(struct pt_regs *regs,
>  {
>  	if (!user_mode(regs))
>  		return 1;
> -	if (__access_ok(ea, nb))
> +	if (access_ok((void __user *)ea, nb))
>  		return 1;
> -	if (__access_ok(ea, 1))
> +	if (access_ok((void __user *)ea, 1))
>  		/* Access overlaps the end of the user region */
>  		regs->dar = TASK_SIZE_MAX - 1;
>  	else
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index 4407b9e48d2c..855450bed9f5 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -21,42 +21,13 @@
>  #include <asm/byteorder.h>
>  #include <asm/extable.h>
>  #include <asm/asm.h>
> +#include <asm-generic/access_ok.h>
>  
>  #define __enable_user_access()							\
>  	__asm__ __volatile__ ("csrs sstatus, %0" : : "r" (SR_SUM) : "memory")
>  #define __disable_user_access()							\
>  	__asm__ __volatile__ ("csrc sstatus, %0" : : "r" (SR_SUM) : "memory")
>  
> -/**
> - * access_ok: - Checks if a user space pointer is valid
> - * @addr: User space pointer to start of block to check
> - * @size: Size of block to check
> - *
> - * Context: User context only.  This function may sleep.
> - *
> - * Checks if a pointer to a block of memory in user space is valid.
> - *
> - * Returns true (nonzero) if the memory block may be valid, false (zero)
> - * if it is definitely invalid.
> - *
> - * Note that, depending on architecture, this function probably just
> - * checks that the pointer is in the user space range - after calling
> - * this function, memory access functions may still return -EFAULT.
> - */
> -#define access_ok(addr, size) ({					\
> -	__chk_user_ptr(addr);						\
> -	likely(__access_ok((unsigned long __force)(addr), (size)));	\
> -})
> -
> -/*
> - * Ensure that the range [addr, addr+size) is within the process's
> - * address space
> - */
> -static inline int __access_ok(unsigned long addr, unsigned long size)
> -{
> -	return size <= TASK_SIZE && addr <= TASK_SIZE - size;
> -}
> -
>  /*
>   * The exception table consists of pairs of addresses: the first is the
>   * address of an instruction that is allowed to fault, and the second is
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
> index 1fc075b8f764..f0c7bb98119a 100644
> --- a/arch/riscv/kernel/perf_callchain.c
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -15,7 +15,7 @@ static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
>  {
>  	struct stackframe buftail;
>  	unsigned long ra = 0;
> -	unsigned long *user_frame_tail =
> +	unsigned long __user *user_frame_tail =
>  			(unsigned long *)(fp - sizeof(struct stackframe));
>  
>  	/* Check accessibility of one struct frame_tail beyond */
> diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
> index 29332edf46f0..f84d70c8e188 100644
> --- a/arch/s390/include/asm/uaccess.h
> +++ b/arch/s390/include/asm/uaccess.h
> @@ -20,18 +20,13 @@
>  
>  void debug_user_asce(int exit);
>  
> -static inline int __range_ok(unsigned long addr, unsigned long size)
> +static inline int __access_ok(const void __user *addr, unsigned long size)
>  {
>  	return 1;
>  }
> +#define __access_ok __access_ok
>  
> -#define __access_ok(addr, size)				\
> -({							\
> -	__chk_user_ptr(addr);				\
> -	__range_ok((unsigned long)(addr), (size));	\
> -})
> -
> -#define access_ok(addr, size) __access_ok(addr, size)
> +#include <asm-generic/access_ok.h>
>  
>  unsigned long __must_check
>  raw_copy_from_user(void *to, const void __user *from, unsigned long n);
> diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
> index 8867bb04b00e..ccd219d74851 100644
> --- a/arch/sh/include/asm/uaccess.h
> +++ b/arch/sh/include/asm/uaccess.h
> @@ -5,28 +5,10 @@
>  #include <asm/segment.h>
>  #include <asm/extable.h>
>  
> -#define __addr_ok(addr) \
> -	((unsigned long __force)(addr) < current_thread_info()->addr_limit.seg)
> -
> -/*
> - * __access_ok: Check if address with size is OK or not.
> - *
> - * Uhhuh, this needs 33-bit arithmetic. We have a carry..
> - *
> - * sum := addr + size;  carry? --> flag = true;
> - * if (sum >= addr_limit) flag = true;
> - */
> -#define __access_ok(addr, size)	({				\
> -	unsigned long __ao_a = (addr), __ao_b = (size);		\
> -	unsigned long __ao_end = __ao_a + __ao_b - !!__ao_b;	\
> -	__ao_end >= __ao_a && __addr_ok(__ao_end); })
> -
> -#define access_ok(addr, size)	\
> -	(__chk_user_ptr(addr),		\
> -	 __access_ok((unsigned long __force)(addr), (size)))
> -
>  #define user_addr_max()	(current_thread_info()->addr_limit.seg)
>  
> +#include <asm-generic/access_ok.h>
> +
>  /*
>   * Uh, these should become the main single-value transfer routines ...
>   * They automatically use the right size if we just have the right
> diff --git a/arch/sparc/include/asm/uaccess.h b/arch/sparc/include/asm/uaccess.h
> index 390094200fc4..ee75f69e3fcd 100644
> --- a/arch/sparc/include/asm/uaccess.h
> +++ b/arch/sparc/include/asm/uaccess.h
> @@ -10,9 +10,6 @@
>  #include <asm/uaccess_32.h>
>  #endif
>  
> -#define user_addr_max() \
> -	(uaccess_kernel() ? ~0UL : TASK_SIZE)
> -
>  long strncpy_from_user(char *dest, const char __user *src, long count);
>  
>  #endif
> diff --git a/arch/sparc/include/asm/uaccess_32.h b/arch/sparc/include/asm/uaccess_32.h
> index 4a12346bb69c..367747116260 100644
> --- a/arch/sparc/include/asm/uaccess_32.h
> +++ b/arch/sparc/include/asm/uaccess_32.h
> @@ -25,17 +25,7 @@
>  #define get_fs()	(current->thread.current_ds)
>  #define set_fs(val)	((current->thread.current_ds) = (val))
>  
> -#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
> -
> -/* We have there a nice not-mapped page at PAGE_OFFSET - PAGE_SIZE, so that this test
> - * can be fairly lightweight.
> - * No one can read/write anything from userland in the kernel space by setting
> - * large size and address near to PAGE_OFFSET - a fault will break his intentions.
> - */
> -#define __user_ok(addr, size) ({ (void)(size); (addr) < STACK_TOP; })
> -#define __kernel_ok (uaccess_kernel())
> -#define __access_ok(addr, size) (__user_ok((addr) & get_fs().seg, (size)))
> -#define access_ok(addr, size) __access_ok((unsigned long)(addr), size)
> +#include <asm-generic/access_ok.h>
>  
>  /* Uh, these should become the main single-value transfer routines..
>   * They automatically use the right size if we just have the right
> @@ -47,13 +37,13 @@
>   * and hide all the ugliness from the user.
>   */
>  #define put_user(x, ptr) ({ \
> -	unsigned long __pu_addr = (unsigned long)(ptr); \
> +	void __user *__pu_addr = (ptr); \
>  	__chk_user_ptr(ptr); \
>  	__put_user_check((__typeof__(*(ptr)))(x), __pu_addr, sizeof(*(ptr))); \
>  })
>  
>  #define get_user(x, ptr) ({ \
> -	unsigned long __gu_addr = (unsigned long)(ptr); \
> +	const void __user *__gu_addr = (ptr); \
>  	__chk_user_ptr(ptr); \
>  	__get_user_check((x), __gu_addr, sizeof(*(ptr)), __typeof__(*(ptr))); \
>  })
> @@ -232,7 +222,7 @@ static inline unsigned long __clear_user(void __user *addr, unsigned long size)
>  
>  static inline unsigned long clear_user(void __user *addr, unsigned long n)
>  {
> -	if (n && __access_ok((unsigned long) addr, n))
> +	if (n && __access_ok(addr, n))
>  		return __clear_user(addr, n);
>  	else
>  		return n;
> diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
> index 5c12fb46bc61..000bac67cf31 100644
> --- a/arch/sparc/include/asm/uaccess_64.h
> +++ b/arch/sparc/include/asm/uaccess_64.h
> @@ -31,7 +31,12 @@
>  
>  #define get_fs() ((mm_segment_t){(current_thread_info()->current_ds)})
>  
> -#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
> +static inline int __access_ok(const void __user *addr, unsigned long size)
> +{
> +	return 1;
> +}
> +#define __access_ok __access_ok
> +#include <asm-generic/access_ok.h>
>  
>  #define set_fs(val)								\
>  do {										\
> @@ -43,33 +48,7 @@ do {										\
>   * Test whether a block of memory is a valid user space address.
>   * Returns 0 if the range is valid, nonzero otherwise.
>   */
> -static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, unsigned long limit)
> -{
> -	if (__builtin_constant_p(size))
> -		return addr > limit - size;
> -
> -	addr += size;
> -	if (addr < size)
> -		return true;
> -
> -	return addr > limit;
> -}
> -
> -#define __range_not_ok(addr, size, limit)                               \
> -({                                                                      \
> -	__chk_user_ptr(addr);                                           \
> -	__chk_range_not_ok((unsigned long __force)(addr), size, limit); \
> -})
> -
> -static inline int __access_ok(const void __user * addr, unsigned long size)
> -{
> -	return 1;
> -}
> -
> -static inline int access_ok(const void __user * addr, unsigned long size)
> -{
> -	return 1;
> -}
> +#define __range_not_ok(addr, size, limit) (!__access_ok(addr, size))
>  
>  void __retl_efault(void);
>  
> diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
> index ffab16369bea..74f80443b195 100644
> --- a/arch/sparc/kernel/signal_32.c
> +++ b/arch/sparc/kernel/signal_32.c
> @@ -65,7 +65,7 @@ struct rt_signal_frame {
>   */
>  static inline bool invalid_frame_pointer(void __user *fp, int fplen)
>  {
> -	if ((((unsigned long) fp) & 15) || !__access_ok((unsigned long)fp, fplen))
> +	if ((((unsigned long) fp) & 15) || !access_ok(fp, fplen))
>  		return true;
>  
>  	return false;
> diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
> index 1ecfc96bcc50..7d9d60e41e4e 100644
> --- a/arch/um/include/asm/uaccess.h
> +++ b/arch/um/include/asm/uaccess.h
> @@ -25,7 +25,7 @@
>  extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
>  extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
>  extern unsigned long __clear_user(void __user *mem, unsigned long len);
> -static inline int __access_ok(unsigned long addr, unsigned long size);
> +static inline int __access_ok(const void __user *ptr, unsigned long size);
>  
>  /* Teach asm-generic/uaccess.h that we have C functions for these. */
>  #define __access_ok __access_ok
> @@ -36,8 +36,9 @@ static inline int __access_ok(unsigned long addr, unsigned long size);
>  
>  #include <asm-generic/uaccess.h>
>  
> -static inline int __access_ok(unsigned long addr, unsigned long size)
> +static inline int __access_ok(const void __user *ptr, unsigned long size)
>  {
> +	unsigned long addr = (unsigned long)ptr;
>  	return __addr_range_nowrap(addr, size) &&
>  		(__under_task_size(addr, size) ||
>  		 __access_ok_vsyscall(addr, size));
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index c6d9dc42724d..c5e4bb7161bc 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -12,18 +12,6 @@
>  #include <asm/smap.h>
>  #include <asm/extable.h>
>  
> -/*
> - * Test whether a block of memory is a valid user space address.
> - * Returns 0 if the range is valid, nonzero otherwise.
> - */
> -static inline bool __access_ok(void __user *ptr, unsigned long size)
> -{
> -	unsigned long limit = TASK_SIZE_MAX;
> -	unsigned long addr = ptr;
> -
> -	return (size <= limit) && (addr <= (limit - size));
> -}
> -
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
>  static inline bool pagefault_disabled(void);
>  # define WARN_ON_IN_IRQ()	\
> @@ -55,6 +43,8 @@ static inline bool pagefault_disabled(void);
>  	likely(__access_ok(addr, size));\
>  })
>  
> +#include <asm-generic/access_ok.h>
> +
>  #define __range_not_ok(addr, size, limit)	(!__access_ok(addr, size))
>  #define __chk_range_not_ok(addr, size, limit)	(!__access_ok((void __user *)addr, size))
>  
> diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
> index 75bd8fbf52ba..0edd9e4b23d0 100644
> --- a/arch/xtensa/include/asm/uaccess.h
> +++ b/arch/xtensa/include/asm/uaccess.h
> @@ -35,15 +35,7 @@
>  #define get_fs()	(current->thread.current_ds)
>  #define set_fs(val)	(current->thread.current_ds = (val))
>  
> -#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
> -
> -#define __kernel_ok (uaccess_kernel())
> -#define __user_ok(addr, size) \
> -		(((size) <= TASK_SIZE)&&((addr) <= TASK_SIZE-(size)))
> -#define __access_ok(addr, size) (__kernel_ok || __user_ok((addr), (size)))
> -#define access_ok(addr, size) __access_ok((unsigned long)(addr), (size))
> -
> -#define user_addr_max() (uaccess_kernel() ? ~0UL : TASK_SIZE)
> +#include <asm-generic/access_ok.h>
>  
>  /*
>   * These are the main single-value transfer routines.  They
> diff --git a/include/asm-generic/access_ok.h b/include/asm-generic/access_ok.h
> new file mode 100644
> index 000000000000..883b573af5fe
> --- /dev/null
> +++ b/include/asm-generic/access_ok.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_GENERIC_ACCESS_OK_H__
> +#define __ASM_GENERIC_ACCESS_OK_H__
> +
> +/*
> + * Checking whether a pointer is valid for user space access.
> + * These definitions work on most architectures, but overrides can
> + * be used where necessary.
> + */
> +
> +/*
> + * architectures with compat tasks have a variable TASK_SIZE and should
> + * override this to a constant.
> + */
> +#ifndef TASK_SIZE_MAX
> +#define TASK_SIZE_MAX			TASK_SIZE
> +#endif
> +
> +#ifndef uaccess_kernel
> +#ifdef CONFIG_SET_FS
> +#define uaccess_kernel()		(get_fs().seg == KERNEL_DS.seg)
> +#else
> +#define uaccess_kernel()		(0)
> +#endif
> +#endif
> +
> +#ifndef user_addr_max
> +#define user_addr_max()			(uaccess_kernel() ? ~0UL : TASK_SIZE_MAX)
> +#endif
> +
> +#ifndef __access_ok
> +/*
> + * 'size' is a compile-time constant for most callers, so optimize for
> + * this case to turn the check into a single comparison against a constant
> + * limit and catch all possible overflows.
> + * On architectures with separate user address space (m68k, s390, parisc,
> + * sparc64) or those without an MMU, this should always return true.
> + *
> + * This version was originally contributed by Jonas Bonn for the
> + * OpenRISC architecture, and was found to be the most efficient
> + * for constant 'size' and 'limit' values.
> + */
> +static inline int __access_ok(const void __user *ptr, unsigned long size)
> +{
> +	unsigned long limit = user_addr_max();
> +	unsigned long addr = (unsigned long)ptr;
> +
> +	if (limit == ULONG_MAX)
> +		return true;
> +
> +	return (size <= limit) && (addr <= (limit - size));
> +}
> +#endif
> +
> +#ifndef access_ok
> +#define access_ok(addr, size) likely(__access_ok(addr, size))
> +#endif
> +
> +#endif
> diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
> index 0870fa11a7c5..ebc685dc8d74 100644
> --- a/include/asm-generic/uaccess.h
> +++ b/include/asm-generic/uaccess.h
> @@ -114,28 +114,9 @@ static inline void set_fs(mm_segment_t fs)
>  }
>  #endif
>  
> -#ifndef uaccess_kernel
> -#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
> -#endif
> -
> -#ifndef user_addr_max
> -#define user_addr_max() (uaccess_kernel() ? ~0UL : TASK_SIZE)
> -#endif
> -
>  #endif /* CONFIG_SET_FS */
>  
> -#define access_ok(addr, size) __access_ok((unsigned long)(addr),(size))
> -
> -/*
> - * The architecture should really override this if possible, at least
> - * doing a check on the get_fs()
> - */
> -#ifndef __access_ok
> -static inline int __access_ok(unsigned long addr, unsigned long size)
> -{
> -	return 1;
> -}
> -#endif
> +#include <asm-generic/access_ok.h>
>  
>  /*
>   * These are the main single-value transfer routines.  They automatically
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 67e9bc94dc40..2c31667e62e0 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -33,13 +33,6 @@ typedef struct {
>  	/* empty dummy */
>  } mm_segment_t;
>  
> -#ifndef TASK_SIZE_MAX
> -#define TASK_SIZE_MAX			TASK_SIZE
> -#endif
> -
> -#define uaccess_kernel()		(false)
> -#define user_addr_max()			(TASK_SIZE_MAX)
> -
>  static inline mm_segment_t force_uaccess_begin(void)
>  {
>  	return (mm_segment_t) { };
> -- 
> 2.29.2
> 
