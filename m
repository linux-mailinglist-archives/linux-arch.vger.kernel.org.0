Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F7047478C
	for <lists+linux-arch@lfdr.de>; Tue, 14 Dec 2021 17:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhLNQV6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Dec 2021 11:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbhLNQV4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Dec 2021 11:21:56 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294CBC061574
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:21:55 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso13394783wms.4
        for <linux-arch@vger.kernel.org>; Tue, 14 Dec 2021 08:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bn0iluGQKzCqja/ee2bGyIYJAYCvHbjpJXxGFhRcops=;
        b=Y2n8SR8JmlMveLo+koPjfKPSJSGX61o4FKxROGolBPysk5IwDsAh+aNlzhT2ZVOksX
         XmfoPvvZhW+hF85/Mv8lzV0cPXk1f4jjFHOpX4DshxpeRmMUdkcBUY1OVojdPY5pdEuk
         Ul1++SKPtqJUb3fAC2Aczc9vWkYioRAW22aTO39LgE2slzNFGV/uzfelgo1PqmlRBlh3
         OR/zy0P2XseTkjhLvooC14X1LxvZInWS9cWrhbu5dMZIAMBhJiGSUloJ81NxdLIwljGO
         aqX3akr5Or3myfYR47LmM9tc9zlChu4AZ08YXI2v/kVPqAncQ2dkElDljtNMkRlUoJsR
         Tf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bn0iluGQKzCqja/ee2bGyIYJAYCvHbjpJXxGFhRcops=;
        b=WEAU37yJud4/yH4r8DWKQgTvgf/nsNX/UWwo6hAkimZgDJfB2IOHAMmSNFBmnh+TFU
         S0YWYKsZhgCPTCzzIK03XKChYbJOwK9mA+D63PK6/i0Uf6+YzoVfIhh9EmoQWXKkMNPb
         pKCqkXuwCXqIzg3ryWVQuFB1ajBkBSQua4x9YYugCATwD0zMCPoI9fGwPbf/JuR9yMtO
         uG6sGrRFHpx5xfs8QCa3C4XorTPgMVu/w5a52yUordKOG1gX9qQix6gRVbnol/fXZdwl
         6w9XfxiA0qJ6/YeoIO6uWg5DBJYgE4aKJkUf9sMqjfQDv8VTOEBu+KAR7VPaxQSi2LzR
         T8Dg==
X-Gm-Message-State: AOAM533/T3RJV1R8WBtRTz6dS3zGAzCKFIOTnpGziqBJiU5uCXqO8/9+
        KZEqxu4mcdPZTqQVOLdESztTvQbPzfg=
X-Google-Smtp-Source: ABdhPJzypdYTAcIE3JgTMJpzSN0Jl0LL/Fp598P/UZlSmQNIgXoesJ949oOdli/fhaL7Il2JsU/I8NTsxJ8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a05:600c:1d1b:: with SMTP id
 l27mr5818231wms.1.1639498912693; Tue, 14 Dec 2021 08:21:52 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:07 +0100
Message-Id: <20211214162050.660953-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 00/43] Add KernelMemorySanitizer infrastructure
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

KernelMemorySanitizer (KMSAN) is a detector of errors related to uses of
uninitialized memory. It relies on compile-time Clang instrumentation
(similar to MSan in the userspace [1]) and tracks the state of every bit
of kernel memory, being able to report an error if uninitialized value is
used in a condition, dereferenced, or escapes to userspace, USB or DMA.

KMSAN has reported more than 300 bugs in the past few years (recently
fixed bugs: [2]), most of them with the help of syzkaller. Such bugs
keep getting introduced into the kernel despite new compiler warnings and
other analyses (the 5.16 cycle already resulted in several KMSAN-reported
bugs, e.g. [3]). Mitigations like total stack and heap initialization are
unfortunately very far from being deployable.

The proposed patchset contains KMSAN runtime implementation together with
small changes to other subsystems needed to make KMSAN work.

The latter changes fall into several categories:

