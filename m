Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DDE5103D8
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiDZQrb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 12:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353095AbiDZQra (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 12:47:30 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EB716C152
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:21 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id dk9-20020a0564021d8900b00425a9c3d40cso8108439edb.7
        for <linux-arch@vger.kernel.org>; Tue, 26 Apr 2022 09:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1G8xzyhN/6cC/oSos2efdoQedsBkWbUJY6WrTftKsiQ=;
        b=H02YMRXjzxy5RjuHuT2YjDfAZIX+tEOSvPyjkJKaXu5+ulq0TbgcmXLetjFPWcy13D
         uiGMyv/a2fbcqRRKCOf96o+hQg31oHSKQ84VhPuHBU2YX+cUZPDefn41wYo4uuxZUfUe
         eypPtslL+veHDE2Q/+unvc//ms3IZf8ngdSTrLGQPC/Ww6cyqjGmHWRMhUIK9r3YrzHp
         DN3ROSkVsjatoSoHdePG9JGyAy6z9dsfpEOYq+xoLMQgSlj+C/SCSAEmCfelgKCY9ZeZ
         c8GIM8E5AWSvmzgmztZcSLLIZnHCAwsFVe3YWHqFg5H5moRwDe98SyqV2dntakeZ1ntu
         WNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1G8xzyhN/6cC/oSos2efdoQedsBkWbUJY6WrTftKsiQ=;
        b=cqUcFQtvj6SwEpGv4nVm0ia9EeuDJ6pq5JChq3j8iB8BoADMy7W8cd/RGuUyIXm1vI
         h0WV+XxkWLN1vh3FPWdOj81I0NHDy7QeJBuR8aa53PsdWHwiOqjExIIWWzs34fuaMQ3Q
         XMoYbS3oKBMjDO3uVlKP5Xs1+i6NLCDMbiuT1ryixaZd/ydv6pz5E3ZKAIXKaXGD2axD
         jLF+cSc+v2ajBXDlDaIYwy5sXfNSY/4tqXO2y/d9DjHVj/6bbTsdnZlr9ggoT/U7cZFC
         Eh5tPrqYLuSOj5/JBTLRgPvtmhuRzBrmk+b+IH+rjVALZeykjhzVmnRyYxxKdbypywuS
         3xdQ==
X-Gm-Message-State: AOAM530SH1fUgjINYVYniJDzuyVZkgQ/cEkCLoTIx4f46n+7tOoTlBE/
        5XXuSORntwVlCGE4Lsg+8w+VvkG6F0k=
X-Google-Smtp-Source: ABdhPJyG9Bwm26XnDyzw19Wz/Alkzd4tUQQg9l7XaVFBhPlMBLSMTQPUQnAIxNdVAd2sg+QqWCxTIcZwY6M=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:d580:abeb:bf6d:5726])
 (user=glider job=sendgmr) by 2002:aa7:cb93:0:b0:415:d57a:4603 with SMTP id
 r19-20020aa7cb93000000b00415d57a4603mr25274990edt.62.1650991460014; Tue, 26
 Apr 2022 09:44:20 -0700 (PDT)
Date:   Tue, 26 Apr 2022 18:42:29 +0200
Message-Id: <20220426164315.625149-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v3 00/46] Add KernelMemorySanitizer infrastructure
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 - [1/46] x86: add missing include to sparsemem.h
 - [2/46] stackdepot: reserve 5 extra bits in depot_stack_handle_t
 - [3/46] kasan: common: adapt to the new prototype of __stack_depot_save()
 - [4/46] instrumented.h: allow instrumenting both sides of copy_from_user()
 - [5/46] x86: asm: instrument usercopy in get_user() and __put_user_size()
 - [6/46] asm-generic: instrument usercopy in cacheflush.h
 - [11/46] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE

2. KMSAN-related declarations in generic code, KMSAN runtime library,
   docs and configs:
 - [7/46] kmsan: add ReST documentation
 - [8/46] kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
 - [10/46] x86: kmsan: pgtable: reduce vmalloc space
 - [12/46] kmsan: add KMSAN runtime core
 - [15/46] MAINTAINERS: add entry for KMSAN
 - [29/46] kmsan: add tests for KMSAN
 - [36/46] objtool: kmsan: list KMSAN API functions as uaccess-safe
 - [41/46] x86: kmsan: use __msan_ string functions where possible.
 - [46/46] x86: kmsan: enable KMSAN builds for x86

3. Adding hooks from different subsystems to notify KMSAN about memory
   state changes:
 - [16/46] kmsan: mm: maintain KMSAN metadata for page operations
 - [17/46] kmsan: mm: call KMSAN hooks from SLUB code
 - [18/46] kmsan: handle task creation and exiting
 - [19/46] kmsan: init: call KMSAN initialization routines
 - [20/46] instrumented.h: add KMSAN support
 - [22/46] kmsan: add iomap support
 - [23/46] Input: libps2: mark data received in __ps2_command() as initialized
 - [24/46] kmsan: dma: unpoison DMA mappings
 - [40/46] x86: kmsan: handle open-coded assembly in lib/iomem.c
 - [42/46] x86: kmsan: sync metadata pages on page fault

4. Changes that prevent false reports by explicitly initializing memory,
   disabling optimized code that may trick KMSAN, selectively skipping
   instrumentation:
 - [13/46] kmsan: implement kmsan_init(), initialize READ_ONCE_NOCHECK()
 - [14/46] kmsan: disable instrumentation of unsupported common kernel code
 - [21/46] kmsan: unpoison @tlb in arch_tlb_gather_mmu()
 - [25/46] kmsan: virtio: check/unpoison scatterlist in vring_map_one_sg()
 - [26/46] kmsan: handle memory sent to/from USB
 - [30/46] kmsan: disable strscpy() optimization under KMSAN
 - [31/46] crypto: kmsan: disable accelerated configs under KMSAN
 - [32/46] kmsan: disable physical page merging in biovec
 - [33/46] kmsan: block: skip bio block merging logic for KMSAN
 - [34/46] kmsan: kcov: unpoison area->list in kcov_remote_area_put()
 - [35/46] security: kmsan: fix interoperability with auto-initialization
 - [37/46] x86: kmsan: make READ_ONCE_TASK_STACK() return initialized values
 - [38/46] x86: kmsan: disable instrumentation of unsupported code
 - [39/46] x86: kmsan: skip shadow checks in __switch_to()
 - [43/46] x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on x86, enable it for KASAN/KMSAN
 - [44/46] x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS

5. Noinstr handling:
 - [9/46] kmsan: mark noinstr as __no_sanitize_memory
 - [27/46] kmsan: instrumentation.h: add instrumentation_begin_with_regs()
 - [28/46] kmsan: entry: handle register passing from uninstrumented code
 - [45/46] x86: kmsan: handle register passing from uninstrumented code

This patchset allows one to boot and run a defconfig+KMSAN kernel on a
QEMU without known false positives. It however doesn't guarantee there
are no false positives in drivers of certain devices or less tested
subsystems, although KMSAN is actively tested on syzbot with a large
config.

The patchset was generated relative to Linux v5.18-rc4. The most
up-to-date KMSAN tree currently resides at
https://github.com/google/kmsan/.
One may find it handy to review these patches in Gerrit:
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/12604/25

