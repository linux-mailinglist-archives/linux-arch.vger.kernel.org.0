Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709AA484736
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 18:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiADRuv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 12:50:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46166 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiADRuv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 12:50:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCA8761557;
        Tue,  4 Jan 2022 17:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9C5C36AEF;
        Tue,  4 Jan 2022 17:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641318650;
        bh=nshZPOCJ0U2hiTwwxDxQ2DRKr/7JGFhPOvjyM9Fn0x8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQDlNS8M0Dn3sQXN6DT5jhbDEP9ybf5uUlVk9Ndrdz/LOyydNSoFkQjTX5l92AXRY
         7XlryXmHMyDtOiCG5RJtmFx0a1CQFHYCNEFxsx6TkgfLLGhg2yYOgHe2xv0TdltQwE
         ssPsyWpwR/Xp0Lsk92ngCbBYcjMwa9oP83SSBO2HRGlvWhpGI2VRFadJ/r7cimGktj
         zvi93+g7tZjsCXnmUwgLKgZ8xM/VPaXPW/+6kzQDKb8rLDn9zp0pTdS5ti1RC3pUSV
         Ppyu/ayt1Uwb86WsetaGBKnH4hu+IjYmjq9qBWhoKa7iyJdzrJRDCO5vQ9+D0MwyGk
         XGflruGPYKHuQ==