1. Changes and refactorings of existing code required to add KMSAN:
- [1/43] arch/x86: add missing include to sparsemem.h
- [2/43] stackdepot: reserve 5 extra bits in depot_stack_handle_t
- [3/43] kasan: common: adapt to the new prototype of __stack_depot_save()
- [4/43] instrumented.h: allow instrumenting both sides of copy_from_user()
- [5/43] asm: x86: instrument usercopy in get_user() and __put_user_size()
- [6/43] asm-generic: instrument usercopy in cacheflush.h
- [7/43] compiler_attributes.h: add __disable_sanitizer_instrumentation
- [11/43] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
- [12/43] kcsan: clang: retire CONFIG_KCSAN_KCOV_BROKEN

2. KMSAN-related declarations in generic code, KMSAN runtime library,
   docs and configs:
- [8/43] kmsan: add ReST documentation
- [9/43] kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
- [10/43] kmsan: pgtable: reduce vmalloc space
- [13/43] kmsan: add KMSAN runtime core
- [14/43] MAINTAINERS: add entry for KMSAN
- [30/43] kmsan: add tests for KMSAN
- [35/43] x86: kmsan: use __msan_ string functions where possible.
- [42/43] objtool: kmsan: list KMSAN API functions as uaccess-safe
- [43/43] x86: kmsan: enable KMSAN builds for x86

3. Adding hooks from different subsystems to notify KMSAN about memory
   state changes:
- [15/43] kmsan: mm: maintain KMSAN metadata for page operations
- [16/43] kmsan: mm: call KMSAN hooks from SLUB code
- [17/43] kmsan: handle task creation and exiting
- [19/43] kmsan: init: call KMSAN initialization routines
- [20/43] instrumented.h: add KMSAN support
- [26/43] kmsan: virtio: check/unpoison scatterlist in vring_map_one_sg()
- [27/43] x86: kmsan: add iomem support
- [28/43] kmsan: dma: unpoison DMA mappings
- [29/43] kmsan: handle memory sent to/from USB
- [36/43] x86: kmsan: sync metadata pages on page fault

4. Changes that prevent false reports by explicitly initializing memory,
   disabling optimized code that may trick KMSAN, selectively skipping
   instrumentation:
- [18/43] kmsan: unpoison @tlb in arch_tlb_gather_mmu()
- [22/43] kmsan: initialize the output of READ_ONCE_NOCHECK()
- [23/43] kmsan: make READ_ONCE_TASK_STACK() return initialized values
- [24/43] kmsan: disable KMSAN instrumentation for certain kernel parts
- [25/43] kmsan: skip shadow checks in files doing context switches
- [31/43] kmsan: disable strscpy() optimization under KMSAN
- [32/43] crypto: kmsan: disable accelerated configs under KMSAN
- [33/43] kmsan: disable physical page merging in biovec
- [34/43] kmsan: block: skip bio block merging logic for KMSAN
- [37/43] x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on x86, enable it for KASAN/KMSAN
- [38/43] x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
- [40/43] kmsan: kcov: unpoison area->list in kcov_remote_area_put()
- [41/43] security: kmsan: fix interoperability with auto-initialization

5. Noinstr handling:
- [21/43] kmsan: mark noinstr as __no_sanitize_memory
- [39/43] x86: kmsan: handle register passing from uninstrumented code

This patchset allows one to boot and run a defconfig+KMSAN kernel on a
QEMU without known false positives. It however doesn't guarantee there
are no false positives in drivers of certain devices or less tested
subsystems, although KMSAN is actively tested on syzbot with a large
config.

The patchset was generated relative to Linux v5.16-rc5. The most
up-to-date KMSAN tree currently resides at
https://github.com/google/kmsan/.
One may find it handy to review these patches in Gerrit:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/1081

