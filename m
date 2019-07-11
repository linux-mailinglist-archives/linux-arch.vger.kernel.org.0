Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1655865673
	for <lists+linux-arch@lfdr.de>; Thu, 11 Jul 2019 14:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfGKMOo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Jul 2019 08:14:44 -0400
Received: from foss.arm.com ([217.140.110.172]:45358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727974AbfGKMOo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 11 Jul 2019 08:14:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E72F92B;
        Thu, 11 Jul 2019 05:14:42 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A80C3F59C;
        Thu, 11 Jul 2019 05:14:40 -0700 (PDT)
Subject: Re: [PATCH] vsyscall: use __iter_div_u64_rem()
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20190710130206.1670830-1-arnd@arndb.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <33511b0e-6d7b-c156-c415-7a609b049567@arm.com>
Date:   Thu, 11 Jul 2019 13:14:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710130206.1670830-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On 10/07/2019 14:01, Arnd Bergmann wrote:
> On 32-bit x86 when building with clang-9, the loop gets turned back into
> an inefficient division that causes a link error:
> 
> kernel/time/vsyscall.o: In function `update_vsyscall':
> vsyscall.c:(.text+0xe3): undefined reference to `__udivdi3'
> 
> Use the provided __iter_div_u64_rem() function that is meant to address
> the same case in other files.
> 
> Fixes: 44f57d788e7d ("timekeeping: Provide a generic update_vsyscall() implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/time/vsyscall.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
> index a80893180826..8cf3596a4ce6 100644
> --- a/kernel/time/vsyscall.c
> +++ b/kernel/time/vsyscall.c
> @@ -104,11 +104,7 @@ void update_vsyscall(struct timekeeper *tk)
>  	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
>  	nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
>  	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
> -	while (nsec >= NSEC_PER_SEC) {
> -		nsec = nsec - NSEC_PER_SEC;
> -		vdso_ts->sec++;
> -	}
> -	vdso_ts->nsec	= nsec;
> +	vdso_ts->sec	+= __iter_div_u64_rem(nsec, NSEC_PER_SEC, &vdso_ts->nsec);
>  
>  	if (__arch_use_vsyscall(vdata))
>  		update_vdso_data(vdata, tk);
> 

I am trying to test this patch using clang-9 tip:

# clang -v
clang version 9.0.0 (git@github.com:llvm-mirror/clang.git
6ed0749151866894a67a3e7eefdc1f3a547daa0e) (git@github.com:llvm-mirror/llvm.git
a10a70238ace1093cad3adeb94814b422bd1b5c1)

but I get a lot of errors similar to the one below:

In file included from ~/linux/arch/x86/events/amd/core.c:11:
~/linux/arch/x86/events/amd/../perf_event.h:824:21: error: invalid output size
for constraint '=q'
        u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
                           ^
~/linux/include/linux/percpu-defs.h:447:2: note: expanded from macro
'__this_cpu_read'
        raw_cpu_read(pcp);                                              \
        ^
~/linux/include/linux/percpu-defs.h:421:28: note: expanded from macro 'raw_cpu_read'
#define raw_cpu_read(pcp)               __pcpu_size_call_return(raw_cpu_read_, pcp)
                                        ^
~/linux/include/linux/percpu-defs.h:322:23: note: expanded from macro
'__pcpu_size_call_return'
        case 1: pscr_ret__ = stem##1(variable); break;                  \
                             ^
<scratch space>:110:1: note: expanded from here
raw_cpu_read_1
^
~/linux/arch/x86/include/asm/percpu.h:394:30: note: expanded from macro
'raw_cpu_read_1'
#define raw_cpu_read_1(pcp)             percpu_from_op(, "mov", pcp)
                                        ^
~/linux/arch/x86/include/asm/percpu.h:189:15: note: expanded from macro
'percpu_from_op'
                    : "=q" (pfo_ret__)                  \

Could you please tell me which version of the compiler did you use?

My building command is:

# make mrproper && make CC=clang HOSTCC=clang i386_defconfig && make ARCH=i386
CC=clang HOSTCC=clang -j56

-- 
Regards,
Vincenzo
