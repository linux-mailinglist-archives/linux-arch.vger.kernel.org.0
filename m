Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD3A5AD28A
	for <lists+linux-arch@lfdr.de>; Mon,  5 Sep 2022 14:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiIEMZH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 08:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiIEMZB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 08:25:01 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9AD186FE
        for <linux-arch@vger.kernel.org>; Mon,  5 Sep 2022 05:24:58 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id q18-20020a056402519200b0043dd2ff50feso5693663edd.9
        for <linux-arch@vger.kernel.org>; Mon, 05 Sep 2022 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=RhEZT1SNq0NPBQzxON055CwG2z9S9v0DBpHgk5coq2c=;
        b=qIFPN9OkzbOXH72mlR5LagOU4V2Qu36zJP5msaFIgWYYDUTG8GebJGj+NaMbBrjOB3
         Eu7cF3S15gWKxMeiFsUeb/z157gaywe/W0TOpKR640uyP92I1KjqZZt2A5xSCA3uGVzF
         ZNCqp2qAM75fQMu+M5Enm/g2VzcAq4oMIywB3HK2fwuKrdL37dPS+tFwswYE+9xcczWg
         CgDILcnihYZfi8cIyMyVX2HxhZcf6avr3r0h3BGIAiAQ+V0kbxrwuKvuid4by0IGVE0x
         mgphjNAkQBRHWKkxyCqm2ECrhuPWrGjt4l1S7ekyJ+t9jk7xZQ39N1GT/3oSImf4pMx6
         5sSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=RhEZT1SNq0NPBQzxON055CwG2z9S9v0DBpHgk5coq2c=;
        b=5vqbDzrGHqh1J3e6LUw6Q/pnFVl6hQ9m/YMfWqUxz31J45PsmNea7CcfksvcDWsTfT
         I3Ddw06Z44DMQOTKt5LoISUv3GvFeBvVnKiEhYEZwYxHTWSjKEDW0lURZWBL5hsi7Q1S
         Qw5+De1LlLRrOw0K+X9Seqvz/n5hqHcFllIQkPMaPzYn3quW2X8cB2W/+acIgcrJ7TOV
         RJRtyIP2g+iW1qYKO3YWJykjaU6Fl9mp+HxBxr2iu3aGT6ihSQA41KEHQaB9J7xlbi3y
         kUR84a4RE/S8qAYwOP78zebCHbwvPWBY6Evw5R7jFCF2VIEqwlp6XdDvvrR4KDquB3g4
         6quQ==
X-Gm-Message-State: ACgBeo1yKS7bFs0X6uS4MPwkKDOumTiiKsAMcSB9nT6764LGpA40OIe1
        XFVWRsvKR+Wj3oAaKqSLV3THkJn9aNI=
X-Google-Smtp-Source: AA6agR7SB58mX8bJV9iQaIevq7gEVvfFs+GKe61XMA10PewWZxWsr24Xg2Hj7RE7Y/avsZrMyDz7q0ZIq1s=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:b808:8d07:ab4a:554c])
 (user=glider job=sendgmr) by 2002:a17:907:3dab:b0:741:9a23:eb01 with SMTP id
 he43-20020a1709073dab00b007419a23eb01mr25839379ejc.26.1662380696610; Mon, 05
 Sep 2022 05:24:56 -0700 (PDT)
Date:   Mon,  5 Sep 2022 14:24:08 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220905122452.2258262-1-glider@google.com>
Subject: [PATCH v6 00/44] Add KernelMemorySanitizer infrastructure
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

KernelMemorySanitizer (KMSAN) is a detector of errors related to uses of
uninitialized memory. It relies on compile-time Clang instrumentation
(similar to MSan in the userspace [1]) and tracks the state of every bit
of kernel memory, being able to report an error if uninitialized value
is used in a condition, dereferenced, or escapes to userspace, USB or
DMA.

KMSAN has reported more than 300 bugs in the past few years (recently
fixed bugs: [2]), most of them with the help of syzkaller. Such bugs
keep getting introduced into the kernel despite new compiler warnings
and other analyses (the 6.0 cycle already resulted in several
KMSAN-reported bugs, e.g. [3]). Mitigations like total stack and heap
initialization are unfortunately very far from being deployable.

