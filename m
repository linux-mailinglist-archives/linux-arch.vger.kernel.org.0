Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48A548366D
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 18:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiACRy4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 12:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiACRy4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 12:54:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CC2C061761;
        Mon,  3 Jan 2022 09:54:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48893B80B4C;
        Mon,  3 Jan 2022 17:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5C7C36AEF;
        Mon,  3 Jan 2022 17:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641232492;
        bh=RR4zMr8w1oD7x3w8KWCwD3Pub3Mo4pKk4MOT2U42mpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrOXCcFRW0zwHePueqMJZHuS7A/eZZOMP5eO/hbx/Uz+4mOumGG+7uULAwfmyYegf
         9OmC69x8xy5ZAEXy5uoBAlZ3KBanp7E+iXS2RtzIx0KF9WDtURZ2WiM7mE91Wswt1p
         lt3J3qFssxYxHsg2DushBidON//vocNXv3mGdzPXfUSS1biMQrxCQsdGg95aNxpMaC
         YOtPasBb+Rjr/4rzx9ACn3RG2M4sUhbyTaQCy66gGlx+x3uRqC3GKYDaCepjl6ED4k
         Hq2L0HrMVN3coh64Y1ic92sJYzICDXmv2/GUDPFrSQeI7JIlV/gpVvPJvJBljir9Ca
         vj09VofJ/UaHw==
Date:   Mon, 3 Jan 2022 10:54:47 -0700
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
Message-ID: <YdM4Z5a+SWV53yol@archlinux-ax161>
References: <YdIfz+LMewetSaEB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdIfz+LMewetSaEB@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Ingo,

On Sun, Jan 02, 2022 at 10:57:35PM +0100, Ingo Molnar wrote:
> Before going into details about how this tree solves 'dependency hell' 
> exactly, here's the current kernel build performance gain with 
> CONFIG_FAST_HEADERS=y enabled, (and with CONFIG_KALLSYMS_FAST=y enabled as 
> well - see below), using a stock x86 Linux distribution's .config with all 
> modules built into the vmlinux:
> 
>   #
>   # Performance counter stats for 'make -j96 vmlinux' (3 runs):
>   #
>   # (Elapsed time in seconds):
>   #
> 
>   v5.16-rc7:            231.34 +- 0.60 secs, 15.5 builds/hour    # [ vanilla baseline ]
>   -fast-headers-v1:     129.97 +- 0.51 secs, 27.7 builds/hour    # +78.0% improvement

This is really impressive; as someone who constantly builds large
kernels for test coverage, I am excited about less time to get results.
Testing on an 80-core arm64 server (the fastest machine I have access to
at the moment) with LLVM, I can see anywhere from 18% to 35% improvement.


Benchmark 1: ARCH=arm64 defconfig (linux)
  Time (mean ± σ):     97.159 s ±  0.246 s    [User: 4828.383 s, System: 611.256 s]
  Range (min … max):   96.900 s … 97.648 s    10 runs

Benchmark 2: ARCH=arm64 defconfig (linux-fast-headers)
  Time (mean ± σ):     76.300 s ±  0.107 s    [User: 3149.986 s, System: 436.487 s]
  Range (min … max):   76.117 s … 76.467 s    10 runs

Summary
  'ARCH=arm64 defconfig (linux-fast-headers)' ran
    1.27 ± 0.00 times faster than 'ARCH=arm64 defconfig (linux)'


Benchmark 1: ARCH=arm64 allmodconfig (linux)
  Time (mean ± σ):     390.106 s ±  0.192 s    [User: 23893.382 s, System: 2802.413 s]
  Range (min … max):   389.942 s … 390.513 s    7 runs

Benchmark 2: ARCH=arm64 allmodconfig (linux-fast-headers)
  Time (mean ± σ):     288.066 s ±  0.621 s    [User: 16436.098 s, System: 2117.352 s]
  Range (min … max):   287.131 s … 288.982 s    7 runs

Summary
  'ARCH=arm64 allmodconfig (linux-fast-headers)' ran
    1.35 ± 0.00 times faster than 'ARCH=arm64 allmodconfig (linux)'


Benchmark 1: ARCH=arm64 allyesconfig (linux)
  Time (mean ± σ):     557.752 s ±  1.019 s    [User: 21227.404 s, System: 2226.121 s]
  Range (min … max):   555.833 s … 558.775 s    7 runs

