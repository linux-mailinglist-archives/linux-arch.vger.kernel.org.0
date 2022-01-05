Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CB6485AE0
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 22:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiAEVm2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Jan 2022 16:42:28 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53026 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiAEVm1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jan 2022 16:42:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F646B81DF8;
        Wed,  5 Jan 2022 21:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82875C36AE9;
        Wed,  5 Jan 2022 21:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641418945;
        bh=7ydjhtwWAR9xWDsD6TpMgHJRhn4lOcG7aWgGBOssULk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AeqCXCqU6kWwX42g4s4wT6NBX8Obu5A7fx1bTK3k5+Ar/sotYyS+vc2QQoMoD5eLI
         zAwmQr1Vq5u0AIbVuFcDr45FVYyPWhV3lgCX5Onf2gZTHRRZZp14abl0/K9kg+LrAs
         sY8NLCc96D51zMiQkleuTnQwGlis9HKLTwYV91dopOC1gd0uxWinDz9upbDYR5BDcG
         JQI7yjooIvmpV6GxoGA/XLGhROlhhB/GHNzUJ7xw5hfn2ahhDHugpKyFLPU4pY2w8W
         lDz4xYcM6oGcD2ya7ZRUrOVTd/isRdQwwpXQTiKZS+nPMArt876UqFO0igg83J5MWJ
         wS0OYU5NN6vAw==
Date:   Wed, 5 Jan 2022 14:42:19 -0700
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
Message-ID: <YdYQu9YxNw0CxJRn@archlinux-ax161>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdSI9LmZE+FZAi1K@archlinux-ax161>
 <YdTpAJxgI+s9Wwgi@gmail.com>
 <YdTvXkKFzA0pOjFf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdTvXkKFzA0pOjFf@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 05, 2022 at 02:07:42AM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > 
> > * Nathan Chancellor <nathan@kernel.org> wrote:
> > 
> > > > I.e. I think the bug was simply to make main.c aware of the array, now 
> > > > that the INIT_THREAD initialization is done there.
> > > 
> > > Yes, that seems right.
> > > 
> > > Unfortunately, while the kernel now builds, it does not boot in QEMU. I 
> > > tried to checkout at 9006a48618cc0cacd3f59ff053e6509a9af5cc18 to see if I 
> > > could reproduce that breakage there but the build errors out at that 
> > > change (I do see notes of bisection breakage in some of the commits) so I 
> > > assume that is expected.
> > 
> > Yeah, there's a breakage window on ARM64, I'll track down that 
> > bisectability bug.
> 
> I haven't fixed this ARM64 bisection breakage yet, but I've integrated & 
> backmerged all the other fixes and changes, and pushed it out to the WIP 
> branch:
> 
>     # 1755441e323b per_task: Implement single template to define 'struct task_struct_per_task' fields and offsets
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
> 
> Let me know if there's anything missing or if there's a new breakage.

I ended up running this through my full set of clang builds and a few
GCC builds and found a few issues, which most of which appear to be
compiler agnostic.