Date:   Tue, 4 Jan 2022 10:50:44 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>, llvm@lists.linux.dev
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdSI9LmZE+FZAi1K@archlinux-ax161>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdQlwnDs2N9a5Reh@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 04, 2022 at 11:47:30AM +0100, Ingo Molnar wrote:
> 
> * Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > Hi Ingo,
> > 
> > On Sun, Jan 02, 2022 at 10:57:35PM +0100, Ingo Molnar wrote:
> > > Before going into details about how this tree solves 'dependency hell' 
> > > exactly, here's the current kernel build performance gain with 
> > > CONFIG_FAST_HEADERS=y enabled, (and with CONFIG_KALLSYMS_FAST=y enabled as 
> > > well - see below), using a stock x86 Linux distribution's .config with all 
> > > modules built into the vmlinux:
> > > 
> > >   #
> > >   # Performance counter stats for 'make -j96 vmlinux' (3 runs):
> > >   #
> > >   # (Elapsed time in seconds):
> > >   #
> > > 
> > >   v5.16-rc7:            231.34 +- 0.60 secs, 15.5 builds/hour    # [ vanilla baseline ]
> > >   -fast-headers-v1:     129.97 +- 0.51 secs, 27.7 builds/hour    # +78.0% improvement
> > 
> > This is really impressive; as someone who constantly builds large
> > kernels for test coverage, I am excited about less time to get results.
> > Testing on an 80-core arm64 server (the fastest machine I have access to
> > at the moment) with LLVM, I can see anywhere from 18% to 35% improvement.
> > 
> > 
> > Benchmark 1: ARCH=arm64 defconfig (linux)
> >   Time (mean ± σ):     97.159 s ±  0.246 s    [User: 4828.383 s, System: 611.256 s]
> >   Range (min … max):   96.900 s … 97.648 s    10 runs
> > 
> > Benchmark 2: ARCH=arm64 defconfig (linux-fast-headers)
> >   Time (mean ± σ):     76.300 s ±  0.107 s    [User: 3149.986 s, System: 436.487 s]
> >   Range (min … max):   76.117 s … 76.467 s    10 runs
> 
> That looks good, thanks for giving it a test, and thanks for all the fixes! 
> :-)
> 
> Note that on ARM64 the elapsed time improvement is 'only' 18-35%, because 
> the triple-linking of vmlinux serializes much of the of a build & ARM64 
> doesn't have the kallsyms-objtool feature yet.
> 
> But we can already see how much faster it became, from the user+system time 
> spent building the kernel:
> 
>            vanilla: 4828.383 s + 611.256 s = 5439.639 s
>   -fast-headers-v1: 3149.986 s + 436.487 s = 3586.473 s
> 
> That's a +51% speedup. :-)
D> 
> With CONFIG_KALLSYMS_FAST=y on x86, the final link gets faster by about 
> 60%-70%, so the header improvements will more directly show up in elapsed 
> time as well.
> 
> Plus I spent more time looking at x86 header bloat than at ARM64 header 
> bloat. In the end I think the improvement could probably moved into the 
> broad 60-70% range that I see on x86.
> 
> All the other ARM64 tests show a 37%-43% improvement in CPU time used:
> 
> > Benchmark 1: ARCH=arm64 allmodconfig (linux)
> >   Time (mean ± σ):     390.106 s ±  0.192 s    [User: 23893.382 s, System: 2802.413 s]
> >   Range (min … max):   389.942 s … 390.513 s    7 runs
> > 
> > Benchmark 2: ARCH=arm64 allmodconfig (linux-fast-headers)
> >   Time (mean ± σ):     288.066 s ±  0.621 s    [User: 16436.098 s, System: 2117.352 s]
> >   Range (min … max):   287.131 s … 288.982 s    7 runs
> 
> # (23893.382+2802.413)/(16436.098+2117.352) = +43% in throughput.
> 
> 
> > Benchmark 1: ARCH=arm64 allyesconfig (linux)
> >   Time (mean ± σ):     557.752 s ±  1.019 s    [User: 21227.404 s, System: 2226.121 s]
> >   Range (min … max):   555.833 s … 558.775 s    7 runs
> > 
> > Benchmark 2: ARCH=arm64 allyesconfig (linux-fast-headers)
> >   Time (mean ± σ):     473.815 s ±  1.793 s    [User: 15351.991 s, System: 1689.630 s]
> >   Range (min … max):   471.542 s … 476.830 s    7 runs
> 
> # (21227.404+2226.121)/(15351.991+1689.630) = +37%
> 
> 
> > Benchmark 1: ARCH=x86_64 defconfig (linux)
> >   Time (mean ± σ):     41.122 s ±  0.190 s    [User: 1700.206 s, System: 205.555 s]
> >   Range (min … max):   40.966 s … 41.515 s    7 runs
> > 
> > Benchmark 2: ARCH=x86_64 defconfig (linux-fast-headers)
> >   Time (mean ± σ):     36.357 s ±  0.183 s    [User: 1134.252 s, System: 152.396 s]
> >   Range (min … max):   35.983 s … 36.534 s    7 runs
> 
> 
> # (1700.206+205.555)/(1134.252+152.396) = +48%
> 
> > Summary
> >   'ARCH=x86_64 defconfig (linux-fast-headers)' ran
> >     1.13 ± 0.01 times faster than 'ARCH=x86_64 defconfig (linux)'
> 
> Now this x86-defconfig result you got is a bit weird - it *should* have 
> been around ~50% faster on x86 in terms of elapsed time too.
> 
> Here's how x86-64 defconfig looks like on my system - with 128 GB RAM & 
> fast NVDIMMs and 64 CPUs:
> 
>    #
>    # -v5.16-rc8:
>    #
> 
>    $ perf stat --repeat 3 -e instructions,cycles,cpu-clock --sync --pre "make clean >/dev/null" make -j96 vmlinux >/dev/null
> 
>    Performance counter stats for 'make -j96 vmlinux' (3 runs):
> 
>    4,906,953,379,372      instructions              #    0.90  insn per cycle           ( +-  0.00% )
>    5,475,163,448,391      cycles                    #    3.898 GHz                      ( +-  0.01% )
>         1,404,614.64 msec cpu-clock                 #   45.864 CPUs utilized            ( +-  0.01% )
> 
>              30.6258 +- 0.0337 seconds time elapsed  ( +-  0.11% )
> 
>    #
>    # -fast-headers-v1:
>    #
> 
>    $ make defconfig
>    $ grep KALLSYMS_FAST .config
>    CONFIG_KALLSYMS_FAST=y
> 
>    $ perf stat --repeat 3 -e instructions,cycles,cpu-clock --sync --pre "make clean >/dev/null" make -j96 vmlinux >/dev/null
> 
>     Performance counter stats for 'make -j96 vmlinux' (3 runs):
> 
>      3,500,079,269,120      instructions              #    0.90  insn per cycle           ( +-  0.00% )
>      3,872,081,278,824      cycles                    #    3.895 GHz                      ( +-  0.10% )
>             993,448.13 msec cpu-clock                 #   47.306 CPUs utilized            ( +-  0.10% )
> 
>              21.0004 +- 0.0265 seconds time elapsed  ( +-  0.13% )
> 
> That's a +45.8% speedup in elapsed time, and a +41.4% improvement in 
> cpu-clock utilization.
> 
> I'm wondering whether your system has some sort of bottleneck?