A huge thanks goes to the reviewers of the RFC patch series sent to LKML
in 2020
(https://lore.kernel.org/all/20200325161249.55095-1-glider@google.com/).

[1] https://clang.llvm.org/docs/MemorySanitizer.html
[2] https://syzkaller.appspot.com/upstream/fixed?manager=ci-upstream-kmsan-gce
[3] https://lore.kernel.org/all/20211126124746.761278-1-glider@google.com/


Alexander Potapenko (45):
  stackdepot: reserve 5 extra bits in depot_stack_handle_t
  kasan: common: adapt to the new prototype of __stack_depot_save()
  instrumented.h: allow instrumenting both sides of copy_from_user()
  x86: asm: instrument usercopy in get_user() and __put_user_size()
  asm-generic: instrument usercopy in cacheflush.h
  kmsan: add ReST documentation
  kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
  kmsan: mark noinstr as __no_sanitize_memory
  x86: kmsan: pgtable: reduce vmalloc space
  libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
  kmsan: add KMSAN runtime core
  kmsan: implement kmsan_init(), initialize READ_ONCE_NOCHECK()
  kmsan: disable instrumentation of unsupported common kernel code
  MAINTAINERS: add entry for KMSAN
  kmsan: mm: maintain KMSAN metadata for page operations
  kmsan: mm: call KMSAN hooks from SLUB code
  kmsan: handle task creation and exiting
  kmsan: init: call KMSAN initialization routines
  instrumented.h: add KMSAN support
  kmsan: unpoison @tlb in arch_tlb_gather_mmu()
  kmsan: add iomap support
  Input: libps2: mark data received in __ps2_command() as initialized
  kmsan: dma: unpoison DMA mappings
  kmsan: virtio: check/unpoison scatterlist in vring_map_one_sg()
  kmsan: handle memory sent to/from USB
  kmsan: instrumentation.h: add instrumentation_begin_with_regs()
  kmsan: entry: handle register passing from uninstrumented code
  kmsan: add tests for KMSAN
  kmsan: disable strscpy() optimization under KMSAN
  crypto: kmsan: disable accelerated configs under KMSAN
  kmsan: disable physical page merging in biovec
  kmsan: block: skip bio block merging logic for KMSAN
  kmsan: kcov: unpoison area->list in kcov_remote_area_put()
  security: kmsan: fix interoperability with auto-initialization
  objtool: kmsan: list KMSAN API functions as uaccess-safe
  x86: kmsan: make READ_ONCE_TASK_STACK() return initialized values
  x86: kmsan: disable instrumentation of unsupported code
  x86: kmsan: skip shadow checks in __switch_to()
  x86: kmsan: handle open-coded assembly in lib/iomem.c
  x86: kmsan: use __msan_ string functions where possible.
  x86: kmsan: sync metadata pages on page fault
  x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on x86, enable it for
    KASAN/KMSAN
  x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
  x86: kmsan: handle register passing from uninstrumented code
  x86: kmsan: enable KMSAN builds for x86

Dmitry Vyukov (1):
  x86: add missing include to sparsemem.h

 Documentation/dev-tools/index.rst       |   1 +
 Documentation/dev-tools/kmsan.rst       | 414 ++++++++++++++++++
 MAINTAINERS                             |  12 +
 Makefile                                |   1 +
 arch/x86/Kconfig                        |   9 +-
 arch/x86/boot/Makefile                  |   1 +
 arch/x86/boot/compressed/Makefile       |   1 +
 arch/x86/entry/common.c                 |   3 +-
 arch/x86/entry/vdso/Makefile            |   3 +
 arch/x86/include/asm/checksum.h         |  16 +-
 arch/x86/include/asm/idtentry.h         |  10 +-
 arch/x86/include/asm/page_64.h          |  13 +
 arch/x86/include/asm/pgtable_64_types.h |  41 +-
 arch/x86/include/asm/sparsemem.h        |   2 +
 arch/x86/include/asm/string_64.h        |  23 +-
 arch/x86/include/asm/uaccess.h          |   7 +
 arch/x86/include/asm/unwind.h           |  23 +-
 arch/x86/kernel/Makefile                |   2 +
 arch/x86/kernel/cpu/Makefile            |   1 +
 arch/x86/kernel/cpu/mce/core.c          |   2 +-
 arch/x86/kernel/kvm.c                   |   2 +-
 arch/x86/kernel/nmi.c                   |   2 +-
 arch/x86/kernel/process_64.c            |   1 +
 arch/x86/kernel/sev.c                   |   4 +-
 arch/x86/kernel/traps.c                 |  14 +-
 arch/x86/lib/Makefile                   |   2 +
 arch/x86/lib/iomem.c                    |   5 +
 arch/x86/mm/Makefile                    |   2 +
 arch/x86/mm/fault.c                     |  25 +-
 arch/x86/mm/init_64.c                   |   2 +-
 arch/x86/mm/ioremap.c                   |   3 +
 arch/x86/realmode/rm/Makefile           |   1 +
 block/bio.c                             |   2 +
 block/blk.h                             |   7 +
 crypto/Kconfig                          |  30 ++
 drivers/firmware/efi/libstub/Makefile   |   1 +
 drivers/input/serio/libps2.c            |   5 +-
 drivers/net/Kconfig                     |   1 +
 drivers/nvdimm/nd.h                     |   2 +-
 drivers/nvdimm/pfn_devs.c               |   2 +-
 drivers/usb/core/urb.c                  |   2 +
 drivers/virtio/virtio_ring.c            |  10 +-
 include/asm-generic/cacheflush.h        |   9 +-
 include/asm-generic/rwonce.h            |   5 +-
 include/linux/compiler-clang.h          |  23 +
 include/linux/compiler-gcc.h            |   6 +
 include/linux/compiler_types.h          |   3 +-
 include/linux/fortify-string.h          |   2 +
 include/linux/highmem.h                 |   3 +
 include/linux/instrumentation.h         |   6 +
 include/linux/instrumented.h            |  26 +-
 include/linux/kmsan-checks.h            | 123 ++++++
 include/linux/kmsan.h                   | 359 ++++++++++++++++
 include/linux/mm_types.h                |  12 +
 include/linux/sched.h                   |   5 +
 include/linux/stackdepot.h              |   8 +
 include/linux/uaccess.h                 |  19 +-
 init/main.c                             |   3 +
 kernel/Makefile                         |   1 +
 kernel/dma/mapping.c                    |   9 +-
 kernel/entry/common.c                   |  22 +-
 kernel/exit.c                           |   2 +
 kernel/fork.c                           |   2 +
 kernel/kcov.c                           |   7 +
 kernel/locking/Makefile                 |   3 +-
 lib/Kconfig.debug                       |   1 +
 lib/Kconfig.kmsan                       |  39 ++
 lib/Makefile                            |   3 +
 lib/iomap.c                             |  40 ++
 lib/iov_iter.c                          |   9 +-
 lib/stackdepot.c                        |  29 +-
 lib/string.c                            |   8 +
 lib/usercopy.c                          |   3 +-
 mm/Makefile                             |   1 +
 mm/internal.h                           |   6 +
 mm/kasan/common.c                       |   2 +-
 mm/kmsan/Makefile                       |  26 ++
 mm/kmsan/annotations.c                  |  28 ++
 mm/kmsan/core.c                         | 468 +++++++++++++++++++++
 mm/kmsan/hooks.c                        | 384 +++++++++++++++++
 mm/kmsan/init.c                         | 240 +++++++++++
 mm/kmsan/instrumentation.c              | 267 ++++++++++++
 mm/kmsan/kmsan.h                        | 188 +++++++++
 mm/kmsan/kmsan_test.c                   | 536 ++++++++++++++++++++++++
 mm/kmsan/report.c                       | 211 ++++++++++
 mm/kmsan/shadow.c                       | 336 +++++++++++++++
 mm/memory.c                             |   2 +
 mm/mmu_gather.c                         |  10 +
 mm/page_alloc.c                         |  18 +
 mm/slab.h                               |   1 +
 mm/slub.c                               |  21 +-
 mm/vmalloc.c                            |  20 +-
 scripts/Makefile.kmsan                  |   1 +
 scripts/Makefile.lib                    |   9 +
 security/Kconfig.hardening              |   4 +
 tools/objtool/check.c                   |  19 +
 96 files changed, 4211 insertions(+), 87 deletions(-)
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
2.36.0.rc2.479.g8af0fa9b8e-goog