Benchmark 2: ARCH=arm64 allyesconfig (linux-fast-headers)
  Time (mean ± σ):     473.815 s ±  1.793 s    [User: 15351.991 s, System: 1689.630 s]
  Range (min … max):   471.542 s … 476.830 s    7 runs

Summary
  'ARCH=arm64 allyesconfig (linux-fast-headers)' ran
    1.18 ± 0.00 times faster than 'ARCH=arm64 allyesconfig (linux)'


I wanted to test the same x86_64 configs last night but I ran out of time
before bed due to some issues that I was only able to look at this morning
(more on those below). I'll just have to settle for defconfig right now, whichs
shows a modest improvement.

Benchmark 1: ARCH=x86_64 defconfig (linux)
  Time (mean ± σ):     41.122 s ±  0.190 s    [User: 1700.206 s, System: 205.555 s]
  Range (min … max):   40.966 s … 41.515 s    7 runs

Benchmark 2: ARCH=x86_64 defconfig (linux-fast-headers)
  Time (mean ± σ):     36.357 s ±  0.183 s    [User: 1134.252 s, System: 152.396 s]
  Range (min … max):   35.983 s … 36.534 s    7 runs

Summary
  'ARCH=x86_64 defconfig (linux-fast-headers)' ran
    1.13 ± 0.01 times faster than 'ARCH=x86_64 defconfig (linux)'

> For example, the preprocessed kernel/pid.c file explodes into over 94,000 
> lines of code on the vanilla kernel:
> 
>   # v5.16-rc7:
> 
>   kepler:~/mingo.tip.git> make kernel/pid.i
>   kepler:~/mingo.tip.git> wc -l kernel/pid.i
>   94569 kernel/pid.i
> 
> The compiler has to go through those 95,000 lines of code - even if a lot 
> of it is trivial fluff not actually used by kernel/pid.c.
> 
> With the fast-headers kernel that's down to ~36,000 lines of code, almost a 
> factor of 3 reduction:
> 
>   # fast-headers-v1:
>   kepler:~/mingo.tip.git> wc -l kernel/pid.i
>   35941 kernel/pid.i

Coming from someone who often has to reduce a preprocessed kernel source
file with creduce/cvise to report compiler bugs, this will be a very
welcomed change, as those tools will have to do less work, and I can get
my reports done faster.

########################################################################

I took the series for a spin with clang and GCC on arm64 and x86_64 and
I found a few warnings/errors.


1. Position of certain attributes

In some commits, you move the cacheline_aligned attributes from after
the closing brace on structures to before the struct keyword, which
causes clang to warn (and error with CONFIG_WERROR):

In file included from arch/arm64/kernel/asm-offsets.c:9:
In file included from arch/arm64/kernel/../../../kernel/sched/per_task_area_struct.h:33:
In file included from ./include/linux/perf_event_api.h:17:
In file included from ./include/linux/perf_event_types.h:41:
In file included from ./include/linux/ftrace.h:18:
In file included from ./arch/arm64/include/asm/ftrace.h:53:
In file included from ./include/linux/compat.h:11:
./include/linux/fs_types.h:997:1: error: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Werror,-Wignored-attributes]
____cacheline_aligned
^
./include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
#define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
                                             ^

My diff to fix this looks like:

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 520daf638d06..da7e77a7cede 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -127,8 +127,7 @@ enum dentry_d_lock_class
        DENTRY_D_LOCK_NESTED
 };