The proposed patchset contains KMSAN runtime implementation together
with small changes to other subsystems needed to make KMSAN work.

The latter changes fall into several categories:

1. Changes and refactorings of existing code required to add KMSAN:
 - [01/44] x86: add missing include to sparsemem.h
 - [02/44] stackdepot: reserve 5 extra bits in depot_stack_handle_t
 - [03/44] instrumented.h: allow instrumenting both sides of copy_from_user()
 - [04/44] x86: asm: instrument usercopy in get_user() and __put_user_size()
 - [05/44] asm-generic: instrument usercopy in cacheflush.h
 - [10/44] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE

2. KMSAN-related declarations in generic code, KMSAN runtime library,
   docs and configs:
 - [06/44] kmsan: add ReST documentation
 - [07/44] kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
 - [09/44] x86: kmsan: pgtable: reduce vmalloc space
 - [11/44] kmsan: add KMSAN runtime core
 - [13/44] MAINTAINERS: add entry for KMSAN
 - [25/44] kmsan: add tests for KMSAN
 - [32/44] objtool: kmsan: list KMSAN API functions as uaccess-safe
 - [36/44] x86: kmsan: use __msan_ string functions where possible
 - [44/44] x86: kmsan: enable KMSAN builds for x86

3. Adding hooks from different subsystems to notify KMSAN about memory
   state changes:
 - [14/44] mm: kmsan: maintain KMSAN metadata for page
 - [15/44] mm: kmsan: call KMSAN hooks from SLUB code
 - [16/44] kmsan: handle task creation and exiting
 - [17/44] init: kmsan: call KMSAN initialization routines
 - [18/44] instrumented.h: add KMSAN support
 - [20/44] kmsan: add iomap support
 - [21/44] Input: libps2: mark data received in __ps2_command() as initialized
 - [22/44] dma: kmsan: unpoison DMA mappings
 - [35/44] x86: kmsan: handle open-coded assembly in lib/iomem.c
 - [37/43] x86: kmsan: sync metadata pages on page fault

4. Changes that prevent false reports by explicitly initializing memory,
   disabling optimized code that may trick KMSAN, selectively skipping
   instrumentation:
 - [08/44] kmsan: mark noinstr as __no_sanitize_memory
 - [12/44] kmsan: disable instrumentation of unsupported common kernel code
 - [19/44] kmsan: unpoison @tlb in arch_tlb_gather_mmu()
 - [23/44] virtio: kmsan: check/unpoison scatterlist in vring_map_one_sg()
 - [24/44] kmsan: handle memory sent to/from USB
 - [26/44] kmsan: disable strscpy() optimization under KMSAN
 - [27/44] crypto: kmsan: disable accelerated configs under KMSAN
 - [28/44] kmsan: disable physical page merging in biovec
 - [29/44] block: kmsan: skip bio block merging logic for KMSAN
 - [30/44] kcov: kmsan: unpoison area->list in kcov_remote_area_put()
 - [31/44] security: kmsan: fix interoperability with auto-initialization
 - [33/44] x86: kmsan: disable instrumentation of unsupported code
 - [34/44] x86: kmsan: skip shadow checks in __switch_to()
 - [38/44] x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on x86, enable it for KASAN/KMSAN
 - [39/44] x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
 - [40/44] x86: kmsan: don't instrument stack walking functions
 - [41/44] entry: kmsan: introduce kmsan_unpoison_entry_regs()

5. Fixes for bugs detected with CONFIG_KMSAN_CHECK_PARAM_RETVAL:
 - [42/44] bpf: kmsan: initialize BPF registers with zeroes
 - [43/44] mm: fs: initialize fsdata passed to write_begin/write_end interface


This patchset allows one to boot and run a defconfig+KMSAN kernel on a
QEMU without known false positives. It however doesn't guarantee there
are no false positives in drivers of certain devices or less tested
subsystems, although KMSAN is actively tested on syzbot with a large
config.

By default, KMSAN enforces conservative checks of most kernel function
parameters passed by value (via CONFIG_KMSAN_CHECK_PARAM_RETVAL, which
maps to the -fsanitize-memory-param-retval compiler flag). As discussed
in [4] and [5], passing uninitialized values as function parameters is
considered undefined behavior, therefore KMSAN now reports such cases as
errors. Several newly added patches fix known manifestations of these
errors.