A huge thanks goes to the reviewers of the RFC patch series sent to LKML
last year
(https://lore.kernel.org/all/20200325161249.55095-1-glider@google.com/).

[1] https://clang.llvm.org/docs/MemorySanitizer.html
[2] https://syzkaller.appspot.com/upstream/fixed?manager=ci-upstream-kmsan-gce
[3] https://lore.kernel.org/all/20211126124746.761278-1-glider@google.com/


Alexander Potapenko (42):
  stackdepot: reserve 5 extra bits in depot_stack_handle_t
  kasan: common: adapt to the new prototype of __stack_depot_save()
  instrumented.h: allow instrumenting both sides of copy_from_user()
  asm: x86: instrument usercopy in get_user() and __put_user_size()
  asm-generic: instrument usercopy in cacheflush.h
  compiler_attributes.h: add __disable_sanitizer_instrumentation
  kmsan: add ReST documentation
  kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
  kmsan: pgtable: reduce vmalloc space
  libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
  kcsan: clang: retire CONFIG_KCSAN_KCOV_BROKEN
  kmsan: add KMSAN runtime core
  MAINTAINERS: add entry for KMSAN
  kmsan: mm: maintain KMSAN metadata for page operations
  kmsan: mm: call KMSAN hooks from SLUB code
  kmsan: handle task creation and exiting
  kmsan: unpoison @tlb in arch_tlb_gather_mmu()
  kmsan: init: call KMSAN initialization routines
  instrumented.h: add KMSAN support
  kmsan: mark noinstr as __no_sanitize_memory
  kmsan: initialize the output of READ_ONCE_NOCHECK()
  kmsan: make READ_ONCE_TASK_STACK() return initialized values
  kmsan: disable KMSAN instrumentation for certain kernel parts
  kmsan: skip shadow checks in files doing context switches
  kmsan: virtio: check/unpoison scatterlist in vring_map_one_sg()
  x86: kmsan: add iomem support
  kmsan: dma: unpoison DMA mappings
  kmsan: handle memory sent to/from USB
  kmsan: add tests for KMSAN
  kmsan: disable strscpy() optimization under KMSAN
  crypto: kmsan: disable accelerated configs under KMSAN
  kmsan: disable physical page merging in biovec
  kmsan: block: skip bio block merging logic for KMSAN
  x86: kmsan: use __msan_ string functions where possible.
  x86: kmsan: sync metadata pages on page fault
  x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on x86, enable it for
    KASAN/KMSAN
  x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
  x86: kmsan: handle register passing from uninstrumented code
  kmsan: kcov: unpoison area->list in kcov_remote_area_put()
  security: kmsan: fix interoperability with auto-initialization
  objtool: kmsan: list KMSAN API functions as uaccess-safe
  x86: kmsan: enable KMSAN builds for x86

Dmitry Vyukov (1):
  arch/x86: add missing include to sparsemem.h

 Documentation/dev-tools/index.rst       |   1 +
 Documentation/dev-tools/kmsan.rst       | 411 ++++++++++++++++++++++
 MAINTAINERS                             |  12 +
 Makefile                                |   1 +
 arch/x86/Kconfig                        |   9 +-
 arch/x86/boot/Makefile                  |   1 +
 arch/x86/boot/compressed/Makefile       |   1 +
 arch/x86/entry/common.c                 |   2 +
 arch/x86/entry/vdso/Makefile            |   3 +
 arch/x86/include/asm/checksum.h         |  16 +-
 arch/x86/include/asm/idtentry.h         |   5 +
 arch/x86/include/asm/page_64.h          |  13 +
 arch/x86/include/asm/pgtable_64_types.h |  41 ++-
 arch/x86/include/asm/sparsemem.h        |   2 +
 arch/x86/include/asm/string_64.h        |  23 +-
 arch/x86/include/asm/uaccess.h          |   7 +
 arch/x86/include/asm/unwind.h           |  23 +-
 arch/x86/kernel/Makefile                |   6 +
 arch/x86/kernel/cpu/Makefile            |   1 +
 arch/x86/kernel/cpu/mce/core.c          |   1 +
 arch/x86/kernel/kvm.c                   |   1 +
 arch/x86/kernel/nmi.c                   |   1 +
 arch/x86/kernel/sev.c                   |   2 +
 arch/x86/kernel/traps.c                 |   7 +
 arch/x86/lib/Makefile                   |   2 +
 arch/x86/lib/iomem.c                    |   5 +
 arch/x86/mm/Makefile                    |   2 +
 arch/x86/mm/fault.c                     |  23 +-
 arch/x86/mm/init_64.c                   |   2 +-
 arch/x86/mm/ioremap.c                   |   3 +
 arch/x86/realmode/rm/Makefile           |   1 +
 block/bio.c                             |   2 +
 block/blk.h                             |   7 +
 crypto/Kconfig                          |  30 ++
 drivers/firmware/efi/libstub/Makefile   |   1 +
 drivers/net/Kconfig                     |   1 +
 drivers/nvdimm/nd.h                     |   2 +-
 drivers/nvdimm/pfn_devs.c               |   2 +-
 drivers/usb/core/urb.c                  |   2 +
 drivers/virtio/virtio_ring.c            |  10 +-
 include/asm-generic/cacheflush.h        |   9 +-
 include/asm-generic/rwonce.h            |   5 +-
 include/linux/compiler-clang.h          |  23 ++
 include/linux/compiler-gcc.h            |   6 +
 include/linux/compiler_attributes.h     |  18 +
 include/linux/compiler_types.h          |   3 +-
 include/linux/fortify-string.h          |   2 +
 include/linux/highmem.h                 |   3 +
 include/linux/instrumented.h            |  26 +-
 include/linux/kmsan-checks.h            | 123 +++++++
 include/linux/kmsan.h                   | 365 +++++++++++++++++++
 include/linux/mm_types.h                |  12 +
 include/linux/sched.h                   |   5 +
 include/linux/stackdepot.h              |   8 +
 include/linux/uaccess.h                 |  19 +-
 init/main.c                             |   3 +
 kernel/Makefile                         |   1 +
 kernel/dma/mapping.c                    |   9 +-
 kernel/entry/common.c                   |   3 +
 kernel/exit.c                           |   2 +
 kernel/fork.c                           |   2 +
 kernel/kcov.c                           |   7 +
 kernel/locking/Makefile                 |   3 +-
 kernel/sched/Makefile                   |   4 +
 lib/Kconfig.debug                       |   1 +
 lib/Kconfig.kcsan                       |  11 -
 lib/Kconfig.kmsan                       |  34 ++
 lib/Makefile                            |   1 +
 lib/iomap.c                             |  40 +++
 lib/iov_iter.c                          |   9 +-
 lib/stackdepot.c                        |  29 +-
 lib/string.c                            |   8 +
 lib/usercopy.c                          |   3 +-
 mm/Makefile                             |   1 +
 mm/kasan/common.c                       |   2 +-
 mm/kmsan/Makefile                       |  26 ++
 mm/kmsan/annotations.c                  |  28 ++
 mm/kmsan/core.c                         | 427 +++++++++++++++++++++++
 mm/kmsan/hooks.c                        | 400 +++++++++++++++++++++
 mm/kmsan/init.c                         | 238 +++++++++++++
 mm/kmsan/instrumentation.c              | 233 +++++++++++++
 mm/kmsan/kmsan.h                        | 197 +++++++++++
 mm/kmsan/kmsan_test.c                   | 444 ++++++++++++++++++++++++
 mm/kmsan/report.c                       | 210 +++++++++++
 mm/kmsan/shadow.c                       | 332 ++++++++++++++++++
 mm/memory.c                             |   2 +
 mm/mmu_gather.c                         |  10 +
 mm/page_alloc.c                         |  18 +
 mm/slab.h                               |   1 +
 mm/slub.c                               |  26 +-
 mm/vmalloc.c                            |  20 +-
 scripts/Makefile.kmsan                  |   1 +
 scripts/Makefile.lib                    |   9 +
 security/Kconfig.hardening              |   4 +
 tools/objtool/check.c                   |  19 +
 95 files changed, 4062 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/dev-tools/kmsan.rst
 create mode 100644 include/linux/kmsan-checks.h
 create mode 100644 include/linux/kmsan.h
 create mode 100644 lib/Kconfig.kmsan
 create mode 100644 mm/kmsan/Makefile
 create mode 100644 mm/kmsan/annotations.c
 create mode 100644 mm/kmsan/core.c
 create mode 100644 mm/kmsan/hooks.c
 create mode 100644 mm/kmsan/init.c
 create mode 100644 mm/kmsan/instrumentation.c
 create mode 100644 mm/kmsan/kmsan.h
 create mode 100644 mm/kmsan/kmsan_test.c
 create mode 100644 mm/kmsan/report.c
 create mode 100644 mm/kmsan/shadow.c
 create mode 100644 scripts/Makefile.kmsan

-- 
2.34.1.173.g76aa8bc2d0-goog