-____cacheline_aligned
-struct dentry_operations {
+struct ____cacheline_aligned dentry_operations {
        int (*d_revalidate)(struct dentry *, unsigned int);
        int (*d_weak_revalidate)(struct dentry *, unsigned int);
        int (*d_hash)(const struct dentry *, struct qstr *);
diff --git a/include/linux/fs_types.h b/include/linux/fs_types.h
index b53aadafab1b..e2e1c0827183 100644
--- a/include/linux/fs_types.h
+++ b/include/linux/fs_types.h
@@ -994,8 +994,7 @@ struct file_operations {
        int (*fadvise)(struct file *, loff_t, loff_t, int);
 } __randomize_layout;

-____cacheline_aligned
-struct inode_operations {
+struct ____cacheline_aligned inode_operations {
        struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
        const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
        int (*permission) (struct user_namespace *, struct inode *, int);
diff --git a/include/linux/netdevice_api.h b/include/linux/netdevice_api.h
index 4a8d7688e148..0e5e08dcbb2a 100644
--- a/include/linux/netdevice_api.h
+++ b/include/linux/netdevice_api.h
@@ -49,7 +49,7 @@
 #endif

 /* This structure contains an instance of an RX queue. */
-____cacheline_aligned_in_smp struct netdev_rx_queue {
+struct ____cacheline_aligned_in_smp netdev_rx_queue {
        struct xdp_rxq_info             xdp_rxq;
 #ifdef CONFIG_RPS
        struct rps_map __rcu            *rps_map;
diff --git a/include/net/xdp_types.h b/include/net/xdp_types.h
index 442028626b35..accc12372bca 100644
--- a/include/net/xdp_types.h
+++ b/include/net/xdp_types.h
@@ -56,7 +56,7 @@ struct xdp_mem_info {
 struct page_pool;

 /* perf critical, avoid false-sharing */
-____cacheline_aligned struct xdp_rxq_info {
+struct ____cacheline_aligned xdp_rxq_info {
        struct net_device *dev;
        u32 queue_index;
        u32 reg_state;


2. Error with CONFIG_SHADOW_CALL_STACK

With ARCH=arm64 defconfig + CONFIG_SHADOW_CALL_STACK, I see the
following error:

$ make -skj"$(nproc)" ARCH=arm64 LLVM=1 defconfig menuconfig init/
init/main.c:916:50: error: use of undeclared identifier 'init_shadow_call_stack'
        per_task(&init_task, ti) = (struct thread_info) INIT_THREAD_INFO(init_task);
                                                        ^
./arch/arm64/include/asm/thread_info.h:123:2: note: expanded from macro 'INIT_THREAD_INFO'
        INIT_SCS                                                        \
        ^
./arch/arm64/include/asm/thread_info.h:113:14: note: expanded from macro 'INIT_SCS'
        .scs_base       = init_shadow_call_stack,                       \
                          ^
init/main.c:916:50: error: use of undeclared identifier 'init_shadow_call_stack'
./arch/arm64/include/asm/thread_info.h:123:2: note: expanded from macro 'INIT_THREAD_INFO'
        INIT_SCS                                                        \
        ^
./arch/arm64/include/asm/thread_info.h:114:13: note: expanded from macro 'INIT_SCS'
        .scs_sp         = init_shadow_call_stack,
                          ^
2 errors generated.

It looks like on mainline, init_shadow_call_stack is in defined and used
in init/init_task.c but now, it is used in init/main.c, with no
declaration to allow the compiler to find the definition. I guess moving
init_shadow_call_stack out of init/init_task.c to somewhere more common
would fix this but it depends on SCS_SIZE, which is defined in
include/linux/scs.h, and as soon as I tried to include that in another
file, the build broke further... Any ideas you have would be appreciated
:) for benchmarking purposes, I just disabled CONFIG_SHADOW_CALL_STACK.


3. Nested function in arch/x86/kernel/asm-offsets.c

$ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 defconfig all
In file included from arch/x86/kernel/asm-offsets.c:40:
arch/x86/kernel/../../../kernel/sched/per_task_area_struct_defs.h:10:1: error: function definition is not allowed here
{
^
1 error generated.

Clang does not and will not support nested functions; any instances of
those in the kernel were eliminated when formalizing clang support.

I am not really sure if this was intentional or not? Looking at the
other asm-offsets.c files, I see the include outside of any function.
Moving it out of the common() function does not appear to break the
build for defconfig, allmodconfig, or my distribution config and it
boots in QEMU and my AMD based test desktop.

diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index ff3f8ed5d0a2..a6d56f4697cd 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -35,10 +35,10 @@
 # include "asm-offsets_64.c"
 #endif

-static void __used common(void)
-{
 #include "../../../kernel/sched/per_task_area_struct_defs.h"

+static void __used common(void)
+{
        BLANK();
        DEFINE(TASK_threadsp, offsetof(struct task_struct, per_task_area) +
                              offsetof(struct task_struct_per_task, thread) +


4. Build error in kernel/gcov/clang.c

$ make -skj"$(nproc)" ARCH=x86_64 LLVM=1 distclean allmodconfig kernel/gcov/clang.o
kernel/gcov/clang.c:232:3: error: implicitly declaring library function 'memset' with type 'void *(void *, int, unsigned long)' [-Werror,-Wimplicit-function-declaration]
                memset(fn->counters, 0,
                ^
kernel/gcov/clang.c:232:3: note: include the header <string.h> or explicitly provide a declaration for 'memset'
kernel/gcov/clang.c:291:32: error: implicit declaration of function 'kmemdup' [-Werror,-Wimplicit-function-declaration]
        struct gcov_fn_info *fn_dup = kmemdup(fn, sizeof(*fn),
                                      ^
kernel/gcov/clang.c:291:23: error: incompatible integer to pointer conversion initializing 'struct gcov_fn_info *' with an expression of type 'int' [-Werror,-Wint-conversion]
        struct gcov_fn_info *fn_dup = kmemdup(fn, sizeof(*fn),
                             ^        ~~~~~~~~~~~~~~~~~~~~~~~~
kernel/gcov/clang.c:304:2: error: implicitly declaring library function 'memcpy' with type 'void *(void *, const void *, unsigned long)' [-Werror,-Wimplicit-function-declaration]
        memcpy(fn_dup->counters, fn->counters, cv_size);
        ^
kernel/gcov/clang.c:304:2: note: include the header <string.h> or explicitly provide a declaration for 'memcpy'
kernel/gcov/clang.c:320:8: error: implicit declaration of function 'kmemdup' [-Werror,-Wimplicit-function-declaration]
        dup = kmemdup(info, sizeof(*dup), GFP_KERNEL);
              ^
kernel/gcov/clang.c:320:6: error: incompatible integer to pointer conversion assigning to 'struct gcov_info *' from 'int' [-Werror,-Wint-conversion]
        dup = kmemdup(info, sizeof(*dup), GFP_KERNEL);
            ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/gcov/clang.c:325:18: error: implicit declaration of function 'kstrdup' [-Werror,-Wimplicit-function-declaration]
        dup->filename = kstrdup(info->filename, GFP_KERNEL);
                        ^
kernel/gcov/clang.c:325:16: error: incompatible integer to pointer conversion assigning to 'const char *' from 'int' [-Werror,-Wint-conversion]
        dup->filename = kstrdup(info->filename, GFP_KERNEL);
                      ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
8 errors generated.

I resolved this with:

diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
index 6ee385f6ad47..29f0899ba209 100644
--- a/kernel/gcov/clang.c
+++ b/kernel/gcov/clang.c
@@ -52,6 +52,7 @@
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/string.h>
 #include "gcov.h"

 typedef void (*llvm_gcov_callback)(void);


5. BPF errors

With Arch Linux's config (https://github.com/archlinux/svntogit-packages/raw/packages/linux/trunk/config),
I see the following errors:

kernel/bpf/preload/iterators/iterators.c:3:10: fatal error: 'linux/sched/signal.h' file not found
#include <linux/sched/signal.h>
         ^~~~~~~~~~~~~~~~~~~~~~
1 error generated.

kernel/bpf/sysfs_btf.c:21:2: error: implicitly declaring library function 'memcpy' with type 'void *(void *, const void *, unsigned long)' [-Werror,-Wimplicit-function-declaration]
        memcpy(buf, __start_BTF + off, len);
        ^
kernel/bpf/sysfs_btf.c:21:2: note: include the header <string.h> or explicitly provide a declaration for 'memcpy'
1 error generated.

The second error is obviously fixed by just including string.h as above.

I am not sure what is wrong with the first one; the includes all appear
to be userland headers, rather than kernel ones, so maybe an -I flag is
not present that should be? To work around it, I disabled
CONFIG_BPF_PRELOAD.


6. resolve_btfids warning

After working around the above errors, with either GCC or clang, I see
the following warnings with Arch Linux's configuration:

WARN: multiple IDs found for 'task_struct': 103, 23549 - using 103
WARN: multiple IDs found for 'path': 1166, 23551 - using 1166
WARN: multiple IDs found for 'inode': 997, 23561 - using 997
WARN: multiple IDs found for 'file': 714, 23566 - using 714
WARN: multiple IDs found for 'seq_file': 1120, 23673 - using 1120

Which appears to come from symbols_resolve() in
tools/bpf/resolve_btfids/main.c.

########################################################################

I am very excited to see where this goes, it is a herculean effort but I
think it will be worth it in the long run. Let me know if there is any
more information or input that I can provide, cheers!

Nathan