Yes, it is entirely possible. That testing was done on Equinix's
c3.large.arm server and I have noticed at times that single threaded
tasks seems to take a little bit longer than on my x86_64 box.

https://metal.equinix.com/product/servers/c3-large-arm/

The all{mod,yes}config tests on that box had a much more noticeable
improvement, along the lines of what you were expecting:


Benchmark 1: ARCH=x86_64 allmodconfig (linux)
  Time (mean ± σ):     387.575 s ±  0.288 s    [User: 23916.296 s, System: 2814.850 s]
  Range (min … max):   387.252 s … 388.295 s    10 runs

Benchmark 2: ARCH=x86_64 allmodconfig (linux-fast-headers)
  Time (mean ± σ):     255.934 s ±  0.972 s    [User: 15130.494 s, System: 2095.091 s]
  Range (min … max):   254.655 s … 257.357 s    10 runs

Summary
  'ARCH=x86_64 allmodconfig (linux-fast-headers)' ran
    1.51 ± 0.01 times faster than 'ARCH=x86_64 allmodconfig (linux)'

# (23916.296+2814.850)/(15130.494+2095.091) = +55.18%


Benchmark 1: ARCH=x86_64 allyesconfig (linux)
  Time (mean ± σ):     568.027 s ±  1.071 s    [User: 21985.096 s, System: 2357.516 s]
  Range (min … max):   566.769 s … 569.801 s    10 runs

Benchmark 2: ARCH=x86_64 allyesconfig (linux-fast-headers)
  Time (mean ± σ):     381.248 s ±  0.919 s    [User: 14916.766 s, System: 1728.218 s]
  Range (min … max):   379.746 s … 382.852 s    10 runs

Summary
  'ARCH=x86_64 allyesconfig (linux-fast-headers)' ran
    1.49 ± 0.00 times faster than 'ARCH=x86_64 allyesconfig (linux)'

# (21985.096+2357.516)/(14916.766+1728.218) = +46.25%

> One thing I do though when running benchmarks is to switch the cpufreq 
> governor to 'performance', via something like:
> 
>    NR_CPUS=$(nproc --all)
> 
>    curr=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
>    next=performance
> 
>    echo "# setting all $NR_CPUS CPUs from '"$curr"' to the '"$next"' governor"
> 
>    for ((cpu=0; cpu<$NR_CPUS; cpu++)); do
>      G=/sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
>      [ -f $G ] && echo $next > $G
>    done
> 
> This minimizes the amount of noise across iterations and makes the results 
> more dependable:
> 
>              30.6258 +- 0.0337 seconds time elapsed  ( +-  0.11% )
>              21.0004 +- 0.0265 seconds time elapsed  ( +-  0.13% )

Good point. With my main box (AMD EPYC 7502P), with the performance governor...

GCC:

Benchmark 1: ARCH=x86_64 defconfig (linux)
  Time (mean ± σ):     48.685 s ±  0.049 s    [User: 1969.835 s, System: 204.166 s]
  Range (min … max):   48.620 s … 48.782 s    10 runs

Benchmark 2: ARCH=x86_64 defconfig (linux-fast-headers)
  Time (mean ± σ):     46.797 s ±  0.119 s    [User: 1403.854 s, System: 154.336 s]
  Range (min … max):   46.620 s … 47.052 s    10 runs

Summary
  'ARCH=x86_64 defconfig (linux-fast-headers)' ran
    1.04 ± 0.00 times faster than 'ARCH=x86_64 defconfig (linux)'

LLVM:

Benchmark 1: ARCH=x86_64 defconfig (linux)
  Time (mean ± σ):     51.816 s ±  0.079 s    [User: 2208.577 s, System: 200.410 s]
  Range (min … max):   51.671 s … 51.900 s    10 runs

Benchmark 2: ARCH=x86_64 defconfig (linux-fast-headers)
  Time (mean ± σ):     46.806 s ±  0.062 s    [User: 1438.972 s, System: 154.846 s]
  Range (min … max):   46.696 s … 46.917 s    10 runs

Summary
  'ARCH=x86_64 defconfig (linux-fast-headers)' ran
    1.11 ± 0.00 times faster than 'ARCH=x86_64 defconfig (linux)'

