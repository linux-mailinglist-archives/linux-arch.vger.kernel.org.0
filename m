Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07CE3186907
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 11:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgCPK2w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 06:28:52 -0400
Received: from foss.arm.com ([217.140.110.172]:45564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730550AbgCPK2w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Mar 2020 06:28:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82B61FEC;
        Mon, 16 Mar 2020 03:28:51 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D1143F85E;
        Mon, 16 Mar 2020 03:28:48 -0700 (PDT)
Date:   Mon, 16 Mar 2020 10:28:46 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 21/26] arm64: Introduce asm/vdso/arch_timer.h
Message-ID: <20200316102845.GB5746@lakrids.cambridge.arm.com>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-22-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313154345.56760-22-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Vincenzo,

On Fri, Mar 13, 2020 at 03:43:40PM +0000, Vincenzo Frascino wrote:
> The vDSO library should only include the necessary headers required for
> a userspace library (UAPI and a minimal set of kernel headers). To make
> this possible it is necessary to isolate from the kernel headers the
> common parts that are strictly necessary to build the library.
> 
> Introduce asm/vdso/arch_timer.h to contain all the arm64 specific
> code. This allows to replace the second isb() in __arch_get_hw_counter()
> with a fake dependent stack read of the counter which improves the vdso
> library peformances of ~4.5%. Below the results of vdsotest [1] ran for
> 100 iterations.
> 
> Before the patch:
> =================
> clock-gettime-monotonic: syscall: 771 nsec/call
> clock-gettime-monotonic:    libc: 130 nsec/call
> clock-gettime-monotonic:    vdso: 111 nsec/call
> ...
> clock-gettime-realtime: syscall: 762 nsec/call
> clock-gettime-realtime:    libc: 130 nsec/call
> clock-gettime-realtime:    vdso: 111 nsec/call
> 
> After the patch:
> ================
> clock-gettime-monotonic: syscall: 792 nsec/call
> clock-gettime-monotonic:    libc: 124 nsec/call
> clock-gettime-monotonic:    vdso: 106 nsec/call
> ...
> clock-gettime-realtime: syscall: 776 nsec/call
> clock-gettime-realtime:    libc: 124 nsec/call
> clock-gettime-realtime:    vdso: 106 nsec/call
> 
> [1] https://github.com/nathanlynch/vdsotest
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <Mark.Rutland@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  arch/arm64/include/asm/arch_timer.h        | 29 ++++---------------
>  arch/arm64/include/asm/vdso/arch_timer.h   | 33 ++++++++++++++++++++++
>  arch/arm64/include/asm/vdso/gettimeofday.h |  7 +++--
>  3 files changed, 42 insertions(+), 27 deletions(-)
>  create mode 100644 arch/arm64/include/asm/vdso/arch_timer.h
> 
> diff --git a/arch/arm64/include/asm/arch_timer.h b/arch/arm64/include/asm/arch_timer.h
> index 7ae54d7d333a..7f22cd00ad45 100644
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -164,24 +164,7 @@ static inline void arch_timer_set_cntkctl(u32 cntkctl)
>  	isb();
>  }
>  
> -/*
> - * Ensure that reads of the counter are treated the same as memory reads
> - * for the purposes of ordering by subsequent memory barriers.
> - *
> - * This insanity brought to you by speculative system register reads,
> - * out-of-order memory accesses, sequence locks and Thomas Gleixner.
> - *
> - * http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/631195.html
> - */
> -#define arch_counter_enforce_ordering(val) do {				\
> -	u64 tmp, _val = (val);						\
> -									\
> -	asm volatile(							\
> -	"	eor	%0, %1, %1\n"					\
> -	"	add	%0, sp, %0\n"					\
> -	"	ldr	xzr, [%0]"					\
> -	: "=r" (tmp) : "r" (_val));					\
> -} while (0)
> +#include <asm/vdso/arch_timer.h>
>  
>  static __always_inline u64 __arch_counter_get_cntpct_stable(void)
>  {
> @@ -189,7 +172,7 @@ static __always_inline u64 __arch_counter_get_cntpct_stable(void)
>  
>  	isb();
>  	cnt = arch_timer_reg_read_stable(cntpct_el0);
> -	arch_counter_enforce_ordering(cnt);
> +	cnt = arch_counter_enforce_ordering(cnt);
>  	return cnt;

Why have you changed the structure of arch_counter_enforce_ordering() to
return a value? The commit message has no rationale for that.

If there is a reason to change that, I'd prefer the driver change as one
patch, before moving the definition.

[...]

> +/*
> + * Ensure that reads of the counter are treated the same as memory reads
> + * for the purposes of ordering by subsequent memory barriers.
> + *
> + * This insanity brought to you by speculative system register reads,
> + * out-of-order memory accesses, sequence locks and Thomas Gleixner.
> + *
> + * http://lists.infradead.org/pipermail/linux-arm-kernel/2019-February/631195.html
> + *
> + */
> +static u64 arch_counter_enforce_ordering(u64 val)
> +{
> +	u64 tmp, _val = (val);
> +
> +	asm volatile(
> +	"	eor	%0, %1, %1\n"
> +	"	add	%0, sp, %0\n"
> +	"	ldr	xzr, [%0]"
> +	: "=r" (tmp) : "r" (_val));
> +
> +	return _val;
> +}

This change has no functional effect. Since `_val` is only passed in as
an input parameter, the compiler can assume the assembly has no effect
on it.

As above, what is the rationale for changing this?

> @@ -82,10 +83,10 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock_mode)
>  	isb();
>  	asm volatile("mrs %0, cntvct_el0" : "=r" (res) :: "memory");
>  	/*
> -	 * This isb() is required to prevent that the seq lock is
> -	 * speculated.#
> +	 * arch_counter_enforce_ordering() is required to prevent that
> +	 * the seq lock is speculated.
>  	 */
> -	isb();
> +	res = arch_counter_enforce_ordering(res);

Can we delete the comment entirely? We don't bother in <asm/arch_timer.h>.

Even better, can we factor out __arch_counter_get_cntvct(), and use
that?

Thanks,
Mark.
