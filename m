Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635314759FE
	for <lists+linux-arch@lfdr.de>; Wed, 15 Dec 2021 14:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhLONyA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Dec 2021 08:54:00 -0500
Received: from foss.arm.com ([217.140.110.172]:52626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230013AbhLONx7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Dec 2021 08:53:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB19E13D5;
        Wed, 15 Dec 2021 05:53:58 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F3183F774;
        Wed, 15 Dec 2021 05:53:54 -0800 (PST)
Date:   Wed, 15 Dec 2021 13:53:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/43] kmsan: disable KMSAN instrumentation for certain
 kernel parts
Message-ID: <Ybnzb2CWWFX+R3LT@FVFF77S0Q05N>
References: <20211214162050.660953-1-glider@google.com>
 <20211214162050.660953-25-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214162050.660953-25-glider@google.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 14, 2021 at 05:20:31PM +0100, Alexander Potapenko wrote:
> Instrumenting some files with KMSAN will result in kernel being unable
> to link, boot or crashing at runtime for various reasons (e.g. infinite
> recursion caused by instrumentation hooks calling instrumented code again).
> 
> Completely omit KMSAN instrumentation in the following places:
>  - arch/x86/boot and arch/x86/realmode/rm, as KMSAN doesn't work for i386;
>  - arch/x86/entry/vdso, which isn't linked with KMSAN runtime;
>  - three files in arch/x86/kernel - boot problems;
>  - arch/x86/mm/cpu_entry_area.c - recursion;
>  - EFI stub - build failures;
>  - kcov, stackdepot, lockdep - recursion.

It probably makes sense to split the arch/x86/ bits from everything else, and
to group the arch/x86 enablement patches together closer to the end of the
series.

The non-x86 changes all look fine to me.

Mark.

> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
> Link: https://linux-review.googlesource.com/id/Id5e5c4a9f9d53c24a35ebb633b814c414628d81b
> ---
>  arch/x86/boot/Makefile                | 1 +
>  arch/x86/boot/compressed/Makefile     | 1 +
>  arch/x86/entry/vdso/Makefile          | 3 +++
>  arch/x86/kernel/Makefile              | 2 ++
>  arch/x86/kernel/cpu/Makefile          | 1 +
>  arch/x86/mm/Makefile                  | 2 ++
>  arch/x86/realmode/rm/Makefile         | 1 +
>  drivers/firmware/efi/libstub/Makefile | 1 +
>  kernel/Makefile                       | 1 +
>  kernel/locking/Makefile               | 3 ++-
>  lib/Makefile                          | 1 +
>  11 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index b5aecb524a8aa..d5623232b763f 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -12,6 +12,7 @@
>  # Sanitizer runtimes are unavailable and cannot be linked for early boot code.
>  KASAN_SANITIZE			:= n
>  KCSAN_SANITIZE			:= n
> +KMSAN_SANITIZE			:= n
>  OBJECT_FILES_NON_STANDARD	:= y
>  
>  # Kernel does not boot with kcov instrumentation here.
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 431bf7f846c3c..c4a284b738e71 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -20,6 +20,7 @@
>  # Sanitizer runtimes are unavailable and cannot be linked for early boot code.
>  KASAN_SANITIZE			:= n
>  KCSAN_SANITIZE			:= n
> +KMSAN_SANITIZE			:= n
>  OBJECT_FILES_NON_STANDARD	:= y
>  
>  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index a2dddcc189f69..f2a175d872b07 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -11,6 +11,9 @@ include $(srctree)/lib/vdso/Makefile
>  
>  # Sanitizer runtimes are unavailable and cannot be linked here.
>  KASAN_SANITIZE			:= n
> +KMSAN_SANITIZE_vclock_gettime.o := n
> +KMSAN_SANITIZE_vgetcpu.o	:= n
> +
>  UBSAN_SANITIZE			:= n
>  KCSAN_SANITIZE			:= n
>  OBJECT_FILES_NON_STANDARD	:= y
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 2ff3e600f4269..0b9fc3ecce2de 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -35,6 +35,8 @@ KASAN_SANITIZE_cc_platform.o				:= n
>  # With some compiler versions the generated code results in boot hangs, caused
>  # by several compilation units. To be safe, disable all instrumentation.
>  KCSAN_SANITIZE := n
> +KMSAN_SANITIZE_head$(BITS).o				:= n
> +KMSAN_SANITIZE_nmi.o					:= n
>  
>  OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
>  
> diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
> index 9661e3e802be5..f10a921ee7565 100644
> --- a/arch/x86/kernel/cpu/Makefile
> +++ b/arch/x86/kernel/cpu/Makefile
> @@ -12,6 +12,7 @@ endif
>  # If these files are instrumented, boot hangs during the first second.
>  KCOV_INSTRUMENT_common.o := n
>  KCOV_INSTRUMENT_perf_event.o := n
> +KMSAN_SANITIZE_common.o := n
>  
>  # As above, instrumenting secondary CPU boot code causes boot hangs.
>  KCSAN_SANITIZE_common.o := n
> diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
> index 5864219221ca8..747d4630d52ce 100644
> --- a/arch/x86/mm/Makefile
> +++ b/arch/x86/mm/Makefile
> @@ -10,6 +10,8 @@ KASAN_SANITIZE_mem_encrypt_identity.o	:= n
>  # Disable KCSAN entirely, because otherwise we get warnings that some functions
>  # reference __initdata sections.
>  KCSAN_SANITIZE := n
> +# Avoid recursion by not calling KMSAN hooks for CEA code.
> +KMSAN_SANITIZE_cpu_entry_area.o := n
>  
>  ifdef CONFIG_FUNCTION_TRACER
>  CFLAGS_REMOVE_mem_encrypt.o		= -pg
> diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
> index 83f1b6a56449f..f614009d3e4e2 100644
> --- a/arch/x86/realmode/rm/Makefile
> +++ b/arch/x86/realmode/rm/Makefile
> @@ -10,6 +10,7 @@
>  # Sanitizer runtimes are unavailable and cannot be linked here.
>  KASAN_SANITIZE			:= n
>  KCSAN_SANITIZE			:= n
> +KMSAN_SANITIZE			:= n
>  OBJECT_FILES_NON_STANDARD	:= y
>  
>  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index d0537573501e9..81432d0c904b1 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -46,6 +46,7 @@ GCOV_PROFILE			:= n
>  # Sanitizer runtimes are unavailable and cannot be linked here.
>  KASAN_SANITIZE			:= n
>  KCSAN_SANITIZE			:= n
> +KMSAN_SANITIZE			:= n
>  UBSAN_SANITIZE			:= n
>  OBJECT_FILES_NON_STANDARD	:= y
>  
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 186c49582f45b..e5dd600e63d8a 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -39,6 +39,7 @@ KCOV_INSTRUMENT_kcov.o := n
>  KASAN_SANITIZE_kcov.o := n
>  KCSAN_SANITIZE_kcov.o := n
>  UBSAN_SANITIZE_kcov.o := n
> +KMSAN_SANITIZE_kcov.o := n
>  CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) -fno-stack-protector
>  
>  # Don't instrument error handlers
> diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
> index d51cabf28f382..ea925731fa40f 100644
> --- a/kernel/locking/Makefile
> +++ b/kernel/locking/Makefile
> @@ -5,8 +5,9 @@ KCOV_INSTRUMENT		:= n
>  
>  obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
>  
> -# Avoid recursion lockdep -> KCSAN -> ... -> lockdep.
> +# Avoid recursion lockdep -> sanitizer -> ... -> lockdep.
>  KCSAN_SANITIZE_lockdep.o := n
> +KMSAN_SANITIZE_lockdep.o := n
>  
>  ifdef CONFIG_FUNCTION_TRACER
>  CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
> diff --git a/lib/Makefile b/lib/Makefile
> index 364c23f155781..8e5ae9d5966de 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -268,6 +268,7 @@ obj-$(CONFIG_IRQ_POLL) += irq_poll.o
>  CFLAGS_stackdepot.o += -fno-builtin
>  obj-$(CONFIG_STACKDEPOT) += stackdepot.o
>  KASAN_SANITIZE_stackdepot.o := n
> +KMSAN_SANITIZE_stackdepot.o := n
>  KCOV_INSTRUMENT_stackdepot.o := n
>  
>  libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o \
> -- 
> 2.34.1.173.g76aa8bc2d0-goog
> 