$ rg KALLSYMS .config
246:CONFIG_KALLSYMS=y
247:# CONFIG_KALLSYMS_ALL is not set
248:CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
249:CONFIG_KALLSYMS_BASE_RELATIVE=y
250:CONFIG_KALLSYMS_FAST=y
706:CONFIG_HAVE_OBJTOOL_KALLSYMS=y

It seems like everything is working right but maybe the build is so
short that there just is not much time for the difference to be as
apparent?

> > > With the fast-headers kernel that's down to ~36,000 lines of code, 
> > > almost a factor of 3 reduction:
> > > 
> > >   # fast-headers-v1:
> > >   kepler:~/mingo.tip.git> wc -l kernel/pid.i
> > >   35941 kernel/pid.i
> > 
> > Coming from someone who often has to reduce a preprocessed kernel source 
> > file with creduce/cvise to report compiler bugs, this will be a very 
> > welcomed change, as those tools will have to do less work, and I can get 
> > my reports done faster.
> 
> That's nice, didn't think of that side effect.
> 
> Could you perhaps measure this too, to see how much of a benefit it is?

Yes, next time that I run into a bug that I have to use those tools on,
I will see if I can benchmark the difference!

> > ########################################################################
> > 
> > I took the series for a spin with clang and GCC on arm64 and x86_64 and
> > I found a few warnings/errors.
> 
> Thank you!
> 
> > 1. Position of certain attributes
> > 
> > In some commits, you move the cacheline_aligned attributes from after
> > the closing brace on structures to before the struct keyword, which
> > causes clang to warn (and error with CONFIG_WERROR):
> > 
> > In file included from arch/arm64/kernel/asm-offsets.c:9:
> > In file included from arch/arm64/kernel/../../../kernel/sched/per_task_area_struct.h:33:
> > In file included from ./include/linux/perf_event_api.h:17:
> > In file included from ./include/linux/perf_event_types.h:41:
> > In file included from ./include/linux/ftrace.h:18:
> > In file included from ./arch/arm64/include/asm/ftrace.h:53:
> > In file included from ./include/linux/compat.h:11:
> > ./include/linux/fs_types.h:997:1: error: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Werror,-Wignored-attributes]
> > ____cacheline_aligned
> > ^
> > ./include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
> > #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
> 
> Yeah, so this is a *really* stupid warning from Clang.
> 
> Putting the attribute after 'struct' risks the hard to track down bugs when 
> a <linux/cache.h> inclusion is missing, which scenario I pointed out in 
> this commit:
> 
>     headers/deps: dcache: Move the ____cacheline_aligned attribute to the head of the definition
>     
>     When changing <linux/dcache.h> I removed the <linux/spinlock_api.h> header,
>     which caused a couple of hundred of mysterious, somewhat obscure link time errors:
>     
>       ld: net/sctp/tsnmap.o:(.bss+0x0): multiple definition of `____cacheline_aligned_in_smp'; init/do_mounts_rd.o:(.bss+0x0): first defined here
>       ld: net/sctp/tsnmap.o:(.bss+0x40): multiple definition of `____cacheline_aligned'; init/do_mounts_rd.o:(.bss+0x40): first defined here
>       ld: net/sctp/debug.o:(.bss+0x0): multiple definition of `____cacheline_aligned_in_smp'; init/do_mounts_rd.o:(.bss+0x0): first defined here
>       ld: net/sctp/debug.o:(.bss+0x40): multiple definition of `____cacheline_aligned'; init/do_mounts_rd.o:(.bss+0x40): first defined here
>     
>     After a bit of head-scratching, what happened is that 'struct dentry_operations'
>     has the ____cacheline_aligned attribute at the tail of the type definition -
>     which turned into a local variable definition when <linux/cache.h> was not
>     included - which <linux/spinlock_api.h> includes into <linux/dcache.h> indirectly.
>     
>     There were no compile time errors, only link time errors.
>     
>     Move the attribute to the head of the definition, in which case
>     a missing <linux/cache.h> inclusion creates an immediate build failure:
>     
>       In file included from ./include/linux/fs.h:9,
>                        from ./include/linux/fsverity.h:14,
>                        from fs/verity/fsverity_private.h:18,
>                        from fs/verity/read_metadata.c:8:
>       ./include/linux/dcache.h:132:22: error: expected ‘;’ before ‘struct’
>         132 | ____cacheline_aligned
>             |                      ^
>             |                      ;
>         133 | struct dentry_operations {
>             | ~~~~~~
>     
>     No change in functionality.
>     
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
> 
> Can this Clang warning be disabled?

I'll comment on this in the other thread.

> > 2. Error with CONFIG_SHADOW_CALL_STACK
> 
> So this feature depends on Clang:
> 
>  # Supported by clang >= 7.0
>  config CC_HAVE_SHADOW_CALL_STACK
>          def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
> 
> No way to activate it under my GCC cross-build toolchain, right?
> 
> But ... I hacked the build mode on with GCC using this patch:
> 
> From: Ingo Molnar <mingo@kernel.org>
> Date: Tue, 4 Jan 2022 11:26:09 +0100
> Subject: [PATCH] DO NOT MERGE: Enable SHADOW_CALL_STACK on GCC builds, for build testing
> 
> NOT-Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  Makefile           | 2 +-
>  arch/Kconfig       | 2 +-
>  arch/arm64/Kconfig | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 16d7f83ac368..bbab462e7509 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -888,7 +888,7 @@ LDFLAGS_vmlinux += --gc-sections
>  endif
>  
>  ifdef CONFIG_SHADOW_CALL_STACK
> -CC_FLAGS_SCS	:= -fsanitize=shadow-call-stack
> +CC_FLAGS_SCS	:=
>  KBUILD_CFLAGS	+= $(CC_FLAGS_SCS)
>  export CC_FLAGS_SCS
>  endif
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 4e56f66fdbcf..2103d9da4fe1 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -605,7 +605,7 @@ config ARCH_SUPPORTS_SHADOW_CALL_STACK
>  
>  config SHADOW_CALL_STACK
>  	bool "Clang Shadow Call Stack"
> -	depends on CC_IS_CLANG && ARCH_SUPPORTS_SHADOW_CALL_STACK
> +	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
>  	depends on DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
>  	help
>  	  This option enables Clang's Shadow Call Stack, which uses a
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c4207cf9bb17..952f3e56e0a7 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1183,7 +1183,7 @@ config ARCH_HAS_FILTER_PGPROT
>  
>  # Supported by clang >= 7.0
>  config CC_HAVE_SHADOW_CALL_STACK
> -	def_bool $(cc-option, -fsanitize=shadow-call-stack -ffixed-x18)
> +	def_bool y
>  
>  config PARAVIRT
>  	bool "Enable paravirtualization code"
> 
> 
> And was able to trigger at least some of the build errors you saw:
> 
>   In file included from kernel/scs.c:15:
>   ./include/linux/scs.h: In function 'scs_task_reset':
>   ./include/linux/scs.h:26:34: error: implicit declaration of function 'task_thread_info' [-Werror=implicit-function-declaration]
> 
> This is fixed with:
> 
> diff --git a/kernel/scs.c b/kernel/scs.c
> index ca9e707049cb..719ab53adc8a 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2019 Google LLC
>   */
>  
> +#include <linux/sched/thread_info_api.h>
>  #include <linux/sched.h>
>  #include <linux/mm_page_address.h>
>  #include <linux/mm_api.h>
> 
> 
> Then there's the build failure in init/main.c:
> 
> > It looks like on mainline, init_shadow_call_stack is in defined and used 
> > in init/init_task.c but now, it is used in init/main.c, with no
> > declaration to allow the compiler to find the definition. I guess moving
> > init_shadow_call_stack out of init/init_task.c to somewhere more common
> > would fix this but it depends on SCS_SIZE, which is defined in
> > include/linux/scs.h, and as soon as I tried to include that in another
> > file, the build broke further... Any ideas you have would be appreciated
> > :) for benchmarking purposes, I just disabled CONFIG_SHADOW_CALL_STACK.
> 
> So I see:
> 
> In file included from ./include/linux/thread_info.h:63,
>                  from ./arch/arm64/include/asm/smp.h:32,
>                  from ./include/linux/smp_api.h:15,
>                  from ./include/linux/percpu.h:6,
>                  from ./include/linux/softirq.h:8,
>                  from init/main.c:17:
> init/main.c: In function 'init_per_task_early':
> ./arch/arm64/include/asm/thread_info.h:113:27: error: 'init_shadow_call_stack' undeclared (first use in this function)
>   113 |         .scs_base       = init_shadow_call_stack,                       \
>       |                           ^~~~~~~~~~~~~~~~~~~~~~
> 
> This looks pretty straightforward, does this patch solve it?
> 
>  include/linux/scs.h | 3 +++
>  init/main.c         | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/linux/scs.h b/include/linux/scs.h
> index 18122d9e17ff..863932a9347a 100644
> --- a/include/linux/scs.h
> +++ b/include/linux/scs.h
> @@ -8,6 +8,7 @@
>  #ifndef _LINUX_SCS_H
>  #define _LINUX_SCS_H
>  
> +#include <linux/sched/thread_info_api.h>
>  #include <linux/gfp.h>
>  #include <linux/poison.h>
>  #include <linux/sched.h>
> @@ -25,6 +26,8 @@
>  #define task_scs(tsk)		(task_thread_info(tsk)->scs_base)
>  #define task_scs_sp(tsk)	(task_thread_info(tsk)->scs_sp)
>  
> +extern unsigned long init_shadow_call_stack[SCS_SIZE / sizeof(long)];
> +
>  void *scs_alloc(int node);
>  void scs_free(void *s);
>  void scs_init(void);
> diff --git a/init/main.c b/init/main.c
> index c9eb3ecbe18c..74ccad445009 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -12,6 +12,7 @@
>  
>  #define DEBUG		/* Enable initcall_debug */
>  
> +#include <linux/scs.h>
>  #include <linux/workqueue_api.h>
>  #include <linux/sysctl.h>
>  #include <linux/softirq.h>
> 
> I've applied these fixes, with that CONFIG_SHADOW_CALL_STACK=y builds fine 
> on ARM64 - but I performed no runtime testing.
> 
> I've backmerged this into:
> 
>     headers/deps: per_task, arm64, x86: Convert task_struct::thread to a per_task() field
> 
> where this bug originated from.
> 
> I.e. I think the bug was simply to make main.c aware of the array, now that 
> the INIT_THREAD initialization is done there.

