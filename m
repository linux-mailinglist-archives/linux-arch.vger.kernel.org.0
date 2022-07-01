Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DF0563506
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 16:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiGAOXU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Jul 2022 10:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiGAOXT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jul 2022 10:23:19 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961A0140E0
        for <linux-arch@vger.kernel.org>; Fri,  1 Jul 2022 07:23:17 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id z13-20020a056402274d00b004357fcdd51fso1868402edd.17
        for <linux-arch@vger.kernel.org>; Fri, 01 Jul 2022 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hq/yXGoN0Uko6++mgqy4oyVuT+D1D64+d8ukuTyOF7Y=;
        b=rRH/DJ0iiW+RRKSVfcMmjVUcGbSbZtJ8wzX/XaUi6CZ+LbI4xPeWx92Qi5JIhiLpuy
         gOVXydHUj/lr4KRPxtfZ5mEADgc7vVSAPVO9AP9A0zv2SKr+FMkNBPf67XvOy6na82uK
         O3//Tz0Kb9O1snmh2m19Pi5EpKu7nOlHv0V84g5RstWUyFKl3f4UTEuG94lbN8rq22EC
         8DgoFEyw8AEVcPkb8WKHNDlWK7R/kR91CqeaeeDe0BZi7+wGxTuytlGG265g0A36/X9m
         nuMdf9E35myElMtb7B+ld95Z/zJwCFjN8jYC5kg3qk9Nm7wR2bOS5qlVSxfqwoLq6pwT
         xuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hq/yXGoN0Uko6++mgqy4oyVuT+D1D64+d8ukuTyOF7Y=;
        b=yXAVRX/njV6gXJRYABSeaXoCQyJGHZHWxI/NV/50s9LSUA/7enA0lcJIjwZf+/setf
         1qk/jlWSqpB1s//kwVg/BNW8BWHRIpSG9Erm9OaVnfJb1BfZHe1AZdtrE3Ytpl/DNiFy
         YGlpR8gUyyCPkVzlYAbek9vaeiKHVJO+oWXe0eaIUhv7nHHHYzq7/Os44e8cc8oVAXT1
         E3B0DT9pO9ylUi8AhmhKnuGjsHB6AcMigm2xC3TcS3MtGeBrJc6jvddVkLlNP/hkiMAj
         HQeYBHhANffRtd7c/E66iXotGiyExZfjSNBG1TCbel2YxeLX1hkpGL9mU/2Ov/MTpZwz
         dIYQ==
X-Gm-Message-State: AJIora+32b21ZiNH7qDl6GWZF4CoJS5WR8scuF4EBOKnAO14Nr+C8QMN
        E2dUqpJig1nUMwa3eIBKTF0BZ3uX61s=
X-Google-Smtp-Source: AGRyM1u0oQF8sd4ibamRf1UWaCiBqp43E17qX/eWQQoE5ul9ZOB2HArcIVGYMEzA+eUdG5TTABPfsvD8TxE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:a6f5:f713:759c:abb6])
 (user=glider job=sendgmr) by 2002:a17:906:5343:b0:722:ea54:fe67 with SMTP id
 j3-20020a170906534300b00722ea54fe67mr14451273ejo.181.1656685396004; Fri, 01
 Jul 2022 07:23:16 -0700 (PDT)
Date:   Fri,  1 Jul 2022 16:22:25 +0200
Message-Id: <20220701142310.2188015-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v4 00/45] Add KernelMemorySanitizer infrastructure
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
and other analyses (the 5.16 cycle already resulted in several
KMSAN-reported bugs, e.g. [3]). Mitigations like total stack and heap
initialization are unfortunately very far from being deployable.

The proposed patchset contains KMSAN runtime implementation together
with small changes to other subsystems needed to make KMSAN work.

The latter changes fall into several categories:

1. Changes and refactorings of existing code required to add KMSAN:
 - [01/45] x86: add missing include to sparsemem.h
 - [02/45] stackdepot: reserve 5 extra bits in depot_stack_handle_t
 - [03/45] instrumented.h: allow instrumenting both sides of copy_from_user()
 - [04/45] x86: asm: instrument usercopy in get_user() and __put_user_size()
 - [05/45] asm-generic: instrument usercopy in cacheflush.h
 - [10/45] libnvdimm/pfn_dev: increase MAX_STRUCT_PAGE_SIZE