The patchset was generated relative to Linux v6.0-rc4. The most
up-to-date KMSAN tree currently resides at
https://github.com/google/kmsan/. One may find it handy to review these
patches in Gerrit [6].

A huge thanks goes to the reviewers of the RFC patch series sent to LKML
in 2020 ([7]).

[1] https://clang.llvm.org/docs/MemorySanitizer.html
[2] https://syzkaller.appspot.com/upstream/fixed?manager=ci-upstream-kmsan-gce
[3] https://lore.kernel.org/all/0000000000002c7abf05e721698d@google.com/
[4] https://lore.kernel.org/all/20220614144853.3693273-1-glider@google.com/ 
[5] https://lore.kernel.org/linux-mm/20220701142310.2188015-45-glider@google.com/
[6] https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/12604/ 
[7] https://lore.kernel.org/all/20200325161249.55095-1-glider@google.com/

Alexander Potapenko (43):
  stackdepot: reserve 5 extra bits in depot_stack_handle_t
  instrumented.h: allow instrumenting both sides of copy_from_user()
  x86: asm: instrument usercopy in get_user() and put_user()
  asm-generic: instrument usercopy in cacheflush.h
  kmsan: add ReST documentation
  kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
  kmsan: mark noinstr as __no_sanitize_memory
  x86: kmsan: pgtable: reduce vmalloc space
  libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE
  kmsan: add KMSAN runtime core
  kmsan: disable instrumentation of unsupported common kernel code
  MAINTAINERS: add entry for KMSAN
  mm: kmsan: maintain KMSAN metadata for page operations
  mm: kmsan: call KMSAN hooks from SLUB code
  kmsan: handle task creation and exiting
  init: kmsan: call KMSAN initialization routines
  instrumented.h: add KMSAN support
  kmsan: unpoison @tlb in arch_tlb_gather_mmu()
  kmsan: add iomap support
  Input: libps2: mark data received in __ps2_command() as initialized
  dma: kmsan: unpoison DMA mappings
  virtio: kmsan: check/unpoison scatterlist in vring_map_one_sg()
  kmsan: handle memory sent to/from USB
  kmsan: add tests for KMSAN
  kmsan: disable strscpy() optimization under KMSAN
  crypto: kmsan: disable accelerated configs under KMSAN
  kmsan: disable physical page merging in biovec
  block: kmsan: skip bio block merging logic for KMSAN
  kcov: kmsan: unpoison area->list in kcov_remote_area_put()
  security: kmsan: fix interoperability with auto-initialization
  objtool: kmsan: list KMSAN API functions as uaccess-safe
  x86: kmsan: disable instrumentation of unsupported code
  x86: kmsan: skip shadow checks in __switch_to()
  x86: kmsan: handle open-coded assembly in lib/iomem.c
  x86: kmsan: use __msan_ string functions where possible.
  x86: kmsan: sync metadata pages on page fault
  x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on x86, enable it for
    KASAN/KMSAN
  x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
  x86: kmsan: don't instrument stack walking functions
  entry: kmsan: introduce kmsan_unpoison_entry_regs()
  bpf: kmsan: initialize BPF registers with zeroes
  mm: fs: initialize fsdata passed to write_begin/write_end interface
  x86: kmsan: enable KMSAN builds for x86