Yes, that seems right.

Unfortunately, while the kernel now builds, it does not boot in QEMU. I
tried to checkout at 9006a48618cc0cacd3f59ff053e6509a9af5cc18 to see if
I could reproduce that breakage there but the build errors out at that
change (I do see notes of bisection breakage in some of the commits) so
I assume that is expected.

There is no output, even with earlycon, so it seems like something is
going wrong in early boot code. I am not very familiar with the SCS code
so I will see if I can debug this with gdb later (I'll try to see if it
is reproducible with GCC as well; as Nick mentions, there is support
being added to it and I don't mind building from source).

> We could move over the init_shadow_call_stack[] array there and make it 
> static to begin with? I don't think anything truly relies on it being a 
> global symbol.

That is what I thought as well... I'll see if I can ping Sami to see if
there is any reason not to do that.

> > 3. Nested function in arch/x86/kernel/asm-offsets.c
> 
> > diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
> > index ff3f8ed5d0a2..a6d56f4697cd 100644
> > --- a/arch/x86/kernel/asm-offsets.c
> > +++ b/arch/x86/kernel/asm-offsets.c
> > @@ -35,10 +35,10 @@
> >  # include "asm-offsets_64.c"
> >  #endif
> > 
> > -static void __used common(void)
> > -{
> >  #include "../../../kernel/sched/per_task_area_struct_defs.h"
> > 
> > +static void __used common(void)
> > +{
> >         BLANK();
> >         DEFINE(TASK_threadsp, offsetof(struct task_struct, per_task_area) +
> >                               offsetof(struct task_struct_per_task, thread) +
> 
> Ha, that code is bogus, it's a merge bug of mine. Super interesting that 
> GCC still managed to include the header ...
> 
> I've applied your fix.
> 
> > 4. Build error in kernel/gcov/clang.c
> 
> > 8 errors generated.
> > 
> > I resolved this with:
> > 
> > diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> > index 6ee385f6ad47..29f0899ba209 100644
> > --- a/kernel/gcov/clang.c
> > +++ b/kernel/gcov/clang.c
> > @@ -52,6 +52,7 @@
> >  #include <linux/ratelimit.h>
> >  #include <linux/slab.h>
> >  #include <linux/mm.h>
> > +#include <linux/string.h>
> >  #include "gcov.h"
> 
> Thank you - applied!
> 
> >  typedef void (*llvm_gcov_callback)(void);
> > 
> > 
> > 5. BPF errors
> > 
> > With Arch Linux's config (https://github.com/archlinux/svntogit-packages/raw/packages/linux/trunk/config),
> > I see the following errors:
> > 
> > kernel/bpf/preload/iterators/iterators.c:3:10: fatal error: 'linux/sched/signal.h' file not found
> > #include <linux/sched/signal.h>
> >          ^~~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> > 
> > kernel/bpf/sysfs_btf.c:21:2: error: implicitly declaring library function 'memcpy' with type 'void *(void *, const void *, unsigned long)' [-Werror,-Wimplicit-function-declaration]
> >         memcpy(buf, __start_BTF + off, len);
> >         ^
> > kernel/bpf/sysfs_btf.c:21:2: note: include the header <string.h> or explicitly provide a declaration for 'memcpy'
> > 1 error generated.
> > 
> > The second error is obviously fixed by just including string.h as above.
> 
> Applied.
> 
> > I am not sure what is wrong with the first one; the includes all appear
> > to be userland headers, rather than kernel ones, so maybe an -I flag is
> > not present that should be? To work around it, I disabled
> > CONFIG_BPF_PRELOAD.
> 
> Yeah, this should be fixed by simply removing the two stray dependencies 
> that found their way into this user-space code:
> 
>  kernel/bpf/preload/iterators/iterators.bpf.c | 1 -
>  kernel/bpf/preload/iterators/iterators.c     | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/kernel/bpf/preload/iterators/iterators.bpf.c b/kernel/bpf/preload/iterators/iterators.bpf.c
> index 41ae00edeecf..03af863314ea 100644
> --- a/kernel/bpf/preload/iterators/iterators.bpf.c
> +++ b/kernel/bpf/preload/iterators/iterators.bpf.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2020 Facebook */
> -#include <linux/seq_file.h>
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_core_read.h>
> diff --git a/kernel/bpf/preload/iterators/iterators.c b/kernel/bpf/preload/iterators/iterators.c
> index d702cbf7ddaf..5d872a705470 100644
> --- a/kernel/bpf/preload/iterators/iterators.c
> +++ b/kernel/bpf/preload/iterators/iterators.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2020 Facebook */
> -#include <linux/sched/signal.h>
>  #include <errno.h>
>  #include <stdio.h>
>  #include <stdlib.h>

Yes, that resolves the error for me.

> > 6. resolve_btfids warning
> > 
> > After working around the above errors, with either GCC or clang, I see
> > the following warnings with Arch Linux's configuration:
> > 
> > WARN: multiple IDs found for 'task_struct': 103, 23549 - using 103
> > WARN: multiple IDs found for 'path': 1166, 23551 - using 1166
> > WARN: multiple IDs found for 'inode': 997, 23561 - using 997
> > WARN: multiple IDs found for 'file': 714, 23566 - using 714
> > WARN: multiple IDs found for 'seq_file': 1120, 23673 - using 1120
> > 
> > Which appears to come from symbols_resolve() in
> > tools/bpf/resolve_btfids/main.c.
> 
> Hm, is this perhaps related to CONFIG_KALLSYMS_FAST=y? If yes then turning 
> it off might help.
> 
> I don't really know this area of BPF all that much, maybe someone else can 
> see what the problem is? The error message is not self-explanatory.

It does not seem related, as I disabled that configuration and still see
it.

I am equally ignorant about BPF so enlisting their help would good.

> > 
> > ########################################################################
> > 
> > I am very excited to see where this goes, it is a herculean effort but I
> > think it will be worth it in the long run. Let me know if there is any
> > more information or input that I can provide, cheers!
> 
> Your testing & patch sending efforts are much appreciated!! You'd help me 
> most by continuing on the same path with new fast-headers releases as well, 
> whenever you find the time. :-)
> 
> BTW., you can always pick up my latest Work-In-Progress branch from:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
> 
> The 'master' branch will carry the release.
> 
> The sched/headers branch is already rebased to -rc8 and has some other 
> changes as well. It should normally work, with less testing than the main 
> releasees, but will at times have fixes at the tail waiting to be 
> backmerged in a bisect-friendly way.

Sure thing, I will continue to follow this and test it as much as I can
to make sure everything continues to work well!

Cheers,
Nathan