2. KMSAN-related declarations in generic code, KMSAN runtime library,
   docs and configs:
 - [06/45] kmsan: add ReST documentation
 - [07/45] kmsan: introduce __no_sanitize_memory and __no_kmsan_checks
 - [09/45] x86: kmsan: pgtable: reduce vmalloc space
 - [11/45] kmsan: add KMSAN runtime core
 - [13/45] MAINTAINERS: add entry for KMSAN
 - [25/45] kmsan: add tests for KMSAN
 - [32/45] objtool: kmsan: list KMSAN API functions as uaccess-safe
 - [36/45] x86: kmsan: use __msan_ string functions where possible
 - [45/45] x86: kmsan: enable KMSAN builds for x86

3. Adding hooks from different subsystems to notify KMSAN about memory
   state changes:
 - [14/45] mm: kmsan: maintain KMSAN metadata for page
 - [15/45] mm: kmsan: call KMSAN hooks from SLUB code
 - [16/45] kmsan: handle task creation and exiting
 - [17/45] init: kmsan: call KMSAN initialization routines
 - [18/45] instrumented.h: add KMSAN support
 - [20/45] kmsan: add iomap support
 - [21/45] Input: libps2: mark data received in __ps2_command() as initialized
 - [22/45] dma: kmsan: unpoison DMA mappings
 - [35/45] x86: kmsan: handle open-coded assembly in lib/iomem.c
 - [37/45] x86: kmsan: sync metadata pages on page fault

4. Changes that prevent false reports by explicitly initializing memory,
   disabling optimized code that may trick KMSAN, selectively skipping
   instrumentation:
 - [08/45] kmsan: mark noinstr as __no_sanitize_memory
 - [12/45] kmsan: disable instrumentation of unsupported common kernel code
 - [19/45] kmsan: unpoison @tlb in arch_tlb_gather_mmu()
 - [23/45] virtio: kmsan: check/unpoison scatterlist in vring_map_one_sg()
 - [24/45] kmsan: handle memory sent to/from USB
 - [26/45] kmsan: disable strscpy() optimization under KMSAN
 - [27/45] crypto: kmsan: disable accelerated configs under KMSAN
 - [28/45] kmsan: disable physical page merging in biovec
 - [29/45] block: kmsan: skip bio block merging logic for KMSAN
 - [30/45] kcov: kmsan: unpoison area->list in kcov_remote_area_put()
 - [31/45] security: kmsan: fix interoperability with auto-initialization
 - [33/45] x86: kmsan: disable instrumentation of unsupported code
 - [34/45] x86: kmsan: skip shadow checks in __switch_to()
 - [38/45] x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on x86, enable it for KASAN/KMSAN
 - [39/45] x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
 - [40/45] x86: kmsan: don't instrument stack walking functions
 - [41/45] entry: kmsan: introduce kmsan_unpoison_entry_regs()

5. Fixes for bugs detected with CONFIG_KMSAN_CHECK_PARAM_RETVAL:
 - [42/45] bpf: kmsan: initialize BPF registers with zeroes
 - [43/45] namei: initialize parameters passed to step_into()
 - [44/45] mm: fs: initialize fsdata passed to write_begin/write_end interface


This patchset allows one to boot and run a defconfig+KMSAN kernel on a
QEMU without known false positives. It however doesn't guarantee there
are no false positives in drivers of certain devices or less tested
subsystems, although KMSAN is actively tested on syzbot with a large
config.

The biggest difference between this patch series and v3 is the
introduction of CONFIG_KMSAN_CHECK_PARAM_RETVAL, which maps to the
-fsanitize-memory-param-retval compiler flag and enforces conservative
checks of most kernel function parameters passed by value. As discussed
in [4], passing uninitialized values as function parameters is
considered undefined behavior, therefore KMSAN now reports such cases as
errors. Several newly added patches fix known manifestations of these
errors.

The patchset was generated relative to Linux v5.19-rc4. The most
up-to-date KMSAN tree currently resides at
https://github.com/google/kmsan/. One may find it handy to review these
patches in Gerrit [5].

A huge thanks goes to the reviewers of the RFC patch series sent to LKML
in 2020 ([6]).

[1] https://clang.llvm.org/docs/MemorySanitizer.html
[2] https://syzkaller.appspot.com/upstream/fixed?manager=ci-upstream-kmsan-gce
[3] https://lore.kernel.org/all/20211126124746.761278-1-glider@google.com/
[4] https://lore.kernel.org/all/20220614144853.3693273-1-glider@google.com/ 
[5] https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/12604/ 
[6] https://lore.kernel.org/all/20200325161249.55095-1-glider@google.com/