This whole report is against commit 1755441e323b ("per_task: Implement
single template to define 'struct task_struct_per_task' fields and
offsets").

In case it is relevant...

$ gcc --version | head -1
gcc (GCC) 11.2.1 20211231



1. kernel/stackleak.c build failure:

$ make -skj"$(nproc)" ARCH=x86_64 allmodconfig kernel/stackleak.o
kernel/stackleak.c: In function ‘stackleak_erase’:
kernel/stackleak.c:92:13: error: implicit declaration of function ‘on_thread_stack’; did you mean ‘setup_thread_stack’? [-Werror=implicit-function-declaration]
   92 |         if (on_thread_stack())
      |             ^~~~~~~~~~~~~~~
      |             setup_thread_stack
kernel/stackleak.c:95:28: error: implicit declaration of function ‘current_top_of_stack’ [-Werror=implicit-function-declaration]
   95 |                 boundary = current_top_of_stack();
      |                            ^~~~~~~~~~~~~~~~~~~~
kernel/stackleak.c: In function ‘stackleak_track_stack’:
kernel/stackleak.c:119:14: error: implicit declaration of function ‘ALIGN’ [-Werror=implicit-function-declaration]
  119 |         sp = ALIGN(sp, sizeof(unsigned long));
      |              ^~~~~
cc1: all warnings being treated as errors

This is fixed with the following diff although I am unsure if that is as
minimal as it should be.

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index ce161a8e8d97..d67c5475183b 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -10,8 +10,10 @@
  * reveal and blocks some uninitialized stack variable attacks.
  */
 
+#include <asm/processor_api.h>
 #include <linux/stackleak.h>
 #include <linux/kprobes.h>
+#include <linux/align.h>
 
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 #include <linux/jump_label.h>



2. Build failures with CONFIG_UAPI_HEADER_TEST=y and O=...

This was originally reproduced with allmodconfig but this is a simpler
reproducer I think.

$ make -skj"$(nproc)" ARCH=x86_64 O=.build/x86_64 defconfig

$ scripts/config --file .build/x86_64/.config -e HEADERS_INSTALL -e UAPI_HEADER_TEST

$ make -skj"$(nproc)" ARCH=x86_64 O=.build/x86_64 olddefconfig usr/
In file included from <command-line>:
./usr/include/linux/rds.h:38:10: fatal error: uapi/linux/sockios.h: No such file or directory
   38 | #include <uapi/linux/sockios.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [/home/nathan/cbl/src/linux-fast-headers/usr/include/Makefile:106: usr/include/linux/rds.hdrtest] Error 1
In file included from ./usr/include/linux/qrtr.h:5,
                 from <command-line>:
./usr/include/linux/socket.h:5:10: fatal error: uapi/linux/socket_types.h: No such file or directory
    5 | #include <uapi/linux/socket_types.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
In file included from ./usr/include/linux/in.h:24,
                 from ./usr/include/linux/nfs_mount.h:12,
                 from <command-line>:
./usr/include/linux/socket.h:5:10: fatal error: uapi/linux/socket_types.h: No such file or directory
    5 | #include <uapi/linux/socket_types.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [/home/nathan/cbl/src/linux-fast-headers/usr/include/Makefile:106: usr/include/linux/qrtr.hdrtest] Error 1
make[4]: *** [/home/nathan/cbl/src/linux-fast-headers/usr/include/Makefile:106: usr/include/linux/nfs_mount.hdrtest] Error 1
...

I don't see this when just building in the tree. I am guessing that
commit f989e243f1f4 ("headers/deps: uapi/headers: Create
usr/include/uapi symbolic link") needs to account for this?



3. Build failure with CONFIG_SAMPLE_CONNECTOR=m and O=...

I am guessing this has a similar root cause as above, since that commit
mentions an error similar to this.

$ make -skj"$(nproc)" ARCH=x86_64 O=.build/x86_64 allmodconfig samples/connector/
In file included from /home/nathan/cbl/src/linux-fast-headers/samples/connector/ucon.c:14:
usr/include/linux/netlink.h:5:10: fatal error: uapi/linux/types.h: No such file or directory
    5 | #include <uapi/linux/types.h>
      |          ^~~~~~~~~~~~~~~~~~~~
compilation terminated.



4. modpost warning around __sw_hweight64

With the first issue resolved:

$ make -skj"$(nproc)" ARCH=i386 allmodconfig
WARNING: modpost: EXPORT symbol "__sw_hweight64" [vmlinux] version ...
Is "__sw_hweight64" prototyped in <asm/asm-prototypes.h>?



5. Build error in arch/arm64/kvm/hyp/nvhe with LTO

With arm64 + CONFIG_LTO_CLANG_THIN=y, I see:

$ make -skj"$(nproc)" ARCH=arm64 LLVM=1 defconfig

$ scripts/config -e LTO_CLANG_THIN

$ make -skj"$(nproc)" ARCH=arm64 LLVM=1 olddefconfig arch/arm64/kvm/hyp/nvhe/
ld.lld: error: arch/arm64/kvm/hyp/nvhe/hyp.lds:2: unknown directive: .macro
>>> .macro __put, val, name
>>> ^
make[5]: *** [arch/arm64/kvm/hyp/nvhe/Makefile:51: arch/arm64/kvm/hyp/nvhe/kvm_nvhe.tmp.o] Error 1

I was not able to figure out the exact include chain but CONFIG_LTO
causes asm/alternative-macros.h to be included in asm/rwonce.h, which
eventually gets included in either asm/cache.h or asm/memory.h.

I managed to solve this with the following diff but I am not sure if
there is a better or cleaner way to do that.

diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
index 1bce62fa908a..e19572a205d0 100644
--- a/arch/arm64/include/asm/rwonce.h
+++ b/arch/arm64/include/asm/rwonce.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_RWONCE_H
 #define __ASM_RWONCE_H
 
-#ifdef CONFIG_LTO
+#if defined(CONFIG_LTO) && !defined(LINKER_SCRIPT)
 
 #include <linux/compiler_types.h>
 #include <asm/alternative-macros.h>
@@ -66,7 +66,7 @@
 })
 
 #endif	/* !BUILD_VDSO */
-#endif	/* CONFIG_LTO */
+#endif	/* CONFIG_LTO && !LINKER_SCRIPT */
 
 #include <asm-generic/rwonce.h>
 

I'll see if I can flush out any other issues.

Cheers,
Nathan