Dmitry Vyukov (1):
  x86: add missing include to sparsemem.h

 Documentation/dev-tools/index.rst       |   1 +
 Documentation/dev-tools/kmsan.rst       | 427 ++++++++++++++++++
 MAINTAINERS                             |  13 +
 Makefile                                |   1 +
 arch/s390/lib/uaccess.c                 |   3 +-
 arch/x86/Kconfig                        |   9 +-
 arch/x86/boot/Makefile                  |   1 +
 arch/x86/boot/compressed/Makefile       |   1 +
 arch/x86/entry/vdso/Makefile            |   3 +
 arch/x86/include/asm/checksum.h         |  16 +-
 arch/x86/include/asm/kmsan.h            |  55 +++
 arch/x86/include/asm/page_64.h          |   7 +
 arch/x86/include/asm/pgtable_64_types.h |  47 +-
 arch/x86/include/asm/sparsemem.h        |   2 +
 arch/x86/include/asm/string_64.h        |  23 +-
 arch/x86/include/asm/uaccess.h          |  22 +-
 arch/x86/kernel/Makefile                |   2 +
 arch/x86/kernel/cpu/Makefile            |   1 +
 arch/x86/kernel/dumpstack.c             |   6 +
 arch/x86/kernel/process_64.c            |   1 +
 arch/x86/kernel/unwind_frame.c          |  11 +
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
 drivers/input/serio/libps2.c            |   5 +-
 drivers/net/Kconfig                     |   1 +
 drivers/nvdimm/nd.h                     |   2 +-
 drivers/nvdimm/pfn_devs.c               |   2 +-
 drivers/usb/core/urb.c                  |   2 +
 drivers/virtio/virtio_ring.c            |  10 +-
 fs/buffer.c                             |   4 +-
 fs/namei.c                              |   2 +-
 include/asm-generic/cacheflush.h        |  14 +-
 include/linux/compiler-clang.h          |  23 +
 include/linux/compiler-gcc.h            |   6 +
 include/linux/compiler_types.h          |   3 +-
 include/linux/fortify-string.h          |   2 +
 include/linux/highmem.h                 |   3 +
 include/linux/instrumented.h            |  59 ++-
 include/linux/kmsan-checks.h            |  83 ++++
 include/linux/kmsan.h                   | 330 ++++++++++++++
 include/linux/kmsan_types.h             |  35 ++
 include/linux/mm_types.h                |  12 +
 include/linux/sched.h                   |   5 +
 include/linux/stackdepot.h              |   8 +
 include/linux/uaccess.h                 |  19 +-
 init/main.c                             |   3 +
 kernel/Makefile                         |   1 +
 kernel/bpf/core.c                       |   2 +-
 kernel/dma/mapping.c                    |  10 +-
 kernel/entry/common.c                   |   5 +
 kernel/exit.c                           |   2 +
 kernel/fork.c                           |   2 +
 kernel/kcov.c                           |   7 +
 kernel/locking/Makefile                 |   3 +-
 lib/Kconfig.debug                       |   1 +
 lib/Kconfig.kmsan                       |  62 +++
 lib/Makefile                            |   3 +
 lib/iomap.c                             |  44 ++
 lib/iov_iter.c                          |   9 +-
 lib/stackdepot.c                        |  29 +-
 lib/string.c                            |   8 +
 lib/usercopy.c                          |   3 +-
 mm/Makefile                             |   1 +
 mm/filemap.c                            |   2 +-
 mm/internal.h                           |   6 +
 mm/kasan/common.c                       |   2 +-
 mm/kmsan/Makefile                       |  28 ++
 mm/kmsan/core.c                         | 458 ++++++++++++++++++++
 mm/kmsan/hooks.c                        | 384 +++++++++++++++++
 mm/kmsan/init.c                         | 235 ++++++++++
 mm/kmsan/instrumentation.c              | 307 +++++++++++++
 mm/kmsan/kmsan.h                        | 208 +++++++++
 mm/kmsan/kmsan_test.c                   | 552 ++++++++++++++++++++++++
 mm/kmsan/report.c                       | 211 +++++++++
 mm/kmsan/shadow.c                       | 294 +++++++++++++
 mm/memory.c                             |   2 +
 mm/mmu_gather.c                         |  10 +
 mm/page_alloc.c                         |  19 +
 mm/slab.h                               |   1 +
 mm/slub.c                               |  17 +
 mm/vmalloc.c                            |  20 +-
 scripts/Makefile.kmsan                  |   8 +
 scripts/Makefile.lib                    |   9 +
 security/Kconfig.hardening              |   4 +
 tools/objtool/check.c                   |  20 +
 94 files changed, 4296 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/dev-tools/kmsan.rst
 create mode 100644 arch/x86/include/asm/kmsan.h
 create mode 100644 include/linux/kmsan-checks.h
 create mode 100644 include/linux/kmsan.h
 create mode 100644 include/linux/kmsan_types.h
 create mode 100644 lib/Kconfig.kmsan
 create mode 100644 mm/kmsan/Makefile
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
2.37.2.789.g6183377224-goog