Alexander Potapenko (44):
  stackdepot: reserve 5 extra bits in depot_stack_handle_t
  instrumented.h: allow instrumenting both sides of copy_from_user()
  x86: asm: instrument usercopy in get_user() and __put_user_size()
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
  x86: kmsan: use __msan_ string functions where possible
  x86: kmsan: sync metadata pages on page fault
  x86: kasan: kmsan: support CONFIG_GENERIC_CSUM on x86, enable it for
    KASAN/KMSAN
  x86: fs: kmsan: disable CONFIG_DCACHE_WORD_ACCESS
  x86: kmsan: don't instrument stack walking functions
  entry: kmsan: introduce kmsan_unpoison_entry_regs()
  bpf: kmsan: initialize BPF registers with zeroes
  namei: initialize parameters passed to step_into()
  mm: fs: initialize fsdata passed to write_begin/write_end interface
  x86: kmsan: enable KMSAN builds for x86

Dmitry Vyukov (1):
  x86: add missing include to sparsemem.h

 Documentation/dev-tools/index.rst       |   1 +
 Documentation/dev-tools/kmsan.rst       | 422 ++++++++++++++++++
 MAINTAINERS                             |  12 +
 Makefile                                |   1 +
 arch/s390/lib/uaccess.c                 |   3 +-
 arch/x86/Kconfig                        |   9 +-
 arch/x86/boot/Makefile                  |   1 +
 arch/x86/boot/compressed/Makefile       |   1 +
 arch/x86/entry/vdso/Makefile            |   3 +
 arch/x86/include/asm/checksum.h         |  16 +-
 arch/x86/include/asm/kmsan.h            |  55 +++
 arch/x86/include/asm/page_64.h          |  12 +
 arch/x86/include/asm/pgtable_64_types.h |  41 +-
 arch/x86/include/asm/sparsemem.h        |   2 +
 arch/x86/include/asm/string_64.h        |  23 +-
 arch/x86/include/asm/uaccess.h          |   7 +
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
 fs/namei.c                              |  10 +-
 include/asm-generic/cacheflush.h        |   9 +-
 include/linux/compiler-clang.h          |  23 +
 include/linux/compiler-gcc.h            |   6 +
 include/linux/compiler_types.h          |   3 +-
 include/linux/fortify-string.h          |   2 +
 include/linux/highmem.h                 |   3 +
 include/linux/instrumented.h            |  26 +-
 include/linux/kmsan-checks.h            |  83 ++++
 include/linux/kmsan.h                   | 362 ++++++++++++++++
 include/linux/mm_types.h                |  12 +
 include/linux/sched.h                   |   5 +
 include/linux/stackdepot.h              |   8 +
 include/linux/uaccess.h                 |  19 +-
 init/main.c                             |   3 +
 kernel/Makefile                         |   1 +
 kernel/bpf/core.c                       |   2 +-
 kernel/dma/mapping.c                    |   9 +-
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
 mm/kmsan/core.c                         | 468 ++++++++++++++++++++
 mm/kmsan/hooks.c                        | 395 +++++++++++++++++
 mm/kmsan/init.c                         | 238 ++++++++++
 mm/kmsan/instrumentation.c              | 271 ++++++++++++
 mm/kmsan/kmsan.h                        | 195 +++++++++
 mm/kmsan/kmsan_test.c                   | 552 ++++++++++++++++++++++++
 mm/kmsan/report.c                       | 211 +++++++++
 mm/kmsan/shadow.c                       | 297 +++++++++++++
 mm/memory.c                             |   2 +
 mm/mmu_gather.c                         |  10 +
 mm/page_alloc.c                         |  18 +
 mm/slab.h                               |   1 +
 mm/slub.c                               |  18 +
 mm/vmalloc.c                            |  20 +-
 scripts/Makefile.kmsan                  |   8 +
 scripts/Makefile.lib                    |   9 +
 security/Kconfig.hardening              |   4 +
 tools/objtool/check.c                   |  20 +
 93 files changed, 4222 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/dev-tools/kmsan.rst
 create mode 100644 arch/x86/include/asm/kmsan.h
 create mode 100644 include/linux/kmsan-checks.h
 create mode 100644 include/linux/kmsan.h
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
2.37.0.rc0.161.g10f37bed90-goog

